---
title: 222_Count_Complete_Tree_Nodes_a9f0cf469b7a428da45e59e2eb14c92c
---

# 222. Count Complete Tree Nodes

Difficulty: Medium
ID: 222
Solved?: Yes
Tags: Binary Search, Tree
击败: 94.83
推荐指数: ⭐⭐⭐

## 题意

Given a **complete** binary tree, count the number of nodes.

**Note:**

**Definition of a complete binary tree from [Wikipedia](http://en.wikipedia.org/wiki/Binary_tree#Types_of_binary_trees):**In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

**Example:**

```
Input: 
    1
   / \
  2   3
 / \  /
4  5 6

Output: 6
```

## 思路

1. 递归：计算左右子树的高度，如果高度一样，说明左子树是满的，继续统计右边的；如果高度不一样，说明右子树是满的，继续统计左边的。

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def countNodes(self, root: TreeNode) -> int:
        def cal_left_height(root):
            height = -1
            while root:
                height += 1
                root = root.left
            return height

        if not root:
            return 0
        hl = cal_left_height(root.left)
        hr = cal_left_height(root.right)
        if hl == hr:
            # the left is full
            return 2 ** (hl + 1) - 1 + 1 + self.countNodes(root.right)
        else:
            # the right is full
            return 2 ** (hr + 1) - 1 + 1 + self.countNodes(root.left)
```

击败94.83%