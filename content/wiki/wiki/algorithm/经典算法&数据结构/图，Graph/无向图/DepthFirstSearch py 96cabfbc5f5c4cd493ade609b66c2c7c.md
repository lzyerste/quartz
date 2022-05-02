---
title: DepthFirstSearch_py_96cabfbc5f5c4cd493ade609b66c2c7c
---

# DepthFirstSearch.py

Description: Single-source connectivity. Given a graph, support queries of the form Are two given vertices connected? and How many connected components does the graph have?
其他: 单点出发可达性问题

```python
class DepthFirstSearch:
    """无向图单点出发的DFS搜索，解决可达性问题。
    """

    def __init__(self, G, s):
        self.visited = set()
        self.__dfs(G, s)

    def marked(self, v) -> bool:
        return v in self.visited

    def count(self) -> int:
        return len(self.visited)

    def __dfs(self, G: Graph, s):
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
```