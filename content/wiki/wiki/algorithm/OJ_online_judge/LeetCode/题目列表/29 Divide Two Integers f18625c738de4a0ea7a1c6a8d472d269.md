---
title: 29_Divide_Two_Integers_f18625c738de4a0ea7a1c6a8d472d269
---

# 29. Divide Two Integers

Difficulty: Medium
ID: 29
Solved?: Yes
Tags: Binary Search, Math
击败: 64.74
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/divide-two-integers/)

## 题意

给定两个整数，被除数 `dividend` 和除数 `divisor`。将两数相除，要求不使用乘法、除法和 mod 运算符。

返回被除数 `dividend` 除以除数 `divisor` 得到的商。

**示例 1:**

```
输入: dividend = 10, divisor = 3
输出: 3
```

**示例 2:**

```
输入: dividend = 7, divisor = -3
输出: -2
```

**说明:**

- 被除数和除数均为 32 位有符号整数。
- 除数不为 0。
- 假设我们的环境只能存储 32 位有符号整数，其数值范围是 [−2^31, 2^31 − 1]。本题中，如果除法结果溢出，则返回 2^31 − 1。

## 思路

- 除法转减法，但使用倍增的方式。

## 题解1

```python
class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        pos = (dividend < 0) == (divisor < 0)
        dividend = abs(dividend)
        divisor = abs(divisor)

        res = 0
        while dividend >= divisor:
            tmp, quote = divisor, 1
            while dividend >= tmp:
                dividend -= tmp
                res += quote
                tmp <<= 1
                quote <<= 1

        if not pos: res = -res
        
        return min(max(-2**31, res), 2**31 - 1)
```

也可以在把内部的while简化，使它的功能是倍增除数，直到超过被除数。也就是每次求结果二进制表示时的最高位，中间过程并不做操作，减少加减运算。

```python
class Solution:
    def divide(self, dividend: int, divisor: int) -> int:
        pos = (dividend < 0) == (divisor < 0)
        dividend = abs(dividend)
        divisor = abs(divisor)

        res = 0
        while dividend >= divisor:
            tmp, quote = divisor, 1
            while tmp <= dividend:
                tmp <<= 1
                quote <<= 1
            res += quote >> 1
            dividend -= tmp >> 1

        if not pos: res = -res
        
        return min(max(-2**31, res), 2**31 - 1)
```