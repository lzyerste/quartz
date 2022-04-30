---
title: DepthFirstOrder_py_6adcde1741a747908d3087e90d478ce3
---

# DepthFirstOrder.py

Description: 生成访问记录，包括前序、后序及后序的逆。

```python
from Digraph import *

class DepthFirstOrder:
    """有向图DFS时节点的访问顺序。
    前序标记及后续标记。
    """

    def __init__(self, G: Digraph):
        self._pre = []
        self._post = []
        self._reversePost = []

        visited = set()
        for v in G.vertices():
            if v not in visited:
                self.__dfs(G, v, visited)

    def __dfs(self, G: Digraph, v, vis):
        vis.add(v)
        self._pre.append(v)
        for w in G.adj(v):
            if w not in vis:
                self.__dfs(G, w, vis)
        self._post.append(v)

    def pre(self):
        return self._pre

    def post(self):
        return self._post

    def reversePost(self):
        return self._post[::-1]

def genTopoGraph():
    # P583页
    G = Digraph()
    edges = [(0, 1), (0, 5), (0, 6), (2, 0), (2, 3),
             (3, 5), (5, 4), (6, 4), (6, 9), (7, 6),
             (8, 7), (9, 10), (9, 11), (9, 12), (11, 12)]
    for v, w in edges:
        G.addEdge(v, w)
    return G

if __name__ == "__main__":
    G = genTopoGraph()
    order = DepthFirstOrder(G)
    print(order.pre())  # [0, 1, 5, 4, 6, 9, 10, 11, 12, 2, 3, 7, 8]
    print(order.post())  # [1, 4, 5, 10, 12, 11, 9, 6, 0, 3, 2, 7, 8]
    print(order.reversePost())  # [8, 7, 2, 3, 0, 6, 9, 11, 12, 10, 5, 4, 1]
```