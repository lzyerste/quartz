---
title: 25_Reverse_Nodes_in_k-Group_4cb6a54b943647ddb78667adb8ac9f79
---

# 25. Reverse Nodes in k-Group

Difficulty: Hard
ID: 25
Solved?: Yes
Tags: Linked List
击败: 16.37
推荐指数: ⭐⭐⭐

[Reverse Nodes in k-Group - LeetCode](https://leetcode.com/problems/reverse-nodes-in-k-group/)

## 题意

给出一个链表，每 *k* 个节点一组进行`翻转`，并返回翻转后的链表。

*k* 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 *k* 的整数倍，那么将最后剩余节点保持原有顺序。

**示例 :**

给定这个链表：`1->2->3->4->5`

当 *k* = 2 时，应当返回: `2->1->4->3->5`

当 *k* = 3 时，应当返回: `3->2->1->4->5`

**说明 :**

- 你的算法只能使用常数的额外空间。
- **你不能只是单纯的改变节点内部的值**，而是需要实际的进行节点交换。

## 思路

- 翻转+递归

## 题解1

先切出第一个Group，分成两部分。前部分为一个明确的Group，做倒转；后部分为剩余部分，递归完成。

最后将两部分衔接起来是很简单的事。

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def reverseKGroup(self, head: ListNode, k: int) -> ListNode:
        def reverse(head: ListNode) -> ListNode:
            if not head or not head.next: return head
            subTail = head.next  # 子序列倒转后的尾节点
            subHead = reverse(head.next)  # 子序列倒转后的头结点
            subTail.next = head  # head沦为倒转后的尾节点
            head.next = None  # 尾节点后面要接None
            return subHead  # 也是当前序列倒转后的头结点
        
        if not head: return head
        tail = head
        for i in range(1, k):
            if tail.next:
                tail = tail.next
            else:
                return head  # 数量不够k个，不用倒转
        # [head, tail] 指向K元素组的首尾，inclusive
        subHead = self.reverseKGroup(tail.next, k)
        tail.next = None  # 切断链表，用于倒转
        newTail = head
        newHead = reverse(head)
        newTail.next = subHead
        return newHead
```

击败率有点尴尬，16.37%，不过要考虑到递归的开销。