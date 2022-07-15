---
title: "DMA, small buffers, and cache incoherence"
---

https://lwn.net/Articles/2265/

Roland Dreier reported on an interesting class of bugs which can affect drivers on some architectures. This particular source of subtle bugs is worth a look as an example of how hard it can be to _really_ make things work on modern hardware.

All modern systems, of course, employ one or more levels of cache in the processor to cut down on slow accesses to main memory. One challenge with in-processor caching has always been to avoid doing the wrong thing when something other than the processor changes memory. On SMP systems, for example, any processor can write anywhere in memory, and the other processors have to adjust immediately. For that reason, SMP systems have elaborate schemes for moving "ownership" of cached data between processors. This "cache line bouncing" is effective but expensive; modern operating system kernels try to minimize the need for such bouncing.

Another possible source of cache confusion is DMA I/O. Peripheral devices doing DMA can change memory directly and leave the processor cache in an incorrect state. Some processors (i.e. the x86) have a _coherent_ cache which notices changes made by peripherals and automatically updates itself. Other processors have incoherent caches which can be fooled by DMA I/O operations.

The Linux DMA support code has been very carefully written to hide cache coherence issues from driver code. If you use the primitives provided and follow the rules regarding processor access to DMA buffers, you will not be bitten by cache problems. The DMA code takes care of invalidating cache contents as needed so that caches never contain incorrect copies of main memory.

That is the idea, anyway. Roland has [found a situation](https://lwn.net/Articles/2266/) where this protection does not quite work. Consider a driver which is using a structure like this:

```
    struct iostruct {
    ...
int ifield;
char dma_buffer[SMALL_SIZE];
...
    };

```

If this structure is allocated properly (with kmalloc, for example), then using the dma\_buffer field in DMA operations is a legal thing to do. The problem is that other fields in the structure (such as ifield in the example above) may share a cache line with part of the buffer. Consider, then, a sequence of things that can happen:

1.  The driver starts a DMA read into dma\_buffer. As part of this operation, the kernel will invalidate the cache data containing both dma\_buffer and ifield.
2.  While the operation is outstanding, the driver accesses the ifield member, bringing the invalidated cache line back into memory.
3.  The I/O operation completes, changing memory underneath the cached data.

At this point, the data in the processor cache does not match what is in memory. If the driver accesses the data in dma\_buffer, it may well find old data that was in memory before the I/O operation took place. If the driver changes ifield, the processor could write back the (incorrect) cache data, corrupting the data in main memory. If the kernel simply invalidates the cache again at the end of the operation, it could lose changes made to ifield. There really is no correct thing to do at this point.

The only way to deal with this problem is to not let it happen in the first place. A number of possibilities are being considered. [One way](https://lwn.net/Articles/2269/), suggested by Roland, is to create a \_\_dma\_buffer attribute which can be used in the declaration of small buffers; on non-cache-coherent systems, this attribute would force the size and alignment of the buffer such that it would not share cache lines with any other data. Another approach is to require that all DMA buffers be allocated separately; the kernel memory allocation primitives already ensure that even the smallest buffers are properly aligned and padded. Yet another approach could be to simply disable caching for the page(s) in question while the operation is in progress; most architectures support this in their page tables. This approach could create performance problems, however (if the page in question has heavily-used data), and it could be complex.

David Miller, who wrote much of the current DMA code, [has a different approach](https://lwn.net/Articles/2270/). He thinks that this kind of subtle cache issue is a trap for driver writers that should be simply avoided altogether. Rather than come up with new ways of working around incoherent caches, it's better to just change the rules and tell driver writers to allocate their small DMA buffers using the "PCI pool" interface. This interface, which was added in 2.4.4, was designed for just this purpose: allocating small buffers for DMA. Rather than make driver writers deal with this sort of cache coherence issue - and watch some of them get it wrong, David would bury it in the PCI pool code. While no real resolution has been proclaimed, this last option appears to be the likely outcome.
