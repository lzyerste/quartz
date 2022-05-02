---
title: DirectedDFS.py
---

# DirectedDFS.py

Description: Single-source reachability. Given a digraph and a source vertex s, support queries of the form Is there a directed path from s to a given target vertex v?
其他: 单点出发可达性问题，同时也使用多点出发。
Multiple-source reachability. Given a digraph and a set of source vertices, sup- port queries of the form Is there a directed path from any vertex in the set to a given target vertex v?

```python
from Digraph import *

class DirectedDFS:
    def __init__(self, G: Digraph, sources):
        """有向图单点或多点出发的DFS遍历。
        algs4第571页。
        
        Arguments:
            G {[type]} -- [description]
            sources {[type]} -- [description]
        """
        self.visited = set()
        for s in sources:
            self.__dfs(G, s)

    def marked(self, v) -> bool:
        return v in self.visited

    def count(self) -> int:
        return len(self.visited)

    def __dfs(self, G: Digraph, s):
        """深度优先搜索。
        将s标记为已访问，然后递归其尚未访问的邻节点。
        
        Arguments:
            G {[type]} -- [description]
            s {[type]} -- [description]
        """
        self.visited.add(s)
        for w in G.adj(s):
            if w not in self.visited:
                self.__dfs(G, w)

def test(sources):
    G = genTinyDigraph()
    dg = DirectedDFS(G, sources)
    print([v for v in G.vertices() if dg.marked(v)])

if __name__ == "__main__":
    test([1])  # 1
    test([2])  # 0 1 2 3 4 5
    test([1, 2, 6])  # 0 1 2 3 4 5 6 9 10 11 12
```