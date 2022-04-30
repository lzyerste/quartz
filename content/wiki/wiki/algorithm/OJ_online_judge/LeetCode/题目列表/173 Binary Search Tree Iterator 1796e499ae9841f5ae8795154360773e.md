---
title: 173_Binary_Search_Tree_Iterator_1796e499ae9841f5ae8795154360773e
---

# 173. Binary Search Tree Iterator

Difficulty: Medium
ID: 173
Solved?: Yes
Tags: Design, Stack, Tree
击败: 78.02
推荐指数: ⭐⭐⭐

[Binary Search Tree Iterator - LeetCode](https://leetcode.com/problems/binary-search-tree-iterator/)

[94. Binary Tree Inorder Traversal](94%20Binary%20Tree%20Inorder%20Traversal%2018f3bd8177974b9b97921a5859cb89bc.md) 

## 题意

Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.

Calling `next()` will return the next smallest number in the BST.

**Example:**

![https://assets.leetcode.com/uploads/2018/12/25/bst-tree.png](https://assets.leetcode.com/uploads/2018/12/25/bst-tree.png)

```
BSTIterator iterator = new BSTIterator(root);
iterator.next();    // return 3
iterator.next();    // return 7
iterator.hasNext(); // return true
iterator.next();    // return 9
iterator.hasNext(); // return true
iterator.next();    // return 15
iterator.hasNext(); // return true
iterator.next();    // return 20
iterator.hasNext(); // return false

```

**Note:**

- `next()` and `hasNext()` should run in average O(1) time and uses O() memory, where h is the height of the tree.
- You may assume that `next()` call will always be valid, that is, there will be at least a next smallest number in the BST when `next()` is called.

## 思路

1. 类似中序遍历的非递归做法。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class BSTIterator:

    def __init__(self, root: TreeNode):
        self.stack = []
        self._leftmostInorder(root)

    def _leftmostInorder(self, root: TreeNode):
        """
        For a given node, add all the elements in the leftmost branch of the tree
        under it to the stack.
        """
        while root:
            self.stack.append(root)
            root = root.left

    def next(self) -> int:
        """
        @return the next smallest number
        """
        top = self.stack.pop()
        if top.right:
            self._leftmostInorder(top.right)
        return top.val

    def hasNext(self) -> bool:
        """
        @return whether we have a next smallest number
        """
        return len(self.stack) > 0

# Your BSTIterator object will be instantiated and called as such:
# obj = BSTIterator(root)
# param_1 = obj.next()
# param_2 = obj.hasNext()
```