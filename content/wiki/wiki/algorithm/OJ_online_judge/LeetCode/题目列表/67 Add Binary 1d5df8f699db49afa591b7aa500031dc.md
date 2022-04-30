---
title: 67_Add_Binary_1d5df8f699db49afa591b7aa500031dc
---

# 67. Add Binary

Difficulty: Easy
ID: 67
Solved?: Yes
Tags: Math, 模拟
击败: 80.62
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/add-binary/)

## 题意

## 题解：模拟

```python
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        a = a[::-1]
        b = b[::-1]
        LA = len(a)
        LB = len(b)
        result = []
        carry = 0
        i = 0
        while i < max(LA, LB):
            x = int(a[i]) if i < LA else 0
            y = int(b[i]) if i < LB else 0
            sum = x + y + carry
            carry, d = divmod(sum, 2)
            result.append(d)
            i += 1
        if carry:
            result.append(carry)
        return "".join(map(str, result))[::-1]
```