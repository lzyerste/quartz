---
title: 160_Intersection_of_Two_Linked_Lists_464929f68916406991a71e0990b0794f
---

# 160. Intersection of Two Linked Lists

Difficulty: Easy
ID: 160
Solved?: Yes
Tags: Linked List
击败: 47.51
推荐指数: ⭐⭐⭐⭐

[Intersection of Two Linked Lists - LeetCode](https://leetcode.com/problems/intersection-of-two-linked-lists/)

## 题意

Write a program to find the node at which the intersection of two singly linked lists begins.

For example, the following two linked lists:

![https://assets.leetcode.com/uploads/2018/12/13/160_statement.png](https://assets.leetcode.com/uploads/2018/12/13/160_statement.png)

begin to intersect at node c1.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/06/29/160_example_1_1.png](https://assets.leetcode.com/uploads/2020/06/29/160_example_1_1.png)

```
Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
Output: Reference of the node with value = 8
Input Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,6,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.
```

**Example 2:**

![https://assets.leetcode.com/uploads/2020/06/29/160_example_2.png](https://assets.leetcode.com/uploads/2020/06/29/160_example_2.png)

```
Input: intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
Output: Reference of the node with value = 2
Input Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [1,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.

```

**Example 3:**

![https://assets.leetcode.com/uploads/2018/12/13/160_example_3.png](https://assets.leetcode.com/uploads/2018/12/13/160_example_3.png)

```
Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
Output: null
Input Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
Explanation: The two lists do not intersect, so return null.
```

**Notes:**

- If the two linked lists have no intersection at all, return `null`.
- The linked lists must retain their original structure after the function returns.
- You may assume there are no cycles anywhere in the entire linked structure.
- Each value on each linked list is in the range `[1, 10^9]`.
- Your code should preferably run in O(n) time and use only O(1) memory.

## 思路

1. 直观法，使用字典或集合记录一条链表的所有节点
2. 将链表尾巴c3指向链表A的头部a1，那么在链表B看来，链表中有个环，而题目所求的正是环的起点c1。检测环可参考题目 [142. Linked List Cycle II](142 Linked List Cycle II 783e2528b51f4ab282c57205eb6324b4.md)
3. 观察路径长度。假设链表A头部到共同点c1的距离为u，链表B头部到共同点c1的距离为v，重合部分长度为w。那么，链表A走了（u + w）步之后到达尾部，此时它绕到链表B再走v步后就能到达c1，此时一共走了（u + v + w）步。类似的，链表B走了（v + w）步之后到达尾部，此时它绕到链表A再走u步就能达到c1，此时一共走了（u + v + w）步，与A走的步数相同，且刚好相遇在重合部分的起点c1。
    
    注意检测链表A和B没重合的情况，即它们的尾部不是同一个的时候。
    

## 题解：检测环

```python
class Solution(object):
    def getIntersectionNode(self, headA, headB):
        """
        :type head1, head1: ListNode
        :rtype: ListNode
        """
        if headA is None or headB is None:
            return None
        tail = headA
        while tail.next:
            tail = tail.next
        tail.next = headB
        
        node = self.detectCycle(headA)
        tail.next = None
        return node
```

## 题解：相遇

```python
class Solution(object):
    def getIntersectionNode(self, headA, headB):
        """
        :type head1, head1: ListNode
        :rtype: ListNode
        """
        if headA is None or headB is None:
            return None
        
        pa = headA
        pb = headB
        
        ta = tb = None  # tail
        
        while True:
            if ta and tb and ta is not tb:
                return None
            if pa is pb:
                return pa
            if pa.next is None:
                ta = pa
                pa = headB
            else:
                pa = pa.next
            if pb.next is None:
                tb = pb
                pb = headA
            else:
                pb = pb.next
```

击败47.51%