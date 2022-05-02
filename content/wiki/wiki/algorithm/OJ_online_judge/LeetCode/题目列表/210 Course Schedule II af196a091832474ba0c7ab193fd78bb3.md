---
title: 210_Course_Schedule_II_af196a091832474ba0c7ab193fd78bb3
---

# 210. Course Schedule II

Difficulty: Medium
ID: 210
Solved?: Yes
Tags: BFS, DFS, Graph, Topological Sort
击败: 67.16
推荐指数: ⭐⭐⭐

[Course Schedule II - LeetCode](https://leetcode.com/problems/course-schedule-ii/)

[207. Course Schedule](207%20Course%20Schedule%2008422da8f3b34f0c8c494546eb27182d.md) 

## 题意

There are a total of `n` courses you have to take labelled from `0` to `n - 1`.

Some courses may have `prerequisites`, for example, if `prerequisites[i] = [ai, bi]` this means you must take the course `bi` before the course `ai`.

Given the total number of courses `numCourses` and a list of the `prerequisite` pairs, return the ordering of courses you should take to finish all courses.

If there are many valid answers, return **any** of them. If it is impossible to finish all courses, return **an empty array**.

**Example 1:**

```
Input: numCourses = 2, prerequisites = [1,0](1,0)
Output: [0,1]
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].

```

**Example 2:**

```
Input: numCourses = 4, prerequisites = [1,0](1,0)
Output: [0,2,1,3]
Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].

```

**Example 3:**

```
Input: numCourses = 1, prerequisites = []
Output: [0]

```

**Constraints:**

- `1 <= numCourses <= 2000`
- `0 <= prerequisites.length <= numCourses * (numCourses - 1)`
- `prerequisites[i].length == 2`
- `0 <= ai, bi < numCourses`
- `ai != bi`
- All the pairs `[ai, bi]` are **distinct**.

## 思路

1. DFS：拓扑排序，环的检测
2. BFS：入度

## 题解1

```python
WHITE = 0
GRAY = 1
BLACK = 2

class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        from collections import defaultdict
        G = defaultdict(list)
        for i in range(numCourses):
            G[i] = list()
        for u, v in prerequisites:
            G[v].append(u)
        
        has_cycle = False
        res = []

        def dfs(G, u):
            nonlocal has_cycle
            C[u] = GRAY
            for v in G[u]:
                if C[v] == GRAY:
                    has_cycle = True
                    return
                if C[v] == WHITE:
                    dfs(G, v)
            C[u] = BLACK
            res.append(u)
        
        C = {u: WHITE for u in G}  # Color
        for u in G:
            if C[u] == WHITE:
                dfs(G, u)
                
        return [] if has_cycle else res[::-1]
```

击败67.16%

## 题解2

```python
class Solution:
    def findOrder(self, numCourses, prerequisites):
        """
        :type numCourses: int
        :type prerequisites: List[List[int]]
        :rtype: List[int]
        """
        n = numCourses
        pre = prerequisites
        G = {}
        for u in range(n):
            G[u] = set()
        for u, v in pre:
            G[v].add(u)
        
        flag, res = self.topo_bfs(G)
        if flag:
            return res
        return []

    def topo_bfs(self, G):
        from collections import deque, defaultdict
        degree = defaultdict(int)
        for u in G:
            for v in G[u]:
                degree[v] += 1
        P = [u for u in G if degree[u] == 0]
        Q = deque(P)
        while Q:
            u = Q.popleft()
            for v in G[u]:
                degree[v] -= 1
                if degree[v] == 0:
                    P.append(v)
                    Q.append(v)
        return len(P) == len(G), P
```