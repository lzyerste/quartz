---
title: 81_Search_in_Rotated_Sorted_Array_II_dfc139a9c31044b3bbd9973a61286ca5
---

# 81. Search in Rotated Sorted Array II

Difficulty: Medium
ID: 81
Solved?: Yes
Tags: Array, Binary Search
击败: 97.61
推荐指数: ⭐⭐⭐⭐

[Loading Question... - LeetCode](https://leetcode.com/problems/search-in-rotated-sorted-array-ii/)

## 题意

## 题解：二分

注意，二分后，L,M,R对应的三个数如果都相等的话，是判断不了转折点在哪里。这时候只能保守地一步步走。

```python
class Solution:
    def search(self, nums: List[int], target: int) -> bool:
        L, R = 0, len(nums) - 1
        while L <= R:
            M = (L + R) // 2
            if nums[M] == target:
                return True
            if nums[M] > nums[R]:
                # the left part is sorted
                if nums[L] <= target < nums[M]:
                    R = M - 1
                else:
                    L = M + 1
            elif nums[M] < nums[R]:
                # the right part is sorted
                if nums[M] < target <= nums[R]:
                    L = M + 1
                else:
                    R = M - 1
            else:
                R -= 1  # 三者相等，看不出转折点，只能挪一个位置，不能对半分
        return False
```