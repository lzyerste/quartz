---
title: 100_Same_Tree_9c46beaaa16246dd95bc9c8a989ff251
---

# 100. Same Tree

Difficulty: Easy
ID: 100
Solved?: Yes
Tags: Recursive, Tree
击败: 12.65
推荐指数: ⭐⭐

[Loading...](https://leetcode.com/problems/same-tree/)

## 题意

## 题解1：简单递归

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isSameTree(self, p: TreeNode, q: TreeNode) -> bool:
        if p is None and q is None: return True  # 皆空
        if p is None or q is None: return False  # 一空一非空
        # 两者皆不空，比较自身、左子树及右子树
        return p.val == q.val and self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)
```