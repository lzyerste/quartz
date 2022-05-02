---
title: 918_Maximum_Sum_Circular_Subarray_fe004014630642a38a64a510f3492995
---

# 918. Maximum Sum Circular Subarray

Difficulty: Medium
ID: 918
Solved?: No
Tags: Array, DP
击败: 80.82
推荐指数: ⭐⭐⭐⭐⭐

[Maximum Sum Circular Subarray - LeetCode](https://leetcode.com/problems/maximum-sum-circular-subarray/)

## 题意

## 题解1：DP

[53. Maximum Subarray](53 Maximum Subarray 896fb9b2c64141fca10942324b22c006.md) 的扩展。

假设最后的结果不是环，那么就是按照正常的最大子数组做就行。

如果是环，那么结果部分在左边，部分在右边，中间是空出来的。中间空出来的地带有什么特征呢？结果子数组要最大，那么剩余部分（中间连续部分）就是要最小，因为数组的总和是一定的。那么，用同样的方法，求出最小连续子数组和就行。

```python
class Solution:
    def maxSubarraySumCircular(self, A: List[int]) -> int:
        if max(A) <= 0: return max(A)
        dpMax = A[:]
        dpMin = A[:]
        for i in range(1, len(A)):
            dpMax[i] = max(dpMax[i], dpMax[i-1] + A[i])
            dpMin[i] = min(dpMin[i], dpMin[i-1] + A[i])
        max1 = max(dpMax)
        max2 = sum(A) - min(dpMin)
        return max(max1, max2)
```