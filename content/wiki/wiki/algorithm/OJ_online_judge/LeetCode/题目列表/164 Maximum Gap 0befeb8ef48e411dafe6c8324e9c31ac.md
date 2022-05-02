---
title: 164_Maximum_Gap_0befeb8ef48e411dafe6c8324e9c31ac
---

# 164. Maximum Gap

Difficulty: Hard
ID: 164
Solved?: Yes
Tags: Sort
击败: 23.33
推荐指数: ⭐⭐⭐⭐

[Maximum Gap - LeetCode](https://leetcode.com/problems/maximum-gap/)

## 题意

Given an unsorted array, find the maximum difference between the successive elements in its sorted form.

Return 0 if the array contains less than 2 elements.

**Example 1:**

```
Input: [3,6,9,1]
Output: 3
Explanation: The sorted form of the array is [1,3,6,9], either
             (3,6) or (6,9) has the maximum difference 3.
```

**Example 2:**

```
Input: [10]
Output: 0
Explanation: The array contains less than 2 elements, therefore return 0.
```

**Note:**

- You may assume all elements in the array are non-negative integers and fit in the 32-bit signed integer range.
- Try to solve it in linear time/space.

## 思路

1. 直接排序
2. Radix Sort
3. 鸽巢原理：从最小值到最大值区间分割成N-1个bucket（等宽），剩余N-2个数字（去除最小值与最大值），那么至少有一个bucket是空的。而bucket内部的点的最远距离不会超过bucket宽度，所以最远距离肯定含有空的bucket。每个bucket只需要跟踪最小值与最大值。bucket之间产生最远距离。

## 题解3

```python
class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        N = len(nums)
        if not nums or N < 2: return 0
        MIN = min(nums)
        MAX = max(nums)
        # the last bucket may be smaller
        gap = (MAX - MIN + N - 2) // (N - 1)
        buckets = [[float("inf"), float("-inf")] for _ in range(N-1)]
        # put numbers into buckets
        for x in nums:
            if x == MIN or x == MAX: continue
            i = (x - MIN) // gap
            buckets[i][0] = min(buckets[i][0], x)
            buckets[i][1] = max(buckets[i][1], x)
        # scan the buckets
        maxGap = float("-inf")
        prev = MIN
        for bmin, bmax in buckets:
            if bmin == float("inf"): continue
            maxGap = max(maxGap, bmin - prev)
            prev = bmax
        maxGap = max(maxGap, MAX - prev)
        return maxGap
```

击败23.33%

## 题解：精细划分区间

gap = (MAX - MIN) // N划分出至少N+1个区间，包括最小值与最大值，这样可以对所有数值一视同仁。

为了划分出K个区间，最右一项的（K-1）的起始位置是min + (K-1)*d，max需要大于等于它。另外K需要大于等于N+1。

- min + (K-1)*d ≤ max
- N+1 ≤ K

得到 N ≤ K-1 ≤ (max - min) / d，所以 d ≤ (max - min) / N，d往小了取，所以可以选(max - min) // N。

注意，d可能会是0（数字太密了）。

确定了gap之后，就可以计算出多少个区间了，也就是K。如果整除的话，max刚好落在左边界，需要额外加1；如果不整除的话，自然是往上取整。

```python
class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        N = len(nums)
        if not nums or N < 2: return 0
        MIN = min(nums)
        MAX = max(nums)
        if MIN == MAX: return 0
        **gap = max(1, (MAX - MIN) // N)**
        **K = (MAX - MIN) // gap + 1**
        buckets = [[float("inf"), float("-inf")] for _ in range(K)]
        # put numbers into buckets
        for x in nums:
            i = (x - MIN) // gap
            buckets[i][0] = min(buckets[i][0], x)
            buckets[i][1] = max(buckets[i][1], x)
        # scan the buckets
        maxGap = float("-inf")
        prev = float("inf")
        for bmin, bmax in buckets:
            if bmin == float("inf"): continue
            maxGap = max(maxGap, bmin - prev)
            prev = bmax
        return maxGap
```