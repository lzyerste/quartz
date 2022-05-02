---
title: 98_Validate_Binary_Search_Tree_5eae44ce8c6b4324b9fe805679acf8b0
---

# 98. Validate Binary Search Tree

Difficulty: Medium
ID: 98
Solved?: Yes
Tags: Recursive, Tree
击败: 18.63
推荐指数: ⭐⭐⭐

[Validate Binary Search Tree - LeetCode](https://leetcode.com/problems/validate-binary-search-tree/)

## 题意

## 题解1：自底向上

求出子树是否合法，以及它的最小值及最大值。

汇总左右子树后比较。

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isValidBST(self, root: TreeNode) -> bool:
        def rec(root: TreeNode):
            bad = False, None, None  # valid, min, max
            if root is None: return True, None, None
            
            validL, minL, maxL = rec(root.left)
            if not validL: return bad
            validR, minR, maxR = rec(root.right)
            if not validR: return bad
            
            minVal = maxVal = root.val
            if maxL is not None:
                if maxL >= root.val: return bad
                minVal = minL
            if minR is not None:
                if minR <= root.val: return bad
                maxVal = maxR
            return True, minVal, maxVal
        
        return rec(root)[0]
```

击败18.63%

## 题解2：自上而下

将值的范围往下传。

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def isValidBST(self, root: TreeNode) -> bool:
        def rec(root, L, R):  # (L, R), not inclusive
            if not root: return True
            if not (L < root.val < R): return False
            return rec(root.left, L, root.val) and rec(root.right, root.val, R)
        
        return rec(root, -float("inf"), float("inf"))
```

还是击败18.63%，好少。