---
title: 82_Remove_Duplicates_from_Sorted_List_II_65c51a5fa7d2465b8661b331902f4976
---

# 82. Remove Duplicates from Sorted List II

Difficulty: Medium
ID: 82
Solved?: Yes
Tags: Linked List
击败: 92.92
推荐指数: ⭐⭐⭐

[Remove Duplicates from Sorted List II - LeetCode](https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/)

## 题意

Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only *distinct* numbers from the original list.

Return the linked list sorted as well.

**Example 1:**

```
Input: 1->2->3->3->4->4->5
Output: 1->2->5
```

**Example 2:**

```
Input: 1->1->1->2->3
Output: 2->3
```

## 思路

- 简洁：与 [83. Remove Duplicates from Sorted List](83 Remove Duplicates from Sorted List 6652f03a615c4b76b266773a734b83db.md) 类似，只是对首次出现的项的处理稍有不同。83是直接收集，而82得再看一步，确定它是唯一的，也就是它的next值跟它不同。之后的过滤流程是一致的。

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
            next = head.next
            if not (next and next.val == x):
                tail.next = head
                tail = tail.next
            while head and head.val == x:
                head = head.next
        tail.next = None
        return dummy.next
```

击败92.92%

## x题解1

只需考虑当前节点，首先判断是否与前一节点的值相同，然后判断是否与后一节点的值是否相同。但这样判断次数会有些多。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        dummy = tail = ListNode(None)
        val = None
        while head:
            if head.val == val:  # 判断与前面节点的值是否相等
                head = head.next
                continue
            curr = head
            val = head.val
            head = head.next
            if curr.next and curr.next.val == curr.val:
                continue
            tail.next = curr
            tail = curr
        tail.next = None
        return dummy.next
```

击败20.44%

## x题解2：candidate

先找候选节点，候选节点与它的下一节点比较即可。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        def findCandidate(head, val):
            # 找下一个不等于val的节点
            while head and head.val == val:
                head = head.next
            return head
        
        dummy = tail = ListNode(None)
        val = None
        while True:
            candidate = findCandidate(head, val)
            if candidate is None: break
            val = candidate.val  # 下次避免的val
            head = candidate.next  # 下次寻找的起点
            next = candidate.next  # 也可以用head代替
            if next and next.val == candidate.val:
                continue
            tail.next = candidate
            tail = candidate
        tail.next = None
        return dummy.next
```

击败20.44%

但是，这里是封装了函数来找候选，如果函数直接展开的话，击败99.94%

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def deleteDuplicates(self, head: ListNode) -> ListNode:
        dummy = tail = ListNode(None)
        val = None
        while True:
            while head and head.val == val:
                head = head.next
            candidate = head
            if candidate is None: break
            val = candidate.val  # 下次避免的val
            head = candidate.next  # 下次寻找的起点
            next = candidate.next  # 也可以用head代替
            if next and next.val == candidate.val:
                continue
            tail.next = candidate
            tail = candidate
        tail.next = None
        return dummy.next
```