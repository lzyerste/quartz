---
title: 228_Summary_Ranges_103691c6819147a0af3b5bf9637adcab
---

# 228. Summary Ranges

Difficulty: Easy
ID: 228
Solved?: Yes
Tags: Array
击败: 89.68
推荐指数: ⭐⭐⭐

[Summary Ranges - LeetCode](https://leetcode.com/problems/summary-ranges/)

## 题意

You are given a **sorted unique** integer array `nums`.

Return *the **smallest sorted** list of ranges that **cover all the numbers in the array exactly***. That is, each element of `nums` is covered by exactly one of the ranges, and there is no integer `x` such that `x` is in one of the ranges but not in `nums`.

Each range `[a,b]` in the list should be output as:

- `"a->b"` if `a != b`
- `"a"` if `a == b`

**Example 1:**

```
Input: nums = [0,1,2,4,5,7]
Output: ["0->2","4->5","7"]
Explanation: The ranges are:
[0,2] --> "0->2"
[4,5] --> "4->5"
[7,7] --> "7"

```

**Example 2:**

```
Input: nums = [0,2,3,4,6,8,9]
Output: ["0","2->4","6","8->9"]
Explanation: The ranges are:
[0,0] --> "0"
[2,4] --> "2->4"
[6,6] --> "6"
[8,9] --> "8->9"

```

**Example 3:**

```
Input: nums = []
Output: []

```

**Example 4:**

```
Input: nums = [-1]
Output: ["-1"]

```

**Example 5:**

```
Input: nums = [0]
Output: ["0"]

```

**Constraints:**

- `0 <= nums.length <= 20`
- `231 <= nums[i] <= 231 - 1`
- All the values of `nums` are **unique**.
- `nums` is sorted in ascending order.

## 思路

1. 题目说的很费解，最终意思就是连续的数字范围用range表示。
    
    用下标来跟踪range的左右范围即可。
    

## 题解

```python
class Solution:
    def summaryRanges(self, nums: List[int]) -> List[str]:
        if not nums: return []
        res = []
        
        def insert(i, j):
            if i == j:
                res.append(str(nums[i]))
            else:
                res.append("%d->%d" % (nums[i], nums[j]))

        i = j = 0
        while j < len(nums):
            if nums[j] - nums[i] != j - i:
                # non-continuous, restart
                insert(i, j-1)
                i = j
            j += 1
        insert(i, j-1)
        return res
```

击败89.68%