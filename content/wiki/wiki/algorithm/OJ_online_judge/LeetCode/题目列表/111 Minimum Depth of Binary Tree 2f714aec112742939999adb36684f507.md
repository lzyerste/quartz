---
title: 111_Minimum_Depth_of_Binary_Tree_2f714aec112742939999adb36684f507
---

# 111. Minimum Depth of Binary Tree

Difficulty: Easy
ID: 111
Solved?: Yes
Tags: BFS, DFS, Tree
击败: 37.09
推荐指数: ⭐⭐⭐

[Minimum Depth of Binary Tree - LeetCode](https://leetcode.com/problems/minimum-depth-of-binary-tree/)

## 题意

Given a binary tree, find its minimum depth.

The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.

**Note:** A leaf is a node with no children.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/10/12/ex_depth.jpg](https://assets.leetcode.com/uploads/2020/10/12/ex_depth.jpg)

```
Input: root = [3,9,20,null,null,15,7]
Output: 2

```

**Example 2:**

```
Input: root = [2,null,3,null,4,null,5,null,6]
Output: 5

```

**Constraints:**

- The number of nodes in the tree is in the range `[0, 105]`.
- `1000 <= Node.val <= 1000`

## 思路

1. DFS：注意，必须遍历到真的叶子节点才算数。
2. BFS：层序遍历的话，从上到下，遇到第一个叶子节点就是最短深度了。

## 题解：DFS

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def minDepth(self, root: TreeNode) -> int:
        if not root: return 0
        if not root.left and not root.right: return 1
        d = float("inf")
        if root.left:
            d = min(d, self.minDepth(root.left) + 1)
        if root.right:
            d = min(d, self.minDepth(root.right) + 1)
        return d
```

击败9.04%，因为遍历了整棵树。

## 题解：BFS

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def minDepth(self, root: TreeNode) -> int:
        if not root: return 0
        depth = 0
        queue = [root]
        while queue:
            q2 = []
            depth += 1
            for node in queue:
                if not node.left and not node.right:
                    return depth
                if node.left: q2.append(node.left)
                if node.right: q2.append(node.right)
            queue = q2
        return depth
```

击败37.09%