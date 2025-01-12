---
title: 237_Delete_Node_in_a_Linked_List_91ef1365fe0746e78cb2e0d3467742cf
---

# 237. Delete Node in a Linked List

Difficulty: Easy
ID: 237
Solved?: Yes
Tags: Linked List
推荐指数: ⭐

[Delete Node in a Linked List - LeetCode](https://leetcode.com/problems/delete-node-in-a-linked-list/)

## 题意

Write a function to **delete a node** in a singly-linked list. You will **not** be given access to the `head` of the list, instead you will be given access to **the node to be deleted** directly.

It is **guaranteed** that the node to be deleted is **not a tail node** in the list.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/09/01/node1.jpg](https://assets.leetcode.com/uploads/2020/09/01/node1.jpg)

```
Input: head = [4,5,1,9], node = 5
Output: [4,1,9]
Explanation: You are given the second node with value 5, the linked list should become 4 -> 1 -> 9 after calling your function.

```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/09/01/node2.jpg](https://assets.leetcode.com/uploads/2020/09/01/node2.jpg)

```
Input: head = [4,5,1,9], node = 1
Output: [4,5,9]
Explanation: You are given the third node with value 1, the linked list should become 4 -> 5 -> 9 after calling your function.

```

**Example 3:**

```
Input: head = [1,2,3,4], node = 3
Output: [1,2,4]
```

**Example 4:**

```
Input: head = [0,1], node = 0
Output: [1]
```

**Example 5:**

```
Input: head = [-3,5,-99], node = -3
Output: [5,-99]
```

**Constraints:**

- The number of the nodes in the given list is in the range `[2, 1000]`.
- `1000 <= Node.val <= 1000`
- The value of each node in the list is **unique**.
- The `node` to be deleted is **in the list** and is **not a tail** node

## 思路

1. 拷贝val

## 题解

```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def deleteNode(self, node):
        """
        :type node: ListNode
        :rtype: void Do not return anything, modify node in-place instead.
        """
        # node is guranteed to not be the tail
        node.val = node.next.val
        node.next = node.next.next
```