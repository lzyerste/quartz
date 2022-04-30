---
title: 58_Length_of_Last_Word_ae96ecd2f3c14d5d8717008a2d7f043c
---

# 58. Length of Last Word

Difficulty: Easy
ID: 58
Solved?: Yes
Tags: String
击败: 9.71
推荐指数: ⭐⭐

[Length of Last Word - LeetCode](https://leetcode.com/problems/length-of-last-word/)

## 题意

## 题解1

找到起始、终止位置。

![58%20Length%20of%20Last%20Word%20ae96ecd2f3c14d5d8717008a2d7f043c/Untitled.png](58%20Length%20of%20Last%20Word%20ae96ecd2f3c14d5d8717008a2d7f043c/Untitled.png)

```python
class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        i = len(s) - 1
        while i >= 0 and s[i] == ' ':
            i -= 1
        # i指向字母或者越界为-1
        j = i
        while j >= 0 and s[j] != ' ':
            j -= 1
        # j指向空格或者越界为-1
        return i - j  # 越界也没关系
```