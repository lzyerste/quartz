---
title: 61_Rotate_List_ac7ea3dc884b47919e2e1e0c53f85a5b
---

# 61. Rotate List

Difficulty: Medium
ID: 61
Solved?: Yes
Tags: Linked List, Two Pointers
击败: 100
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/rotate-list/)

## 题意

Given a linked list, rotate the list to the right by *k* places, where *k* is non-negative.

**Example 1:**

```
Input: 1->2->3->4->5->NULL, k = 2
Output: 4->5->1->2->3->NULL
Explanation:
rotate 1 steps to the right: 5->1->2->3->4->NULL
rotate 2 steps to the right: 4->5->1->2->3->NULL

```

**Example 2:**

```
Input: 0->1->2->NULL, k = 4
Output: 2->0->1->NULL
Explanation:
rotate 1 steps to the right: 2->0->1->NULL
rotate 2 steps to the right: 1->2->0->NULL
rotate 3 steps to the right: 0->1->2->NULL
rotate 4 steps to the right: 2->0->1->NULL
```

## 思路

1. 计算链表的长度，同时找到tail，将它指向head，形成循环链表；接着tail根据k走到最终的位置（倒着走k步，也就是正向走length-k步），在此处断开即可。
    
    [My clean C++ code, quite standard (find tail and reconnect the list) - LeetCode Discuss](find tail and reconnect the list) - LeetCode Discuss)%20-%20LeetCode%20Discuss](https://leetcode.com/problems/rotate-list/discuss/22735/My-clean-C%2B%2B-code-quite-standard-(find-tail-and-reconnect-the-list))
    

## 题解

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def rotateRight(self, head: ListNode, k: int) -> ListNode:
        if not head: return head
        length = 1
        tail = head
        while tail.next:
            length += 1
            tail = tail.next
        tail.next = head  # make circular
        k %= length
        if k:
            for _ in range(length - k):
                tail = tail.next
        new_head = tail.next
        tail.next = None
        return new_head
```

## 题解，凌乱

找到中间断开点。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def rotateRight(self, head: ListNode, k: int) -> ListNode:
        if not head:
            return head

        # calculate the length and find the tail
        length = 1
        t = head
        while t.next:
            length += 1
            t = t.next
        old_tail = t
        old_head = head
        
        k %= length
        if k == 0:
            return head
        
        new_tail = head
        for i in range(length - k - 1):
            new_tail = new_tail.next
        head = new_tail.next
        new_tail.next = None
        old_tail.next = old_head
        return head
```