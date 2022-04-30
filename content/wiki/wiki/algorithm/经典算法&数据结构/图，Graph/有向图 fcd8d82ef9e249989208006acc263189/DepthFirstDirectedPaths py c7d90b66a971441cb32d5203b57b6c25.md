---
title: DepthFirstDirectedPaths_py_c7d90b66a971441cb32d5203b57b6c25
---

# DepthFirstDirectedPaths.py

Description: Single-source directed paths. Given a digraph and a source vertex s, support queries of the form Is there a directed path from s to a given target vertex v? If so, find such a path.
其他: 单点出发到其他节点的路径

```python
from Digraph import *

class DepthFirstDirectedPaths:
    """有向图单点出发的路径。
    """

    def __init__(self, G: Digraph, s):
        self.edgeTo = {}  # w: v，边v->w
        self.visited = set()
        self.__dfs(G, s, self.visited)

    def __dfs(self, G: Digraph, v, vis: set):
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
    G = genTinyDigraph()
    paths = DepthFirstDirectedPaths(G, 8)
    for i in G.vertices():
        print(i, paths.pathTo(i))
```