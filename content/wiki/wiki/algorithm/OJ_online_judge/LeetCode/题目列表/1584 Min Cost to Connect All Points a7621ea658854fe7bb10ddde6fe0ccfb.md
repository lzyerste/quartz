---
title: 1584_Min_Cost_to_Connect_All_Points_a7621ea658854fe7bb10ddde6fe0ccfb
---

# 1584. Min Cost to Connect All Points

Difficulty: Medium
ID: 1584
Solved?: Yes
Tags: Union Find
击败: 90.43
推荐指数: ⭐⭐⭐⭐

[Min Cost to Connect All Points - LeetCode](https://leetcode.com/problems/min-cost-to-connect-all-points/)

## 题意

You are given an array `points` representing integer coordinates of some points on a 2D-plane, where `points[i] = [xi, yi]`.

The cost of connecting two points `[xi, yi]` and `[xj, yj]` is the **manhattan distance** between them: `|xi - xj| + |yi - yj|`, where `|val|` denotes the absolute value of `val`.

Return *the minimum cost to make all points connected.* All points are connected if there is **exactly one** simple path between any two points.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/08/26/d.png](https://assets.leetcode.com/uploads/2020/08/26/d.png)

```
Input: points = [0,0](0,0)
Output: 20
Explanation:

We can connect the points as shown above to get the minimum cost of 20.
Notice that there is a unique path between every pair of points.

```

![https://assets.leetcode.com/uploads/2020/08/26/c.png](https://assets.leetcode.com/uploads/2020/08/26/c.png)

**Example 2:**

```
Input: points = [3,12](3,12)
Output: 18

```

**Example 3:**

```
Input: points = [0,0](0,0)
Output: 4

```

**Example 4:**

```
Input: points = [-1000000,-1000000](-1000000,-1000000)
Output: 4000000

```

**Example 5:**

```
Input: points = [0,0](0,0)
Output: 0

```

**Constraints:**

- `1 <= points.length <= 1000`
- `106 <= xi, yi <= 106`
- All pairs `(xi, yi)` are distinct.

## 思路

1. 标准MST问题：Kruskal算法
2. Prim算法

## 题解1：Kruskal

```python
from heapq import *

class UF:
    def __init__(self):
        self.P = {}  # parent
        
    def make_set(self, x):
        if x not in self.P:
            self.P[x] = x
            
    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x != y:
            self.P[x] = y
    
    def find(self, x):
        if self.P[x] != x:
            self.P[x] = self.find(self.P[x])
        return self.P[x]

class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        def distance(i, j):
            p1 = points[i]
            p2 = points[j]
            return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

        n = len(points)
        Q = []
        for i in range(n):
            for j in range(i+1, n):
                d = distance(i, j)
                Q.append((d, i, j))
                Q.append((d, j, i))
        
        uf = UF()
        for i in range(n):
            uf.make_set(i)

        count = 0
        total = 0
        
        heapify(Q)
        while Q and count < n - 1:
            d, u, v = heappop(Q)
            if uf.find(u) != uf.find(v):
                uf.union(u, v)
                total += d
                count += 1
        return total
```

击败77.15%

## 题解2：Prim

```python
class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        def distance(u, v):
            p1 = points[u]
            p2 = points[v]
            return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

        n = len(points)
        total = 0

        vis = set()
        Q = [(0, 0)]  # (distance, node)
        while Q and len(vis) < n:
            d, u = heappop(Q)
            if u in vis: continue
            vis.add(u)
            total += d
            for v in range(n):
                if v in vis: continue
                heappush(Q, (distance(u, v), v))
        return total
```

击败90.43%