---
title: 342_Power_of_Four_021dcd377c054be683acab9fba56123c
---

# 342. Power of Four

Difficulty: Easy
ID: 342
Solved?: Yes
Tags: Bit Manipulation
击败: 53.64
推荐指数: ⭐⭐⭐⭐

[Power of Four - LeetCode](https://leetcode.com/problems/power-of-four/)

## 题意

Given an integer `n`, return *`true` if it is a power of four. Otherwise, return `false`*.

An integer `n` is a power of four, if there exists an integer `x` such that `n == 4x`.

**Example 1:**

```
Input: n = 16
Output: true
```

**Example 2:**

```
Input: n = 5
Output: false
```

**Example 3:**

```
Input: n = 1
Output: true
```

**Constraints:**

- `231 <= n <= 231 - 1`

**Follow up:**

Could you solve it without loops/recursion?

## 思路

1. 常规
2. 位运算：二进制表示应该是 1 00 00 00的形式，也就是它只有一个1，而且1的位置有要求，只能在01010101的上面，也就是0x55。

## 题解

```python
class Solution:
    def isPowerOfFour(self, n: int) -> bool:
        return n > 0 and (n & (n - 1)) == 0 and (n & 0x55555555) != 0
```