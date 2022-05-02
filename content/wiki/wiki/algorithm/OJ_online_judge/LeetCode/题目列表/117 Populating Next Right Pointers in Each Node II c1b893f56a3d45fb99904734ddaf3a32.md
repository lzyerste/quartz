---
title: 117_Populating_Next_Right_Pointers_in_Each_Node_II_c1b893f56a3d45fb99904734ddaf3a32
---

# 117. Populating Next Right Pointers in Each Node II

Difficulty: Medium
ID: 117
Solved?: Yes
Tags: DFS, Tree
击败: 75.65
推荐指数: ⭐⭐⭐⭐

[Populating Next Right Pointers in Each Node II - LeetCode](https://leetcode.com/problems/populating-next-right-pointers-in-each-node-ii/)

[116. Populating Next Right Pointers in Each Node](116%20Populating%20Next%20Right%20Pointers%20in%20Each%20Node%20751bbec41c1f4513881095155357a246.md) 

## 题意

Given a binary tree

```
struct Node {
  int val;
  Node *left;
  Node *right;
  Node *next;
}

```

Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to `NULL`.

Initially, all next pointers are set to `NULL`.

**Follow up:**

- You may only use constant extra space.
- Recursive approach is fine, you may assume implicit stack space does not count as extra space for this problem.

**Example 1:**

![https://assets.leetcode.com/uploads/2019/02/15/117_sample.png](https://assets.leetcode.com/uploads/2019/02/15/117_sample.png)

```
Input: root = [1,2,3,4,5,null,7]
Output: [1,#,2,3,#,4,5,7,#]
Explanation: Given the above binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level.

```

**Constraints:**

- The number of nodes in the given tree is less than `6000`.
- `100 <= node.val <= 100`

## 思路

1. 层序遍历：当前层已经通过next串起来了，接下来遍历当前层，将下一层的next串起来。

## 题解

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val: int = 0, left: 'Node' = None, right: 'Node' = None, next: 'Node' = None):
        self.val = val
        self.left = left
        self.right = right
        self.next = next
"""

class Solution:
    def connect(self, root: 'Node') -> 'Node':
        head = root
        while head:
            node = head  # current level
            dummy = last = Node()  # next level
            # level traversal
            while node:
                if node.left:
                    last.next = node.left
                    last = node.left
                if node.right:
                    last.next = node.right
                    last = node.right
                node = node.next
            head = dummy.next
        return root
```

击败75.65%