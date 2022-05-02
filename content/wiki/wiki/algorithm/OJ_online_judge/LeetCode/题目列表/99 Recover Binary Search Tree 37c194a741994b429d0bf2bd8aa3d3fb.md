---
title: 99_Recover_Binary_Search_Tree_37c194a741994b429d0bf2bd8aa3d3fb
---

# 99. Recover Binary Search Tree

Difficulty: Hard
ID: 99
Solved?: Yes
Tags: DFS, Tree
击败: 77.82
推荐指数: ⭐⭐⭐⭐⭐

[](https://leetcode.com/problems/recover-binary-search-tree/)

## 题意

二叉搜索树中的`两个节点`被错误地交换。

请在不改变其结构的情况下，恢复这棵树。

**示例 1:**

```
输入: [1,3,null,null,2]

   1
  /
 3
  \\
   2

输出: [3,1,null,null,2]

   3
  /
 1
  \\
   2
```

**示例 2:**

```
输入: [3,1,4,null,null,2]

  3
 / \\
1   4
   /
  2

输出: [2,1,4,null,null,3]

  2
 / \\
1   4
   /
  3
```

**进阶:**

- 使用 O(*n*) 空间复杂度的解法很容易实现。
- 你能想出一个只使用常数空间的解决方案吗？

## 思路

- 如果正常中序遍历的话，结果应该是递增的，很容易发现哪里破坏了递增性。但需要额外O(N)空间。
- dfs的时候检查是否破坏了递增性质，需要当前节点以及中序的前一个节点。

## 题解1：DFS

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def recoverTree(self, root: TreeNode) -> None:
        """
        Do not return anything, modify root in-place instead.
        """
        bad = []
        
        def dfs(node, pre=None):
            # pre表示node这棵树的前一个节点（中序）
            # 对左子树来说，pre保持不变
            # 对右子树来说，pre就是当前节点node
            # dfs返回的是node这棵树的最大节点（右子树不空，那就是右子树的最大节点；否则就是node本身）
            if node is None: return node
            # 对node本身来说，它的前一个节点就是左子树的最大节点
            left = dfs(node.left, pre) or pre  # 左子树为空的话，就是pre
            if left is not None and left.val > node.val:
                bad.append((left, node))
            return dfs(node.right, node) or node  # 右子树为空的话，就返回node
        
        dfs(root)
        
        if len(bad) == 1:
            p, q = bad[0]
            p.val, q.val = q.val, p.val
        else:
            # length must be 2
            p = bad[0][0]
            q = bad[1][1]
            p.val, q.val = q.val, p.val
```

递归应用，有点意思。击败100%（当时）
检查每个节点的前继节点，是否升序。如果破坏了升序，那么把这一对（注意是一对，而不是当前节点）加入bad。
最终，bad可能包含一个pair或者两个pair。如果是一个pair，那么直接交换两者即可。如果是两个pair，那么将最左端与最右端交换。

一对的情况比如[1, 2, 3, 4, 5]交换了2和3（相邻）。

两对的情况比如[1, 2, 3, 4, 5]交换了2和4。