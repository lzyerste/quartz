---
title: 224_Basic_Calculator_9267aa60b3a84c78bd23fff69a31cf07
---

# 224. Basic Calculator

Difficulty: Hard
ID: 224
Solved?: Yes
Tags: Math, Stack
击败: 30.16
推荐指数: ⭐⭐⭐⭐

[Basic Calculator - LeetCode](https://leetcode.com/problems/basic-calculator/)

## 题意

Implement a basic calculator to evaluate a simple expression string.

The expression string may contain open `(` and closing parentheses `)`, the plus `+` or minus sign `-`, **non-negative** integers and empty spaces .

**Example 1:**

```
Input: "1 + 1"
Output: 2

```

**Example 2:**

```
Input: " 2-1 + 2 "
Output: 3
```

**Example 3:**

```
Input: "(1+(4+5+2)-3)+(6+8)"
Output: 23
```

**Note:**

- You may assume that the given expression is always valid.
- **Do not** use the `eval` built-in library function.

## 思路

1. 使用stack

## 题解

```python
class Solution:
    def calculate(self, s):
        """
        :type s: str
        :rtype: int
        """
        prec = {'(': 1, ')': 1, '+': 2, '-': 2, '*': 3, '/': 3}
        for op in prec:
            s = s.replace(op, " " + op + " ")
        tokens = s.split()
        opStack = []
        numStack = []
        
        def cal(a, b, op):
            if op == '+':
                return a + b
            elif op == '-':
                return a - b
            elif op == '*':
                return a * b
            elif op == '/':
                return a // b

        def do_op():
            op = opStack.pop()
            b = numStack.pop()
            a = numStack.pop()
            numStack.append(cal(a, b, op))
        
        for token in tokens:
            if token not in prec:
                numStack.append(int(token))
            elif token == '(':
                opStack.append(token)
            elif token == ')':
                while opStack[-1] != '(':
                    do_op()
                opStack.pop()
            else:
                while opStack and prec[opStack[-1]] >= prec[token]:
                    do_op()
                opStack.append(token)
        while opStack:
            do_op()
        return numStack.pop()
```

击败30.16%