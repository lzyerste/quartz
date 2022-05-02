---
title: Cycle.py
---

# Cycle.py

Description: Cycle detection. Support this query: Is a given graph acylic?
其他: 无向图中环的检测

```python
from Graph import *

class Cycle:
    """检测无向图是否有环。
    注意过滤parent。
    """

    def __init__(self, G: Graph):
        self._hasCycle = False
        visited = set()
        for v in G.vertices():
            if v not in visited:
                self.__dfs(G, v, None, visited)

    def __dfs(self, G: Graph, v, parent, vis: set):
        vis.add(v)
        for w in G.adj(v):
            if w == parent: continue  # 因为是无向图，会有条边指向父节点。
            if w in vis:  # 无向图中dfs可达的都是连通的，所以无需当前路径一说。
                self._hasCycle = True
            else:
                self.__dfs(G, w, v, vis)

    def hasCycle(self) -> bool:
        return self._hasCycle

if __name__ == "__main__":
    G = genTinyGraph()
    cycle = Cycle(G)
    print(cycle.hasCycle())
```