---
title: KosarajuSCC_py_1aeb1e62e1404c83924aba88fba5157b
---

# KosarajuSCC.py

Description: Strong connectivity. Given a digraph, support queries of the form: Are two given vertices strongly connected ? and How many strong components does the digraph have ?
其他: 强连通体的生成。
依赖DepthFirstOrder来生成访问的后序逆。

```python
from Digraph import *
from DepthFirstOrder import *

class KosarajuSCC:
    """SCC: 强连通体。
    """

    def __init__(self, G: Digraph):
        self._id = {}  # 也可以作为已访问节点记录
        self._count = 0

        GT = G.reverse()
        order = DepthFirstOrder(GT)
        reverseOrder = order.reversePost()
        for s in reverseOrder:
            if s not in self._id:
                self.__dfs(G, s, self._count)
                self._count += 1

    def __dfs(self, G: Digraph, v, cnt):
        self._id[v] = cnt
        for w in G.adj(v):
            if w not in self._id:
                self.__dfs(G, w, cnt)

    def id(self, v):
        return self._id[v]

    def count(self):
        return self._count

    def stronlyConnected(self, v, w):
        return self.id(v) == self.id(w)

if __name__ == "__main__":
    G = genTinyDigraph()
    cc = KosarajuSCC(G)
    M = cc.count()
    print("%d components" % M)

    from collections import defaultdict
    components = defaultdict(list)
    for v in G.vertices():
        components[cc.id(v)].append(v)
    for nodes in components.values():
        print(" ".join(map(str, nodes)))
```