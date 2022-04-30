---
title: 106_Construct_Binary_Tree_from_Inorder_and_Postord_7fb49728220d45b494208a87158016da
---

# 106. Construct Binary Tree from Inorder and Postorder Traversal

Difficulty: Medium
ID: 106
Solved?: Yes
Tags: Array, DFS, Tree
击败: 25.5
推荐指数: ⭐⭐

[Construct Binary Tree from Inorder and Postorder Traversal - LeetCode](https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/)

[105. Construct Binary Tree from Preorder and Inorder Traversal](105%20Construct%20Binary%20Tree%20from%20Preorder%20and%20Inorde%205247cc18803a46358c26fe5ef086cf5e.md) 

## 题意

Given inorder and postorder traversal of a tree, construct the binary tree.

**Note:**You may assume that duplicates do not exist in the tree.

For example, given

```
inorder = [9,3,15,20,7]
postorder = [9,15,7,20,3]
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

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> TreeNode:
        if not inorder: return None
        val = postorder.pop()
        idx = inorder.index(val)
        root = TreeNode(val)
        root.left = self.buildTree(inorder[:idx], postorder[:idx])
        root.right = self.buildTree(inorder[idx + 1:], postorder[idx:])
        return root
```

击败25.50%