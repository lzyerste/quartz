---
title: 2_Add_Two_Numbers_6843dc5ed34e4be89ef1efade5c3e103
---

# 2. Add Two Numbers

Difficulty: Medium
ID: 2
Solved?: Yes
Tags: Linked List, Math
击败: 78.6
推荐指数: ⭐⭐⭐

[Loading...](https://leetcode.com/problems/add-two-numbers/)

## 题意

给出两个 **`非空`** 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 **`逆序`** 的方式存储的，并且它们的每个节点只能存储 **`一位`** 数字。

如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

**示例：**

```
输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
输出：7 -> 0 -> 8
原因：342 + 465 = 807
```

## 题解1：递归

`一句话`：模拟小学数学加法。

小学数学算式是从低位往高位加，对应到这里的链表则是从左到右，因为链表已经是逆序的了。

> 思考，如果链表是正常顺序呢？
> 

使用递归来做比较直观，`当前`需要处理的是两个加数a、b（注意节点可能为None，相当于高位补0，不影响计算），还有产生的进位carry。处理方式就是直接加起来，看和值是否产生进位，和值作为当前运算结果的val，产生新的链表节点。`递归`要处理的是`剩余`的节点（各自链表的下一个节点，注意None的处理，以及当前新产生的进位carry）。

> 思考，如何改为非递归方式呢？
> 

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1: 'ListNode', l2: 'ListNode') -> 'ListNode':
        def addHelper(l1, l2, carry):
            if not l1 and not l2 and not carry:
                return None
            a = l1.val if l1 else 0
            b = l2.val if l2 else 0
            carry, d = divmod(a + b + carry, 10)
            node = ListNode(d)
            l1 = l1.next if l1 else None
            l2 = l2.next if l2 else None
            node.next = addHelper(l1, l2, carry)
            return node
        
        return addHelper(l1, l2, 0)
```

## 题解2：非递归

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        carry = 0
        head = tail = ListNode(0)  # dummy node
        while l1 or l2 or carry:
            a = l1.val if l1 else 0
            b = l2.val if l2 else 0
            carry, d = divmod(a + b + carry, 10)
            node = ListNode(d)
            tail.next = node
            tail = node
            l1 = l1.next if l1 else None
            l2 = l2.next if l2 else None
        return head.next
```