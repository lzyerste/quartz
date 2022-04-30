---
title: 234_Palindrome_Linked_List_dd6bedd870ce4fea8822f2fd5202c01f
---

# 234. Palindrome Linked List

Difficulty: Easy
ID: 234
Solved?: Yes
Tags: Linked List, Two Pointers
推荐指数: ⭐⭐

[Palindrome Linked List - LeetCode](https://leetcode.com/problems/palindrome-linked-list/)

## 题意

Given a singly linked list, determine if it is a palindrome.

**Example 1:**

```
Input: 1->2
Output: false
```

**Example 2:**

```
Input: 1->2->2->1
Output: true
```

**Follow up:**Could you do it in O(n) time and O(1) space?

## 思路

1. 从中间切分成两个链表，其中一个反转，再比较

## 题解

```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

def list_mid(head):
    """
    :type head: ListNode
    :rtype: ListNode
 
    O(N) time.
    [1, 2, 3, 4] ==> 3
    [1, 2, 3, 4, 5] ==> 3
    """
    fast = slow = head
    while fast and fast.next:
        fast = fast.next.next
        slow = slow.next
    return slow

def list_reverse(head):
    """O(N) time and O(1) space"""
    prev = None
    while head is not None:
        nxt = head.next
        head.next = prev
        prev = head
        head = nxt
    return prev

class Solution(object):
    def isPalindrome(self, head):
        """
        :type head: ListNode
        :rtype: bool
        """
        if head is None or head.next is None:
            return True
        mid = list_mid(head)
        save_head = r_head = list_reverse(mid)
        result = True
        while head and r_head:
            if head.val != r_head.val:
                result = False
                break
            head = head.next
            r_head = r_head.next
        list_reverse(save_head)
        return result
```