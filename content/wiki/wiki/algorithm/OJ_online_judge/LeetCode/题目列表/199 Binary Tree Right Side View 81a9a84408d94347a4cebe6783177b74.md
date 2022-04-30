---
title: 199_Binary_Tree_Right_Side_View_81a9a84408d94347a4cebe6783177b74
---

# 199. Binary Tree Right Side View

Difficulty: Medium
ID: 199
Solved?: Yes
Tags: BFS, DFS, Tree
击败: 34.77
推荐指数: ⭐⭐⭐

[Binary Tree Right Side View - LeetCode](https://leetcode.com/problems/binary-tree-right-side-view/)

## 题意

Given a binary tree, imagine yourself standing on the *right* side of it, return the values of the nodes you can see ordered from top to bottom.

**Example:**

```
Input: [1,2,3,null,5,null,4]
Output: [1, 3, 4]
Explanation:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---

```

## 思路

1. 层序遍历：选取每一层的最右节点
2. DFS：先右后左

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def rightSideView(self, root: TreeNode) -> List[int]:
        if not root: return []
        res = []
        queue = [root]
        while queue:
            res.append(queue[-1].val)
            level = []
            for node in queue:
                if node.left: level.append(node.left)
                if node.right: level.append(node.right)
            queue = level
        return res
```

击败34.77%