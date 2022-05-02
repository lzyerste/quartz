---
title: 102_Binary_Tree_Level_Order_Traversal_dfa97e2a5d674626981bcb598a4b5448
---

# 102. Binary Tree Level Order Traversal

Difficulty: Medium
ID: 102
Solved?: Yes
Tags: BFS, Tree
击败: 95.13
推荐指数: ⭐⭐

[Binary Tree Level Order Traversal - LeetCode](https://leetcode.com/problems/binary-tree-level-order-traversal/)

## 题意

Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:Given binary tree `[3,9,20,null,null,15,7]`,

```
    3
   / \
  9  20
    /  \
   15   7

```

return its level order traversal as:

```
[
  [3],
  [9,20],
  [15,7]
]

```

## 思路

1. 使用队列保存每层的节点。
2. DFS？记录遍历到节点时的深度？

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def levelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root: return []
        res = []
        queue = [root]
        while queue:
            level = []
            q2 = []
            for node in queue:
                level.append(node.val)
                if node.left: q2.append(node.left)
                if node.right: q2.append(node.right)
            queue = q2
            res.append(level)
        return res
```

击败95.13%