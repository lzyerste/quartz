---
title: 94_Binary_Tree_Inorder_Traversal_18f3bd8177974b9b97921a5859cb89bc
---

# 94. Binary Tree Inorder Traversal

Difficulty: Easy
ID: 94
Solved?: Yes
Tags: Recursive, Stack, Tree
击败: 98.54
推荐指数: ⭐⭐⭐⭐

[Binary Tree Inorder Traversal - LeetCode](https://leetcode.com/problems/binary-tree-inorder-traversal/)

[144. Binary Tree Preorder Traversal](144%20Binary%20Tree%20Preorder%20Traversal%20c7855ea336f6459da3adcd286d7c59a8.md) 

[145. Binary Tree Postorder Traversal](145%20Binary%20Tree%20Postorder%20Traversal%20194edeae07e444adbb9ba799a4ab6e66.md) 

## 题意

Given the `root` of a binary tree, return *the inorder traversal of its nodes' values*.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/09/15/inorder_1.jpg](https://assets.leetcode.com/uploads/2020/09/15/inorder_1.jpg)

```
Input: root = [1,null,2,3]
Output: [1,3,2]
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
Output: [2,1]
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

1. 递归
2. 非递归：不直观法
3. 非递归：模拟递归调用，保存上下文，状态机形式

## ★题解3：非递归+状态机

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Context:
    def __init__(self, node: TreeNode, state: int):
        self.node = node
        self.state = state

class Solution:
    def inorderTraversal(self, root: TreeNode) -> List[int]:
        stack = [Context(root, 0)]
        res = []
        while stack:
            top = stack[-1]
            node, state = top.node, top.state
            if not node:
                stack.pop()
                continue
            if state == 0:
                stack.append(Context(node.left, 0))
                top.state = 1
            elif state == 1:
                res.append(node.val)
                stack.append(Context(node.right, 0))
                top.state = 2
            elif state == 2:
                stack.pop()
        return res

    def inorderTraversal2(self, root: TreeNode) -> List[int]:
        stack = [[root, 0]]
        res = []
        while stack:
            top = root, state = stack[-1]
            if not root:
                stack.pop()
                continue
            if state == 0:
                stack.append([root.left, 0])
                top[1] = 1
            elif state == 1:
                res.append(root.val)
                stack.append([root.right, 0])
                top[1] = 2
            elif top[1] == 2:
                stack.pop()
        return res

    def inorder(self, root: TreeNode) -> List[int]:
        if not root: return []
        # case 0: first time met root
        res = self.inorder(root.left)
        # case 1: has handled root.left
        res.append(root.val)
        res += self.inorder(root.right)
        # case 2: has handled root.right
        return res
```

击败93.73%

## 题解1：递归

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def inorderTraversal(self, root: TreeNode) -> List[int]:
        if root is None: return []
        left = self.inorderTraversal(root.left)
        right = self.inorderTraversal(root.right)
        return left + [root.val] + right
```

击败82.58%

## ★题解2：非递归

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def inorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        # stack保存每棵子树的表示（所有最左节点）
        # 出栈的时候，表示左子树已经处理完毕了，自身也出来了，还剩下右子树，入栈。
        stack = []
        self.leftmostInorder(root, stack)
        while stack:
            top = stack.pop()
            if top.right:
                self.leftmostInorder(top.right, stack)
            res.append(top.val)
        return res
    
    def leftmostInorder(self, root: TreeNode, stack: List[TreeNode]):
        while root:
            stack.append(root)
            root = root.left
```

击败98.54%

## 题解2：非递归，不好

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Solution:
    def inorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        stack = []
        while root or stack:
            while root:
                stack.append(root)
                root = root.left
            if stack:
                root = stack.pop()
                res.append(root.val)
                root = root.right
        return res
```