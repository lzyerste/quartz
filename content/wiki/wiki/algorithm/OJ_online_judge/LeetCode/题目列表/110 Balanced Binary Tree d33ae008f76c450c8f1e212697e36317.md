---
title: 110_Balanced_Binary_Tree_d33ae008f76c450c8f1e212697e36317
---

# 110. Balanced Binary Tree

Difficulty: Easy
ID: 110
Solved?: Yes
Tags: DFS, Tree
击败: 83.22
推荐指数: ⭐⭐⭐

[Balanced Binary Tree - LeetCode](https://leetcode.com/problems/balanced-binary-tree/)

## 题意

Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as:

> a binary tree in which the left and right subtrees of every node differ in height by no more than 1.
> 

**Example 1:**

![https://assets.leetcode.com/uploads/2020/10/06/balance_1.jpg](https://assets.leetcode.com/uploads/2020/10/06/balance_1.jpg)

```
Input: root = [3,9,20,null,null,15,7]
Output: true

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/10/06/balance_2.jpg](https://assets.leetcode.com/uploads/2020/10/06/balance_2.jpg)

```
Input: root = [1,2,2,3,3,null,null,4,4]
Output: false

```

**Example 3:**

```
Input: root = []
Output: true

```

**Constraints:**

- The number of nodes in the tree is in the range `[0, 5000]`.
- `104 <= Node.val <= 104`

## 思路

1. 一棵树是否高度平衡，需要判断左右子树都是高度平衡的，而且它们的高度最多相差1。检查一棵树，既返回它是否平衡，又返回它的高度。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isBalanced(self, root: TreeNode) -> bool:
        return self._balanced(root)[0]
    
    def _balanced(self, root: TreeNode) -> (bool, int):
        if not root: return True, 0
        l_b, l_h = self._balanced(root.left)
        if not l_b: return False, -1
        r_b, r_h = self._balanced(root.right)
        if not r_b: return False, -1
        if abs(l_h - r_h) > 1: return False, -1
        return True, max(l_h, r_h) + 1
```

击败83.22%