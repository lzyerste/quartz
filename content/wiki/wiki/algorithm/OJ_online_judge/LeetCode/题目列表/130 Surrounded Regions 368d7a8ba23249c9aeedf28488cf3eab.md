---
title: 130_Surrounded_Regions_368d7a8ba23249c9aeedf28488cf3eab
---

# 130. Surrounded Regions

Difficulty: Medium
ID: 130
Solved?: Yes
Tags: BFS, DFS, Union Find
击败: 78.74
推荐指数: ⭐⭐⭐

[Surrounded Regions - LeetCode](https://leetcode.com/problems/surrounded-regions/)

## 题意

Given a 2D board containing `'X'` and `'O'` (**the letter O**), capture all regions surrounded by `'X'`.

A region is captured by flipping all `'O'`s into `'X'`s in that surrounded region.

**Example:**

```
X X X X
X O O X
X X O X
X O X X

```

After running your function, the board should be:

```
X X X X
X X X X
X X X X
X O X X

```

**Explanation:**

Surrounded regions shouldn’t be on the border, which means that any `'O'` on the border of the board are not flipped to `'X'`. Any `'O'` that is not on the border and it is not connected to an `'O'` on the border will be flipped to `'X'`. Two cells are connected if they are adjacent cells connected horizontally or vertically.

## 思路

1. DFS：安全的O肯定可以通达边缘，所以可以从边上的O触发，DFS搜索即可。搜索不到的O就是被包围了。

## 题解

```python
class Solution:
    def solve(self, board: List[List[str]]) -> None:
        """
        Do not return anything, modify board in-place instead.
        """
        if not board or not board[0]: return
        vis = set()
        M, N = len(board), len(board[0])
        for r in (0, M - 1):
            for c in range(N):
                self.dfs(board, r, c, vis)
        for c in (0, N - 1):
            for r in range(M):
                self.dfs(board, r, c, vis)
        for r in range(M):
            for c in range(N):
                if (r, c) not in vis:
                    board[r][c] = 'X'

    def dfs(self, board, r, c, vis):
        p = r, c
        M, N = len(board), len(board[0])
        if p in vis: return
        if r < 0 or r >= M: return
        if c < 0 or c >= N: return
        if board[r][c] == 'O':
            vis.add(p)
            self.dfs(board, r-1, c, vis)
            self.dfs(board, r+1, c, vis)
            self.dfs(board, r, c-1, vis)
            self.dfs(board, r, c+1, vis)
```

击败78.74%