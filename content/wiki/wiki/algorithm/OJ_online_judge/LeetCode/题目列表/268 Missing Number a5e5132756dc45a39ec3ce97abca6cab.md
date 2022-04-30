---
title: 268_Missing_Number_a5e5132756dc45a39ec3ce97abca6cab
---

# 268. Missing Number

Difficulty: Easy
ID: 268
Solved?: Yes
Tags: Array, Bit Manipulation, Math
击败: 94.8
推荐指数: ⭐⭐⭐

[Missing Number - LeetCode](https://leetcode.com/problems/missing-number/)

## 题意

Given an array `nums` containing `n` distinct numbers in the range `[0, n]`, return *the only number in the range that is missing from the array.*

**Follow up:** Could you implement a solution using only `O(1)` extra space complexity and `O(n)` runtime complexity?

**Example 1:**

```
Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.

```

**Example 2:**

```
Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.

```

**Example 3:**

```
Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.

```

**Example 4:**

```
Input: nums = [0]
Output: 1
Explanation: n = 1 since there is 1 number, so all numbers are in the range [0,1]. 1 is the missing number in the range since it does not appear in nums.

```

**Constraints:**

- `n == nums.length`
- `1 <= n <= 104`
- `0 <= nums[i] <= n`
- All the numbers of `nums` are **unique**.

## 思路

1. 求和
2. 与连续自然数异或。

## 题解1

```python
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        return n * (n + 1) // 2 - sum(nums)
```

击败94.80%

## 题解2

```python
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        r = n
        for i, v in enumerate(nums):
            r ^= i
            r ^= v
        return r
```

击败63.89%