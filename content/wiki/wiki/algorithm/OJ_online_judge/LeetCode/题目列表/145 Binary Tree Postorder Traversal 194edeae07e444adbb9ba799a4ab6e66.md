---
title: 145_Binary_Tree_Postorder_Traversal_194edeae07e444adbb9ba799a4ab6e66
---

# 145. Binary Tree Postorder Traversal

Difficulty: Medium
ID: 145
Solved?: Yes
Tags: Stack, Tree
击败: 98.62
推荐指数: ⭐⭐⭐

[Binary Tree Postorder Traversal - LeetCode](https://leetcode.com/problems/binary-tree-postorder-traversal/)

## 题意

Given the `root` of a binary tree, return *the postorder traversal of its nodes' values*.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/08/28/pre1.jpg](https://assets.leetcode.com/uploads/2020/08/28/pre1.jpg)

```
Input: root = [1,null,2,3]
Output: [3,2,1]

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

![https://assets.leetcode.com/uploads/2020/08/28/pre3.jpg](https://assets.leetcode.com/uploads/2020/08/28/pre3.jpg)

```
Input: root = [1,2]
Output: [2,1]

```

**Example 5:**

![https://assets.leetcode.com/uploads/2020/08/28/pre2.jpg](https://assets.leetcode.com/uploads/2020/08/28/pre2.jpg)

```
Input: root = [1,null,2]
Output: [2,1]

```

**Constraints:**

- The number of the nodes in the tree is in the range `[0, 100]`.
- `100 <= Node.val <= 100`

**Follow up:**

Recursive solution is trivial, could you do it iteratively?

## 思路

1. 递归
2. 非递归，堆栈模拟
3. 非递归，类似inorder，但需要记录的状态更多。因为处理top的时候，它的左子树处理了吗？它的右子树处理了吗？如何处理自身呢？按照postorder，需要在左子树跟右子树全部处理完毕之后，自身才能弹出，它在栈中的时间反而是最长的。但是可以观察，如果它没有右孩子，那么它就可以放心地弹出自己；另外，如果知道已经处理到了右子树的最后一个节点了，那么就下来就是处理自身了，而右子树的最后一个节点不就是自身的右孩子么（postorder），所以需要额外跟踪的数据并不多，也就是遍历过程中产生的最后一个节点。

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
    def postorderTraversal2(self, root: TreeNode) -> List[int]:
        if not root: return []
        res = []
        # case 0
        res += self.postorderTraversal(root.left)
        # case 1
        res += self.postorderTraversal(root.right)
        # case 2
        res.append(root.val)
        return res
    
    def postorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        stack = [Context(root, 0)]
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
                stack.append(Context(node.right, 0))
                top.state = 2
            elif state == 2:
                res.append(node.val)
                stack.pop()
        return res
```

击败93.17%

## 题解3

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def postorderTraversal(self, root: TreeNode) -> List[int]:
        res = []
        prev = None
        stack = []
        self.leftmostInorder(root, stack)
        while stack:
            top = stack[-1]
            if top.right is None or top.right is prev:
                stack.pop()
                prev = top
                res.append(top.val)
            else:
                self.leftmostInorder(top.right, stack)
        return res
    
    def leftmostInorder(self, root: TreeNode, stack: List[int]):
        while root:
            stack.append(root)
            root = root.left
```

击败98.62%