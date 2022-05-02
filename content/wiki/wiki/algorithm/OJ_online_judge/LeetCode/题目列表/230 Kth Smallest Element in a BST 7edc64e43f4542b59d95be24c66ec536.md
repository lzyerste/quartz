---
title: 230_Kth_Smallest_Element_in_a_BST_7edc64e43f4542b59d95be24c66ec536
---

# 230. Kth Smallest Element in a BST

Difficulty: Medium
ID: 230
Solved?: Yes
Tags: Binary Search, Tree
击败: 79.75
推荐指数: ⭐⭐⭐

[Kth Smallest Element in a BST - LeetCode](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)

## 题意

Given a binary search tree, write a function `kthSmallest` to find the **k**th smallest element in it.

**Example 1:**

```
Input: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2
Output: 1
```

**Example 2:**

```
Input: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1
Output: 3

```

**Follow up:**What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

**Constraints:**

- The number of elements of the BST is between `1` to `10^4`.
- You may assume `k` is always valid, `1 ≤ k ≤ BST's total elements`.

## 思路

1. 递归：先找左子树，再找右子树。本质也是中序遍历。
2. 也可以中序遍历，直到第k个

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def kthSmallest(self, root: TreeNode, k: int) -> int:
        return self.dfs(root, k)[1].val
    
    def dfs(self, root, k):
        if root is None: return 0, None
        left = self.dfs(root.left, k)
        if left[1]: return left
        if left[0] == k - 1:
            return k, root
        right = self.dfs(root.right, k - left[0] - 1)
        if right[1]: return right
        return left[0] + right[0] + 1, None
```

击败79.75%