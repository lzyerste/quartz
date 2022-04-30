---
title: TwoColor.py
---

# TwoColor.py

Description: Two-colorability. Support this query: Can the vertices of a given graph be assigned one of two colors in such a way that no edge connects vertices of the same color ? which is equivalent to this question: Is the graph bipartite ?
其他: 相邻两个节点颜色不同

```python
from Graph import *

class TwoColor:
    """图能否两色间隔地着色。
    相邻节点不能是同色。
    """

    def __init__(self, G: Graph):
        self.isTwoColorable = True
        self.color = {}
        visited = set()
        for v in G.vertices():
            if v not in visited:
                self.__dfs(G, v, visited, True)

    def __dfs(self, G: Graph, v, vis: set, color: bool):
        vis.add(v)
        self.color[v] = color
        for w in G.adj(v):
            if w not in vis:
                self.__dfs(G, w, vis, not color)
            elif self.color[w] == self.color[v]:
                self.isTwoColorable = False

    def isBipartite(self) -> bool:
        return self.isTwoColorable

if __name__ == "__main__":
    G = genTinyGraph()
    twoColor = TwoColor(G)
    print(twoColor.isBipartite())  # False
```