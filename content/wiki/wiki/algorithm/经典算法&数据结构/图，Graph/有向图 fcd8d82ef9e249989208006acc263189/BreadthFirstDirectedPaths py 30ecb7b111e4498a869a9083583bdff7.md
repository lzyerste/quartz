---
title: BreadthFirstDirectedPaths_py_30ecb7b111e4498a869a9083583bdff7
---

# BreadthFirstDirectedPaths.py

Description: Single-source shortest directed paths. Given a digraph and a source vertex s, support queries of the form Is there a directed path from s to a given target vertex v? If so, find a shortest such path (one with a minimal number of edges).
其他: 单点出发到其他节点的最短路径

```python
from Digraph import *

class BreadthFirstDirectedPaths:
    """BFS：有向图单点出发最短路径。
    """

    def __init__(self, G, s):
        self.visited = set()
        self.edgeTo = {}
        self.__bfs(G, s)

    def __bfs(self, G: Digraph, s):
        from collections import deque
        queue = deque()
        self.visited.add(s)
        queue.append(s)
        while queue:
            v = queue.popleft()  # queue中元素都已处理过
            for w in G.adj(v):
                if w not in self.visited:
                    self.visited.add(w)
                    self.edgeTo[w] = v
                    queue.append(w)

    def hasPathTo(self, v):
        return v in self.visited

    def pathTo(self, v):
        if not self.hasPathTo(v): return []
        path = []
        while v in self.edgeTo:
            path.append(v)
            v = self.edgeTo[v]
        path.append(v)  # s
        return path[::-1]

if __name__ == "__main__":
    G = genTinyDigraph()
    paths = BreadthFirstDirectedPaths(G, 8)
    for v in G.vertices():
        print(v, paths.pathTo(v))
```