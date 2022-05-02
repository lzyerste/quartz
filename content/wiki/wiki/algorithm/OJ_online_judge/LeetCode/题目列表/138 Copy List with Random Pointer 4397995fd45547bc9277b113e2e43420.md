---
title: 138_Copy_List_with_Random_Pointer_4397995fd45547bc9277b113e2e43420
---

# 138. Copy List with Random Pointer

Difficulty: Medium
ID: 138
Solved?: Yes
Tags: Hash Table, Linked List
击败: 89.78
推荐指数: ⭐⭐⭐

[Copy List with Random Pointer - LeetCode](https://leetcode.com/problems/copy-list-with-random-pointer/)

## 题意

A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.

Return a **[](https://en.wikipedia.org/wiki/Object_copying#Deep_copy)** of the list.

The Linked List is represented in the input/output as a list of `n` nodes. Each node is represented as a pair of `[val, random_index]` where:

- `val`: an integer representing `Node.val`
- `random_index`: the index of the node (range from `0` to `n-1`) where random pointer points to, or `null` if it does not point to any node.

**Example 1:**

![https://assets.leetcode.com/uploads/2019/12/18/e1.png](https://assets.leetcode.com/uploads/2019/12/18/e1.png)

```
Input: head = [7,null](7,null)
Output: [7,null](7,null)

```

**Example 2:**

![https://assets.leetcode.com/uploads/2019/12/18/e2.png](https://assets.leetcode.com/uploads/2019/12/18/e2.png)

```
Input: head = [1,1](1,1)
Output: [1,1](1,1)

```

**Example 3:**

![https://assets.leetcode.com/uploads/2019/12/18/e3.png](https://assets.leetcode.com/uploads/2019/12/18/e3.png)

```
Input: head = [3,null](3,null)
Output: [3,null](3,null)

```

**Example 4:**

```
Input: head = []
Output: []
Explanation: Given linked list is empty (null pointer), so return null.

```

**Constraints:**

- `10000 <= Node.val <= 10000`
- `Node.random` is null or pointing to a node in the linked list.
- The number of nodes will not exceed 1000.

## 思路

1. 使用字典记录原始节点（key）与拷贝节点（value）之间的对应关系。
2. 不用额外的空间，修改原来节点的next指针，使它指向拷贝，而拷贝的next则指向原节点的下一个节点，如此交叉。

## 题解1：字典

```python
"""
# Definition for a Node.
class Node:
    def __init__(self, x, next=None, random=None):
        self.val = int(x)
        self.next = next
        self.random = random
"""

class Solution(object):
    def copyRandomList(self, head):
        """
        :type head: Node
        :rtype: Node
        """
        G = {None: None}
        curr = head
        while curr:
            node = Node(curr.val, curr.next, curr.random)
            G[curr] = node
            curr = curr.next
        curr = head
        while curr:
            node = G[curr]
            node.next = G[node.next]
            node.random = G[node.random]
            curr = curr.next
        return G[head]
```

击败89.78%