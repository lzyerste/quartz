---
title: 260_Single_Number_III_ec387876e53f47e4b087649cee2c25aa
---

# 260. Single Number III

Difficulty: Medium
ID: 260
Solved?: Yes
Tags: Bit Manipulation
击败: 98.81
推荐指数: ⭐⭐⭐⭐

[Single Number III - LeetCode](https://leetcode.com/problems/single-number-iii/)

## 题意

Given an integer array `nums`, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in **any order**.

**Follow up:** Your algorithm should run in linear runtime complexity. Could you implement it using only constant space complexity?

**Example 1:**

```
Input: nums = [1,2,1,3,2,5]
Output: [3,5]
Explanation:  [5, 3] is also a valid answer.

```

**Example 2:**

```
Input: nums = [-1,0]
Output: [-1,0]

```

**Example 3:**

```
Input: nums = [0,1]
Output: [1,0]

```

**Constraints:**

- `1 <= nums.length <= 30000`
- Each integer in `nums` will appear twice, only two integers will appear once.

## 思路

1. A, B, CC, DD, EE。全部异或，因为A≠B，所以结果肯定不为0。
    
    求结果的最低位的1的位置，r &= -r，比如10100 → 00100
    
    所有数根据该位是否为1，分为2组。
    
    每一组各自异或，得到各自的只出现一次的数。
    

## 题解

```python
class Solution:
    def singleNumber(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        r = 0
        for n in nums:
            r ^= n
        # r is not 0
        r &= -r  # lowest 1
        
        a, b = 0, 0
        for n in nums:
            if n & r:
                b ^= n
            else:
                a ^= n
        return [a, b]
```

击败98.81%