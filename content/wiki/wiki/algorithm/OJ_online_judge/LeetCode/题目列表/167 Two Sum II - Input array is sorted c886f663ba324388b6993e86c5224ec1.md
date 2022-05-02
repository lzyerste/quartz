---
title: 167_Two_Sum_II_-_Input_array_is_sorted_c886f663ba324388b6993e86c5224ec1
---

# 167. Two Sum II - Input array is sorted

Difficulty: Easy
ID: 167
Solved?: Yes
Tags: Array, Binary Search, Two Pointers
击败: 99.98
推荐指数: ⭐⭐

[Two Sum II - Input array is sorted - LeetCode](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/)

## 题意

Given an array of integers that is already ***sorted in ascending order***, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2.

**Note:**

- Your returned answers (both index1 and index2) are not zero-based.
- You may assume that each input would have *exactly* one solution and you may not use the *same* element twice.

**Example 1:**

```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.

```

**Example 2:**

```
Input: numbers = [2,3,4], target = 6
Output: [1,3]

```

**Example 3:**

```
Input: numbers = [-1,0], target = -1
Output: [1,2]

```

**Constraints:**

- `2 <= nums.length <= 3 * 104`
- `1000 <= nums[i] <= 1000`
- `nums` is sorted in **increasing order**.
- `1000 <= target <= 1000`

## 思路

- 有序数组，双指针从两侧往中间移动即可。见题解1。
- a+b=target，假设确定了a之后，就需要在剩余数组寻找target-a，有序数组可以二分查找

## 题解1：双指针

```python
class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        i, j = 0, len(numbers) - 1
        while i < j:
            a, b = numbers[i], numbers[j]
            sum = a + b
            if sum < target:
                i += 1
            elif sum > target:
                j -= 1
            else:
                return [i+1, j+1]
```

击败99.98%