---
title: 62_Unique_Paths_f8fe2bddb8a04b56ab4ecb4a8c28b224
---

# 62. Unique Paths

Difficulty: Medium
ID: 62
Solved?: Yes
Tags: Array, DP
击败: 81.33
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/unique-paths/)

## 题意

## 题解1：DP

常规DP。

dp(r, c) = dp(r, c - 1) + dp(r - 1, c)

```python
class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        def dp(G, r, c):
            p = r, c
            if p in G: return G[p]
            if r < 0 or c < 0: return 0
            G[p] = dp(G, r, c - 1) + dp(G, r - 1, c)
            return G[p]
        
        G = {(0, 0): 1}  # 注意初始化
        return dp(G, m - 1, n - 1)
```

## 题解2：迭代DP

```python
class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        dp = [[0 for c in range(n + 1)] for r in range(m + 1)]
        for c in range(n):
            dp[0][c] = 1  # 第0行初始化为1
        for r in range(1, m):
            for c in range(n):
                dp[r][c] = dp[r][c-1] + dp[r-1][c]
        return dp[m-1][n-1]
```

击败81.33%