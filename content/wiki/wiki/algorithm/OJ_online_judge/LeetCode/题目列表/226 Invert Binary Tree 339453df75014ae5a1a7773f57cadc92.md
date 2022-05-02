---
title: 226_Invert_Binary_Tree_339453df75014ae5a1a7773f57cadc92
---

# 226. Invert Binary Tree

Difficulty: Easy
ID: 226
Solved?: Yes
Tags: Tree
击败: 99.06
推荐指数: ⭐⭐⭐

[Invert Binary Tree - LeetCode](https://leetcode.com/problems/invert-binary-tree/)

## 题意

Invert a binary tree.

**Example:**

Input:

```
     4
   /   \
  2     7
 / \   / \
1   3 6   9
```

Output:

```
     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

**Trivia:**This problem was inspired by [this original tweet](https://twitter.com/mxcl/status/608682016205344768) by [Max Howell](https://twitter.com/mxcl):

> Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so f*** off.
> 

## 思路

1. 递归法

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def invertTree(self, root: TreeNode) -> TreeNode:
        if not root: return root
        left = self.invertTree(root.left)
        right = self.invertTree(root.right)
        root.left = right
        root.right = left
        return root
```

击败99.06%