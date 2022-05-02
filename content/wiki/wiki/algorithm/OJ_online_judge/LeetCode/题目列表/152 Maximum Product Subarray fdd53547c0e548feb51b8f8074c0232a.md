---
title: 152_Maximum_Product_Subarray_fdd53547c0e548feb51b8f8074c0232a
---

# 152. Maximum Product Subarray

Difficulty: Medium
ID: 152
Solved?: Yes
Tags: Array, DP
击败: 83.51
推荐指数: ⭐⭐⭐

[Maximum Product Subarray - LeetCode](https://leetcode.com/problems/maximum-product-subarray/)

## 题意

Given an integer array `nums`, find the contiguous subarray within an array (containing at least one number) which has the largest product.

**Example 1:**

```
Input: [2,3,-2,4]
Output: 6Explanation: [2,3] has the largest product 6.

```

**Example 2:**

```
Input: [-2,0,-1]
Output: 0
Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
```

## 思路

1. DP：dp(n)表示以下标n作为右边界（左边界在哪不管）的子数组的最小及最大乘积。它有两种选择，一种是另起炉灶，忽略前面的n-1；另一种是接上前面的n-1，也就是dp(n-1)，右边界刚好接上，连续。因为有正有负，所以要记录最大与最小值。

## 题解：DP

```python
class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        G = {0:(nums[0], nums[0])}  # (min, max)
        x = float("-inf")
        for i in range(len(nums)):
            x = max(x, self.dp(G, nums, i)[1])
        return x
    
    def dp(self, G, nums, k):
        if k in G: return G[k]
        x = [nums[k]]
        pmin, pmax = self.dp(G, nums, k - 1)
        x.extend([nums[k] * pmin, nums[k] * pmax])
        G[k] = (min(x), max(x))
        return G[k]
```

击败83.51%