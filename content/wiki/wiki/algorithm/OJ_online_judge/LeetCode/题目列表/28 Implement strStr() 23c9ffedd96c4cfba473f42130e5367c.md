---
title: 28_Implement_strStr___23c9ffedd96c4cfba473f42130e5367c
---

# 28. Implement strStr()

Difficulty: Easy
ID: 28
Solved?: Yes
Tags: String, Two Pointers
击败: 59.53
推荐指数: ⭐⭐⭐

[Implement strStr() - LeetCode]()%20-%20LeetCode) - LeetCode)%20-%20LeetCode](https://leetcode.com/problems/implement-strstr/)

## 题意

实现 [strStr()]()))](https://baike.baidu.com/item/strstr/811469) 函数。

给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回 **-1**。

**示例 1:**

```
输入: haystack = "hello", needle = "ll"
输出: 2
```

**示例 2:**

```
输入: haystack = "aaaaa", needle = "bba"
输出: -1
```

**说明:**

当 `needle` 是空字符串时，我们应当返回什么值呢？这是一个在面试中很好的问题。

对于本题而言，当 `needle` 是空字符串时我们应当返回 0 。这与C语言的 [strstr()]()))](https://baike.baidu.com/item/strstr/811469) 以及 Java的 [](https://docs.oracle.com/javase/7/docs/api/java/lang/String.html#indexOf(java.lang.String)) 定义相符。

## 思路

- 暴力法：双指针
- glibc中strstr是怎么实现的？

## 题解1：双指针

注意while的判断条件，至少要在haystack中预留needle的长度，这样for里面就不需要判断越界情况。

这里代码处理的比较干净，包括needle长度比较长，needle为空串（found为True，即使haystack也为空串）。

```python
class Solution:
    def strStr(self, haystack: str, needle: str) -> int:
        i = 0
        while i <= len(haystack) - len(needle):
            found = True
            for j, c in enumerate(needle):
                if haystack[i + j] != c:
                    found = False
                    break
            if found: return i
            i += 1
        return -1  # not found
```

击败59.53%

## 题解2：glibc？