---
title: 80_Remove_Duplicates_from_Sorted_Array_II_dd141920664f4faeb4ca9dbd99a0b34a
---

# 80. Remove Duplicates from Sorted Array II

Difficulty: Medium
ID: 80
Solved?: Yes
Tags: Array, Two Pointers
击败: 94.78
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/remove-duplicates-from-sorted-array-ii/)

## 题意

## 题解：双指针

```python
class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 2: return n
        i = 1
        for j in range(2, n):
            if nums[j] == nums[i - 1]: continue  # 妙用i-1
            i += 1
            nums[i] = nums[j]
        return i + 1
```