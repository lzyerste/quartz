---
title: 79_Word_Search_47a59c6293c64ab2a00ef07f9b32f5bb
---

# 79. Word Search

Difficulty: Medium
ID: 79
Solved?: Yes
Tags: Backtracking, DFS, Matrix
击败: 13.67
推荐指数: ⭐⭐⭐

[Word Search - LeetCode](https://leetcode.com/problems/word-search/)

## 题意

Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where "adjacent" cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/11/04/word2.jpg](https://assets.leetcode.com/uploads/2020/11/04/word2.jpg)

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/11/04/word-1.jpg](https://assets.leetcode.com/uploads/2020/11/04/word-1.jpg)

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true

```

**Example 3:**

![https://assets.leetcode.com/uploads/2020/10/15/word3.jpg](https://assets.leetcode.com/uploads/2020/10/15/word3.jpg)

```
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false

```

**Constraints:**

- `board` and `word` consists only of lowercase and uppercase English letters.
- `1 <= board.length <= 200`
- `1 <= board[i].length <= 200`
- `1 <= word.length <= 10^3`

## 思路

1. DFS：一个个字符搜索下去，实时记录当前走过的路径。

## 题解：DFS

```python
class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        if not board or not board[0]: return False
        M, N = len(board), len(board[0])
        
        def dfs(board, r, c, s, k, vis):
            if k == len(s): return True
            if (r, c) in vis: return False
            if not (0 <= r < M): return False
            if not (0 <= c < N): return False
            if board[r][c] != s[k]: return False
            
            for r0, c0 in [(r+1,c), (r-1,c), (r,c+1), (r,c-1)]:
                vis.add((r, c))
                if dfs(board, r0, c0, s, k+1, vis):
                    return True
                vis.remove((r, c))
            return False
        
        for r in range(M):
            for c in range(N):
                if dfs(board, r, c, word, 0, set()):
                    return True
        return False
```

击败13.67%，为什么击败率这么低？