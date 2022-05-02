---
title: 392_Is_Subsequence_4bef6a8ea10a4bb5be26f6c7597a1665
---

# 392. Is Subsequence

Difficulty: Easy
ID: 392
Solved?: Yes
Tags: Binary Search, DP, Greedy
击败: 83.56
推荐指数: ⭐⭐⭐

[Is Subsequence - LeetCode](https://leetcode.com/problems/is-subsequence/)

## 题意

Given a string **s** and a string **t**, check if **s** is subsequence of **t**.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, `"ace"` is a subsequence of `"abcde"` while `"aec"` is not).

**Follow up:**If there are lots of incoming S, say S1, S2, ... , Sk where k >= 1B, and you want to check one by one to see if T has its subsequence. In this scenario, how would you change your code?

**Credits:**Special thanks to [@pbrother](https://leetcode.com/pbrother/) for adding this problem and creating all test cases.

**Example 1:**

```
Input: s = "abc", t = "ahbgdc"
Output: true

```

**Example 2:**

```
Input: s = "axc", t = "ahbgdc"
Output: false
```

**Constraints:**

- `0 <= s.length <= 100`
- `0 <= t.length <= 10^4`
- Both strings consists only of lowercase characters.

## 思路

考虑扩展情况：假设会有很多次s的查询。 

1. 二分法：针对t中的每个字符建立索引，记录同一字符在t中的所有位置，这样就可以二分查找下一个可行位置。

## 题解

下面的prev表示t已经匹配到的下标，所以二分时要寻找的是大于prev的下标。

```python
class Solution:
    def isSubsequence(self, s: str, t: str) -> bool:
        n = len(t)
        G = {}
        for i, c in enumerate(t):
            if c in G:
                G[c].append(i)
            else:
                G[c] = [i]
        for k in G:
            G[k].append(n)  # guard
        
        def binary_search(c, prev):
            A = G[c]
            L, R = 0, len(A) - 1
            while L <= R:
                M = (L + R) // 2
                if A[M] <= prev:
                    L = M + 1
                else:
                    R = M - 1
            return A[L]  # L always valid, as we have guards
        
        def judge(s):
            prev = -1
            for c in s:
                if c not in G:
                    return False
                prev = binary_search(c, prev)
                if prev == n:
                    return False
            return True
        
        return judge(s)
```

击败83.56%