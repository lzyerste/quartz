---
title: go中的坑
---

# go中的坑

- slice扩展后可能会丢失原来的引用，最好将slice作为返回值。
- for循环作用域（匿名函数），遍历项是指向同一个引用。
    
    [go%E4%B8%AD%E7%9A%84%E5%9D%91/untitled](go%E4%B8%AD%E7%9A%84%E5%9D%91/untitled)
    
    Above, the single variable f is share d by all the anonymous function values and updated by successive loop iterations.
    
    要使用explicit parameter
    
    [go%E4%B8%AD%E7%9A%84%E5%9D%91/untitled%201](go%E4%B8%AD%E7%9A%84%E5%9D%91/untitled%201)
    
- goroutine有时候需要类似barrier的操作，等待所有其他goroutine完成后，main routine才退出。