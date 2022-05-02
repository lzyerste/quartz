---
title: 241_Different_Ways_to_Add_Parentheses_c0b3fd40aaca4b04a9318cd8ef120482
---

# 241. Different Ways to Add Parentheses

Difficulty: Medium
ID: 241
Solved?: Yes
Tags: Divide and Conquer
击败: 99.79
推荐指数: ⭐⭐⭐⭐

[Different Ways to Add Parentheses - LeetCode](https://leetcode.com/problems/different-ways-to-add-parentheses/)

## 题意

Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are `+`, `` and ``.

**Example 1:**

```
Input: "2-1-1"Output: [0, 2]Explanation: 
((2-1)-1) = 0 
(2-(1-1)) = 2
```

**Example 2:**

```
Input: "2*3-4*5"Output: [-34, -14, -10, -10, 10]Explanation: 
(2*(3-(4*5))) = -34 
((2*3)-(4*5)) = -14 
((2*(3-4))*5) = -10 
(2*((3-4)*5)) = -10 
(((2*3)-4)*5) = 10
```

## 思路

1. 分治法：以运算符为核心，左边视为一个整体（加括号），右边视为一个整体（加括号），该运算符作为最后一步操作。
    
    会不会有重复子结构？会有的。
    
2. DP

## 题解：分治法

```python
class Solution:
    def diffWaysToCompute(self, input: str) -> List[int]:
        if not input: return []
        for c in "+-*":
            input = input.replace(c, " " + c + " ")
        return self.rec(input.split())
    
    def cal(self, a, op, b):
        a, b = int(a), int(b)
        if op == '+':
            return a + b
        elif op == '-':
            return a - b
        elif op == '*':
            return a * b

    def rec(self, ts):
        if len(ts) == 1: return [int(ts[0])]
        res = []
        for i, op in enumerate(ts):
            if op in "+-*":
                la = self.rec(ts[:i])
                lb = self.rec(ts[i + 1:])
                res += [self.cal(a, op, b) for a in la for b in lb]
        return res
```

击败55.24%

## 题解2：DP

```python
class Solution:
    def diffWaysToCompute(self, input: str) -> List[int]:
        if not input: return []
        G = {}
        return self.dfs(G, input)
    
    def cal(self, a, op, b):
        a, b = int(a), int(b)
        if op == '+':
            return a + b
        elif op == '-':
            return a - b
        elif op == '*':
            return a * b

    def dfs(self, G, s):
        if s in G: return G[s]
        res = []
        for i, c in enumerate(s):
            if c in "+-*":
                left = self.dfs(G, s[:i])
                right = self.dfs(G, s[i+1:])
                res += [self.cal(a, c, b) for a in left for b in right]
        if res == []:
            res = [int(s)]
        G[s] = res
        return G[s]
```

击败99.79%