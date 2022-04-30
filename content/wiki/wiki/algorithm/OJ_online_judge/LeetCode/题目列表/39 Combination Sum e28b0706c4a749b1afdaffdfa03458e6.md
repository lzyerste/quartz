---
title: 39_Combination_Sum_e28b0706c4a749b1afdaffdfa03458e6
---

# 39. Combination Sum

Difficulty: Medium
ID: 39
Solved?: Yes
Tags: Array, Backtracking, DP
击败: 67.85
推荐指数: ⭐⭐⭐⭐

[Combination Sum - LeetCode](https://leetcode.com/problems/combination-sum/)

## 题意

给定一个**无重复元素**的数组 `candidates` 和一个目标数 `target` ，找出 `candidates` 中所有可以使数字和为 `target` 的组合。

`candidates` 中的数字可以无限制重复被选取。

**说明：**

- 所有数字（包括 `target`）都是正整数。
- 解集不能包含重复的组合。

**示例 1:**

```
输入: candidates = [2,3,6,7], target = 7,
所求解集为:
[
  [7],
  [2,2,3]
]
```

**示例 2:**

```
输入: candidates = [2,3,5], target = 8,
所求解集为:
[
  [2,2,2,2],
  [2,3,3],
  [3,5]
]
```

## 思路

- DP。dp(i, t)，t为目标值，i为可选值右边界。那么针对元素A[i]，要么选择它，dp(i, t-A[i])；要么不选择，dp(i-1, t)。
- 回溯？

## 题解1：DP

```python
class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        def dp(G, nums, i, t):
            p = i, t
            if p in G: return G[p]
            if t == 0: return [[]]  # 合法终点，包含1个元素，空
            if i < 0 or t < 0: return []  # 非法终点
            part1 = dp(G, nums, i - 1, t)  # t中不包含nums[i]
            # 包含，仍为i，表示可重用
            part2 = [_ + [nums[i]] for _ in dp(G, nums, i, t - nums[i])]
            G[p] = part1 + part2
            return G[p]
            
        candidates.sort()
        return dp({}, candidates, len(candidates) - 1, target)
```

## 题解2：回溯

```python
def comb_sum(nums, target):
    nums.sort()
    res = []
    backtrack(res, [], nums, target, 0)
    return res

def backtrack(res, temp, nums, remain, start):
    if remain < 0:
        return
    elif remain == 0:
        res.append(temp[:])
    else:
        for i in range(start, len(nums)):
            temp.append(nums[i])  # 假设包含
            backtrack(res, temp, nums, remain - nums[i], i)  # i不变，可重用
            temp.pop()
            # 循环接下来是不包含

class Solution:
    def combinationSum(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        return comb_sum(candidates, target)
```

击败13.08%