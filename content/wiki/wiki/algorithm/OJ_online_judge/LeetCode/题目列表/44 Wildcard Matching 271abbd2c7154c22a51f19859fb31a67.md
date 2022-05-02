---
title: 44_Wildcard_Matching_271abbd2c7154c22a51f19859fb31a67
---

# 44. Wildcard Matching

Difficulty: Hard
ID: 44
Solved?: Yes
Tags: Backtracking, DP, Greedy, String
击败: 59.48
推荐指数: ⭐⭐⭐⭐

[](https://leetcode.com/problems/wildcard-matching/)

## 题意

给定一个字符串 (`s`) 和一个字符模式 (`p`) ，实现一个支持 `'?'` 和 `'*'` 的通配符匹配。

```
'?' 可以匹配任何单个字符。
'*' 可以匹配任意字符串（包括空字符串）。
```

两个字符串**完全匹配**才算匹配成功。

**说明:**

- `s` 可能为空，且只包含从 `a-z` 的小写字母。
- `p` 可能为空，且只包含从 `a-z` 的小写字母，以及字符 `?` 和 `*`。

**示例 1:**

```
输入:
s = "aa"
p = "a"
输出: false
解释: "a" 无法匹配 "aa" 整个字符串。
```

**示例 2:**

```
输入:
s = "aa"
p = "*"
输出: true
解释: '*' 可以匹配任意字符串。
```

**示例 3:**

```
输入:
s = "cb"
p = "?a"
输出: false
解释: '?' 可以匹配 'c', 但第二个 'a' 无法匹配 'b'。
```

**示例 4:**

```
输入:
s = "adceb"
p = "*a*b"
输出: true
解释: 第一个 '*' 可以匹配空字符串, 第二个 '*' 可以匹配字符串 "dce".
```

**示例 5:**

```
输入:
s = "acdcb"
p = "a*c?b"
输入: false
```

## 思路

- 与 [10. Regular Expression Matching](10%20Regular%20Expression%20Matching%20d66accc7d2b84771b8dadad4ecd09a6d.md) 类似，且更简单

## 解法1：DP

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        def dp(G, s, p):
            z = s, p
            if z in G: return G[z]
            if p == "":
                return s == ""
            if s == "":
                G[z] = False
                if p[0] == "*":
                    G[z] = dp(G, s, p[1:])
                return G[z]
            # s和p都不为空
            if p[0] == "*":  # 可选择用或者不用
                G[z] = dp(G, s[1:], p) or dp(G, s, p[1:])
            elif s[0] == p[0] or p[0] == "?":
                G[z] = dp(G, s[1:], p[1:])
            else:
                G[z] = False
            return G[z]
        
        return dp({}, s, p)
```

击败12.07%

## 题解1优化1：使用下标，不截断

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        def dp(G, s, p, i, j):
            # i -> s, j -> p
            z = j, i  # 先行后列
            if z in G: return G[z]
            if p[j] == "*":
                G[z] = dp(G, s, p, i-1, j) or dp(G, s, p, i, j-1)
            elif s[i] == p[j] or p[j] == "?":
                G[z] = dp(G, s, p, i-1, j-1)
            else:
                G[z] = False
            return G[z]
        
        G = {(-1, -1): True}
        for c in range(len(s)):
            G[(-1, c)] = False
        for r in range(len(p)):
            G[(r, -1)] = G[(r-1, -1)] and p[r] == "*"
        
        return dp(G, s, p, len(s)-1, len(p)-1)
```

击败41.50

## 题解1优化2：iterative

```python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        G = [[False for c in range(len(s) + 1)] for r in range(len(p) + 1)]
        G[-1][-1] = True
        for r in range(len(p)):
            G[r][-1] = G[r-1][-1] and p[r] == "*"
        
        for r, a in enumerate(p):
            for c, b in enumerate(s):
                if a == "*":
                    G[r][c] = G[r-1][c] or G[r][c-1]
                elif a == b or a == "?":
                    G[r][c] = G[r-1][c-1]
        
        return G[len(p)-1][len(s)-1]
```

击败59.48

## 题解2：NFA

```python
class Solution:
    def isMatch(self, s, p):
        """
        :type s: str
        :type p: str
        :rtype: bool
        """
        p = p.replace("?", ".")
        p = p.replace("*", ".*")
        from collections import defaultdict
        n = len(p)
        G = defaultdict(set)
        # G = {i: set() for i in range(n + 1)}
        for i, c in enumerate(p):
            if c == '*':
                G[i].add(i - 1)
                G[i].add(i + 1)
                G[i - 1].add(i)
        # G[n - 1].add(n)
        # print(G)
        
        def dfs(G, s, vis):
            vis.add(s)
            for v in G[s]:
                if v not in vis:
                    dfs(G, v, vis)
        
        pc = set()
        dfs(G, 0, pc)
        # print(pc)
        
        for c in s:
            match = set()
            for v in pc:
                if v < n and (p[v] == c or p[v] == '.'):
                    match.add(v + 1)
            pc = set()
            for v in match:
                dfs(G, v, pc)
            # print("match", match)
            # print("pc", pc)
        return n in pc
```