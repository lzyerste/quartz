---
title: 132_Palindrome_Partitioning_II_61be1ec0a4b1411ea36cea231e71e923
---

# 132. Palindrome Partitioning II

Difficulty: Hard
ID: 132
Solved?: Yes
Tags: DP
击败: 84.82
推荐指数: ⭐⭐⭐⭐

[Palindrome Partitioning II - LeetCode](https://leetcode.com/problems/palindrome-partitioning-ii/)

## 题意

Given a string `s`, partition `s` such that every substring of the partition is a palindrome.

Return *the minimum cuts needed* for a palindrome partitioning of `s`.

**Example 1:**

```
Input: s = "aab"
Output: 1
Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.

```

**Example 2:**

```
Input: s = "a"
Output: 0

```

**Example 3:**

```
Input: s = "ab"
Output: 1

```

**Constraints:**

- `1 <= s.length <= 2000`
- `s` consists of lower-case English letters only.

## 思路

1. DP：注意dp递推式。如果[i, j]已经是回文，那么不用砍。要不然砍第一刀的时候要小心，只砍出回文段，dp(i, j) = min(1 + dp(k+1, j))，前提是s[i..k]是回文。如果k任意选择，那得既要处理区间[i..k]，又要处理区间[k+1..j]，实际上是有很多重复的。这样的话，dp的空间实际是一维的。
2. 优化只需要1刀的情况。

## 题解：DP

```python
class Solution:
    def minCut(self, s: str) -> int:
        G = {}  # 记录DP
        T = {}  # 记录回文
        return self.dp(G, T, s, 0, len(s) - 1)
    
    def isPalin(self, T, s, i, j):
        p = i, j
        if p in T: return T[p]
        if i > j: return True
        if s[i] != s[j]:
            T[p] = False
            return T[p]
        T[p] = self.isPalin(T, s, i + 1, j - 1)
        return T[p]
        
    def dp(self, G, T, s, i, j):
        p = i, j
        if p in G: return G[p]
        if self.isPalin(T, s, i, j):
            G[p] = 0
            return G[p]
        G[p] = j - i
        for k in range(i, j):
            if self.isPalin(T, s, i, k):
                G[p] = min(G[p], self.dp(G, T, s, k + 1, j) + 1)
        return G[p]
```

击败28.73%

## 题解：加速1

如果本身就是回文，那就是不用砍，0刀；

其他情况，如果出现只用砍一刀，那么肯定是最少，可以提前结束。

击败47.62%

```python
class Solution:
    def minCut(self, s: str) -> int:
        G = {}
        T = {}
        return self.dp(G, T, s, 0, len(s) - 1)

    def isPalin(self, T, s, i, j):
        p = i, j
        if p in T: return T[p]
        if i > j: return True
        if s[i] == s[j]:
            T[p] = self.isPalin(T, s, i+1, j-1)
        else:
            T[p] = False
        return T[p]

    def dp(self, G, T, s, i, j):
        p = i, j
        if p in G: return G[p]
        if self.isPalin(T, s, i, j):
            G[p] = 0
            return G[p]
        G[p] = j - i
        for k in range(i, j):
            if self.isPalin(T, s, i, k):
                G[p] = min(G[p], self.dp(G, T, s, k + 1, j) + 1)
                **if G[p] == 1: break**
        return G[p]
```

## 题解：加速2

在加速1的基础上，再加快砍1刀的进程。也就是这一刀砍的越大越远越好，这样右边的dp范围就是从小到大，而原来是从大到小。

击败84.82%

```python
class Solution:
    def minCut(self, s: str) -> int:
        G = {}
        T = {}
        return self.dp(G, T, s, 0, len(s) - 1)

    def isPalin(self, T, s, i, j):
        p = i, j
        if p in T: return T[p]
        if i > j: return True
        if s[i] == s[j]:
            T[p] = self.isPalin(T, s, i+1, j-1)
        else:
            T[p] = False
        return T[p]

    def dp(self, G, T, s, i, j):
        p = i, j
        if p in G: return G[p]
        if self.isPalin(T, s, i, j):
            G[p] = 0
            return G[p]
        G[p] = j - i
        **for k in reversed(range(i, j)):**
            if self.isPalin(T, s, i, k):
                G[p] = min(G[p], self.dp(G, T, s, k + 1, j) + 1)
                **if G[p] == 1: break**
        return G[p]
```

## ★题解：DP，由内而外

```python
class Solution:
    def minCut(self, s: str) -> int:
        if s == s[::-1]: return 0
        cut = [i for i in range(len(s))]
        
        for i in range(len(s)):
            self.expandFromMiddle(s, i, i, cut)
            self.expandFromMiddle(s, i, i+1, cut)
                
        return cut[-1]
    
    def expandFromMiddle(self, s, left, right, cut):
        while left >= 0 and right < len(s) and s[left] == s[right]:
            if left == 0: cut[right]=0
                
            cut[right] = min(cut[right], cut[left-1] + 1)
            left -= 1
            right += 1
```

击败85.59%