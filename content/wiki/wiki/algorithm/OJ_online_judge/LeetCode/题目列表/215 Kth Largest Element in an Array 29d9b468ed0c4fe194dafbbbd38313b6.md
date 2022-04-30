---
title: 215_Kth_Largest_Element_in_an_Array_29d9b468ed0c4fe194dafbbbd38313b6
---

# 215. Kth Largest Element in an Array

Difficulty: Medium
ID: 215
Solved?: Yes
Tags: Divide and Conquer, Heap
击败: 94.81
推荐指数: ⭐⭐⭐⭐

[Kth Largest Element in an Array - LeetCode](https://leetcode.com/problems/kth-largest-element-in-an-array/)

tag: 第k大

## 题意

Find the **k**th largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.

**Example 1:**

```
Input: [3,2,1,5,6,4] and k = 2
Output: 5

```

**Example 2:**

```
Input: [3,2,3,1,2,4,5,5,6] and k = 4
Output: 4
```

**Note:**You may assume k is always valid, 1 ≤ k ≤ array's length.

## 思路

1. 使用快排的思想，对数组进行partition，分为三部分：小于、等于和大于pivot。注意，pivot的选择，选中间较好。一开始总是选最左边的，性能很差，选中间的就很好了。
2. 使用heap

## 题解1：快排思想

```python
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        def partition(nums, L, R, k):
            if L == R: return L  # k must be 1
            M = (L + R) // 2
            nums[L], nums[M] = nums[M], nums[L]
            pivot = nums[L]
            p = q = L
            for i in range(L+1, R+1):
                if nums[i] < pivot:
                    tmp = nums[i]
                    nums[i] = nums[q+1]
                    nums[q+1] = nums[p]
                    nums[p] = tmp
                    p += 1
                    q += 1
                elif nums[i] == pivot:
                    nums[q+1], nums[i] = nums[i], nums[q+1]
                    q += 1
                else:
                    pass
            # [L, p-1] --> less than pivot
            # [p, q] --> equal to pivot
            # [q+1, R] --> larger than pivot
            if k <= p - L:
                return partition(nums, L, p - 1, k)
            elif k <= q - L + 1:
                return p  # all equal
            else:
                return partition(nums, q + 1, R, k - (q - L + 1))
        
        kth = partition(nums, 0, len(nums) - 1, len(nums) + 1 - k)
        return nums[kth]
```

击败94.81%