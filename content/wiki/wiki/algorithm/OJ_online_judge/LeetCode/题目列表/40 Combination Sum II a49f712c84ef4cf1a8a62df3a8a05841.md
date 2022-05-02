---
title: 40_Combination_Sum_II_a49f712c84ef4cf1a8a62df3a8a05841
---

# 40. Combination Sum II

Difficulty: Medium
ID: 40
Solved?: Yes
Tags: Array, Backtracking, DP
击败: 77.75
推荐指数: ⭐⭐⭐⭐

[Combination Sum II - LeetCode](https://leetcode.com/problems/combination-sum-ii/)

## 题意

给定一个数组 `candidates` 和一个目标数 `target` ，找出 `candidates` 中所有可以使数字和为 `target` 的组合。

`candidates` 中的每个数字在每个组合中`只能使用一次`。

**说明：**

- 所有数字（包括目标数）都是正整数。
- 解集不能包含重复的组合。

**示例 1:**

```
输入: candidates = [10,1,2,7,6,1,5], target = 8,
所求解集为:
[
  [1, 7],
  [1, 2, 5],
  [2, 6],
  [1, 1, 6]
]
```

**示例 2:**

```
输入: candidates = [2,5,2,1,2], target = 5,
所求解集为:
[
  [1,2,2],
  [5]
]
```

## 思路

- 0/1背包，仍然可使用DP，注意去重的处理。
- 使用回溯

## 题解1：DP

现在，如果不要某个下标，其实是不要某个下标对应的值（之后未遍历的范围）。

比如6, 6, 6, 6, 6，要取3个6，从左往右遍历的话，会取最左边的3个6，而不用先舍弃最左的2个6，再取最右的3个6。

也就是说，如果存在只取右边的，左边的不要，我们总是可以将右边的交换到左边，使得只取左边的，保证不会有遗漏。

也就是说，先取了的覆盖范围是更大的。比如上面先去最左的6，剩余的先不管，那么就是：

`6, X, X, X, X`。X代表可取可不取。

如果最左的6不要，那么，可能范围就是`_, X, X, X, X`。这种方式包含6的组合不会超过上种方式的，不过它多了一种方式，那就是全都不选。所以，它的作用就是提供全都不选，直接跳过数值6，到下一个不同的数值。

上面讨论的从左往右与从右往左都是类似的。题解2的回溯就是从左往右，这里的DP是从右往左。

```sql
class Solution:
    def combinationSum2(self, candidates: List[int], target: int) -> List[List[int]]:
        def dp(G, nums, i, t):
            p = i, t
            if p in G: return G[p]
            if t == 0: return [40 Combination Sum II a49f712c84ef4cf1a8a62df3a8a05841](.md)
            if i < 0 or t < 0: return []
            
            j = i
            while j >= 0 and nums[j] == nums[i]:
                j -= 1
            part1 = dp(G, nums, j, t)  # 不使用该值
            
            part2 = [_ + [nums[i]] for _ in dp(G, nums, i - 1, t - nums[i])]  # 使用
            G[p] = part1 + part2
            return G[p]
            
        candidates.sort()
        return dp({}, candidates, len(candidates) - 1, target)
```

## 题解2：回溯，未整理

```sql
def comb_sum2(nums, target):
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
            if i > start and nums[i] == nums[i - 1]: continue
            temp.append(nums[i])
            backtrack(res, temp, nums, remain - nums[i], i + 1)
            temp.pop()

class Solution:
    def combinationSum2(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        return comb_sum2(candidates, target)
```