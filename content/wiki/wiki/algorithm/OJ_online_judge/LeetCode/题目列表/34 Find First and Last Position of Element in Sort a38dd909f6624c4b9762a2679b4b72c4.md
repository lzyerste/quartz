---
title: 34_Find_First_and_Last_Position_of_Element_in_Sort_a38dd909f6624c4b9762a2679b4b72c4
---

# 34. Find First and Last Position of Element in Sorted Array

Difficulty: Medium
ID: 34
Solved?: Yes
Tags: Array, Binary Search
击败: 18.14
推荐指数: ⭐⭐⭐

[Find First and Last Position of Element in Sorted Array - LeetCode](https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array/)

## 题意

给定一个按照升序排列的整数数组 `nums`，和一个目标值 `target`。找出给定目标值在数组中的开始位置和结束位置。

你的算法时间复杂度必须是 *O*(log *n*) 级别。

如果数组中不存在目标值，返回 `[-1, -1]`。

**示例 1:**

```
输入: nums = [5,7,7,8,8,10], target = 8
输出: [3,4]
```

**示例 2:**

```
输入: nums = [5,7,7,8,8,10], target = 6
输出: [-1,-1]
```

## 思路

- 先在数组中二分搜索，找到后再往左右二分确定边界
- 二分搜索两次，一次找最左，一次找最右

## 题解1：先命中，再确定左右边界

```python
class Solution:
    def searchRange(self, nums: List[int], target: int) -> List[int]:
        def mostLeft(nums, L, R, T):
            # 保证nums[R] == T
            while L < R:  # 退出时L==R
                M = (L + R) // 2  # 偏向L
                if nums[M] != T:
                    L = M + 1
                else:
                    R = M
            return L
        
        def mostRight(nums, L, R, T):
            # 保证nums[L] == T
            while L < R:
                M = (L + R + 1) // 2  # 偏向R
                if nums[M] != T:
                    R = M - 1
                else:
                    L = M
            return L
        
        def bsearch(nums, L, R, T):
            while L <= R:
                M = (L + R) // 2
                if nums[M] < T:
                    L = M + 1
                elif nums[M] > T:
                    R = M - 1
                else:  # found
                    return [mostLeft(nums, L, M, T), mostRight(nums, M, R, T)]
            return [-1, -1]
        
        return bsearch(nums, 0, len(nums) - 1, target)
```

击败18.14%