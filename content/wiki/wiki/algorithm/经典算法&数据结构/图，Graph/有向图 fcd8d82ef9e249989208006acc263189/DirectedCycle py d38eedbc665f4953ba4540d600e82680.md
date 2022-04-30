---
title: DirectedCycle_py_d38eedbc665f4953ba4540d600e82680
---

# DirectedCycle.py

Description: Directed cycle detection. Does a given digraph have a directed cycle? If so, find the vertices on some such cycle, in order from some vertex back to itself.
其他: 有向图中环的检测

- 注意要记录搜索的当前路径，而不是是否已访问记录。

```python
from Digraph import *

class DirectedCycle:
    """有向图中环的检测。
    注意要记录当前搜索的路径。
    """

    def __init__(self, G: Digraph):
        self._cycle = None
        self.edgeTo = {}  # 用于回溯路径，key为child，value为parent
        self.visited = set()

        path = set()  # 记录本次搜索的当前路径
        for v in G.vertices():
            if v not in self.visited:
                self.__dfs(G, v, path)

    def __dfs(self, G: Digraph, v, path: set):
        self.visited.add(v)
        path.add(v)  # 进来的时候加上（pre），返回的时候去掉（post）
        for w in G.adj(v):
            if self.hasCycle(): return  # !!重要
            self.edgeTo[w] = v
            if w not in self.visited:
                self.__dfs(G, w, path)
            elif w in path:
                # has cycle，从w到w
                self._cycle = [w]  # 最后的w
                x = v
                while x != w:  # 中间节点
                    self._cycle.append(x)
                    x = self.edgeTo[x]
                self._cycle.append(w)  # 第一个w
                self._cycle = self._cycle[::-1]
        path.remove(v)

    def hasCycle(self) -> bool:
        return self._cycle is not None

    def cycle(self):
        return self._cycle

if __name__ == "__main__":
    G = genTinyDigraph()
    cycle = DirectedCycle(G)
    print(cycle.hasCycle())
    print(cycle.cycle())

    print("-" * 20)

    G = Digraph()
    G.addEdge(0, 5)
    G.addEdge(5, 4)
    G.addEdge(4, 3)
    G.addEdge(3, 5)
    cycle = DirectedCycle(G)
    print(cycle.hasCycle())
    print(cycle.cycle())
```