---
title: 217_Contains_Duplicate_1645d61d2b1043389d2bd0605b549bde
---

# 217. Contains Duplicate

Difficulty: Easy
ID: 217
Solved?: Yes
Tags: Array, Hash Table
击败: 100
推荐指数: ⭐⭐

[Contains Duplicate - LeetCode](https://leetcode.com/problems/contains-duplicate/)

## 题意

Given an array of integers, find if the array contains any duplicates.

Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.

**Example 1:**

```
Input: [1,2,3,1]
Output: true
```

**Example 2:**

```
Input: [1,2,3,4]
Output: false
```

**Example 3:**

```
Input: [1,1,1,3,3,4,3,2,4,2]
Output: true
```

## 思路

1. 集合化，看看元素是否减少。

## 题解

```python
class Solution:
    def containsDuplicate(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        return len(nums) != len(set(nums))
```

击败100%