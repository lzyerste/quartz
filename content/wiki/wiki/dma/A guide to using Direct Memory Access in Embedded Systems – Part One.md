---
title: "A guide to using Direct Memory Access in Embedded Systems – Part One"
---

[A guide to using Direct Memory Access in Embedded Systems – Part Two](A%20guide%20to%20using%20Direct%20Memory%20Access%20in%20Embedded%20Systems%20–%20Part%20Two.md)

#### **A guide to using Direct Memory Access in Embedded Systems – Part One**

**In the first part of this two part article we will look at why DMA is used and the benefits it can bring for overall system performance.**

Direct Memory Access is feature of computer hardware that allows devices to gain access to the main bus linking the processor to the system memory and move data directly between the main memory and another part of the system. A dedicated DMA controller, often integrated in the processor, can be configured to move data between main memory and a range of subsystems, including another part of main memory.  This article explains the benefits of using DMA in embedded systems, what needs to be considered when writing software to perform DMA transfers, and some of the pitfalls to be aware of.

**Why use DMA?**

Many embedded systems have internal and external interfaces that produce or consume data. These can be simple UARTs, external bus devices such as PCI-based Ethernet controllers, or complicated video and graphics devices. A key part of any embedded system is ensuring that data flowing in to and out of these interfaces is handled properly and not lost or corrupted.

In order to for the system to operate on the data (decode a message, produce the next frame of a video, send data to a remote server, etc.) the data must normally be in the system main memory to allow the main processor to access it. A simple way of moving the data between  the peripheral device and main memory is to use the main processor to perform load or store operations for each byte or word of data to be moved. The processor must wait for the peripheral to be ready before transferring each byte or word, which can be done by polling a status register or by handling a “ready” interrupt from the device.  This is referred to as Programmed I/O.

If the device produces or consumes a small amount of data at low data rates, this may be the best way of managing the data transfer in and out of main memory; in fact, for some devices such as simple UARTs this may be the only way.  However, using programmed i/o has some limitations: first of all, the fact that programmed i/o involves a software loop may limit its performance.  Secondly, for many systems this is not a good use of processing time as the processor may be spending more time than is necessary or available moving data between main memory and its external interfaces.

The alternative is to set up a DMA transfer that gives the job of moving the data to a special-purpose device in the system. Once the processor has set up the transfer it can do something else while the transfer is in progress or wait to be notified when the transfer has finished. For example, the same transfer to the UART that was done using programmed i/o in the example above could be done using the system’s DMA controller, which would free up the processor to do other work while the transfer was in progress.

Some peripheral devices have their own built-in DMA controller, meaning that they can take over the system bus and carry out DMA transfers without needing a separate system DMA controller. Devices that can take over the system bus are known as bus masters or devices that have bus mastering capabilities. Typical examples are disk controllers, Ethernet controllers, USB controllers, and video controllers. Usually the DMA controller built into these devices can only move data between the device itself and main memory – that is, it’s not intended to be used as a general system DMA controller.

**Other Reasons for using DMA**

The obvious benefit of moving data using DMA transfers is that the processor can be doing something else while the transfer is in progress. However, using DMA sometimes has other advantages depending on the hardware involved. These include:

**Data transformations** – application-specific processors, such as those targeted to video or digital signal processing, may be able to perform data transformations as part of the DMA transfer. These include byte-order changes and 2D block transfers (see below).

**Lower power**  – if the processor load is reduced and there are fewer interrupts  – for example, one on completion of the whole transfer rather than one per item of data transferred – it may be possible to run the processor at a lower clock rate or even to enter a low power mode while DMA transfers are in flight.

**Higher data throughput** – a given processor may be able to handle more external interfaces at higher data rates, or a low-end processor might be able to handle more complicated interfaces such as Ethernet or USB.

DMA transfers are also commonly used for inter-processor communication between cores in a multi-core processor or processors in a multi-processor system.

**Types of DMA transfer** 

To assess the benefits and consequences of using DMA it is necessary to know what is happening at the hardware level.

DMA transfers can take different forms depending on the hardware design and the peripheral devices involved. The simplest is a known as a single-cycle DMA transfer and is typically used to transfer data between devices such as UARTs or audio codecs that produce or consume data a word at a time. In this situation the peripheral device uses a control line to signal that it has data to transfer or requires new data. The DMA controller obtains access to the system bus, transfers the data, and then releases the bus. Access to the bus is granted when the processor, or another bus master, is not using the bus. Single-cycle DMA transfers are therefore interleaved with other bus transactions and do not much affect the operation of the processor.

