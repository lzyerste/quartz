---
title: 107_Binary_Tree_Level_Order_Traversal_II_9e5478f5f3b84a62859868ee2d2e8a76
---

# 107. Binary Tree Level Order Traversal II

Difficulty: Easy
ID: 107
Solved?: Yes
Tags: BFS, Tree
击败: 83.74
推荐指数: ⭐⭐

[Binary Tree Level Order Traversal II - LeetCode](https://leetcode.com/problems/binary-tree-level-order-traversal-ii/)

[102. Binary Tree Level Order Traversal](102 Binary Tree Level Order Traversal dfa97e2a5d674626981bcb598a4b5448.md) 

## 题意

Given a binary tree, return the bottom-up level order traversal of its nodes' values. (ie, from left to right, level by level from leaf to root).

For example:Given binary tree `[3,9,20,null,null,15,7]`,

```
    3
   / \
  9  20
    /  \
   15   7

```

return its bottom-up level order traversal as:

```
[
  [15,7],
  [9,20],
  [3]
]
```

## 思路

1. 层序遍历后，反转结果。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def levelOrderBottom(self, root: TreeNode) -> List[List[int]]:
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
        return res[::-1]
```

击败83.74%