---
title: 200_Number_of_Islands_ebf04cc974454acba152ee747f93228b
---

# 200. Number of Islands

Difficulty: Medium
ID: 200
Solved?: Yes
Tags: BFS, DFS, Union Find
击败: 46.69
推荐指数: ⭐⭐⭐

[Number of Islands - LeetCode](https://leetcode.com/problems/number-of-islands/)

## 题意

Given an `m x n` 2d `grid` map of `'1'`s (land) and `'0'`s (water), return *the number of islands*.

An **island** is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

**Example 1:**

```
Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1

```

**Example 2:**

```
Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3

```

**Constraints:**

- `m == grid.length`
- `n == grid[i].length`
- `1 <= m, n <= 300`
- `grid[i][j]` is `'0'` or `'1'`.

## 思路

1. DFS：新遇到"1"的时候，表示找到了新的岛屿，接下来将与它相邻的连成一片。
2. BFS：类似DFS，连成一片使用BFS
3. Union Find：遇到1的时候，新生成一个岛屿，然后尝试与它的上与左（因为遍历矩阵顺序是从左到右、从上到下）合并。

## 题解1：DFS

```python
class Solution:
    def numIslands(self, grid: List[List[str]]) -> int:
        if not grid or not grid[0]: return 0
        count = 0
        m, n = len(grid), len(grid[0])
        vis = set()
        for r in range(m):
            for c in range(n):
                if grid[r][c] != "1": continue
                if (r, c) in vis: continue
                self.dfs(grid, m, n, r, c, vis)
                count += 1
        return count
    
    def dfs(self, grid, m, n, r, c, vis):
        if r < 0 or r >= m: return
        if c < 0 or c >= n: return
        if (r, c) in vis: return
        # 起点进来的时候(r, c)还没有加入vis
        vis.add((r, c))
        if grid[r][c] != "1": return
        self.dfs(grid, m, n, r - 1, c, vis)
        self.dfs(grid, m, n, r + 1, c, vis)
        self.dfs(grid, m, n, r, c - 1, vis)
        self.dfs(grid, m, n, r, c + 1, vis)
```

击败46.69%