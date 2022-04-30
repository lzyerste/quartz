---
title: DijkstraSP_py_aadcdf4df5164aa08313c8f1eed21eca
---

# DijkstraSP.py

Description: Single-source shortest paths. Given an edge-weighted digraph and a source ver- tex s, support queries of the form Is there a directed path from s to a given target vertex t? If so, find a shortest such path (one whose total weight is minimal).
备注: 有向图，单点出发最短路径

```python
import heapq
from collections import defaultdict

class DijkstraSP:
    def __init__(self, G, s):
        self._visited = set()
        self._edgeTo = {}
        self._distTo = {}
        self._heap = [(0.0, s)]

        for v in G:
            self._distTo[v] = float("inf")
        self._distTo[s] = 0.0

        while self._heap:
            v = heapq.heappop(self._heap)[1]
            if v in self._visited: continue
            self.__relax(G, v)

    def __relax(self, G, v):
        self._visited.add(v)
        for w, weight in G[v].items():
            if self._distTo[v] + weight < self._distTo[w]:
                self._distTo[w] = self._distTo[v] + weight
                self._edgeTo[w] = v
                heapq.heappush(self._heap, (self._distTo[w], w))

    def distTo(self, v):
        return self._distTo[v]

def genTinyEWD():
    G = defaultdict(defaultdict)
    edges = [(4, 5, 0.35), (5, 4, 0.35), (4, 7, 0.37), (5, 7, 0.28), 
             (7, 5, 0.28), (5, 1, 0.32), (0, 4, 0.38), (0, 2, 0.26), 
             (7, 3, 0.39), (1, 3, 0.29), (2, 7, 0.34), (6, 2, 0.40), 
             (3, 6, 0.52), (6, 0, 0.58), (6, 4, 0.93)]
    for u, v, w in edges:
        G[u][v] = w
    return G

if __name__ == "__main__":
    G = genTinyEWD()
    s = 0
    Dij = DijkstraSP(G, s)
    for v in sorted(G.keys()):
        print(v, Dij.distTo(v))
```