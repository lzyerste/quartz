---
title: 300_Longest_Increasing_Subsequence_685e3fb6fa88497d8bf9260ba6a0f853
---

# 300. Longest Increasing Subsequence

Difficulty: Medium
ID: 300
Solved?: Yes
Tags: Binary Search, DP
击败: 76.16
推荐指数: ⭐⭐⭐⭐

[Longest Increasing Subsequence - LeetCode](https://leetcode.com/problems/longest-increasing-subsequence/)

## 题意

Given an unsorted array of integers, find the length of longest increasing subsequence.

**Example:**

```
Input: [10,9,2,5,3,7,101,18]
Output: 4 
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4. 
```

**Note:**

- There may be more than one LIS combination, it is only necessary for you to return the length.
- Your algorithm should run in O() complexity.
    
    n2
    

**Follow up:** Could you improve it to O(n log n) time complexity?

## 思路

1. 暴力DP：dp(i)表示以[i]结束的最长递增子序列，那么有递推式：
    
    $dp(i) = max(dp(j) + 1\ if\ A[i] > A[j]\ for\ 0 <= j < i)$
    
    复杂度为O(N*N)
    
2. 实时维护一个当前最长递增序列，如果新来一个元素，如何处理呢？比如：
    
    $[2, 3, 7, 101, 105, 18, 106, 19, 20, 21]$
    
    前面一直递增，维护到[2, 3, 7, 101, 105]，来了18，它可以放到2, 3, 7之后，不就是替换101么？替换有什么副作用么？对前面的105来说，没影响，对后面的来说，[2, 3, 7, 101]跟[2, 3, 7, 18]，它们的长度都是4，但18更容易接。后面来了一个106，接到105后面；19替换105，20替换105，变成了[2, 3, 7, 18, 19, 20]，来21的时候，可以直接接上。
    
    所以，维护的最长递增序列是指，在同样的长度下，尽量使序列末尾元素减小。
    

## 题解1：DP

```python
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        # dp(i): ends at [i]
        # dp(i) = max(dp(j) + 1 if [j] > [i] for 0 <= j < i)
        dp = [1 for _ in nums]
        for i in range(1, len(nums)):
            for j in range(i):
                if nums[i] > nums[j]:
                    dp[i] = max(dp[i], dp[j] + 1)
        return max(dp, default=0)
```

击败8.45%

## 题解2：二分

```python
class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        def insert_pos(seq, x):
            L, R = 0, len(seq) - 1
            while L <= R:
                M = (L + R) // 2
                if seq[M] < x:
                    L = M + 1
                else:
                    R = M - 1
            return L  # may == len(seq)
        
        seq = []
        for x in nums:
            p = insert_pos(seq, x)
            if p == len(seq):
                seq.append(x)
            else:
                seq[p] = x
        return len(seq)
```

击败76.16%

函数insert_pos就是说按照插入排序，x应该排在哪个位置。比如[1, 2, 2, 5, 5]，再插入5的时候，它选择排在最后的2之后，成为第一个5，所以插入位置是3（思考：如果选择成为最后一个5，该如何做？）。这个函数的while判断使用了小于等于，它的好处是不管seq是否为空，最终结果总是指向正确位置，比如插入7，返回的下标是5，超过了数组容量，表示要添加到屁股后面。

有了这个函数，nums的处理就很直接了，不需要考虑边界情况。