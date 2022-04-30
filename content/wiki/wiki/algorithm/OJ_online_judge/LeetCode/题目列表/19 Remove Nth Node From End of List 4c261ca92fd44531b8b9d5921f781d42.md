---
title: 19_Remove_Nth_Node_From_End_of_List_4c261ca92fd44531b8b9d5921f781d42
---

# 19. Remove Nth Node From End of List

Difficulty: Medium
ID: 19
Solved?: Yes
Tags: Linked List, Two Pointers
击败: 61.47
推荐指数: ⭐⭐⭐

[Remove Nth Node From End of List - LeetCode](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)

## 题意

给定一个链表，删除链表的倒数第 *n* 个节点，并且返回链表的头结点。

**示例：**

```
1->2->3->4->5n1->2->3->5
```

**说明：**

给定的 *n* 保证是有效的。

**进阶：**

你能尝试使用一趟扫描实现吗？

## 思路

- 双指针方法，使两个指针之间相距n。那么，当前面的指针走到链表尾时，后面的指针走到待操 作节点处（或者说待删除节点的前一个节点）。

## 题解1

需要注意边界情况（待删除的节点刚好是head）。

举个例子1 → 2 → 3 → 4 → 5 → NULL，

如果n为1，要删除5，需要将指针定位到4。fast停在5，slow停在4。

如果n为2，要删除4，需要将指针定位到3。fast停在5，slow停在3。

如果n为3，要删除3，需要将指针定位到2。fast停在5，slow停在2。

如果n为2，要删除2，需要将指针定位到1。fast停在5，slow停在1。

如果n为5，需要删除1，将头结点转为2。`fast停在NULL，slow停在1。`

双指针，fast指针停在最后一个节点，slow指针停在待删除节点的前一节点。

初始时，fast和slow指针都先指向head节点，然后让fast先走n步。接下来，fast和slow同步走，保持间距n，直到fast走到最后一个节点，此时slow节点停在待删除节点的前一个节点。

```python
class Solution:
    def removeNthFromEnd(self, head: ListNode, n: int) -> ListNode:
        fast = slow = head  # slow is the node before to be removed
        # fast go n steps first
        for i in range(n):
            fast = fast.next
        if fast is None:  # remove the head
            return slow.next
        while fast.next:
            fast = fast.next
            slow = slow.next
        # remove slow.next
        slow.next = slow.next.next
        return head
```