---
title: 213_House_Robber_II_534f4591032e4c6fbd38a6fef17e62ef
---

# 213. House Robber II

Difficulty: Medium
ID: 213
Solved?: Yes
Tags: DP
击败: 82.16
推荐指数: ⭐⭐⭐⭐

[House Robber II - LeetCode](https://leetcode.com/problems/house-robber-ii/)

[198. House Robber](198%20House%20Robber%20d2d2babc278645bab0dd1e4c85accc24.md) 

## 题意

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are **arranged in a circle.** That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and **it will automatically contact the police if two adjacent houses were broken into on the same night**.

Given a list of non-negative integers `nums` representing the amount of money of each house, return *the maximum amount of money you can rob tonight **without alerting the police***.

**Example 1:**

```
Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.

```

**Example 2:**

```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.

```

**Example 3:**

```
Input: nums = [0]
Output: 0

```

**Constraints:**

- `1 <= nums.length <= 100`
- `0 <= nums[i] <= 1000`

## 思路

1. 两轮一维DP：dp(i)表示到i截止时，能抢的最大值。常规情况下，dp(i) = max(dp(i-1), dp(i-2) + A[i])，第一项表示不抢第i项，所以沿用dp(i-1)，第二项表示抢第i项，那么第i-1不能抢，只能从i-2开始。
    
    现在要注意的是，形成了一个环，中间元素照常，最后一个元素到底能不能抢呢？它不知道第0项到底有没有被抢。
    
    简单分类讨论，第一种情况，总是抢了第0项，那么第1项与最后一项与它相邻。第二种情况，总是不抢第0项，那么，就跟常规情况一样了。
    

## 题解

```python
class Solution:
    def rob(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 3: return max(nums)
        
        MAX = 0
        # [0] is robbed, [1], [n-1] are disabled
        dp = [0 for _ in nums]
        dp[0] = nums[0]  # [0] is robbed
        dp[1] = nums[0]  # [1] is not robbed
        for i in range(2, n - 1):
            dp[i] = max(nums[i] + dp[i-2], dp[i-1])
        MAX = max(MAX, max(dp))
        
        # [0] is not robbed
        dp = [0 for _ in nums]
        dp[0] = 0  # [0] is not robbed
        dp[1] = nums[1]  # [1] may be robbed
        for i in range(2, n):
            dp[i] = max(nums[i] + dp[i-2], dp[i-1])
        MAX = max(MAX, max(dp))
        
        return MAX
```

击败82.16%