---
title: 203_Remove_Linked_List_Elements_7a7c3f8c83a941b18969e18b19b4e3b6
---

# 203. Remove Linked List Elements

Difficulty: Easy
ID: 203
Solved?: Yes
Tags: Linked List
击败: 98.14
推荐指数: ⭐⭐

[Remove Linked List Elements - LeetCode](https://leetcode.com/problems/remove-linked-list-elements/)

## 题意

Remove all elements from a linked list of integers that have value **val**.

**Example:**

```
Input:  1->2->6->3->4->5->6, val = 6
Output: 1->2->3->4->5
```

## 思路

1. 使用前置节点prev辅助

## 题解

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeElements(self, head: ListNode, val: int) -> ListNode:
        dummy = prev = ListNode(next=head)
        curr = prev.next
        while curr:
            if curr.val == val:
                prev.next = curr.next  # prev stays
            else:
                prev = curr  # prev moves forward
            curr = prev.next  # curr is always prev's next
        return dummy.next
```

击败98.14%