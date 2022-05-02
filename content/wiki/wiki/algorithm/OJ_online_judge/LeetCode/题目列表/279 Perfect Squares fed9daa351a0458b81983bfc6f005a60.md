---
title: 279_Perfect_Squares_fed9daa351a0458b81983bfc6f005a60
---

# 279. Perfect Squares

Difficulty: Medium
ID: 279
Solved?: Yes
Tags: BFS, DP, Math
击败: 64.65
推荐指数: ⭐⭐⭐

[Perfect Squares - LeetCode](https://leetcode.com/problems/perfect-squares/)

## 题意

Given a positive integer n, find the least number of perfect square numbers (for example, `1, 4, 9, 16, ...`) which sum to n.

**Example 1:**

```
Input: n = 12
Output: 3 
Explanation: 12 = 4 + 4 + 4.
```

**Example 2:**

```
Input: n = 13
Output: 2
Explanation: 13 = 4 + 9.
```

## 思路

1. BFS最短路径
2. DP：dp(n) = min(dp(n-square) + 1)，square是一个小于n的平方数。
    
    针对题目的优化：题目有很多case，case之间的dp是可以共享的，防止重复计算。
    

## 题解1：BFS

```python
WHITE, GRAY, BLACK = list(range(3))

class Solution:
    def numSquares(self, n: int) -> int:
        # BFS
        D = {}
        C = {}
        
        squares = [i*i for i in range(n+1) if i*i <= n]
        
        for i in range(n+1):
            D[i] = float("inf")
            C[i] = WHITE
        
        D[0] = 0
        C[0] = GRAY
        
        from collections import deque
        Q = deque([0])
        while Q:
            u = Q.popleft()
            if u == n: break
            for sqr in squares:
                v = u + sqr
                if v > n or C[v] != WHITE: continue
                C[v] = GRAY
                D[v] = D[u] + 1
                Q.append(v)
            C[u] = BLACK
        return D[n]
```

击败64.65%

## 题解2：DP

```python
class Solution:
    def numSquares(self, n: int) -> int:
        dp = [float("inf") for _ in range(n+1)]
        dp[0] = 0
        squares = [i*i for i in range(n+1) if i*i <= n]
        for i in range(1, n+1):
            for sqr in squares:
                if sqr > i: break
                dp[i] = min(dp[i], dp[i-sqr] + 1)
        return dp[n]
```

击败36.64%