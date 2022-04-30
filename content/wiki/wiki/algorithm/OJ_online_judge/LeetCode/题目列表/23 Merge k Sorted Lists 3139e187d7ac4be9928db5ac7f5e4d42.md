---
title: 23_Merge_k_Sorted_Lists_3139e187d7ac4be9928db5ac7f5e4d42
---

# 23. Merge k Sorted Lists

Difficulty: Hard
ID: 23
Solved?: Yes
Tags: Divide and Conquer, Heap, Linked List
击败: 85.11
推荐指数: ⭐⭐⭐⭐

[Merge k Sorted Lists - LeetCode](https://leetcode.com/problems/merge-k-sorted-lists/)

## 题意

合并 *k* 个排序链表，返回合并后的排序链表。请分析和描述算法的复杂度。

**示例:**

```
输入:
[
  1->4->5,
  1->3->4,
  2->6
]
输出: 1->1->2->3->4->4->5->6
```

## 思路

- 使用优先级队列，将k条链表的头结点一股脑儿塞入堆，然后每次弹出一个，保证当前最小，然后将该结点的下一个节点（如果存在的话）塞入堆中。
- 也可以用D&C思想，将链表分成两堆，各自合并之后再合并。

## 题解1：heapq

用Python3实现时，遇到一个问题，ListNode本身并没有实现比较，所以不能直接把node扔到堆中。所以，想构造一个二元tuple，为(node.val, node)，但如果node.val相等时，它还会去继续比较node。

所以，要想办法打破平衡，再人为引入一个ID（递增），这样就不会有重复了。

> store entries as `3-element` list including the `priority`, an `entry count`, and the `task`. The entry count serves as a tie-breaker so that two tasks with the same priority are returned in the order they were added. And since no two entry counts are the same, the tuple comparison will never attempt to directly compare two tasks.
> 

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

class Solution:
    def mergeKLists(self, lists: List[ListNode]) -> ListNode:
        def id():
            i = 0
            while True:
                yield i
                i += 1

        import heapq as hq
        it = id()  # iterator
        # (val, id, node) tuple
        h = [(node.val, next(it), node) for node in lists if node]
        hq.heapify(h)
        head = tail = ListNode(0)
        while h:
            _, _, node = hq.heappop(h)
            tail.next = node
            tail = tail.next
            node = node.next
            if node:
                hq.heappush(h, (node.val, next(it), node))
        return head.next
```

## 题解2：自己实现优先级队列

```python
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, x):
#         self.val = x
#         self.next = None

def heapify(heap, less):
    n = len(heap)
    for i in range(n//2)[::-1]:
        down(heap, i, less)

def heappush(heap, item, less):
    heap.append(item)
    up(heap, len(heap) - 1, less)

def heappop(heap, less):
    swap(heap, 0, len(heap) - 1)
    top = heap.pop()
    down(heap, 0, less)
    return top

def up(heap, k, less):
    if k == 0: return
    parent = (k - 1) // 2
    if less(heap[k], heap[parent]):
        swap(heap, k, parent)
        up(heap, parent, less)

def down(heap, k, less):
    n = len(heap)
    left = 2 * k + 1  # left child
    right = left + 1  # right child

    if left >= n: return

    smaller = left
    if right < n and less(heap[right], heap[left]):
        smaller = right

    if less(heap[smaller], heap[k]):
        swap(heap, smaller, k)
        down(heap, smaller, less)

def swap(heap, i, j):
    heap[i], heap[j] = heap[j], heap[i]

class Solution:
    def mergeKLists(self, lists: List[ListNode]) -> ListNode:
        less = lambda x, y: x.val < y.val
        heap = [node for node in lists if node]
        heapify(heap, less)
        head = tail = ListNode(0)
        while heap:
            node = heappop(heap, less)
            tail.next = node
            tail = tail.next
            if node.next:
                heappush(heap, node.next, less)
        return head.next
```