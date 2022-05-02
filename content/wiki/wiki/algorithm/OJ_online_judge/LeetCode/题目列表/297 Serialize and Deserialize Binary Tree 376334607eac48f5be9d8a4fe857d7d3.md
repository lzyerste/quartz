---
title: 297_Serialize_and_Deserialize_Binary_Tree_376334607eac48f5be9d8a4fe857d7d3
---

# 297. Serialize and Deserialize Binary Tree

Difficulty: Hard
ID: 297
Solved?: Yes
Tags: Design, Tree
击败: 83.27
推荐指数: ⭐⭐⭐⭐

[Serialize and Deserialize Binary Tree - LeetCode](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)

## 题意

Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

**Clarification:** The input/output format is the same as [](https://leetcode.com/faq/#binary-tree). You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/09/15/serdeser.jpg](https://assets.leetcode.com/uploads/2020/09/15/serdeser.jpg)

```
Input: root = [1,2,3,null,null,4,5]
Output: [1,2,3,null,null,4,5]

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

```
Input: root = [1,2]
Output: [1,2]

```

**Constraints:**

- The number of nodes in the tree is in the range `[0, 104]`.
- `1000 <= Node.val <= 1000`

## 思路

1. 使用preorder来处理。

思考：如何使用非递归？？如果反序列化的时候，并不能看到整个序列，而是一个stream呢？

## 题解

```python
# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

class Codec:

    def serialize(self, root):
        """Encodes a tree to a single string.
        
        :type root: TreeNode
        :rtype: str
        """
        if not root: return "#"
        left = self.serialize(root.left)
        right = self.serialize(root.right)
        # preorder
        return ",".join([str(root.val), left, right])
    
    def deserialize(self, data):
        """Decodes your encoded data to tree.
        
        :type data: str
        :rtype: TreeNode
        """
        return self._deserialize(data.split(","), 0)[0]
    
    def _deserialize(self, nodes, i):
        # 返回值是：root以及消耗了多少个元素
        v = nodes[i]
        if v == "#": return (None, 1)
        root = TreeNode(int(v))
        left = self._deserialize(nodes, i+1)
        right = self._deserialize(nodes, i+1+left[1])
        root.left = left[0]
        root.right = right[0]
        return (root, 1+left[1]+right[1])

# Your Codec object will be instantiated and called as such:
# ser = Codec()
# deser = Codec()
# ans = deser.deserialize(ser.serialize(root))
```

击败83.27%