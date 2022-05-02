---
title: CC.py
---

# CC.py

Description: Connected components.
其他: 无向图中的连通体

```python
from Graph import *

class CC:
    """无向图中的连通体：Connected Componnets.
    """

    def __init__(self, G: Graph):
        self._id = {}  # 也可以作为已访问节点记录
        self._count = 0
        
        for v in G.vertices():
            if v not in self._id:  # visited
                self.__dfs(G, v, self._count)
                self._count += 1

    def connected(self, v, w):
        return self.id(v) == self.id(w)

    def count(self) -> int:
        return self._count

    def id(self, v) -> int:
        return self._id[v]

    def __dfs(self, G, v, id):
        self._id[v] = id
        for w in G.adj(v):
            if w not in self._id:
                self.__dfs(G, w, id)

if __name__ == "__main__":
    G = genTinyGraph()
    cc = CC(G)
    M = cc.count()
    print("%d components" % M)

    from collections import defaultdict
    components = defaultdict(list)
    for v in G.vertices():
        components[cc.id(v)].append(v)
    for nodes in components.values():
        print(" ".join(map(str, nodes)))
```