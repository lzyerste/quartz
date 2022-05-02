---
title: 96_Unique_Binary_Search_Trees_6e5de06636fe49f1858d7d119408b997
---

# 96. Unique Binary Search Trees

Difficulty: Medium
ID: 96
Solved?: Yes
Tags: DP, Tree
击败: 74.08
推荐指数: ⭐⭐

[Unique Binary Search Trees - LeetCode](https://leetcode.com/problems/unique-binary-search-trees/)

## 题意

## 题解1：DP

跟题目 [95. Unique Binary Search Trees II](95 Unique Binary Search Trees II a1b1891b58364691b8b8013e762286b6.md) 一样。

```python
class Solution:
    def numTrees(self, n: int) -> int:
        
        def dfs(G, n):
            if n in G: return G[n]
            res = 0
            for k in range(1, n + 1):
                res += dfs(G, k - 1) * dfs(G, n - k)
            G[n] = res
            return G[n]
        
        G = {0: 1, 1: 1}
        return dfs(G, n)
```