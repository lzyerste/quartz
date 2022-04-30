---
title: 169_Majority_Element_58f663935d3a43b9bac4b484c76e0b3e
---

# 169. Majority Element

Difficulty: Easy
ID: 169
Solved?: Yes
Tags: Array, Bit Manipulation, Divide and Conquer
击败: 96.52
推荐指数: ⭐⭐⭐⭐

[Majority Element - LeetCode](https://leetcode.com/problems/majority-element/)

## 题意

Given an array of size n, find the majority element. The majority element is the element that appears **more than** `⌊ n/2 ⌋` times.

You may assume that the array is non-empty and the majority element always exist in the array.

**Example 1:**

```
Input: [3,2,3]
Output: 3
```

**Example 2:**

```
Input: [2,2,1,1,1,2,2]
Output: 2

```

## 思路

1. 粗暴法：直接统计计数
2. 消除法：比如[2, 2, 2, 1, 3]，数字2已经在仓库里，而且有3个；接下来遇到1，不等于2，两两消除，还剩余2个2；接下来遇到3，不等于2，两两消除，还剩余1个2，就是最后的结果。实际上数组是乱序的，但不妨碍最后剩下的是最终结果。比如上面的1跟3两两消除，剩下3个2，仍是正确结果。
    
    该算法学名叫Boyer-Moore Voting Algorithm，选举投票，跟推选的一致就+1，不一致就-1。
    
3. 分治法：将数组分为左右部分，如果左右部分选出来的一样，那么它就是结果；如果不一样，那么需要整体扫描谁的投票多。复杂度为O(nlgn)。
4. 随机法：随机选中一个数，看它是否为大多数。因为每次的概率超过一半。

## 题解2：消除法

```python
class Solution:
    def majorityElement(self, nums: List[int]) -> int:
        count = 0
        n = None
        for v in nums:
            if count == 0:
                n = v
                count = 1
            elif v == n:
                count += 1
            elif v != n:
                count -= 1
        return n
```

击败96.52%