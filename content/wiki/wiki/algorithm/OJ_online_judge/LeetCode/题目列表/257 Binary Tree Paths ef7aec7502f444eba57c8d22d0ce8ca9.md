---
title: 257_Binary_Tree_Paths_ef7aec7502f444eba57c8d22d0ce8ca9
---

# 257. Binary Tree Paths

Difficulty: Easy
ID: 257
Solved?: Yes
Tags: DFS, Tree
击败: 88.54
推荐指数: ⭐⭐⭐

[Binary Tree Paths - LeetCode](https://leetcode.com/problems/binary-tree-paths/)

## 题意

Given a binary tree, return all root-to-leaf paths.

**Note:** A leaf is a node with no children.

**Example:**

```
Input:

   1
 /   \
2     3
 \
  5

Output: ["1->2->5", "1->3"]

Explanation: All root-to-leaf paths are: 1->2->5, 1->3

```

## 思路

1. 递归：先得到左右子树（非空）的结果，然后与根节点拼接。
2. DFS：DFS遍历的时候，将前面的路径一直传递下来，如果遇到叶子节点了，那么就生成一条路径。

## 题解：递归

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def binaryTreePaths(self, root: TreeNode) -> List[str]:
        if root is None: return []
        res = self.dfs(root)
        return ["->".join(lst) for lst in res]
    
    def dfs(self, root: TreeNode) -> List[List[str]]:
        if root.left is None and root.right is None:
            return [str(root.val)](root.val)))
        tmp = []
        if root.left:
            tmp.extend(self.dfs(root.left))
        if root.right:
            tmp.extend(self.dfs(root.right))
        return [[str(root.val)] + lst for lst in tmp]
```

击败88.54%