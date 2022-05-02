---
title: 105_Construct_Binary_Tree_from_Preorder_and_Inorde_5247cc18803a46358c26fe5ef086cf5e
---

# 105. Construct Binary Tree from Preorder and Inorder Traversal

Difficulty: Medium
ID: 105
Solved?: Yes
Tags: Array, DFS, Tree
击败: 37.7
推荐指数: ⭐⭐⭐

[Construct Binary Tree from Preorder and Inorder Traversal - LeetCode](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)

## 题意

Given preorder and inorder traversal of a tree, construct the binary tree.

**Note:**You may assume that duplicates do not exist in the tree.

For example, given

```
preorder = [3,9,20,15,7]
inorder = [9,3,15,20,7]
```

Return the following binary tree:

```
    3
   / \
  9  20
    /  \
   15   7
```

## 思路

1. 根据preorder，首个元素就是树根，接下来是左子树和右子树，但要确定它们的大小。根据树根在inorder中的位置，它左边的是左子树，它右边的是右子树，它们的大小是知道的。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> TreeNode:
        if not preorder: return None
        val = preorder[0]
        idx = inorder.index(val)
        root = TreeNode(val)
        root.left = self.buildTree(preorder[1:idx + 1], inorder[:idx])
        root.right = self.buildTree(preorder[idx + 1:], inorder[idx + 1:])
        return root
```

击败37.70%

因为每次inorder.index(val)需要花比较长的时间，而且拆解列表也要花时间。