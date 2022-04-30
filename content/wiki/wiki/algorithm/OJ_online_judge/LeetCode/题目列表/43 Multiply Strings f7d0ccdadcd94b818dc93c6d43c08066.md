---
title: 43_Multiply_Strings_f7d0ccdadcd94b818dc93c6d43c08066
---

# 43. Multiply Strings

Difficulty: Medium
ID: 43
Solved?: Yes
Tags: Math, 模拟
击败: 24.02
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/multiply-strings/)

## 题意

给定两个以字符串形式表示的非负整数 `num1` 和 `num2`，返回 `num1` 和 `num2` 的乘积，它们的乘积也表示为字符串形式。

**示例 1:**

```
输入: num1 = "2", num2 = "3"
输出: "6"
```

**示例 2:**

```
输入: num1 = "123", num2 = "456"
输出: "56088"
```

**说明：**

1. `num1` 和 `num2` 的长度小于110。
2. `num1` 和 `num2` 只包含数字 `0-9`。
3. `num1` 和 `num2` 均不以零开头，除非是数字 0 本身。
4. **不能使用任何标准库的大数类型（比如 BigInteger）或直接将输入转换为整数来处理**。

## 思路

- 模拟乘法运算

## 题解1：暴力模拟

这里都是逆序运算。

```python
class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        def mul_1bit(s: [int], i: int):
            carry = 0
            prod = []
            for d in s[::-1]:
                p = d * i + carry
                carry, r = divmod(p, 10)
                prod.append(r)
            if carry:
                prod.append(carry)
            return prod[::-1]

        def add_str(s1, s2):
            len1 = len(s1)
            len2 = len(s2)
            carry = 0
            total = []
            for i in range(max(len1, len2)):
                a = int(s1[len1 - 1 - i]) if i <= len1 - 1 else 0
                b = int(s2[len2 - 1 - i]) if i <= len2 - 1 else 0
                sm = a + b + carry
                carry, r = divmod(sm, 10)
                total.append(r)
            if carry:
                total.append(carry)
            return total[::-1]
        
        if len(num1) < len(num2):
            return self.multiply(num2, num1)
        
        num1 = [int(_) for _ in num1]
        num2 = [int(_) for _ in num2]
        
        G = {0: [0]}
        for i in range(1, 10):
            G[i] = mul_1bit(num1, i)
        
        product = [0]
        shift = []
        for b in num2[::-1]:
            tmp = G[b] + shift
            product = add_str(product, tmp)
            shift.append(0)
        return "".join(map(str, product))
```