---
title: 174_Dungeon_Game_0ff627cbe6744af8acfe096d558a9d97
---

# 174. Dungeon Game

Difficulty: Hard
ID: 174
Solved?: Yes
Tags: Binary Search, DP
击败: 32.32
推荐指数: ⭐⭐⭐⭐

[Dungeon Game - LeetCode](https://leetcode.com/problems/dungeon-game/)

## 题意

The demons had captured the princess (**P**) and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of M x N rooms laid out in a 2D grid. Our valiant knight (**K**) was initially positioned in the top-left room and must fight his way through the dungeon to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

Some of the rooms are guarded by demons, so the knight loses health (*negative* integers) upon entering these rooms; other rooms are either empty (*0's*) or contain magic orbs that increase the knight's health (*positive* integers).

In order to reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

**Write a function to determine the knight's minimum initial health so that he is able to rescue the princess.**

For example, given the dungeon below, the initial health of the knight must be at least **7** if he follows the optimal path `RIGHT-> RIGHT -> DOWN -> DOWN`.

- 2 (K)33510110305 (P)

**Note:**

- The knight's health has no upper bound.
- Any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.

## 思路

1. 二维DP：需要明确dp(r, c)所代表的严格含义。我们定义dp(r, c)为进入位置(r, c)前所需要的最小生命值。显然，dp(r, c) ≥ 1，进入前需要活着；然后，在位置(r, c)进行补给或消耗生命，离开(r, c)可进入(r, c+1)或(r+1, c)，选择所需生命值较小的路径，需要满足dp(r, c) + dungeon[r][c] ≥ min(dp(r, c+1), dp(r+1, c))。当然，离开时要求还活着，所以隐含了dp(r, c) + dungeon[r][c] ≥ 1。因为任意的dp(x, y)都保证大于等于1，所以min里就不用再添加1了。
    
    注意越界情况的处理，以及终点的初始化。越界采用正无穷大表示不要过来，过来的代价是无穷大。
    

## 题解

```python
class Solution:
    def calculateMinimumHP(self, dungeon: List[List[int]]) -> int:
        if not dungeon or not dungeon[0]: return 0
        M, N = len(dungeon), len(dungeon[0])
        
        def dp(G, r, c):
            p = r, c
            if p in G: return G[p]
            if r < 0 or r >= M: return float("inf")
            if c < 0 or c >= N: return float("inf")
            G[p] = max(1, min(dp(G, r, c+1), dp(G, r+1, c)) - dungeon[r][c])
            return G[p]
        
        G = {(M-1, N-1): max(1, 1 - dungeon[M-1][N-1])}
        return dp(G, 0, 0)
```

击败32.32%