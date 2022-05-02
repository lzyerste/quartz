---
title: 172_Factorial_Trailing_Zeroes_f232266069634be595be0507a2b3b659
---

# 172. Factorial Trailing Zeroes

Difficulty: Easy
ID: 172
Solved?: Yes
Tags: Math
击败: 99
推荐指数: ⭐⭐⭐

[Factorial Trailing Zeroes - LeetCode](https://leetcode.com/problems/factorial-trailing-zeroes/)

## 题意

Given an integer `n`, return *the number of trailing zeroes in `n!`*.

**Follow up:** Could you write a solution that works in logarithmic time complexity?

**Example 1:**

```
Input: n = 3
Output: 0
Explanation: 3! = 6, no trailing zero.

```

**Example 2:**

```
Input: n = 5
Output: 1
Explanation: 5! = 120, one trailing zero.

```

**Example 3:**

```
Input: n = 0
Output: 0

```

**Constraints:**

- `1 <= n <= 104`

## 思路

1. 统计因子5的个数。

## 题解

```python
class Solution:
    def trailingZeroes(self, n: int) -> int:
        cnt = 0
        while n:
            n = n // 5
            cnt += n
        return cnt
```

击败99%