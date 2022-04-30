---
title: 60_Permutation_Sequence_409f7defd8474cfcacdbf8695d5ea3a0
---

# 60. Permutation Sequence

Difficulty: Medium
ID: 60
Solved?: Yes
Tags: Backtracking, Math
击败: 25.23
推荐指数: ⭐⭐⭐⭐

[Permutation Sequence - LeetCode](https://leetcode.com/problems/permutation-sequence/)

## 题意

## 题解1：递归

类似不断变换radix。

比如[A, B, C, D, E], 第30大（从0开始计数）。

先定下第一位，剩下还有4个数，排列组合有4! = 24种，30/24 = 1，所以选择B（从0开始计数）。

接下来是[A, C, D, E]，选第6大。

以此类推。

```python
class Solution:
    def getPermutation(self, n: int, k: int) -> str:
        F = [1 for _ in range(n+1)]  # factorial
        for i in range(1, n+1):
            F[i] = F[i-1] * i
        
        def rec(items, k):
            n = len(items)
            if k == 0:
                return items
            q, k = divmod(k, F[n-1])
            return [items[q]] + rec(items[:q] + items[q+1:], k)
        
        items = [str(i+1) for i in range(n)]
        return "".join(rec(items, k-1))  # k转为从0开始计数
```