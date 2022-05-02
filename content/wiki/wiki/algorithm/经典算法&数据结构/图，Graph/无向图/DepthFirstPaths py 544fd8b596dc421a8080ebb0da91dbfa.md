---
title: DepthFirstPaths_py_544fd8b596dc421a8080ebb0da91dbfa
---

# DepthFirstPaths.py

Description: Single-source paths. Given a graph and a source vertex s, support queries of the form Is there a path from s to a given target vertex v? If so, find such a path.
其他: 单点出发到其他节点的路径

```python
from Graph import *

class DepthFirstPaths:
    """无向图单点出发的路径。
    """

    def __init__(self, G: Graph, s):
        self.edgeTo = {}  # w: v，边v->w
        self.visited = set()
        self.__dfs(G, s, self.visited)

    def __dfs(self, G: Graph, v, vis: set):
        vis.add(v)
        for w in G.adj(v):
            if w not in vis:
                self.edgeTo[w] = v
                self.__dfs(G, w, vis)

    def hasPathTo(self, v):
        """s能否到达v。
        
        Arguments:
            v {[type]} -- [description]
        
        Returns:
            [type] -- [description]
        """
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
    G = genTinyGraph()
    paths = DepthFirstPaths(G, 0)
    for i in G.vertices():
        print(i, paths.pathTo(i))
```