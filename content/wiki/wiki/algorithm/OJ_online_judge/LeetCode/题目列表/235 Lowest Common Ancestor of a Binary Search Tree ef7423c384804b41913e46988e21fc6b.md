---
title: 235_Lowest_Common_Ancestor_of_a_Binary_Search_Tree_ef7423c384804b41913e46988e21fc6b
---

# 235. Lowest Common Ancestor of a Binary Search Tree

Difficulty: Easy
ID: 235
Solved?: Yes
Tags: Tree
击败: 80.75
推荐指数: ⭐⭐⭐

[Lowest Common Ancestor of a Binary Search Tree - LeetCode](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## 题意

Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the [definition of LCA on Wikipedia](https://en.wikipedia.org/wiki/Lowest_common_ancestor): “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow **a node to be a descendant of itself**).”

**Example 1:**

![https://assets.leetcode.com/uploads/2018/12/14/binarysearchtree_improved.png](https://assets.leetcode.com/uploads/2018/12/14/binarysearchtree_improved.png)

```
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.

```

**Example 2:**

![https://assets.leetcode.com/uploads/2018/12/14/binarysearchtree_improved.png](https://assets.leetcode.com/uploads/2018/12/14/binarysearchtree_improved.png)

```
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.

```

**Example 3:**

```
Input: root = [2,1], p = 2, q = 1
Output: 2

```

**Constraints:**

- The number of nodes in the tree is in the range `[2, 105]`.
- `109 <= Node.val <= 109`
- All `Node.val` are **unique**.
- `p != q`
- `p` and `q` will exist in the BST.

## 思路

1. 递归：如果root的值介于p跟q之间，那么，它就是公共祖先。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def lowestCommonAncestor(self, root: 'TreeNode', p: 'TreeNode', q: 'TreeNode') -> 'TreeNode':
        if (root.val - p.val) * (root.val - q.val) <= 0:
            return root
        if p.val < root.val:
            return self.lowestCommonAncestor(root.left, p, q)
        if p.val > root.val:
            return self.lowestCommonAncestor(root.right, p, q)
```

击败80.75%