---
title: "A guide to using Direct Memory Access in Embedded Systems – Part Two"
---

[[A guide to using Direct Memory Access in Embedded Systems – Part One]]

### **A guide to using Direct Memory Access in Embedded Systems – Part Two**

**The first part of this [article](https://www.pebblebay.com/direct-memory-access-embedded-systems/ "A guide to using Direct Memory Access in Embedded Systems – Part One") looked at why DMA is important and how DMA can be used in a system.** 

This part looks at some of the problems that can occur and what needs to be done to handle the problems effectively.

**Cache Coherency**

On processors with a data cache an unwanted side effect of using DMA is the possibility that the contents of the cache are no longer coherent with respect to main memory which can lead to data corruption problems. As with any memory corruption problem, these are notoriously difficult to track down because the behaviour of the system may not be predictable.

==The problem occurs when a DMA transfer changes the contents of main memory that has been cached by the processor.== The data stored in the cache will be the previous value. However, when the cache is flushed the stale data will be written back to the main memory overwriting the new data stored by the DMA.  The end result is that the data in main memory is not correct.

A similar problem can also occur with transfers from main memory. If a cached memory location is updated by the processor the new value in the cache will be different to the value in main memory until the cache is flushed. If a DMA transfer is initiated from main memory the stale data will be transferred instead of the data updated by the processor.

Some system hardware designs include a mechanism called bus snooping or cache snooping; the snooping hardware notices when an external DMA transfer refers to main memory using an address that matches data in the cache, and either flushes/invalidates the cache entry or “redirects” the transfer so that the DMA transfers the correct data and the state of the cache entry is updated accordingly.  In systems with snooping, DMA drivers don’t have to worry about cache coherency.

When the hardware doesn’t have snooping, DMA-based device drivers usually use one of two techniques to avoid cache coherency problems. The first is to ensure that the data buffers are allocated from a non-cacheable region of memory or are marked as non-cacheable by the processor’s memory management unit. This can simplify the software a great deal as the cache coherency problem never arises for transfers to or from un-cached memory. However, to minimise unnecessary data copying to and from the cache-safe buffers the driver may have to loan its buffers to the application. This can complicate the driver API and can involve complex memory mapping operations on operating systems where the kernel and the application software are in different virtual address spaces.

The second solution is for the device driver software to explicitly flush or invalidate the data cache (depending on the transfer direction) before initiating a transfer or making data buffers available to bus mastering peripherals. This can also complicate the software and will cause more transfers between cache and main memory but it does allow the application to use any arbitrary region of cached memory as a data buffer.

As well as ensuring that the data buffers themselves are coherent with the cache, the driver may also have to ensure that control structures and DMA descriptor lists are also cache-coherent. This is because a device may use a DMA transaction to get the DMA transfer attributes as well as to transfer the application data – this is very often the case when using chained DMA.

**Address Translation**

A further issue that must be properly handled by device drivers is address translation on systems that employ a memory management unit (MMU). The MMU manages access to the processor address space which is treated as a series of pages, typically 4 Kbytes in size. In operating systems that provide a virtual address space for different processes the MMU is used to map virtual addresses used by the application or kernel software to memory pages in the processor’s physical address space.

DMA capable devices generally deal with physical addresses; they bypass the MMU when addressing memory. Software refers to memory using virtual addresses (both in the kernel and application address spaces). However, bus mastering devices on some peripheral buses such as PCI or VME identify memory locations using bus-specific addresses. This means that a single physical memory location in the processor address space can be referenced by its physical address, an application virtual address, a kernel virtual address, or a bus-specific address.

Moreover, a contiguous buffer allocated by an application (or the kernel, on some systems) may not consist of contiguous physical pages. To set up a DMA transfer to or from that buffer a device driver would have to:

-   build a scatter gather table that links together the non-contiguous physical pages that make up the data buffer
-   translate the address of the individual pages into physical addresses
-   (for a PCI device) translate the physical addresses into PCI bus addresses the device can process
-   create a DMA descriptor list using the physical or bus-specific address, as appropriate
-   program the DMA controller or device with the DMA descriptor list

In practice this is usually more straightforward than it might appear as many operating systems provide address translation routines or macros that help device drivers get the underlying physical address from a given virtual address. Going from a physical address to a bus-specific address, or vice versa, usually involves adding or subtracting a fixed offset.

[![dma7](https://pebblebay.com/wp-content/uploads/2014/12/dma7-300x232.png)](https://pebblebay.com/wp-content/uploads/2014/12/dma7.png)

**Buffer Alignment**

It is not unusual to find that DMA hardware needs data buffers or control structures to be located in memory at specific address boundaries (multiples of 8, 16, 32, etc). This simplifies the hardware design particularly when data is transferred in burst mode.

If the device driver is responsible for allocating the data buffers this is not normally a problem as there are standard routines, such as memalign(), that return memory aligned to a given address boundary. If the application is providing the buffer it may not be correctly aligned for the device. Other than forcing the application to using strictly aligned buffers, there are two possible solutions to this sort of problem, with different levels of complexity.

The simplest solution is to copy the data from the misaligned user buffer into a temporary buffer that is accessed during the DMA operation. However, depending on the size of the data buffer and the frequency of the data transfer this solution could add significant extra processing effort and reduce any performance gains from using DMA in the first place.

Another solution is to transfer the misaligned part of the buffer using programmed I/O. The remaining data in the buffer will then be correctly aligned for the hardware and can be transferred using DMA. The hardware may also require the DMA transfer count (buffer size) to be an integer multiple of the burst size. If this is the case the software must also transfer any remainder using programmed I/O.

Problems with cache coherency were discussed above but there is also a cache problem caused by ==incorrect buffer alignment==. This occurs when the ==data buffer used for a DMA transfer shares a cache line with other program data==. Consider the situation where a variable used by the program is in the same cache line as part of a buffer that is the destination of a DMA transfer. The application requests a DMA transfer and then updates the variable, which would normally update the value in cache but not immediately in main memory.  ==At the end of the transfer the DMA controller driver invalidates the cache line==, to avoid the cache being stale with respect to the data just DMA’d into main memory.   At this point, main memory contains the correct value of the data from the DMA transfer ==along with the stale value of the variable used by the program==.  Because the cache line is now invalid, when the program next accesses the variable the stale value from the main memory will be loaded into the cache which means that the previous update has been lost.

The simple solution to this problem is to ==ensure that buffers used for DMA are multiples of the cache line size (typically 32 or 64 bytes) and are aligned to a cache-line size boundary==.

> 需要同时注意 DMA buffer 的大小对齐跟起始地址对齐。

**Buffer Location**

On systems using established 32-bit processors the main memory is often arranged to be at address 0 in the processor address map and is limited to 4 Gbytes. Newer processors from Intel and Freescale provide 36-bit addressing modes that enable systems to have much more than 4 Gbytes of memory. DMA controllers integrated into these processors are designed to handle the extended address range but external controllers or bus mastering devices may still be limited to a 32-bit address range. This means they will not be able to directly DMA to and from memory locations that are above the 4 GB address boundary. Some operating systems, such as Linux or Windows, handle this problem by using intermediate buffers within the 32-bit address space and copying data between them and the user buffers above the 4 GB address boundary. While this simplifies the device driver software it can impose a severe performance penalty.

Older DMA controllers may not even be able to access the whole of the 32-bit address range. For example the standard DMA controller found on ISA architecture buses is limited to the first 16 MB of the address range.

One strategy that avoids some of these problems is to pre-allocate a large block of memory at a known location in the processor address map during system initialisation to be used specifically for DMA transfers. This memory can be divided in to buffers to suit the application and the buffers can be arranged on known address boundaries to meet any hardware restrictions.

**Debugging problems with DMA**

As we have seen there are many pitfalls when writing software that relies on DMA transfers. If the source or destination address is not set correctly, or the buffer is misaligned the transfer may not complete or transfer data to or from the wrong location in memory. These problems can be very difficult to solve because one end of the transfer is usually a peripheral or memory on a bus that cannot be easily inspected. Fortunately, there are a few techniques that can give clues if things are not working as expected.

Dedicated DMA controllers and other DMA capable devices will usually provide status registers and error interrupts that can inform software if an error occurs. The status registers may give the transfer count, source address and destination address when the error occurred. There may also be bus-specific protocol registers that might show if the DMA transfer terminated because of a bus error, for example due to a misaligned access.

Bus analysers are also very useful tools for tracking down DMA errors. They can show what is happening on the address and data bus between the processor and the peripheral.  They can also be set up to trigger and capture transactions that occur outside expected address windows on the bus, which helps to limit the amount of data captured and needing analysis.

If the peripheral device is implemented in an FPGA the tool vendor may provide analyser tools and software that allow inspection of internal FPGA registers and memory blocks, or even capture what is happening on external interface signals. These can be invaluable in determining why a transfer is aborting early or where the data is actually going.

**It seems like a lot of hard work…**

Writing software to configure and handle DMA transfers is inevitably more time consuming and difficult to debug than software that uses programmed I/O. The goal is an increase in data throughput and a decrease in CPU load which can reduce the power requirements of a system or enable more application work to be done. With the massive growth in connected embedded devices the need to handle more data and at higher rates means that DMA will continue to be an important part of hardware and software design.  We hope that this article has de-mystified what goes on inside DMA driver software, and provided some useful hints and tips for how to incorporate DMA into your embedded system design.