---
title: 86_Partition_List_62a5282be26e4a4cb4c8dc76e2761d06
---

# 86. Partition List

Difficulty: Medium
ID: 86
Solved?: Yes
Tags: Linked List, Two Pointers
击败: 97.65
推荐指数: ⭐⭐

[Loading...](https://leetcode.com/problems/partition-list/)

## 题意

Given a linked list and a value *x*, partition it such that all nodes less than *x* come before nodes greater than or equal to *x*.

You should preserve the original relative order of the nodes in each of the two partitions.

**Example:**

```
Input: head = 1->4->3->2->5->2, x = 3
Output: 1->2->2->4->3->5
```

## 思路

1. 直接构造两个虚拟节点来存即可

## 扩展

与快排相结合。

[148. Sort List](148%20Sort%20List%20fcae33b05f7a4dba99041f79a55b7964.md) 

## 题解1

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def partition(self, head: ListNode, x: int) -> ListNode:
        dummy1 = tail1 = ListNode(None)
        dummy2 = tail2 = ListNode(None)
        while head:
            if head.val < x:
                tail1.next = head
                tail1 = head
            else:
                tail2.next = head
                tail2 = head
            head = head.next
        tail2.next = None
        tail1.next = dummy2.next
        return dummy1.next
```