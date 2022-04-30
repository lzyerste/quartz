---
title: 214_Shortest_Palindrome_1dac439292da4644a38446e4c9f876be
---

# 214. Shortest Palindrome

Difficulty: Hard
ID: 214
Solved?: Yes
Tags: KMP, String
击败: 32.5
推荐指数: ⭐⭐⭐⭐⭐

[Shortest Palindrome - LeetCode](https://leetcode.com/problems/shortest-palindrome/)

## 题意

Given a string ***s***, you can convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.

**Example 1:**

```
Input: s = "aacecaaa"
Output: "aaacecaaa"

```

**Example 2:**

```
Input: s = "abcd"
Output: "dcbabcd"

```

**Constraints:**

- `0 <= s.length <= 5 * 104`
- `s` consists of lowercase English letters only.

## 思路

1. 暴力解法：s的前部分存在的最长回文，剩余的补上就行。
2. KMP：将s视为pattern，将s的反视为text，看KMP搜索走到最好的时候，匹配多少。也就是s的前缀与s的反的后缀，匹配了说明就是回文串。

## 题解1：暴力

```python
class Solution:
    def shortestPalindrome(self, s: str) -> str:
        M = len(s)
        for R in range(M, 0, -1):
            subs = s[:R]
            if subs == subs[::-1]:
                return s[R:M][::-1] + s
        return ""
```

击败23.59%

## 题解2：KMP

```python
class KMP:
    def __init__(self, pat):
        self.pat = pat
        self.next = {(0, pat[0]): 1}
        
        X = 0
        cset = set(pat)
        for i in range(1, len(pat)):
            for c in cset:
                if c == pat[i]:
                    self.next[(i, c)] = i + 1
                else:
                    self.next[(i, c)] = self.next.get((X, c), 0)
            X = self.next.get((X, pat[i]), 0)
            
    def max_suffix(self, txt):
        N = len(txt)
        M = len(self.pat)
        
        i = j = 0
        while i < N:
            j = self.next.get((j, txt[i]), 0)
            if j == M and i != N - 1:
                j = 0
            i += 1
        return j

class Solution:
    def shortestPalindrome(self, s: str) -> str:
        if not s: return s
        kmp = KMP(s)
        txt = s[::-1]
        MAX = kmp.max_suffix(txt)  # 前MAX个字符形成最大回文子串
        return s[MAX:][::-1] + s
```

击败32.50%