---
title: 129_Sum_Root_to_Leaf_Numbers_4c315af66be94af0b00cbd50a312da7a
---

# 129. Sum Root to Leaf Numbers

Difficulty: Medium
ID: 129
Solved?: Yes
Tags: DFS, Tree
击败: 96.75
推荐指数: ⭐⭐⭐

[Sum Root to Leaf Numbers - LeetCode](https://leetcode.com/problems/sum-root-to-leaf-numbers/)

## 题意

Given a binary tree containing digits from `0-9` only, each root-to-leaf path could represent a number.

An example is the root-to-leaf path `1->2->3` which represents the number `123`.

Find the total sum of all root-to-leaf numbers.

**Note:** A leaf is a node with no children.

**Example:**

```
Input: [1,2,3]
    1
   / \
  2   3
Output: 25
Explanation:
The root-to-leaf path 1->2 represents the number 12.
The root-to-leaf path 1->3 represents the number 13.
Therefore, sum = 12 + 13 = 25.
```

**Example 2:**

```
Input: [4,9,0,5,1]
    4
   / \
  9   0
 / \
5   1
Output: 1026
Explanation:
The root-to-leaf path 4->9->5 represents the number 495.
The root-to-leaf path 4->9->1 represents the number 491.
The root-to-leaf path 4->0 represents the number 40.
Therefore, sum = 495 + 491 + 40 = 1026.
```

## 思路

1. DFS：往叶子节点走的时候，把树根到本节点的信息汇总好，也就是前缀。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sumNumbers(self, root: TreeNode) -> int:
        if not root: return 0
        return self.dfs(root, 0)
    
    def dfs(self, root, base):
        base += root.val
        if not root.left and not root.right: return base
        base *= 10
        total = 0
        if root.left: total += self.dfs(root.left, base)
        if root.right: total += self.dfs(root.right, base)
        return total
```

击败96.75%