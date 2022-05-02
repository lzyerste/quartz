---
title: 147_Insertion_Sort_List_27aedbca2dfc4e47890cb27d88d454d9
---

# 147. Insertion Sort List

Difficulty: Medium
ID: 147
Solved?: Yes
Tags: Linked List, Sort
推荐指数: ⭐⭐

[Insertion Sort List - LeetCode](https://leetcode.com/problems/insertion-sort-list/)

## 题意

Sort a linked list using insertion sort.

![https://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif](https://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif)

A graphical example of insertion sort. The partial sorted list (black) initially contains only the first element in the list.With each iteration one element (red) is removed from the input data and inserted in-place into the sorted list

**Algorithm of Insertion Sort:**

1. Insertion sort iterates, consuming one input element each repetition, and growing a sorted output list.
2. At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list, and inserts it there.
3. It repeats until no input elements remain.

**Example 1:**

```
Input: 4->2->1->3
Output: 1->2->3->4
```

**Example 2:**

```
Input: -1->5->3->4->0
Output: -1->0->3->4->5
```

## 题解

```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution(object):
    def insertionSortList(self, head):
        """
        :type head: ListNode
        :rtype: ListNode
        """
        nil = ListNode(float("inf"))
        node = head
        while node:
            nxt = node.next
            
            # insert node to sorted list
            pre = nil
            cur = nil.next
            while cur and node.val > cur.val:
                pre = pre.next
                cur = pre.next
            node.next = pre.next
            pre.next = node
            
            node = nxt
        return nil.next
```