---
title: 76_Minimum_Window_Substring_f0c99e7328dc427bb4a61cb6a6b2864a
---

# 76. Minimum Window Substring

Difficulty: Hard
ID: 76
Solved?: Yes
Tags: Hash Table, Sliding Window, String, Two Pointers
击败: 30.1
推荐指数: ⭐⭐⭐⭐

[](https://leetcode.com/problems/minimum-window-substring/)

## 题意

## 题解1：滑动窗口

使用了两个字典来统计字符数量，一个是目标字典，一个是滑动窗口的字典。实时记录是否有个字符刚好匹配了或者刚好不匹配了。

写的有点冗长，也可以只使用一个字典，初始为目标字典，然后一个个消除。

```python
class Solution:
    def minWindow(self, s: str, t: str) -> str:
        from collections import Counter
        G = Counter(t)
        H = Counter()
        N = len(G)  # 需要匹配的数量
        cnt = 0  # 匹配的数量
        L, R = 0, 0
        minLen = float("inf")
        minLeft = -1
        while R < len(s):
            c = s[R]
            R +=1
            if c not in G: continue
            H[c] += 1
            if H[c] == G[c]:  # 刚好达到
                cnt += 1
            if cnt < N: continue
            while cnt == N:
                if R - L < minLen:
                    minLen = R - L
                    minLeft = L
                # remove s[L]
                c = s[L]
                L += 1
                if c in G:
                    if H[c] == G[c]:  # 刚好不满足
                        cnt -= 1
                    H[c] -= 1
        return s[minLeft: minLeft + minLen] if minLeft >= 0 else ""
```