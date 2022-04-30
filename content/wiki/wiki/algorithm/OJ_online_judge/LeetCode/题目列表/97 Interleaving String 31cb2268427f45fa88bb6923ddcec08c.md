---
title: 97_Interleaving_String_31cb2268427f45fa88bb6923ddcec08c
---

# 97. Interleaving String

Difficulty: Hard
ID: 97
Solved?: Yes
Tags: DP, String
击败: 98.92
推荐指数: ⭐⭐⭐⭐

[](https://leetcode.com/problems/interleaving-string/)

## 题意

给定三个字符串 *s1*, *s2*, *s3*, 验证 *s3* 是否是由 *s1* 和 *s2* 交错组成的。

**示例 1:**

```
输入: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
输出: true
```

**示例 2:**

```
输入: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
输出: false
```

## 题解：DP

dp(i, j, k)，三个下标分别对应三个字符串，其实有关系i+j==k，实际是二维DP。

两维DP，变量k表示s3当前检查字符数量，i表示s1当前检查字符数量，那么s2中对应的字符数量是j=k-i。
显然，s3'（前k个字符）的最后一个字符肯定是s1'（前i个字符）或s2'（前j个字符）的最后一个字符。
所以dp(k, i)的表达式是：
如果s3[k-1] == s1[i-1]，采用dp(k - 1, i - 1)。
如果s3[k-1] == s2[j-1]，采用dp(k - 1, i)。
不匹配，那么肯定False。

如果第一步就True了，那么第二步其实可以pass。
注意，要检查i和j下标是否合法。

```python
class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        def dp(G, i, j, k):
            p = i, j, k
            if p in G: return G[p]
            if k < 0: return True
            res = False
            if i >= 0 and s1[i] == s3[k]:
                res |= dp(G, i-1, j, k-1)
            if not res and j >= 0 and s2[j] == s3[k]:
                res |= dp(G, i, j-1, k-1)
            G[p] = res
            return G[p]
            
        if s1 == "" or s2 == "":
            return s3 == (s1 or s2)
        
        len1 = len(s1)
        len2 = len(s2)
        len3 = len(s3)
        
        if len3 != len1 + len2:
            return False
        
        return dp({}, len1-1, len2-1, len3-1)
```