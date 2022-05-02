---
title: 328_Odd_Even_Linked_List_42ef29b949f84758aa0b211a93a6a146
---

# 328. Odd Even Linked List

Difficulty: Medium
ID: 328
Solved?: Yes
推荐指数: ⭐⭐

[Odd Even Linked List - LeetCode](https://leetcode.com/problems/odd-even-linked-list/)

## 题意

Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.

You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.

**Example 1:**

```
Input: 1->2->3->4->5->NULL
Output: 1->3->5->2->4->NULL
```

**Example 2:**

```
Input: 2->1->3->5->6->4->7->NULL
Output: 2->3->6->7->1->5->4->NULL
```

**Constraints:**

- The relative order inside both the even and odd groups should remain as it was in the input.
- The first node is considered odd, the second node even and so on ...
- The length of the linked list is between `[0, 10^4]`.

## 思路

1. 分两个链表

## 题解

```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def oddEvenList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        if head is None:
            return None
        h1 = head
        h2 = head.next
        c1 = h1
        c2 = h2
        while c2 and c2.next:
            c1.next = c2.next
            c1 = c1.next
            c2.next = c1.next
            c2 = c1.next
        c1.next = h2
        return h1
```