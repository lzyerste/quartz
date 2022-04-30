---
title: 32_Longest_Valid_Parentheses_2cc92fad2b3e49688618f89fb7794416
---

# 32. Longest Valid Parentheses

Difficulty: Hard
ID: 32
Solved?: Yes
Tags: DP, Stack, String
击败: 72.19
推荐指数: ⭐⭐⭐⭐⭐

[](https://leetcode.com/problems/longest-valid-parentheses/)

## 题意

给定一个只包含 `'('` 和 `')'` 的字符串，找出最长的包含有效括号的子串的长度。

**示例 1:**

```
输入: "(()"
输出: 2
解释: 最长有效括号子串为 "()"
```

**示例 2:**

```
输入: ")()())"
输出: 4
解释: 最长有效括号子串为 "()()"
```

## 思路

- 暴力。检查区间[i, j]的子串是否合法，拆分方式有深度变大（A[i]与A[j]相互消耗），或者是平级，在中间找个k，使得[i, k]和[k+1, j]都是合法串，那么连接起来仍然是合法的。
- 堆栈+DP。右括号总是要匹配左括号，关键是匹配完之后要知道前面是否有平级的括号串可以连接起来，如()()。

## 题解1：堆栈+DP

遇到左括号，只管压栈（入栈的是它的index）。

遇到右括号，如果栈不为空，说明找到合法匹配，两者的下标分别表示了合法括号对的左右边界。

但是，我们要检查，紧挨着左边界的前面是否也有合法括号对，如果有的话，那就可以拼接成
一个更大的括号串。比如"()()"，遍历到第二个括号对时，应该知道它前面也有一对合法的括号对。

所以使用dp来记录以当前位置结束（显然对应的是右括号）的最长括号对。

```python
class Solution:
    def longestValidParentheses(self, s: str) -> int:
        from collections import defaultdict
        stack = []
        G = defaultdict(int)  # 以右括号为界，得到的最长合法串
        for i, c in enumerate(s):
            if c == '(':
                stack.append(i)  # 左括号的位置
            elif len(stack) > 0:
                top = stack.pop()
                G[i] = G[top-1] + (i - top + 1)
        return max(G.values(), default=0)
```