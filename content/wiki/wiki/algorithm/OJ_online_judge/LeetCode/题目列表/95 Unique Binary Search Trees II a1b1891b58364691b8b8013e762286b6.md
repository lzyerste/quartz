---
title: 95_Unique_Binary_Search_Trees_II_a1b1891b58364691b8b8013e762286b6
---

# 95. Unique Binary Search Trees II

Difficulty: Medium
ID: 95
Solved?: Yes
Tags: DP, Tree
击败: 96.22
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/unique-binary-search-trees-ii/)

## 题意

## 题解1：DP

挑选根节点，左边的组合成左子树（递归），右边的组合成右子树（递归）。

可能会重复，所以加上记忆。

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def generateTrees(self, n: int) -> List[TreeNode]:
        def dp(G, L, R):  # L, R: inclusive
            p = L, R
            if p in G: return G[p]
            if L > R: return [None]
            if L == R: return [TreeNode(L)]
            res = []
            for M in range(L, R + 1):
                left = dp(G, L, M - 1)  # 左子树的所有组合
                right = dp(G, M + 1, R)  # 右子树的所有组合
                for lf in left:
                    for rt in right:
                        root = TreeNode(M)
                        root.left = lf
                        root.right = rt
                        res.append(root)
            G[p] = res
            return G[p]
            
        if n <= 0: return []
        return dp({}, 1, n)
```