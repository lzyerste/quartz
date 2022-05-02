---
title: 220_Contains_Duplicate_III_b9302bf8b3bc45399e666c0ba0723915
---

# 220. Contains Duplicate III

Difficulty: Medium
ID: 220
Solved?: Yes
Tags: Ordered Map, Sliding Window, Sort
击败: 53.41
推荐指数: ⭐⭐⭐⭐

[Contains Duplicate III - LeetCode](https://leetcode.com/problems/contains-duplicate-iii/)

[219. Contains Duplicate II](219%20Contains%20Duplicate%20II%2066b434bc595e4f2c9f5ea4ef6281e667.md) 

## 题意

Given an array of integers, find out whether there are two distinct indices i and j in the array such that the **absolute** difference between **nums[i]** and **nums[j]** is at most t and the **absolute** difference between i and j is at most k.

**Example 1:**

```
Input: nums = [1,2,3,1], k = 3, t = 0
Output: true

```

**Example 2:**

```
Input: nums = [1,0,1,1], k = 1, t = 2
Output: true

```

**Example 3:**

```
Input: nums = [1,5,9,1,5,9], k = 2, t = 3
Output: false

```

**Constraints:**

- `0 <= nums.length <= 2 * 104`
- `231 <= nums[i] <= 231 - 1`
- `0 <= k <= 104`
- `0 <= t <= 231 - 1`

## 思路

1. 现在检查的是区间范围t，比较难处理，如果退化为点的话，就类似第219题了。
    
    使用滑动窗口，左游标i是为了减小窗口大小，使其小于k+1。
    

## 题解

```python
class Solution:
    def containsNearbyAlmostDuplicate(self, nums: List[int], k: int, t: int) -> bool:
        if k == 0: return False
        G = {}
        i = j = 0
        while j < len(nums):
            # handle nums[j]
            idx = nums[j] // (t + 1)
            for dx in [-1, 0, 1]:
                if (idx + dx) in G and abs(G[idx+dx] - nums[j]) <= t:
                    return True
            G[idx] = nums[j]
            j += 1
            while j - i >= k + 1:  # [i, j)
                # handle nums[i]
                del G[nums[i] // (t + 1)]
                i += 1
        return False
```

击败53.41%