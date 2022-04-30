---
title: 367_Valid_Perfect_Square_65ec4815062a4fe5ad84642c5fdedce2
---

# 367. Valid Perfect Square

Difficulty: Easy
ID: 367
Solved?: Yes
Tags: Binary Search, Math
击败: 75.66
推荐指数: ⭐⭐⭐

[Valid Perfect Square - LeetCode](https://leetcode.com/problems/valid-perfect-square/)

## 题意

Given a **positive** integer num, write a function which returns True if num is a perfect square else False.

**Follow up:** **Do not** use any built-in library function such as `sqrt`.

**Example 1:**

```
Input: num = 16
Output: true
```

**Example 2:**

```
Input: num = 14
Output: false
```

**Constraints:**

- `1 <= num <= 2^31 - 1`

## 思路

1. 自主二分法：结束时为RL，结果落在R上，代表的是R*R≤ n
2. 牛顿法求根

## 题解

```python
class Solution:
    def isPerfectSquare(self, num: int) -> bool:
        L, R = 0, num
        while L <= R:
            M = (L + R) // 2
            if M * M <= num:
                L = M + 1
            else:
                R = M - 1
        return R * R == num
```