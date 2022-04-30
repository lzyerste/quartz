---
title: 7_Reverse_Integer_d3225ff3723e481eafc6c2cb43380337
---

# 7. Reverse Integer

Difficulty: Easy
ID: 7
Solved?: Yes
Tags: Math
击败: 60.66
推荐指数: ⭐⭐

[Loading...](https://leetcode.com/problems/reverse-integer/)

## 题意

给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。

**示例 1:**

```
输入: 123
输出: 321
```

**示例 2:**

```
输入: -123
输出: -321
```

**示例 3:**

```
输入: 120
输出: 21
```

**注意:**

假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231, 231 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。

## 思路

1. 使用Python，直接先将数字转成字符串，然后倒转字符串，最后转成整数。返回之前要判断是否溢出。
2. 按照数学运算，循环地将低位数挪到高位。
3. 思考下C语言如何实现，不用long类型，如何判断溢出。

## 题解1：Python字符串转换

```python
class Solution:
    def reverse(self, x: int) -> int:
        max_pos = 2 ** 31 - 1
        max_neg = - 2 ** 31
        y = int(str(abs(x))[::-1])
        if x < 0:
            y = -y
        return y if max_neg <= y <= max_pos else 0
```

击败41.81%

## 题解2：循环

注意下面的while循环体。变量y表示当前值，对x进行divmod操作之后，将余数（也就是x的最末位）添到变量y之后（也就是y乘以10加上r）。

比如初始数字为12345。

进行到某一步时，y值为54，x值为123。

下一步处理之后，y值应变为543（3来自x的末位），x值应变为12。

y值从54变为543过程为：543 = 54 * 10 + 3。

```python
class Solution:
    def reverse(self, x: int) -> int:
        def helper(x):
            if x < 0:
                return -helper(-x)
            y = 0
            while x > 0:
                x, r = divmod(x, 10)
                y = y * 10 + r
            return y
        
        max_pos = 2 ** 31 - 1
        max_neg = - 2 ** 31
        y = helper(x)
        return y if max_neg <= y <= max_pos else 0
```

击败60.66%