---
title: 206_Reverse_Linked_List_7107cc6b82674a8aaa8934b045a62ff6
---

# 206. Reverse Linked List

Difficulty: Easy
ID: 206
Solved?: Yes
Tags: Linked List
击败: 71.24
推荐指数: ⭐⭐⭐

[Reverse Linked List - LeetCode](https://leetcode.com/problems/reverse-linked-list/)

## 题意

Reverse a singly linked list.

**Example:**

```
Input: 1->2->3->4->5->NULL
Output: 5->4->3->2->1->NULL
```

**Follow up:**

A linked list can be reversed either iteratively or recursively. Could you implement both?

## 思路

1. 递归法：从第2个节点开始作为自链表，先将其反转；然后将原来的head作为新链表的tail即可。
2. 非递归，保持prev跟curr的关系
3. 非递归，将前面已反转的部分作为一个整体（有head跟tail），然后每一步是将下一个节点加入反转链表中。整个过程中始终保持链表的完整性。

## 题解1：递归

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        if not head or not head.next: return head
        sub_tail = head.next
        sub_head = self.reverseList(head.next)
        sub_tail.next = head
        head.next = None
        return sub_head
```

击败71.24%

## 题解2：非递归

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        prev = None
        curr = head
        while curr:
            next = curr.next
            curr.next = prev
            prev = curr
            curr = next
        return prev  # 结束时prev为新的head，curr已经是None
```

击败71.24%

## 题解3：非递归2，更优

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        if not head or not head.next: return head
        tail, next = head, head.next
        while next:
            tail.next = next.next
            next.next = head
            head = next
            next = tail.next
        return head
```

击败89.08%

这种解法的好处是每一轮循环都是保持链表的完整。

比如要反转`1 2 3 4 5`，假设到中间过程时，`1 2 3`已经反转好了，那么链表就是`3 2 1 4 5`。将已反转的`3 2 1`视为一个整体，接下来要做的就是把节点4挪到整体的前面。

代码中的head跟tail对应的是已反转整体的头节点与尾节点；代码中的next代表的是接下来要处理的节点。

注意，整个过程中已反转整体的tail是不会变动的，比如上面例子总是1。

这种解法的好处是，可以反转任意个节点，而不一定是整条链表。