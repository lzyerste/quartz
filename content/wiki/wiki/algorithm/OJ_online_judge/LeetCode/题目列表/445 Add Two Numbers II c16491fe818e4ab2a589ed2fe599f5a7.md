---
title: 445_Add_Two_Numbers_II_c16491fe818e4ab2a589ed2fe599f5a7
---

# 445. Add Two Numbers II

Difficulty: Medium
ID: 445
Solved?: Yes
Tags: Linked List
推荐指数: ⭐⭐

[Add Two Numbers II - LeetCode](https://leetcode.com/problems/add-two-numbers-ii/)

## 题意

You are given two **non-empty** linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Follow up:**What if you cannot modify the input lists? In other words, reversing the lists is not allowed.

**Example:**

```
Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 8 -> 0 -> 7
```

## 思路

1. 将两个链表先反转，然后相加，最后将结果链表再反转。参考 [2. Add Two Numbers](2%20Add%20Two%20Numbers%206843dc5ed34e4be89ef1efade5c3e103.md) 。
2. 使用递归法，比如两个链表长度一样，那么它们的相加就相当于head.next子链表相加，然后把head跟carry相加。如果链表长度不一样，处理起来啰嗦一些。