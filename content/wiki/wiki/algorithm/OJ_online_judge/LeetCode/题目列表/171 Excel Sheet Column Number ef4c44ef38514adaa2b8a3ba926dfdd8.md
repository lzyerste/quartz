---
title: 171_Excel_Sheet_Column_Number_ef4c44ef38514adaa2b8a3ba926dfdd8
---

# 171. Excel Sheet Column Number

Difficulty: Easy
ID: 171
Solved?: Yes
Tags: Math
击败: 87.04
推荐指数: ⭐⭐

[Excel Sheet Column Number - LeetCode](https://leetcode.com/problems/excel-sheet-column-number/)

## 题意

Given a column title as appear in an Excel sheet, return its corresponding column number.

For example:

```
    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28 
    ...

```

**Example 1:**

```
Input: "A"
Output: 1

```

**Example 2:**

```
Input: "AB"
Output: 28

```

**Example 3:**

```
Input: "ZY"
Output: 701

```

**Constraints:**

- `1 <= s.length <= 7`
- `s` consists only of uppercase English letters.
- `s` is between "A" and "FXSHRXW".

## 思路

1. 直接26进制转换

## 题解

从后往前：

```python
class Solution:
    def titleToNumber(self, s: str) -> int:
        def toInt(c):
            return ord(c) - ord('A') + 1

        r = 1
        v = 0
        for c in s[::-1]:
            v += toInt(c) * r
            r *= 26
        return v
```

击败36.73%

从前往后：

```python
class Solution:
    def titleToNumber(self, s: str) -> int:
        v = 0
        for c in s:
            v = v * 26 + ord(c) - ord('A') + 1
        return v
```

击败87.04%