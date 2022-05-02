---
title: 92_Reverse_Linked_List_II_1716646e166f4914a534ddcb6bd3f320
---

# 92. Reverse Linked List II

Difficulty: Medium
ID: 92
Solved?: Yes
Tags: Linked List
击败: 65.21
推荐指数: ⭐⭐⭐⭐

[Reverse Linked List II - LeetCode](https://leetcode.com/problems/reverse-linked-list-ii/)

## 题意

Reverse a linked list from position *m* to *n*. Do it in one-pass.

**Note:** 1 ≤ *m* ≤ *n* ≤ length of list.

**Example:**

```
Input: 1->2->3->4->5->NULL, m = 2, n = 4
Output: 1->4->3->2->5->NULL
```

## 思路

1. 每次反转一个元素，保持链表完整。参考 [206. Reverse Linked List](206 Reverse Linked List 7107cc6b82674a8aaa8934b045a62ff6.md)
2. 先确定m、n对应的元素及其前后元素，然后对这个子串进行反转，再串起来。

## 题解

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseBetween(self, head: ListNode, m: int, n: int) -> ListNode:
        dummy = ListNode(next=head)
        mprev = dummy
        for _ in range(m - 1):
            mprev = mprev.next
        
        head = tail = mprev.next
        next = tail.next
        for _ in range(n - m):
            tail.next = next.next
            next.next = head
            head = next
            next = tail.next
        mprev.next = head
        return dummy.next
```

击败65.21%

因为循环中每一轮保持链表的完整性，所以指针操作会多一些。