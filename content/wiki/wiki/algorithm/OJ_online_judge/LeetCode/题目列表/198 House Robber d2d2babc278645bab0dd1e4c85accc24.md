---
title: 198_House_Robber_d2d2babc278645bab0dd1e4c85accc24
---

# 198. House Robber

Difficulty: Easy
ID: 198
Solved?: Yes
Tags: DP
击败: 86.55
推荐指数: ⭐⭐⭐

[House Robber - LeetCode](https://leetcode.com/problems/house-robber/)

## 题意

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and **it will automatically contact the police if two adjacent houses were broken into on the same night**.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight **without alerting the police**.

**Example 1:**

```
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
             Total amount you can rob = 1 + 3 = 4.

```

**Example 2:**

```
Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
             Total amount you can rob = 2 + 9 + 1 = 12.

```

**Constraints:**

- `0 <= nums.length <= 100`
- `0 <= nums[i] <= 400`

## 思路

1. 简单DP：dp(n)表示考虑范围[0..n]内的最大收益，它分两种情况，一种是选中A[n]，那么，它前一个就不能选了，即跳过n-1，继续考虑[0..n-2]；另一种是不选中A[n]，那么可以继续往前考虑[0..n-1]；dp(n)取两者的最大值即可。
    
    内存可压缩为常量。
    

## 题解1：DP，自上而下

```python
class Solution:
    def rob(self, nums: List[int]) -> int:
        G = {}
        return self.dp(G, nums, len(nums) - 1)
    
    def dp(self, G, nums, n):
        if n in G: return G[n]
        if n < 0: return 0
        G[n] = max(self.dp(G, nums, n - 2) + nums[n], self.dp(G, nums, n - 1))
        return G[n]
```

击败67.62%

## 题解2：DP，自下而上

```python
class Solution:
    def rob(self, nums: List[int]) -> int:
        dp = [0 for i in range(len(nums) + 2)]
        for i, n in enumerate(nums):
            dp[i + 2] = max(dp[i + 1], n + dp[i])
        return dp[-1]
```

击败86.55%

压缩空间：

```python
class Solution:
    def rob(self, nums: List[int]) -> int:
        first = second = current = 0
        for n in nums:
            current = max(n + first, second)
            first, second = second, current
        return current
```