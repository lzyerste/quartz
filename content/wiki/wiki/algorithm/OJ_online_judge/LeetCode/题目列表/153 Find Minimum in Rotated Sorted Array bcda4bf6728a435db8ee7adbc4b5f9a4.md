---
title: 153_Find_Minimum_in_Rotated_Sorted_Array_bcda4bf6728a435db8ee7adbc4b5f9a4
---

# 153. Find Minimum in Rotated Sorted Array

Difficulty: Medium
ID: 153
Solved?: Yes
Tags: Array, Binary Search
击败: 96.63
推荐指数: ⭐⭐⭐

[Find Minimum in Rotated Sorted Array - LeetCode](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)

## 题意

Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., `[0,1,2,4,5,6,7]` might become `[4,5,6,7,0,1,2]`).

Find the minimum element.

You may assume no duplicate exists in the array.

**Example 1:**

```
Input: [3,4,5,1,2] 
Output: 1

```

**Example 2:**

```
Input: [4,5,6,7,0,1,2]
Output: 0

```

## 思路

1. 二分法：注意判断条件nums[M] > nums[R]，说明分属两块，L放心往前走1。

## 题解

```python
class Solution:
    def findMin(self, nums: List[int]) -> int:
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R) // 2
            if nums[M] > nums[R]:
                L = M + 1
            else:
                R = M
        return nums[L]
```

击败96.63%