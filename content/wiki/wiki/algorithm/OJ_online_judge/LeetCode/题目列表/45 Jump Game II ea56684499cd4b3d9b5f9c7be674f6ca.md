---
title: 45_Jump_Game_II_ea56684499cd4b3d9b5f9c7be674f6ca
---

# 45. Jump Game II

Difficulty: Hard
ID: 45
Solved?: Yes
Tags: Array, BFS, Greedy
击败: 35.68
推荐指数: ⭐⭐⭐⭐⭐

[Jump Game II - LeetCode](https://leetcode.com/problems/jump-game-ii/)

## 题意

给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

你的目标是使用最少的跳跃次数到达数组的最后一个位置。

**示例:**

```
输入: [2,3,1,1,4]
输出: 2
解释: 跳到最后一个位置的最小跳跃数是 2。
     从下标为 0 跳到下标为 1 的位置，跳 1 步，然后跳 3 步到达数组的最后一个位置。
```

**说明:**

假设你总是可以到达数组的最后一个位置。

## 思路

- 贪心算法
- BFS

## 题解1：贪心

根据当前位置，它可以跳到多个位置。在这些候选位置中，选取覆盖范围最远的点（贪心）。注意候选范围的起点。

比如起始数组2，3，1。

当前值是2，可选范围有3和1，选3，因为它跳的最远，1能跳到的地方，3都能跳到。

接下来，考察3，并不是从它的右邻居1开始的，而是上一个元素的范围右边界开始。上一个元素已经覆盖了1，那么，显然3不用再去考虑1了，否则步数肯定是多于2了，所以3就从1的右边开始。

下面是递归写法。

```python
class Solution:
    def jump(self, nums: List[int]) -> int:
        def rec(nums, i, start):
            end = i + nums[i]
            if end >= len(nums) - 1: return 1  # 射程范围内
            maxDist = 0
            maxJ = 0
            # [start, end]为候选范围，选取能跳最远的位置
            for j in range(start, end + 1):
                dist = j + nums[j]
                if dist > maxDist:
                    maxDist = dist
                    maxJ = j
            return rec(nums, maxJ, end + 1) + 1
        
        if len(nums) <= 1: return 0
        return rec(nums, 0, 1)
```

击败25.34%

---

改成循环后，击败35.68%

```python
class Solution:
    def jump(self, nums: List[int]) -> int:
        if len(nums) <= 1: return 0
        
        cnt = 0
        i = 0
        start = 1
        while True:
            cnt += 1
            end = i + nums[i]
            if end >= len(nums) - 1:
                break
            maxDist = 0
            maxJ = 0
            for j in range(start, end + 1):
                dist = j + nums[j]
                if dist > maxDist:
                    maxDist = dist
                    maxJ = j
            i = maxJ
            start = end + 1
        return cnt
```