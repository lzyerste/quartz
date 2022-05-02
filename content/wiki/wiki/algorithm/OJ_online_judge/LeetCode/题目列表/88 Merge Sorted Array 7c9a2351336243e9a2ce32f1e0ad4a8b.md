---
title: 88_Merge_Sorted_Array_7c9a2351336243e9a2ce32f1e0ad4a8b
---

# 88. Merge Sorted Array

Difficulty: Easy
ID: 88
Solved?: Yes
Tags: Array, Two Pointers
击败: 81.79
推荐指数: ⭐⭐⭐

[Merge Sorted Array - LeetCode](https://leetcode.com/problems/merge-sorted-array/)

## 题意

## 题解

从大往下放。

```python
class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        # 从大往小放
        i, j, k = m - 1, n - 1, m + n - 1  # 数组1有效末尾，数组2有效末尾，数组1真实末尾
        while i >= 0 and j >= 0:
            if nums2[j] > nums1[i]:
                nums1[k] = nums2[j]
                j -= 1
            else:
                nums1[k] = nums1[i]
                i -= 1
            k -= 1  # 每步k总是往前一步
        if j >= 0:  # 如果是nums1多出来，那么已经是处于正确位置
            nums1[:j+1] = nums2[:j+1]
```