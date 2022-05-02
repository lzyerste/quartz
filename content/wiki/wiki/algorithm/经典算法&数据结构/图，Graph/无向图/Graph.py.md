---
title: Graph.py
---

# Graph.py

Description: 无向图的表示

```python
class Graph:
    """无向无权重图的表示。
    可以用list或set表示邻节点。
    """
    
    def __init__(self):
        from collections import defaultdict
        self.G = defaultdict(list)
        self.cntEdges = 0  # 边的数量

    def V(self):
        """返回节点数量。
        """
        return len(self.G)

    def E(self):
        """返回边的数量。
        
        Returns:
            [type] -- [description]
        """
        return self.cntEdges

    def vertices(self):
        """返回所有节点。
        排序不是必要的，调试时方便打印查看。
        
        Returns:
            [type] -- [description]
        """
        return sorted(self.G.keys())

    def addEdge(self, v, w):
        """添加一条边，连接v和w。
        
        Arguments:
            v {[type]} -- [description]
            w {[type]} -- [description]
        """
        self.addNode(v)
        self.addNode(w)
        
        self.G[v].append(w)
        self.G[w].append(v)
        self.cntEdges += 1

    def addNode(self, v):
        """添加一个顶点。比如图中一个孤立的点。
        
        Arguments:
            v {[type]} -- [description]
        """
        if v not in self.G:
            self.G[v] = []

    def adj(self, v):
        """返回v的所有邻节点。
        
        Arguments:
            v {[type]} -- [description]
        
        Returns:
            [type] -- [description]
        """
        return self.G[v]

    def __str__(self):
        s = "%d vertices, %d Edges\n" % (self.V(), self.E())
        for v in sorted(self.G.keys()):
            s += str(v) + ": "
            s += " ".join(map(str, self.adj(v)))
            s += "\n"
        return s

def genTinyGraph():
    # tinyG.txt, p526页
    G = Graph()
    edges = [(0, 5), (4, 3), (0, 1), (9, 12), (6, 4), 
             (5, 4), (0, 2), (11, 12), (9, 10), (0, 6), 
             (7, 8), (9, 11), (5, 3)]
    for v, w in edges:
        G.addEdge(v, w)
    return G

if __name__ == "__main__":
    G = genTinyGraph()
    print(G)
```