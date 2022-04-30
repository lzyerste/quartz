---
title: 154_Find_Minimum_in_Rotated_Sorted_Array_II_ee9f53be979a40c5a3ffe63c4a795dfe
---

# 154. Find Minimum in Rotated Sorted Array II

Difficulty: Hard
ID: 154
Solved?: Yes
Tags: Array, Binary Search
击败: 68.38
推荐指数: ⭐⭐⭐⭐

[Find Minimum in Rotated Sorted Array II - LeetCode](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array-ii/)

## 题意

Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., `[0,1,2,4,5,6,7]` might become `[4,5,6,7,0,1,2]`).

Find the minimum element.

The array may contain duplicates.

**Example 1:**

```
Input: [1,3,5]
Output: 1
```

**Example 2:**

```
Input: [2,2,2,0,1]
Output: 0
```

**Note:**

- This is a follow up problem to [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/).
- Would allow duplicates affect the run-time complexity? How and why?

## 思路

1. 二分法：注意元素相同的情况

## 题解

```python
class Solution:
    def findMin(self, nums: List[int]) -> int:
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R) // 2
            if nums[M] > nums[R]:  # M在左部分
                L = M + 1
            elif nums[M] < nums[R]: # M在右部分
                R = M
            else:
                # Ｍ不确定在左还是右。
                # R不可能对应唯一的最小。因为M≠R，而nums[M]==nums[R]，所以可以放弃R。
                R -= 1
        return nums[L]
```

击败68.38%