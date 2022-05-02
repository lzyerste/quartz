---
title: 980_Unique_Paths_III_2d69857fdf534369bd500f6d7e3efe0c
---

# 980. Unique Paths III

Difficulty: Hard
ID: 980
Solved?: No
Tags: Backtracking, DFS
击败: 90.15
推荐指数: ⭐⭐⭐⭐

[](https://leetcode.com/problems/unique-paths-iii/)

## 题意

## 题解：回溯

```python
class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        M = len(grid)
        N = len(grid[0])
        start = stop = None
        nodes = set()  # 可以停留的点
        for r in range(M):
            for c in range(N):
                if grid[r][c] == 0:
                    nodes.add((r, c))
                elif grid[r][c] == 1:
                    start = r, c
                elif grid[r][c] == 2:
                    stop = r, c
                    nodes.add(stop)  # stop也是可以走的点

        def bp(nodes, r, c):
            if len(nodes) == 0:
                return int((r, c) == stop)
            cnt = 0
            for r0, c0 in [(r,c+1), (r,c-1), (r+1,c), (r-1,c)]:
                p = r0, c0
                if p not in nodes: continue
                nodes.remove(p)
                cnt += bp(nodes, r0, c0)
                nodes.add(p)
            return cnt
        
        # 初始的时候，将相当于走过了起点，所以nodes里不需要包含stat。
        return bp(nodes, start[0], start[1])
```

击败46.72%

---

调换下回溯退出条件的判断：原来是等到nodes为空的时候，看是否停留在终点；可以反过来，在经过终点的时候，判断nodes是否为空，这样就避免了过了终点还继续遍历nodes。

```python
class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        M = len(grid)
        N = len(grid[0])
        start = stop = None
        nodes = set()
        for r in range(M):
            for c in range(N):
                if grid[r][c] == 0:
                    nodes.add((r, c))
                elif grid[r][c] == 1:
                    start = r, c
                elif grid[r][c] == 2:
                    stop = r, c
                    nodes.add(stop)

        def bp(nodes, r, c):
            if (r, c) == stop:
                return int(len(nodes) == 0)
            cnt = 0
            for r0, c0 in [(r,c+1), (r,c-1), (r+1,c), (r-1,c)]:
                p = r0, c0
                if p not in nodes: continue
                nodes.remove(p)
                cnt += bp(nodes, r0, c0)
                nodes.add(p)
            return cnt
        
        return bp(nodes, start[0], start[1])
```

击败90.15%