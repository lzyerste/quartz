---
title: 144_Binary_Tree_Preorder_Traversal_c7855ea336f6459da3adcd286d7c59a8
---

# 144. Binary Tree Preorder Traversal

Difficulty: Medium
ID: 144
Solved?: Yes
Tags: Stack, Tree
击败: 79.54
推荐指数: ⭐⭐⭐

[Binary Tree Preorder Traversal - LeetCode](https://leetcode.com/problems/binary-tree-preorder-traversal/)

## 题意

Given the `root` of a binary tree, return *the preorder traversal of its nodes' values*.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/09/15/inorder_1.jpg](https://assets.leetcode.com/uploads/2020/09/15/inorder_1.jpg)

```
Input: root = [1,null,2,3]
Output: [1,2,3]
```

**Example 2:**

```
Input: root = []
Output: []

```

**Example 3:**

```
Input: root = [1]
Output: [1]

```

**Example 4:**

![https://assets.leetcode.com/uploads/2020/09/15/inorder_5.jpg](https://assets.leetcode.com/uploads/2020/09/15/inorder_5.jpg)

```
Input: root = [1,2]
Output: [1,2]

```

**Example 5:**

![https://assets.leetcode.com/uploads/2020/09/15/inorder_4.jpg](https://assets.leetcode.com/uploads/2020/09/15/inorder_4.jpg)

```
Input: root = [1,null,2]
Output: [1,2]

```

**Constraints:**

- The number of nodes in the tree is in the range `[0, 100]`.
- `100 <= Node.val <= 100`

**Follow up:**

Recursive solution is trivial, could you do it iteratively?

## 思路

1. 递归法
2. 非递归：模拟递归

## 题解

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Context:
    def __init__(self, node, state):
        self.node = node
        self.state = state

class Solution:
    def preorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        stack = [Context(root, 0)]
        while stack:
            top = stack[-1]
            node, state = top.node, top.state
            if not node:
                stack.pop()
                continue
            if state == 0:
                res.append(node.val)
                stack.append(Context(node.left, 0))
                top.state = 1
            elif state == 1:
                stack.append(Context(node.right, 0))
                top.state = 2
            elif state == 2:
                stack.pop()
        return res

    def preorderTraversal2(self, root: TreeNode) -> List[int]:
        if not root: return []
        # case 0
        res = [root.val]
        res += self.preorderTraversal(root.left)
        # case 1
        res += self.preorderTraversal(root.right)
        # case 2
        return res
```

击败54.07

## 题解2：非递归

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def preorderTraversal(self, root: TreeNode) -> List[int]:
        if not root: return []
        res = []
        # stack中的每个节点代表了一棵子树
        # 处理当前节点时，先将右子树入栈，再将左子树入栈，自身直接处理，从栈中消失
        stack = [root]
        while stack:
            top = stack.pop()
            if top.right: stack.append(top.right)
            if top.left: stack.append(top.left)
            res.append(top.val)
        return res
```

击败79.54%