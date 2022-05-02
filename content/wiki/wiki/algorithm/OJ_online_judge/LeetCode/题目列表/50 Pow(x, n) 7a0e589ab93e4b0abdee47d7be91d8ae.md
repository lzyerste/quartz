---
title: 50_Pow_x,_n__7a0e589ab93e4b0abdee47d7be91d8ae
---

# 50. Pow(x, n)

Difficulty: Medium
ID: 50
Solved?: Yes
Tags: Binary Search, Math, Recursive
击败: 99.69
推荐指数: ⭐⭐

[](https://leetcode.com/problems/powx-n/)

## 题意

实现 [pow(*x*, *n*)](*x*, *n*))](https://www.cplusplus.com/reference/valarray/pow/) ，即计算 x 的 n 次幂函数。

**示例 1:**

```
输入: 2.00000, 10
输出: 1024.00000
```

**示例 2:**

```
输入: 2.10000, 3
输出: 9.26100
```

**示例 3:**

```
输入: 2.00000, -2
输出: 0.25000
解释: 2-2 = 1/22 = 1/4 = 0.25
```

**说明:**

- -100.0 < *x* < 100.0
- *n* 是 32 位有符号整数，其数值范围是 [−2^31, 2^31 − 1] 。

## 题解1：二分递归

```python
class Solution:
    def myPow(self, x: float, n: int) -> float:
        if n == 0:
            return 1.0
        if n < 0:
            return 1.0 / self.myPow(x, -n)
        v = self.myPow(x * x, n // 2)
        if n % 2:
            v *= x
        return v
```