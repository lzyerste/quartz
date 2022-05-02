---
title: 231_Power_of_Two_89b52f34c5fb4d82bab86a47388a7fd5
---

# 231. Power of Two

Difficulty: Easy
ID: 231
Solved?: Yes
Tags: Bit Manipulation, Math
击败: 100
推荐指数: ⭐⭐⭐

[Power of Two - LeetCode](https://leetcode.com/problems/power-of-two/)

## 题意

Given an integer `n`, write a function to determine if it is a power of two.

**Example 1:**

```
Input: n = 1
Output: true
Explanation: 20 = 1

```

**Example 2:**

```
Input: n = 16
Output: true
Explanation: 24 = 16

```

**Example 3:**

```
Input: n = 3
Output: false

```

**Example 4:**

```
Input: n = 4
Output: true

```

**Example 5:**

```
Input: n = 5
Output: false

```

**Constraints:**

- `231 <= n <= 231 - 1`

## 思路

1. 统计1的个数。

## 题解

```python
bool isPowerOfTwo(int x) {
    // x will check if x == 0 and !(x & (x - 1)) will check if x is a power of 2 or not
    return ((x > 0) && !(x & (x - 1)));
}
```

击败100%