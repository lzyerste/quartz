---
title: 168_Excel_Sheet_Column_Title_94a7d695195a46be99389b4a4d87bd3c
---

# 168. Excel Sheet Column Title

Difficulty: Easy
ID: 168
Solved?: Yes
Tags: Math
击败: 70.7
推荐指数: ⭐⭐⭐

[Excel Sheet Column Title - LeetCode](https://leetcode.com/problems/excel-sheet-column-title/)

[171. Excel Sheet Column Number](171%20Excel%20Sheet%20Column%20Number%20ef4c44ef38514adaa2b8a3ba926dfdd8.md) 

## 题意

Given a positive integer, return its corresponding column title as appear in an Excel sheet.

For example:

```
    1 -> A
    2 -> B
    3 -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB 
    ...

```

**Example 1:**

```
Input: 1
Output: "A"

```

**Example 2:**

```
Input: 28
Output: "AB"

```

**Example 3:**

```
Input: 701
Output: "ZY"

```

## 思路

1. 首先，显然选用26进制。最好是从0开始计数（往小偏移1），0~25对应A到Z。进来一个数时，将其减1，然后做26进制分解，商和余数。商继续做递归求解（注意，商仍然是从1开始计数的），余数可直接转为字符。

## 题解

```python
class Solution:
    def convertToTitle(self, n: int) -> str:
        def toChar(i):
            return chr(ord('A') + i)
        n = n - 1
        if n < 26: return toChar(n)
        q, r = divmod(n, 26)
        return self.convertToTitle(q) + toChar(r)
```

击败70.70%