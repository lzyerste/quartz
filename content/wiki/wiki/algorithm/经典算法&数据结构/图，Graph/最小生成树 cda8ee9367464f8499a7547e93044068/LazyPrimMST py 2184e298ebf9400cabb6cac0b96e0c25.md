---
title: LazyPrimMST_py_2184e298ebf9400cabb6cac0b96e0c25
---

# LazyPrimMST.py

备注: 收集顶点，最小割。

```python
import heapq
from collections import defaultdict

class LazyPrimMST:
    """最小生成树MST。
    使用贪心算法。相当于维护一个已访问集合，将它们的临边都纳入最小堆中，
    每次都挑选权重最小的边，加入一个节点，同时临边又扩散了。
    无向带权重图直接用defaultdict表示。
    键为节点，value又是一个defaultdict，记录邻边的权重。
    Lazy是指加入一个顶点后，最小堆中有些边其实失效了，但并不马上清理，
    等到从堆中弹出时检查。
    """

    def __init__(self, G):
        self._visited = set()
        self._edges = []  # (v, w, weight)
        self._heap = []  # (weight, v, w)

        s = list(G.keys())[0]
        self.__visit(G, s)
        while self._heap:
            weight, v, w = heapq.heappop(self._heap)
            # 最小堆中存在已访问的边，忽略就行。
            if v in self._visited and w in self._visited: continue
            self._edges.append((v, w, weight))
            # 扩展MST
            if v not in self._visited: self.__visit(G, v)
            if w not in self._visited: self.__visit(G, w)

    def __visit(self, G, v):
        """访问一个节点，将其未访问的邻边都放入最小堆中。
        
        Arguments:
            G {[type]} -- [description]
            v {[type]} -- [description]
        """
        self._visited.add(v)
        for w, weight in G[v].items():
            if w not in self._visited:
                heapq.heappush(self._heap, (weight, v, w))

    def weight(self) -> float:
        return sum(_[2] for _ in self._edges)

    def edges(self):
        return self._edges

def genTinyEWG():
    # P604页
    G = defaultdict(defaultdict)
    edges = [(4,5,.35), (4,7,.37), (5,7,.28), (0,7,.16), 
             (1,5,.32), (0,4,.38), (2,3,.17), (1,7,.19), 
             (0,2,.26), (1,2,.36), (1,3,.29), (2,7,.34), 
             (6,2,.40), (3,6,.52), (6,0,.58), (6,4,.93)]
    for u, v, w in edges:
        G[u][v] = w
        G[v][u] = w
    return G

if __name__ == "__main__":
    G = genTinyEWG()
    mst = LazyPrimMST(G)
    print(mst.weight())  # 1.81
    for u, v, w in mst.edges():
        print("%s-%s %s" % (u, v, w))
```