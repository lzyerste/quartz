---
title: Topological_py_063705e8900f49e5bc1ba0fe16b60161
---

# Topological.py

Description: Topological sort. Given a digraph, put the vertices in order such that all its directed edges point from a ver- tex earlier in the order to a vertex later in the order (or report that doing so is not possible).
其他: 有向图的拓扑排序，依赖DirectedCycle来检测是否有环。依赖DepthFirstOrder来生成访问的后序逆。

```python
from Digraph import *
from DepthFirstOrder import *
from DirectedCycle import *

class Topological:
    """DAG的拓扑排序。
    这里利用了post order。
    拓扑排序的另一种做法是根据入度，入度为0表示无依赖，可以出队列。
    """

    def __init__(self, G: Digraph):
        self._order = None
        cycleFinder = DirectedCycle(G)
        if not cycleFinder.hasCycle():
            dfs = DepthFirstOrder(G)
            self._order = dfs.reversePost()

    def isDAG(self):
        return self._order is not None

    def order(self):
        return self._order

if __name__ == "__main__":
    G = genTopoGraph()
    topo = Topological(G)
    print(topo.order())  # [8, 7, 2, 3, 0, 6, 9, 11, 12, 10, 5, 4, 1]
```