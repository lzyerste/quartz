---
title: 20_Valid_Parentheses_5bb07a3b0ef6459086f7d9a92a7a2ef7
---

# 20. Valid Parentheses

Difficulty: Easy
ID: 20
Solved?: Yes
Tags: Stack, String
击败: 83.12
推荐指数: ⭐⭐

[Loading...](https://leetcode.com/problems/valid-parentheses/)

## 题意

给定一个只包括 `'('`，`')'`，`'{'`，`'}'`，`'['`，`']'` 的字符串，判断字符串是否有效。

有效字符串需满足：

1. 左括号必须用相同类型的右括号闭合。
2. 左括号必须以正确的顺序闭合。

注意空字符串可被认为是有效字符串。

**示例 1:**

```
输入: "()"
输出: true
```

**示例 2:**

```
输入: "()[]{}"
输出: true
```

**示例 3:**

```
输入: "(]"
输出: false
```

**示例 4:**

```
输入: "([)]"
输出: false
```

**示例 5:**

```
输入: "{[]}"
输出: true
```

## 思路

- 常规stack操作

## 题解1：stack

```python
class Solution:
    def isValid(self, s: str) -> bool:
        # 常规stack操作，左括号入栈，右括号匹配出栈
        G = {
            "(": ")",
            "[": "]",
            "{": "}"
        }
        stack = []
        for c in s:
            if c in G:
                stack.append(c)  # push
            else:
                if len(stack) == 0: return False
                top = stack.pop()
                if G[top] != c: return False
        return len(stack) == 0
```

击败5.36，有点尴尬。

同样的代码，再次提交，击败83.12，不细究了。