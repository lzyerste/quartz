---
title: 131_Palindrome_Partitioning_ab5f8a1475ff42ea9bfbcf605fe34242
---

# 131. Palindrome Partitioning

Difficulty: Medium
ID: 131
Solved?: Yes
Tags: Backtracking, DP
击败: 98.36
推荐指数: ⭐⭐⭐

[Palindrome Partitioning - LeetCode](https://leetcode.com/problems/palindrome-partitioning/)

[132. Palindrome Partitioning II](132 Palindrome Partitioning II 61be1ec0a4b1411ea36cea231e71e923.md) 

## 题意

Given a string *s*, partition *s* such that every substring of the partition is a palindrome.

Return all possible palindrome partitioning of *s*.

**Example:**

```
Input: "aab"
Output:
[
  ["aa","b"],
  ["a","a","b"]
]

```

## 思路

1. 常规DP

## 题解

```python
class Solution:
    def partition(self, s: str) -> List[List[str]]:
        G = {}
        T = {}
        return self.dp(G, T, s, 0, len(s) - 1)
    
    def isPalin(self, T, s, i, j):
        p = i, j
        if p in T: return T[p]
        if i > j: return True
        if s[i] == s[j]:
            T[p] = self.isPalin(T, s, i+1, j-1)
        else:
            T[p] = False
        return T[p]
    
    def dp(self, G, T, s, i, j):
        p = i, j
        if p in G: return G[p]
        res = []
        if self.isPalin(T, s, i, j):
            res.append([s[i:j+1]])
        for k in range(i, j):
            if self.isPalin(T, s, i, k):
                for t in self.dp(G, T, s, k+1, j):
                    res.append([s[i:k+1]] + t)
        G[p] = res
        return G[p]
```

击败98.36%