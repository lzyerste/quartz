---
title: 108_Convert_Sorted_Array_to_Binary_Search_Tree_8826cfd4331646f299a9820e9d241e98
---

# 108. Convert Sorted Array to Binary Search Tree

Difficulty: Easy
ID: 108
Solved?: Yes
Tags: DFS, Tree
击败: 89.76
推荐指数: ⭐⭐

[Convert Sorted Array to Binary Search Tree - LeetCode](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/)

[109. Convert Sorted List to Binary Search Tree](109 Convert Sorted List to Binary Search Tree 0908281b093b430194b2c5302477410a.md) 

## 题意

Given an array where elements are sorted in ascending order, convert it to a height balanced BST.

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of *every* node never differ by more than 1.

**Example:**

```
Given the sorted array: [-10,-3,0,5,9],

One possible answer is: [0,-3,9,-10,null,5], which represents the following height balanced BST:

      0
     / \
   -3   9
   /   /
 -10  5

```

## 思路

1. 根据中点划分

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> TreeNode:
        if not nums: return None
        r_idx = len(nums) // 2
        root = TreeNode(nums[r_idx])
        root.left = self.sortedArrayToBST(nums[:r_idx])
        root.right = self.sortedArrayToBST(nums[r_idx + 1:])
        return root
```

击败89.76%