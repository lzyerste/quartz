---
title: 101_Symmetric_Tree_e406aaaa1e514de9a6c062ebfc12ba12
---

# 101. Symmetric Tree

Difficulty: Easy
ID: 101
Solved?: Yes
Tags: BFS, DFS, Tree
击败: 93.75
推荐指数: ⭐⭐

[Symmetric Tree - LeetCode](https://leetcode.com/problems/symmetric-tree/)

## 题意

Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree `[1,2,2,3,4,4,3]` is symmetric:

```
    1
   / \
  2   2
 / \ / \
3  4 4  3

```

But the following `[1,2,2,null,3,null,3]` is not:

```
    1
   / \
  2   2
   \   \
   3    3

```

**Follow up:** Solve it both recursively and iteratively.

## 思路

1. 不要修改二叉树，分左右子树同步遍历，但使用镜像方向。DFS。
2. 修改二叉树，比如将右子树反转了，然后比较左右子树是否相同。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSymmetric(self, root: TreeNode) -> bool:
        if root is None: return True
        return self._symmetric(root.left, root.right)
    
    def _symmetric(self, L: TreeNode, R: TreeNode) -> bool:
        if L is None and R is None: return True
        if not (L and R): return False
        # L and R are valid
        if L.val != R.val: return False
        return self._symmetric(L.left, R.right) and self._symmetric(L.right, R.left)
```

击败93.75%