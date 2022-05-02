---
title: 83_Remove_Duplicates_from_Sorted_List_6652f03a615c4b76b266773a734b83db
---

# 83. Remove Duplicates from Sorted List

Difficulty: Easy
ID: 83
Solved?: Yes
Tags: Linked List
击败: 95.28
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/remove-duplicates-from-sorted-list/)

## 题意

Given a sorted linked list, delete all duplicates such that each element appear only *once*.

**Example 1:**

```
Input: 1->1->2
Output: 1->2
```

**Example 2:**

```
Input: 1->1->2->3->3
Output: 1->2->3
```

## 思路

- 简洁：总是将首次出现的节点收集起来，然后往后过滤掉相同值节点，停止的时候刚好停在下一个不同值的首次出现节点。invariant。
- 总是先找到一个合法的节点，while嵌套while
- 仅仅检查当前节点，一层while，更直观

## ★题解：简洁

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        dummy = tail = ListNode()
        while head:
            x = head.val
            tail.next = head  # always append the first one
            tail = tail.next
            while head and head.val == x:
                head = head.next
        tail.next = None
        return dummy.next
```

击败95.28%

## ×题解1

总是确认一个合法的节点添加到尾部，最后节点已经是None，所以退出while循环时不用处理tail。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        dummy = ListNode(None)
        tail = dummy
        curr = head
        while curr:
            # 总是找到一个不同值的curr或者None
            while curr and curr.val == tail.val:
                curr = curr.next
            # append curr
            tail.next = curr
            tail = curr
        # while出来后，tail已经是None
        return dummy.next
```

## ×题解2：

仅仅检查当前节点。注意退出while循环时tail的处理

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        dummy = ListNode(None)
        tail = dummy
        curr = head
        while curr:
            if curr.val == tail.val:
                curr = curr.next
                continue
            # append curr
            tail.next = curr
            tail = curr
        tail.next = curr  # None
        return dummy.next
```