Another type of transfer is a burst transfer. This is used to transfer a block of data in a series of back-to-back accesses to the system bus. The transfer starts with a bus request; when this is granted, the data is transferred in bursts, for example 128 bytes at a time. The burst size depends on the processor architecture and the peripheral, and may be programmable depending on the details of the hardware.

While a burst transaction is occurring the processor will not be able to access the system bus. However, preventing the processor from accessing the system bus – for example to fetch new instructions or data from external memory – may cause it to stall, which can reduce the system performance. To minimise the effects of this problem, the DMA controller may release the bus after a fixed number of burst transactions or when a pre-determined bandwidth limit has been reached. The system bus arbitration logic then determines which bus master will next have access to the bus and when the DMA transfer will continue with the next block. The number of bus masters and their relative priority is a wider system design issue that will not be addressed here.  However, if the system needs to perform large DMA block transfers the system designer needs to carefully work out the bus bandwidth requirements to ensure there are no performance bottlenecks in the hardware or software design.

**Performing a DMA transfer**

Before a DMA transfer can begin the processor must tell the DMA controller or the peripheral device how much data to move and where in memory to move it to or from. For dedicated DMA controllers this usually involves programming a set of registers that describe the transfer. Peripheral controllers with DMA capability may also have explicit DMA control registers but in many cases DMA is implicit to the operation of the device and does not require special programming.

A DMA transfer usually has these attributes:

**Source address** the address from which the data is transferred, in main memory or the peripheral address space

**Destination address** the address to which the data is transferred, in main memory or the peripheral address space

**Transfer length** the overall length of the transfer, specified in terms of bytes or words

It may also include:

**Transfer type** usually memory-to-peripheral or peripheral-to-device but may also include memory-to-memory and peripheral-to-peripheral

**Block size** when performing burst transfers, the amount of data to transfer before yielding bus access and requesting it again

More sophisticated DMA controllers can perform 2D transfers, that is, the source and/or destination are viewed as a two-dimensional block of memory consisting of a series of lines rather than a contiguous block. There are two more important attributes for this type of transfer:

**Line stride** the width of each line in the 2D buffer (the number of bytes to advance to get to the start of the next line)

**Line length** the number of bytes to transfer from each line (this may be less than the stride).

An example of a 2D transfer is extracting a region of interest from a video frame. The line stride is the width of the full image while the line length is the width of the region of interest.

Once the attributes of the transfer have been set the transfer is ready to start. If this is done under software control, the processor writes to a control register in the DMA controller to start the transfer. If the transfer is dependent on device being ready then it may initiated by the device itself asserting a control signal to the controller.

At the end of the transfer, the device or the DMA controller generates an interrupt at the processor to indicate that there is data available for processing and/or that a new transfer must be set up.

When a transfer is set up and initiated by programming all the transfer attributes into device registers it is known as a _direct_ DMA transfer. Many devices also provide support for _chained_ DMA transfer. Here the transfer attributes are specified in a device-specific data structure, often referred to as a DMA descriptor, that is similar to the direct DMA register set. Each descriptor in the chain has a pointer to the next. The address of the first descriptor in the chain is usually programmed into a register in the device.

Each descriptor points to a single block of memory or data buffer in the processor memory that is the source or destination of the transfer. There may be restrictions on how the memory is aligned and what the maximum block size is. For example, each buffer may have to be aligned to a 32- or 64-byte address boundary and be limited to 64 Kbytes. The memory blocks generally do not have to be contiguous but the memory inside each buffer must be made up of contiguous physical pages. This configuration is often referred to as scatter-gather DMA and operating systems may provide routines to help device drivers to build and manage scatter-gather memory buffers.When the transfer is initiated the device moves the data specified by each descriptor in turn and only stops when it gets to the end of the chain. Depending on the hardware design, it may be possible to append new descriptors to the end of the chain while the transfer is being carried out, enabling a continuous unbroken data stream to be created.

**The first part of this article has looked at why DMA is important and how DMA can be used in a system. The next part will look at some of the problems that can occur and what needs to be done to handle them properly.**