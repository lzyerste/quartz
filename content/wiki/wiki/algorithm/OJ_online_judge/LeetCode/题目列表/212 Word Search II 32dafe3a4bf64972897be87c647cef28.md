---
title: 212_Word_Search_II_32dafe3a4bf64972897be87c647cef28
---

# 212. Word Search II

Difficulty: Hard
ID: 212
Solved?: Yes
Tags: Backtracking, Trie
击败: 99.23
推荐指数: ⭐⭐⭐⭐

[Word Search II - LeetCode](https://leetcode.com/problems/word-search-ii/)

[79. Word Search](79%20Word%20Search%2047a59c6293c64ab2a00ef07f9b32f5bb.md) 

## 题意

Given an `m x n` `board` of characters and a list of strings `words`, return *all words on the board*.

Each word must be constructed from letters of sequentially adjacent cells, where **adjacent cells** are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/11/07/search1.jpg](https://assets.leetcode.com/uploads/2020/11/07/search1.jpg)

```
Input: board = ["o","a","a","n"]("o","a","a","n"), words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/11/07/search2.jpg](https://assets.leetcode.com/uploads/2020/11/07/search2.jpg)

```
Input: board = ["a","b"]("a","b"), words = ["abcb"]
Output: []

```

**Constraints:**

- `m == board.length`
- `n == board[i].length`
- `1 <= m, n <= 12`
- `board[i][j]` is a lowercase English letter.
- `1 <= words.length <= 3 * 104`
- `1 <= words[i].length <= 10`
- `words[i]` consists of lowercase English letters.
- All the strings of `words` are unique.

## 思路

1. 使用Trie：针对所有word，建立一棵Trie树。从每个位置出发，沿着Trie走，看能匹配哪些word。
2. 直接DFS：针对每个位置(r, c)，检查每个word，看能不能匹配。word长度不大。

## ★题解2：DFS

```python
class Solution:
    def findWords(self, board, words):
        """
        :type board: List[List[str]]
        :type words: List[str]
        :rtype: List[str]
        """
        if not board or not board[0] or not words:
            return []
        M, N = len(board), len(board[0])
            
        def dfs(word, vis, r, c):
            if len(word) == 0:
                return True
            if not (0 <= r < M and 0 <= c < N) or vis[r][c]:
                return False
            ch = board[r][c]
            if ch != word[0]:
                return False

            res = False
            vis[r][c] = True
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                res = res or dfs(word[1:], vis, r + dr, c + dc)
                if res: break
            vis[r][c] = False
            return res
            
        vis = [[False for c in range(N)] for r in range(M)]
        res = set()
        for r in range(M):
            for c in range(N):
                for word in words:
                    if dfs(word, vis, r, c):
                        res.add(word)
        return list(res)
```

击败99.23%

## 题解1：Trie

```python
class Trie:
    def __init__(self):
        from collections import defaultdict
        self.next = defaultdict(Trie)
        self.val = None
        
    def put(self, s):
        node = self
        for c in s:
            node = node.next[c]
        node.val = s

class Solution:
    def findWords(self, board, words):
        """
        :type board: List[List[str]]
        :type words: List[str]
        :rtype: List[str]
        """
        if not board or not board[0] or not words:
            return []
        M, N = len(board), len(board[0])
        
        trie = Trie()
        for word in words:
            trie.put(word)
            
        def dfs(res, node, vis, r, c):
            if not (0 <= r < M and 0 <= c < N) or vis[r][c]:
                return
            ch = board[r][c]
            if ch not in node.next:
                return
            vis[r][c] = True
            node = node.next[ch]
            if node.val is not None:
                res.append(node.val)
                node.val = None  # avoid dup
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                dfs(res, node, vis, r + dr, c + dc)
            vis[r][c] = False
            
        vis = [[False for c in range(N)] for r in range(M)]
        res = []
        for r in range(M):
            for c in range(N):
                dfs(res, trie, vis, r, c)
        return res
```

才击败5%