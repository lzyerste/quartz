---
title: 219_Contains_Duplicate_II_66b434bc595e4f2c9f5ea4ef6281e667
---

# 219. Contains Duplicate II

Difficulty: Easy
ID: 219
Solved?: Yes
Tags: Array, BFS, Hash Table
击败: 98.93
推荐指数: ⭐⭐⭐

[Contains Duplicate II - LeetCode](https://leetcode.com/problems/contains-duplicate-ii/)

## 题意

Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that **nums[i] = nums[j]** and the **absolute** difference between i and j is at most k.

**Example 1:**

```
Input: nums = [1,2,3,1], k = 3
Output: true

```

**Example 2:**

```
Input: nums = [1,0,1,1], k = 1
Output: true

```

**Example 3:**

```
Input: nums = [1,2,3,1,2,3], k = 2
Output: false

```

## 思路

1. 遍历到当前元素时，检查下数值之前是否出现过（最近的一次），然后检查下距离。

## 题解

```python
class Solution:
    def containsNearbyDuplicate(self, nums: List[int], k: int) -> bool:
        G = {}
        for i, d in enumerate(nums):
            if d in G and i - G[d] <= k:
                return True
            G[d] = i
        return False
```

击败98.93%