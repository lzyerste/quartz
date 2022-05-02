---
title: 209_Minimum_Size_Subarray_Sum_cb8fe2a9ea264be38bd53e40a6287e49
---

# 209. Minimum Size Subarray Sum

Difficulty: Medium
ID: 209
Solved?: Yes
Tags: Array, Binary Search, Two Pointers
击败: 52.08
推荐指数: ⭐⭐⭐

[Minimum Size Subarray Sum - LeetCode](https://leetcode.com/problems/minimum-size-subarray-sum/)

## 题意

Given an array of **n** positive integers and a positive integer **s**, find the minimal length of a **contiguous** subarray of which the sum ≥ **s**. If there isn't one, return 0 instead.

**Example:**

```
Input: s = 7, nums = [2,3,1,2,4,3]Output: 2
Explanation: the subarray [4,3] has the minimal length under the problem constraint.
```

**Follow up:**

If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log n).

## 思路

1. 标准滑动窗口，复杂度O(N)。
2. 二分搜索，复杂度O(NlgN)。

## 题解

```python
class Solution:
    def minSubArrayLen(self, s: int, nums: List[int]) -> int:
        i = j = 0
        sum = 0
        length = float("inf")
        while j < len(nums):
            sum += nums[j]
            j += 1
            if sum < s: continue
            while sum >= s:
                length = min(length, j - i)
                sum -= nums[i]
                i += 1
        return length if length != float("inf") else 0
```

击败52.08%