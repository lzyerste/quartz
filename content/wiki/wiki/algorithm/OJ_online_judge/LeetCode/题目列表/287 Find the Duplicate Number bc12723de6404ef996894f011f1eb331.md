---
title: 287_Find_the_Duplicate_Number_bc12723de6404ef996894f011f1eb331
---

# 287. Find the Duplicate Number

Difficulty: Medium
ID: 287
Solved?: Yes
Tags: Array, Binary Search, Two Pointers
击败: 71.21
推荐指数: ⭐⭐⭐⭐

[Find the Duplicate Number - LeetCode](https://leetcode.com/problems/find-the-duplicate-number/)

[142. Linked List Cycle II](142 Linked List Cycle II 783e2528b51f4ab282c57205eb6324b4.md) 

## 题意

Given an array of integers `nums` containing `n + 1` integers where each integer is in the range `[1, n]` inclusive.

There is only **one duplicate number** in `nums`, return *this duplicate number*.

**Follow-ups:**

1. How can we prove that at least one duplicate number must exist in `nums`?
2. Can you solve the problem **without** modifying the array `nums`?
3. Can you solve the problem using only constant, `O(1)` extra space?
4. Can you solve the problem with runtime complexity less than `O(n2)`?

**Example 1:**

```
Input: nums = [1,3,4,2,2]
Output: 2

```

**Example 2:**

```
Input: nums = [3,1,3,4,2]
Output: 3

```

**Example 3:**

```
Input: nums = [1,1]
Output: 1

```

**Example 4:**

```
Input: nums = [1,1,2]
Output: 1

```

**Constraints:**

- `2 <= n <= 3 * 104`
- `nums.length == n + 1`
- `1 <= nums[i] <= n`
- All the integers in `nums` appear only **once** except for **precisely one integer** which appears **two or more** times.

## 思路

1. 使用负数来标记出现过一次。
2. 快慢指针？环的检测？
3. 二分：猜测答案为M，分为区间[1..M), M, (M, N]，下一轮就缩半了。

## 题解

```python
class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        for x in nums:
            x = abs(x)
            if nums[x-1] < 0: return x
            nums[x-1] = -nums[x-1]
```

击败71.21%