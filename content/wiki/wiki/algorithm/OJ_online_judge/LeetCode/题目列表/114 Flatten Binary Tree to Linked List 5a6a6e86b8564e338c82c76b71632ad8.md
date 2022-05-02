---
title: 114_Flatten_Binary_Tree_to_Linked_List_5a6a6e86b8564e338c82c76b71632ad8
---

# 114. Flatten Binary Tree to Linked List

Difficulty: Medium
ID: 114
Solved?: Yes
Tags: DFS, Tree
击败: 98.07
推荐指数: ⭐⭐⭐

[Flatten Binary Tree to Linked List - LeetCode](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/)

## 题意

Given a binary tree, flatten it to a linked list in-place.

For example, given the following tree:

```
    1
   / \
  2   5
 / \   \
3   4   6

```

The flattened tree should look like:

```
1
 \
  2
   \
    3
     \
      4
       \
        5
         \
          6

```

## 思路

1. DFS：前序遍历，注意子树的最后一个节点，因为它是用来串联的。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def flatten(self, root: TreeNode) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        if not root: return
        self.dfs(root)
    
    def dfs(self, root: TreeNode) -> TreeNode:
        left, right = root.left, root.right
        root.left = None
        last = root
        if left:
            last.right = left
            last = self.dfs(left)
        if right:
            last.right = right
            last = self.dfs(right)
        return last
```

击败98.07%

这里dfs返回的是树的最后一个节点，也可以返回树的首末节点。