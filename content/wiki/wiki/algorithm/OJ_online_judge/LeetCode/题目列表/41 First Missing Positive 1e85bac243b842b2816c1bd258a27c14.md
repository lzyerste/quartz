---
title: 41_First_Missing_Positive_1e85bac243b842b2816c1bd258a27c14
---

# 41. First Missing Positive

Difficulty: Hard
ID: 41
Solved?: Yes
Tags: Array
击败: 99.27
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/first-missing-positive/)

## 题意

给定一个未排序的整数数组，找出其中没有出现的最小的正整数。

**示例 1:**

```
输入: [1,2,0]
输出: 3
```

**示例 2:**

```
输入: [3,4,-1,1]
输出: 2
```

**示例 3:**

```
输入: [7,8,9,11,12]
输出: 1
```

**说明:**

你的算法的时间复杂度应为O(*n*)，并且只能使用常数级别的空间。

## 思路

- 原地标记
- 不断交换归位

## 题解1：原地标记

如果可以使用线性空间的话，那么，直接用bitmap标记即可。

现在只能使用常数空间，那么只好利用已有的数组来标记。

基本思路就是将值作为下标，将下标对应的元素取为负数。

预处理的时候，需要将非正数设置为n+1，这个值是超出要求的值，不能作为下标使用。因为即使全是正常的数，1，2，3...n铺满，n+1仍然不在里面。

```python
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        n = len(nums)
        for i, k in enumerate(nums):  # 处理非正数
            if k <= 0:
                nums[i] = n + 1
        for k in nums:  # 做标记，注意偏移量为1
            j = abs(k) - 1
            if j < n:
                nums[j] = -abs(nums[j])
        for i, k in enumerate(nums):
            if k > 0:  # 正数，未被标记过
                return i + 1
        return n + 1
```

## 题解2：swap，TODO