---
title: 64_Minimum_Path_Sum_3c0bf553a6b74f249ead0ff42e3bba8f
---

# 64. Minimum Path Sum

Difficulty: Medium
ID: 64
Solved?: Yes
Tags: DP, Matrix
击败: 15
推荐指数: ⭐⭐⭐

[Minimum Path Sum - LeetCode](https://leetcode.com/problems/minimum-path-sum/)

## 题意

Given a *m* x *n* grid filled with non-negative numbers, find a path from top left to bottom right which *minimizes* the sum of all numbers along its path.

**Note:** You can only move either down or right at any point in time.

**Example:**

```
Input:
[
  [1,3,1],
  [1,5,1],
  [4,2,1]
]
Output: 7
Explanation: Because the path 1→3→1→1→1 minimizes the sum.

```

## 题解：DP

常规DP。

```python
class Solution:
    def minPathSum(self, grid: List[List[int]]) -> int:
        def dp(G, r, c, grid):
            p = r, c
            if p in G: return G[p]
            if r < 0 or c < 0: return float("inf")
            G[p] = grid[r][c] + min(dp(G, r, c-1, grid), dp(G, r-1, c, grid))
            return G[p]
        
        if not grid: return 0
        
        G = {(0, 0): grid[0][0]}
        M = len(grid)
        N = len(grid[0])
        return dp(G, M-1, N-1, grid)
```