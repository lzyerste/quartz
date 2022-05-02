---
title: 238_Product_of_Array_Except_Self_dd366d3f5d4a4fd28a4cb4e30dc9a3ef
---

# 238. Product of Array Except Self

Difficulty: Medium
ID: 238
Solved?: Yes
Tags: Array
击败: 30.78
推荐指数: ⭐⭐⭐

[Product of Array Except Self - LeetCode](https://leetcode.com/problems/product-of-array-except-self/)

## 题意

Given an array `nums` of *n* integers where *n* > 1, return an array `output` such that `output[i]` is equal to the product of all the elements of `nums` except `nums[i]`.

**Example:**

```
Input:  [1,2,3,4]
Output: [24,12,8,6]
```

**Constraint:** It's guaranteed that the product of the elements of any prefix or suffix of the array (including the whole array) fits in a 32 bit integer.

**Note:** Please solve it **without division** and in O(*n*).

**Follow up:**Could you solve it with constant space complexity? (The output array **does not** count as extra space for the purpose of space complexity analysis.)

## 思路

1. 每个位置相当于把左边的累乘起来，再把右边的累乘起来。

## 题解

```python
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        res = [1 for i in range(len(nums))]
        for i in range(len(nums) - 2, -1, -1):
            res[i] = res[i + 1] * nums[i + 1]
        pre = 1
        for i, n in enumerate(nums):
            res[i] *= pre
            pre *= n
        return res
```

击败30.78%