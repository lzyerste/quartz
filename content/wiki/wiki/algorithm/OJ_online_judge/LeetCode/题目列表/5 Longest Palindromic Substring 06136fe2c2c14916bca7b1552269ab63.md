---
title: 5_Longest_Palindromic_Substring_06136fe2c2c14916bca7b1552269ab63
---

# 5. Longest Palindromic Substring

Difficulty: Medium
ID: 5
Solved?: Yes
Tags: DP, String
击败: 71.57
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/longest-palindromic-substring/)

## 题意

给定一个字符串 `s`，找到 `s` 中最长的回文子串。你可以假设 `s` 的最大长度为 1000。

**示例 1：**

```
输入: "babad"
输出: "bab"
注意: "aba" 也是一个有效答案。
```

**示例 2：**

```
输入: "cbbd"
输出: "bb"
```

## 思路

- 由内而外判断回文（贪心？）
- 由外向内判断回文（DP）

## 题解1：由内而外

选定子串的中心点，由内而外扩散，找到尽可能大的回文串。

```python
class Solution:
    def longestPalindrome(self, s: str) -> str:
        def extend_palin(s, left, right):
            while left >= 0 and right < len(s) and s[left] == s[right]:
                left -= 1
                right += 1
            return right - left - 1, left + 1, right - 1
        
        R = (0, 0, 0)  # length, [begin, end]
        for i in range(len(s)):
            R = max(R, extend_palin(s, i, i))
            R = max(R, extend_palin(s, i, i + 1))
        return s[R[1]: R[2] + 1]
```

extend_palin函数表示从中心点left与right往外扩散能得到的最大回文串，返回值是一个三元组，回文串长度、起始点下标、终点下标。

extend_palin从left开始往左扩散，right开始同步往右扩散，直到破坏回文规则（left与right对应的字符不等或越界）。while停止的时候，left与right对应的下标是回文串的边界，但不包含left与right，所以返回的时候，回文串的首字符位置为left+1，末字符位置是right-1。

如果是奇数长的回文串，一开始中心点的left与right是一样的。

如果是偶数长的回文串，right是left的右邻。

## 题解2：动态规划

动态规划重要的是定义好递推式。

dp(i, j)表示从i到j这段区间内能得到的最大回文串（同样返回三元组：长度、起始位置、结束位置）。题目就转换为求解dp(0, n-1)，n为输入字符串s的长度。

dp(i, j)可拆解为3个子问题：

1. dp(i, j-1)，去掉末尾的j
2. dp(i+1, j)，去掉开始的i
3. 如果s[i]与s[j]相等的情况下，要求解dp(i+1, j-1)，去掉收尾的i和j。如果[i+1, j-1]子串为回文的话（思考下如何判断？），那么[i, j]也是回文串。注意，上面两种情况都是去掉1个元素，这里去掉了2个元素，所以上面的两种情况实际上是包含dp(i+1, j-1)的。

```python
class Solution:
    def longestPalindrome(self, s: str) -> str:
        def dp(G, s, i, j):
            length = j - i + 1
            p = i, j
            if p in G:
                return G[p]
            if j <= i:
                return length, i, j
            r0 = dp(G, s, i + 1, j - 1)
            if s[i] == s[j] and r0[0] + 2 == length:
                G[p] = length, i, j
            else:
                r1 = dp(G, s, i, j - 1)
                r2 = dp(G, s, i + 1, j)
                G[p] = max(r1, r2)
            return G[p]
        
        res = dp({}, s, 0, len(s) - 1)
        return s[res[1]: res[2] + 1]
```

可惜，超时了，102/103个case。

但这个思路可以用来解题目的变种：不是回文子串，而是回文子序列（也就是字符间不一定是连续的）。

比如输入字符串为abcdefdcba，最大回文子序列长度为9，外围的abcd与dcba，中间ef选一个。

[Ideone.com](https://ideone.com/JqXDEo)

## 题解3：动态规划

修改递推式的定义，dp(i, j)返回的是子串[i, j]是否为回文串。题目求解就转化为遍历所有(i, j)组合，检查是否为回文串并记录最大值。

dp(i, j)是否为回文串只需要先判断首尾两个字符是否相等。若不相等，那肯定就不是回文串了；若相等，则继续判断dp(i+1, j-1)即可。

```python
class Solution:
    def longestPalindrome(self, s: str) -> str:
        def dp(G, s, i, j):
            p = i, j
            if p in G:
                return G[p]
            if j <= i:
                return True
            if s[i] != s[j]:
                return False
            G[p] = dp(G, s, i + 1, j - 1)
            return G[p]
        
        G = {}
        n = len(s)
        longest = 0
        idx = 0
        for i in range(n):
            for j in range(i, n):
                if dp(G, s, i, j) and longest < j - i + 1:
                    longest = j - i + 1
                    idx = i
        return s[idx: idx + longest]
```

勉强通过。

---

可将递归方式改为循环式。

```python
class Solution:
    def longestPalindrome(self, s: str) -> str:
        n = len(s)
        G = {}
        for i in range(n):
            G[(i, i)] = True
            G[(i, i - 1)] = True
        longest = 1
        idx = 0
        for d in range(2, n + 1):
            for i in range(n):
                j = i + d - 1
                if j >= n: break
                G[(i, j)] = s[i] == s[j] and G[(i + 1, j - 1)]
                if G[(i, j)] and longest < d:
                    longest = d
                    idx = i
        return s[idx : idx + longest]
```

d表示子串的长度，从2到n，inclusive。