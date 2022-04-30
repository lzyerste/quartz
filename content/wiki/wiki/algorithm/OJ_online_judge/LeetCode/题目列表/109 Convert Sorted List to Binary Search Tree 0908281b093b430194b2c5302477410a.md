---
title: 109_Convert_Sorted_List_to_Binary_Search_Tree_0908281b093b430194b2c5302477410a
---

# 109. Convert Sorted List to Binary Search Tree

Difficulty: Medium
ID: 109
Solved?: Yes
Tags: DFS, Linked List
击败: 38.82
推荐指数: ⭐⭐⭐

[Convert Sorted List to Binary Search Tree - LeetCode](https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/)

## 题意

Given the `head` of a singly linked list where elements are **sorted in ascending order**, convert it to a height balanced BST.

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of *every* node never differ by more than 1.

**Example 1:**

![https://assets.leetcode.com/uploads/2020/08/17/linked.jpg](https://assets.leetcode.com/uploads/2020/08/17/linked.jpg)

```
Input: head = [-10,-3,0,5,9]
Output: [0,-3,9,-10,null,5]
Explanation: One possible answer is [0,-3,9,-10,null,5], which represents the shown height balanced BST.
```

**Example 2:**

```
Input: head = []
Output: []
```

**Example 3:**

```
Input: head = [0]
Output: [0]
```

**Example 4:**

```
Input: head = [1,3]
Output: [3,1]
```

**Constraints:**

- The number of nodes in `head` is in the range `[0, 2 * 104]`.
- `10^5 <= Node.val <= 10^5`

## 思路

1. 找到链表的终点，作为root，左半部分作为左子树，右半部分作为右子树，递归完成。

## 题解

```python
# Definition for singly-linked list.
# class ListNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.next = None

# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, x):
#         self.val = x
#         self.left = None
#         self.right = None

# mid偏向于左半部分
def list_mid(head, stop):
    """
    :type head: ListNode
    :rtype: ListNode

    O(N) time
    """
    fast = slow = head
    while fast is not stop and fast.next is not stop and fast.next.next is not stop:
        fast = fast.next.next
        slow = slow.next
    return slow

class Solution(object):
    def sortedListToBST(self, head):
        """
        :type head: ListNode
        :rtype: TreeNode
        """
        return self.sortedListToBSTHelp(head, None)
    
    def sortedListToBSTHelp(self, head, stop):
        if head is stop:
            return None
        mid = list_mid(head, stop)
        root = TreeNode(mid.val)
        root.left = self.sortedListToBSTHelp(head, mid)
        root.right = self.sortedListToBSTHelp(mid.next, stop)
        return root
```