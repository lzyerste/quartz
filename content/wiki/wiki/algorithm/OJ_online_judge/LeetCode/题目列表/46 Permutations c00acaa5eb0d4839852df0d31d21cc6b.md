---
title: 46_Permutations_c00acaa5eb0d4839852df0d31d21cc6b
---

# 46. Permutations

Difficulty: Medium
ID: 46
Solved?: Yes
Tags: Backtracking, Recursive
击败: 64.36
推荐指数: ⭐⭐⭐⭐

[Permutations - LeetCode](https://leetcode.com/problems/permutations/)

## 题意

给定一个**`没有重复`**数字的序列，返回其所有可能的`全排列`。

**示例:**

```
输入: [1,2,3]
输出:
[
  [1,2,3],
  [1,3,2],
  [2,1,3],
  [2,3,1],
  [3,1,2],
  [3,2,1]
]
```

## 思路

- 按照全排列定义，先定下一个数（N种可能），其余数再全排列。递归做法。
- 回溯。

## 题解1：递归

全排列，每个位置需要放置一个元素，只要一个个放置就行。

在当前数组中任意挑选一个元素，将剩余元素组成一个新的数组，递归去求它的全排列。

将子排列的结果加上当前元素进行汇总。

这写法比回溯好理解、好写。

```python
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        def rec(nums):
            if len(nums) == 0:
                return [[]]
            res = []
            for i, v in enumerate(nums):
                tmp = rec(nums[:i] + nums[i+1:])
                res.extend([[v] + _ for _ in tmp])
            return res
        
        return rec(nums)
```

击败35.35%

## 题解2：回溯

N个元素的数组（无重复），全排列形成的仍然是一个N元数组，只是元素顺序重新排了一下而已。

那么，按照以下思路，先从数组中挑选第一个元素（有N个元素可选），作为新排列的第一个元素；
接着从剩余数组中挑选下一个元素（有N-1个元素可选），作为新排列的第二个元素；
以此类推，挑选完所有元素之后，所形成的新排列就是其中的一个可行解。

全排列的数量显然是`N!`。

```python
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        def bp(res, temp, nums, vis, cnt):
            if cnt == len(nums):
                res.append(temp[:])
                return
            # pick the next element
            for i, v in enumerate(vis):
                if v: continue  # visited
                vis[i] = True
                temp.append(nums[i])
                bp(res, temp, nums, vis, cnt + 1)
                temp.pop()
                vis[i] = False
        
        nums.sort()
        res = []
        vis = [False] * len(nums)  # 标记元素是否已被挑选
        bp(res, [], nums, vis, 0)
        return res
```

击败35.29%

优化：原地swap，将挑选好的元素放到前面

```python
class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        def bp(res, nums, idx):
            if idx == len(nums):
                res.append(nums[:])
                return
            # pick the next element
            for i in range(idx, len(nums)):
                nums[idx], nums[i] = nums[i], nums[idx]
                bp(res, nums, idx + 1)
                nums[idx], nums[i] = nums[i], nums[idx]  # 恢复
        
        res = []
        bp(res, nums, 0)
        return res
```

击败64.36%