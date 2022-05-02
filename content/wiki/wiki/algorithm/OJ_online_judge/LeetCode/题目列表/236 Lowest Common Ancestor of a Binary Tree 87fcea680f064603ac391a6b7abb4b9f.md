---
title: 236_Lowest_Common_Ancestor_of_a_Binary_Tree_87fcea680f064603ac391a6b7abb4b9f
---

# 236. Lowest Common Ancestor of a Binary Tree

Difficulty: Medium
ID: 236
Solved?: Yes
Tags: Tree
击败: 94.26
推荐指数: ⭐⭐⭐⭐

[Lowest Common Ancestor of a Binary Tree - LeetCode](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/)

[235. Lowest Common Ancestor of a Binary Search Tree](235 Lowest Common Ancestor of a Binary Search Tree ef7423c384804b41913e46988e21fc6b.md) 

## 题意

Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.

According to the [definition of LCA on Wikipedia](https://en.wikipedia.org/wiki/Lowest_common_ancestor): “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow **a node to be a descendant of itself**).”

**Example 1:**

![https://assets.leetcode.com/uploads/2018/12/14/binarytree.png](https://assets.leetcode.com/uploads/2018/12/14/binarytree.png)

```
Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
Output: 3
Explanation: The LCA of nodes 5 and 1 is 3.

```

**Example 2:**

![https://assets.leetcode.com/uploads/2018/12/14/binarytree.png](https://assets.leetcode.com/uploads/2018/12/14/binarytree.png)

```
Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
Output: 5
Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

```

**Example 3:**

```
Input: root = [1,2], p = 1, q = 2
Output: 1

```

**Constraints:**

- The number of nodes in the tree is in the range `[2, 105]`.
- `109 <= Node.val <= 109`
- All `Node.val` are **unique**.
- `p != q`
- `p` and `q` will exist in the tree.

## 思路

注意，题目给的并不是二叉搜索树，也就是说节点的val并没有顺序的。

1. DFS：搜索左右子树是否包含p和q。如果左子树包含p或q，右子树也包含p和q，说明p和q分别在两棵子树中，那么当前节点就是它们的共同祖先，返回当前节点。如果子树中某一棵反馈没有找到p或q，那么它返回的是None，另一棵子树返回的就是共同祖先了。

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
        return self.dfs(root, p, q)
        
    def dfs(self, node, p, q):
        if not node:
            return node
        if node in (p, q):
            return node
        lf = self.dfs(node.left, p, q)
        rt = self.dfs(node.right, p, q)
        if lf and rt:
            return node
        else:
            return lf or rt
```

击败94.26%