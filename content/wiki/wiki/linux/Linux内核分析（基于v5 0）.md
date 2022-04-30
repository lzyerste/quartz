---
title: Linux内核分析（基于v5_0）
---

# Linux内核分析（基于v5.0）

[《Linux Kernel Development》](../%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A1%AC%E6%A0%B8/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%9B%BE%E4%B9%A6/%E3%80%8ALinux%20Kernel%20Development%E3%80%8B.md)

[Understanding the Linux Kernel](../%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A1%AC%E6%A0%B8/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%9B%BE%E4%B9%A6/Understanding%20the%20Linux%20Kernel.md) 

- 内核版本号：Linux 5.0，git tag 为 v5.0
    
    ```python
    commit 1c163f4c7b3f621efff9b28a47abb36f7378d783
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Sun Mar 3 15:21:29 2019 -0800
    
        Linux 5.0
    ```
    
- 使用sublime text阅读源码
    
    使用ctags生成索引
    
    ```python
    ctags -R -f .tags
    ```
    

[内核关键结构体索引](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%86%85%E6%A0%B8%E5%85%B3%E9%94%AE%E7%BB%93%E6%9E%84%E4%BD%93%E7%B4%A2%E5%BC%95.md)

[内核关键函数索引](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%86%85%E6%A0%B8%E5%85%B3%E9%94%AE%E5%87%BD%E6%95%B0%E7%B4%A2%E5%BC%95.md)

---

[资源](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%B5%84%E6%BA%90.md)

[好文](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%A5%BD%E6%96%87.md)

# 数据结构

[链表，list](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E9%93%BE%E8%A1%A8%EF%BC%8Clist.md)

[队列，kfifo](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E9%98%9F%E5%88%97%EF%BC%8Ckfifo.md)

[红黑树](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E7%BA%A2%E9%BB%91%E6%A0%91.md)

[Radix Tree](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/Radix%20Tree.md)

[位图，bitmap](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E4%BD%8D%E5%9B%BE%EF%BC%8Cbitmap.md)

# 进程管理

[关键概念](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%85%B3%E9%94%AE%E6%A6%82%E5%BF%B5.md)

[进程表示](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%BF%9B%E7%A8%8B%E8%A1%A8%E7%A4%BA.md)

[进程调度](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%BF%9B%E7%A8%8B%E8%B0%83%E5%BA%A6.md)

[CFS调度器](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/CFS%E8%B0%83%E5%BA%A6%E5%99%A8.md)

[调度相关系统调用](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%B0%83%E5%BA%A6%E7%9B%B8%E5%85%B3%E7%B3%BB%E7%BB%9F%E8%B0%83%E7%94%A8.md)

# 内存管理

[内存管理](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%86%85%E5%AD%98%E7%AE%A1%E7%90%86.md)

[伙伴系统，buddy system](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E4%BC%99%E4%BC%B4%E7%B3%BB%E7%BB%9F%EF%BC%8Cbuddy%20system.md)

[slab分配器，slab allocator](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/slab%E5%88%86%E9%85%8D%E5%99%A8%EF%BC%8Cslab%20allocator.md)

[per-cpu变量](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/per-cpu%E5%8F%98%E9%87%8F.md)

# 锁机制

[内核锁机制总结](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%86%85%E6%A0%B8%E9%94%81%E6%9C%BA%E5%88%B6%E6%80%BB%E7%BB%93.md)

[自旋锁](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%87%AA%E6%97%8B%E9%94%81.md)

[信号量](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E4%BF%A1%E5%8F%B7%E9%87%8F.md)

[互斥锁mutex](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E4%BA%92%E6%96%A5%E9%94%81mutex.md)

[读写锁](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E8%AF%BB%E5%86%99%E9%94%81.md)

[顺序锁](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E9%A1%BA%E5%BA%8F%E9%94%81.md)

[RCU](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/RCU.md)

[原子变量与位操作](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E5%8E%9F%E5%AD%90%E5%8F%98%E9%87%8F%E4%B8%8E%E4%BD%8D%E6%93%8D%E4%BD%9C.md)

[条件变量](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/%E6%9D%A1%E4%BB%B6%E5%8F%98%E9%87%8F.md)

[Kernel Locking Techniques | Linux Journal](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/Kernel%20Locking%20Techniques%20Linux%20Journal.md)

# 中断

# IO

# 文件系统

[debugfs](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/debugfs.md)

# 剪辑

[Getting a handle on caching [LWN.net]](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/Getting%20a%20handle%20on%20caching%20%5BLWN%20net%5D.md)

[ioremap() and memremap() [LWN.net]](Linux%E5%86%85%E6%A0%B8%E5%88%86%E6%9E%90%EF%BC%88%E5%9F%BA%E4%BA%8Ev5%200%EF%BC%89/ioremap()%20and%20memremap()%20%5BLWN%20net%5D.md)