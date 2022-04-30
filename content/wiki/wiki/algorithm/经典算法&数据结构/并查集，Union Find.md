---
title: 并查集，Union_Find
---

# 并查集，Union Find

精简版：

```python
class UF:
    def __init__(self):
        self.p = {}  # parent relationship

    def add(self, x):
        if x not in self.p:
            self.p[x] = x  # point to self

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x != y:
            self.p[x] = y

    def find(self, x):
        if self.p[x] != x:
            self.p[x] = self.find(self.p[x])
        return self.p[x]
```

algs4/UF.py

```python
class UF:
    def __init__(self):
        self.parent = {}
        self._count = 0  # 不相交集合数量

    def add(self, p):
        """添加一个新元素到并查集，需要另外建立集合。
        
        Arguments:
            p {[type]} -- [description]
        """
        if p not in self.parent:
            self.parent[p] = p
            self._count += 1

    def union(self, p, q):
        """合并两个集合（可能属于一个集合）。
        
        Arguments:
            p {[type]} -- [description]
            q {[type]} -- [description]
        """
        x = self.find(p)
        y = self.find(q)
        if x != y:
            self.parent[x] = y
            self._count -= 1
    
    def find(self, p):
        """寻找节点p所在的根节点。
        节点可以不存在，会新添加。
        带路径压缩。
        
        Arguments:
            p {[type]} -- [description]
        
        Returns:
            [type] -- [description]
        """
        self.add(p)
        if p != self.parent[p]:
            self.parent[p] = self.find(self.parent[p])
        return self.parent[p]

    def connected(self, p, q) -> bool:
        """节点p和q是否在同一个集合里。
        
        Arguments:
            p {[type]} -- [description]
            q {[type]} -- [description]
        
        Returns:
            bool -- [description]
        """
        return self.find(p) == self.find(q)

    def count(self) -> int:
        """返回UF有多少个不相交的集合。
        
        Returns:
            int -- [description]
        """
        return self._count

if __name__ == "__main__":
    uf = UF()
    # tinyUF.txt
    for i in range(10):
        uf.add(i)
    for (p, q) in [(4, 3), (3, 8), (6, 5), (9, 4), (2, 1), (8, 9), (5, 0), 
                    (7, 2), (6, 1), (1, 0), (6, 7)]:
        uf.union(p, q)
    assert uf.count() == 2
```