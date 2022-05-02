---
title: 166_Fraction_to_Recurring_Decimal_9e82e1addd6144df840cad1511cff3a1
---

# 166. Fraction to Recurring Decimal

Difficulty: Medium
ID: 166
Solved?: Yes
Tags: Hash Table, Math
击败: 80.41
推荐指数: ⭐⭐⭐

[Fraction to Recurring Decimal - LeetCode](https://leetcode.com/problems/fraction-to-recurring-decimal/)

## 题意

Given two integers representing the `numerator` and `denominator` of a fraction, return *the fraction in string format*.

If the fractional part is repeating, enclose the repeating part in parentheses.

If multiple answers are possible, return **any of them**.

It is **guaranteed** that the length of the answer string is less than `104` for all the given inputs.

**Example 1:**

```
Input: numerator = 1, denominator = 2
Output: "0.5"

```

**Example 2:**

```
Input: numerator = 2, denominator = 1
Output: "2"

```

**Example 3:**

```
Input: numerator = 2, denominator = 3
Output: "0.(6)"

```

**Example 4:**

```
Input: numerator = 4, denominator = 333
Output: "0.(012)"

```

**Example 5:**

```
Input: numerator = 1, denominator = 5
Output: "0.2"

```

**Constraints:**

- `231 <= numerator, denominator <= 231 - 1`
- `denominator != 0`

## 思路

1. 模拟小学除法，注意重复开始的位置，因为可能一开始没重复，后来才开始重复，比如7除以12。

## 题解

```python
class Solution:
    def fractionToDecimal(self, numerator: int, denominator: int) -> str:
        flag = -1 if numerator / denominator < 0 else 1
        numerator = abs(numerator)
        denominator = abs(denominator)
        q, r = divmod(numerator, denominator)
        x = str(q) if flag > 0 else "-" + str(q)  # integer part
        if r == 0: return x
        
        G = {0:-1}
        frac = []
        idx = 0
        while r not in G:
            G[r] = idx
            idx += 1
            r *= 10
            q, r = divmod(r, denominator)
            frac.append(q)
        frac = list(map(str, frac))
        if r == 0:
            return "%s.%s" % (x, "".join(frac))
        else:
            y = "".join(frac[:G[r]])
            z = "".join(frac[G[r]:])
            return "%s.%s(%s)" % (x, y, z)
```

击败80.41%