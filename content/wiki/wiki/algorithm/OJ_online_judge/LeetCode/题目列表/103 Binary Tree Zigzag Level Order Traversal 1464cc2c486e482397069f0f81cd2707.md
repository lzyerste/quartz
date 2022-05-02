---
title: 103_Binary_Tree_Zigzag_Level_Order_Traversal_1464cc2c486e482397069f0f81cd2707
---

# 103. Binary Tree Zigzag Level Order Traversal

Difficulty: Medium
ID: 103
Solved?: Yes
Tags: BFS, Stack, Tree
击败: 97.72
推荐指数: ⭐⭐

[Binary Tree Zigzag Level Order Traversal - LeetCode](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/)

## 题意

Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

For example:Given binary tree `[3,9,20,null,null,15,7]`,

```
    3
   / \
  9  20
    /  \
   15   7

```

return its zigzag level order traversal as:

```
[
  [3],
  [20,9],
  [15,7]
]

```

## 思路

1. 按照常规的层序遍历，只是将每层的遍历结果按照zigzag方式返回。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def zigzagLevelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root: return []
        res = []
        queue = [root]
        to_right = True
        while queue:
            level = []
            q2 = []
            for node in queue:
                level.append(node.val)
                if node.left: q2.append(node.left)
                if node.right: q2.append(node.right)
            if to_right:
                res.append(level)
            else:
                res.append(level[::-1])
            to_right = not to_right
            queue = q2
        return res
```

击败97.72%