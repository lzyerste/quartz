---
title: 430_Flatten_a_Multilevel_Doubly_Linked_List_a19e32443cbc4179a86ce609d21eb667
---

# 430. Flatten a Multilevel Doubly Linked List

Difficulty: Medium
ID: 430
Solved?: Yes
Tags: DFS, Linked List
击败: 67.89
推荐指数: ⭐⭐

[Flatten a Multilevel Doubly Linked List - LeetCode](https://leetcode.com/problems/flatten-a-multilevel-doubly-linked-list/)

## 题意

You are given a doubly linked list which in addition to the next and previous pointers, it could have a child pointer, which may or may not point to a separate doubly linked list. These child lists may have one or more children of their own, and so on, to produce a multilevel data structure, as shown in the example below.

Flatten the list so that all the nodes appear in a single-level, doubly linked list. You are given the head of the first level of the list.

**Example 1:**

```
Input: head = [1,2,3,4,5,6,null,null,null,7,8,9,10,null,null,11,12]
Output: [1,2,3,7,8,11,12,9,10,4,5,6]
Explanation:

The multilevel linked list in the input is as follows:

After flattening the multilevel linked list it becomes:

```

![https://assets.leetcode.com/uploads/2018/10/12/multilevellinkedlist.png](https://assets.leetcode.com/uploads/2018/10/12/multilevellinkedlist.png)

![https://assets.leetcode.com/uploads/2018/10/12/multilevellinkedlistflattened.png](https://assets.leetcode.com/uploads/2018/10/12/multilevellinkedlistflattened.png)

**Example 2:**

```
Input: head = [1,2,null,3]
Output: [1,3,2]
Explanation:

The input multilevel linked list is as follows:

  1---2---NULL
  |
  3---NULL

```

**Example 3:**

```
Input: head = []
Output: []

```

**How multilevel linked list is represented in test case:**

We use the multilevel linked list from **Example 1** above:

```
 1---2---3---4---5---6--NULL
         |
         7---8---9---10--NULL
             |
             11--12--NULL
```

The serialization of each level is as follows:

```
[1,2,3,4,5,6,null]
[7,8,9,10,null]
[11,12,null]

```

To serialize all levels together we will add nulls in each level to signify no node connects to the upper node of the previous level. The serialization becomes:

```
[1,2,3,4,5,6,null]
[null,null,7,8,9,10,null]
[null,11,12,null]

```

Merging the serialization of each level and removing trailing nulls we obtain:

```
[1,2,3,4,5,6,null,null,null,7,8,9,10,null,null,11,12]
```

**Constraints:**

- Number of Nodes will not exceed 1000.
- `1 <= Node.val <= 10^5`

## 思路

1. 递归。注意，平坦孩子时需要得到头结点与尾节点

## 题解

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, val, prev, next, child):
        self.val = val
        self.prev = prev
        self.next = next
        self.child = child
"""

class Solution:
    def flatten(self, head: 'Node') -> 'Node':
        head, tail = self._flat(head)
        return head

    def _flat(self, head: 'Node') -> ('Node', 'Node'):
        ret_head = ret_tail = head
        curr = head
        while curr:
            ret_tail = curr
            next = curr.next
            if curr.child:
                head, tail = self._flat(curr.child)
                curr.next = head
                head.prev = curr
                tail.next = next
                if next: next.prev = tail

                curr.child = None
                ret_tail = tail
            curr = next
        return ret_head, ret_tail
```

击败67.89%