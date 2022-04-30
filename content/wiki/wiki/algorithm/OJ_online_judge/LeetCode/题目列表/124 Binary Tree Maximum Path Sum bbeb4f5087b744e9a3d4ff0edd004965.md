---
title: 124_Binary_Tree_Maximum_Path_Sum_bbeb4f5087b744e9a3d4ff0edd004965
---

# 124. Binary Tree Maximum Path Sum

Difficulty: Hard
ID: 124
Solved?: Yes
Tags: DFS, Tree
击败: 93.98
推荐指数: ⭐⭐⭐⭐

[Binary Tree Maximum Path Sum - LeetCode](https://leetcode.com/problems/binary-tree-maximum-path-sum/)

## 题意

Given a **non-empty** binary tree, find the maximum path sum.

For this problem, a path is defined as any node sequence from some starting node to any node in the tree along the parent-child connections. The path must contain **at least one node** and does not need to go through the root.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/10/13/exx1.jpg](https://assets.leetcode.com/uploads/2020/10/13/exx1.jpg)

```
Input: root = [1,2,3]
Output: 6

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/10/13/exx2.jpg](https://assets.leetcode.com/uploads/2020/10/13/exx2.jpg)

```
Input: root = [-10,9,20,null,null,15,7]
Output: 42

```

**Constraints:**

- The number of nodes in the tree is in the range `[0, 3 * 104]`.
- `1000 <= Node.val <= 1000`

## 思路

1. 注意这里的最大路径是可以拐弯的，比如上面的15 → 20 → 7，以20为中间节点，将左右子树的路径串起来。
    
    考察任意的节点n，它的最大路径要么完全在左子树中，要么完全在右子树中，要么是跨过节点n的左右两条路径拼接。前两种情况完全是子问题，主要是第三种情况需要获取从节点n出发，它在左子树中的最大路径，它在右子树中的最大路径。可以dfs返回两个值：第一个是节点n问题的最大路径和，包括上面所说的三种情况，第二个是从节点n触发的单边路径，可能是往左边走，可能是往右边走，但不能跨。
    
2. 优化：可以简化，只需要求取节点n在左右子树的单边最大路径，然后在节点n汇总，跨两边是否有更大收益。也就是说，解决节点n的问题转化为包含节点n的最大路径，而不是以节点n所代表的子树了。那么，问题来了，包含节点n的最大路径并不一定是节点n所代表的子树的最优解呀？它可能在节点n的左右子树中，不经过节点n。这是没问题的，因为假设最优解是由节点m串起来的，那么，dfs遍历到节点m的时候，此时节点m的解就是最优解了。当然，要全局保存这个最优解。
    
    而上一种解法，相当于把最优解一直在通过返回值向上传递。
    

## 题解1：

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxPathSum(self, root: TreeNode) -> int:
        return self.dfs(root)[0]
    
    def dfs(self, node: TreeNode) -> (int, int):
        if not node: return (float("-inf"), float("-inf"))
        L = self.dfs(node.left)
        R = self.dfs(node.right)
        twoWay = node.val
        if L[1] > 0: twoWay += L[1]
        if R[1] > 0: twoWay += R[1]
        oneWay = max(node.val, node.val + L[1], node.val + R[1])
        return max(twoWay, L[0], R[0]), oneWay
```

击败25.10%

## 题解2

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxPathSum(self, root: TreeNode) -> int:
        self.maxSum = float("-inf")
        self.dfs(root)
        return self.maxSum
    
    def dfs(self, node: TreeNode) -> int:
        if not node: return 0
        L = max(0, self.dfs(node.left))
        R = max(0, self.dfs(node.right))
        twoWay = node.val + L + R
        self.maxSum = max(self.maxSum, twoWay)
        return max(node.val + L, node.val + R)
```

击败93.98**%**