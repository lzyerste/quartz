---
title: 133_Clone_Graph_acf08480f7eb470fa76b3a9a88b0b4f0
---

# 133. Clone Graph

Difficulty: Medium
ID: 133
Solved?: Yes
Tags: BFS, DFS, Graph
击败: 50.53
推荐指数: ⭐⭐⭐

[Clone Graph - LeetCode](https://leetcode.com/problems/clone-graph/)

## 题意

Given a reference of a node in a **[connected](https://en.wikipedia.org/wiki/Connectivity_(graph_theory)#Connected_graph)** undirected graph.

Return a **[](https://en.wikipedia.org/wiki/Object_copying#Deep_copy)** (clone) of the graph.

Each node in the graph contains a val (`int`) and a list (`List[Node]`) of its neighbors.

```
class Node {
    public int val;
    public List<Node> neighbors;
}

```

**Test case format:**

For simplicity sake, each node's value is the same as the node's index (1-indexed). For example, the first node with `val = 1`, the second node with `val = 2`, and so on. The graph is represented in the test case using an adjacency list.

**Adjacency list** is a collection of unordered **lists** used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with `val = 1`. You must return the **copy of the given node** as a reference to the cloned graph.

**Example 1:**

![https://assets.leetcode.com/uploads/2019/11/04/133_clone_graph_question.png](https://assets.leetcode.com/uploads/2019/11/04/133_clone_graph_question.png)

```
Input: adjList = [2,4](2,4)
Output: [2,4](2,4)
Explanation: There are 4 nodes in the graph.
1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/01/07/graph.png](https://assets.leetcode.com/uploads/2020/01/07/graph.png)

```
Input: adjList = [133 Clone Graph acf08480f7eb470fa76b3a9a88b0b4f0](.md)
Output: [133 Clone Graph acf08480f7eb470fa76b3a9a88b0b4f0](.md)
Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.

```

**Example 3:**

```
Input: adjList = []
Output: []
Explanation: This an empty graph, it does not have any nodes.

```

**Example 4:**

![https://assets.leetcode.com/uploads/2020/01/07/graph-1.png](https://assets.leetcode.com/uploads/2020/01/07/graph-1.png)

```
Input: adjList = [2](2)
Output: [2](2)

```

**Constraints:**

- `1 <= Node.val <= 100`
- `Node.val` is unique for each node.
- Number of Nodes will not exceed 100.
- There is no repeated edges and no self-loops in the graph.
- The Graph is connected and all nodes can be visited starting from the given node.

## 思路

1. DFS：先克隆所有节点，然后克隆所有边。

## 题解

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []
"""

class Solution:
    def cloneGraph(self, node: 'Node') -> 'Node':
        if not node: return node
        G = {}
        nodes = set()
        self.dfs(node, nodes)
        for u in nodes:
            G[u] = Node(u.val)
        for u in nodes:
            x = G[u]
            for v in u.neighbors:
                x.neighbors.append(G[v])
        return G[node]
    
    def dfs(self, u, nodes):
        if u in nodes: return
        nodes.add(u)
        for v in u.neighbors:
            self.dfs(v, nodes)
```

击败50.53%