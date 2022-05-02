---
title: 21_Merge_Two_Sorted_Lists_fa9f0d3a950840cdb73077a151b9fa5a
---

# 21. Merge Two Sorted Lists

Difficulty: Easy
ID: 21
Solved?: Yes
Tags: Linked List
击败: 63.71
推荐指数: ⭐⭐

[Merge Two Sorted Lists - LeetCode](https://leetcode.com/problems/merge-two-sorted-lists/)

## 题意

将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。

**示例：**

```
输入：1->2->4, 1->3->4
输出：1->1->2->3->4->4
```

## 思路

- 递归法。确定新的链表头，剩余的再递归合并。
- 循环法。

## 题解1：递归

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        # 递归方法
        if not l1 or not l2: return l1 or l2
        if l1.val < l2.val:
            l1.next = self.mergeTwoLists(l1.next, l2)
            return l1
        else:
            l2.next = self.mergeTwoLists(l1, l2.next)
            return l2
```

击败63.71%

## 题解2：循环

注意，先构造一个伪头结点。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def mergeTwoLists(self, l1: ListNode, l2: ListNode) -> ListNode:
        head = ListNode(0)
        cur = head

        while l1 and l2:
            if l1.val < l2.val:
                cur.next = l1
                l1 = l1.next
            else:
                cur.next = l2
                l2 = l2.next
            cur = cur.next

        if l1: cur.next = l1
        if l2: cur.next = l2

        return head.next
```