---
title: 150_Evaluate_Reverse_Polish_Notation_f26d9ca551004f15819262d540a0b0d1
---

# 150. Evaluate Reverse Polish Notation

Difficulty: Medium
ID: 150
Solved?: Yes
Tags: Stack
推荐指数: ⭐⭐

[Evaluate Reverse Polish Notation - LeetCode](https://leetcode.com/problems/evaluate-reverse-polish-notation/)

## 题意

Evaluate the value of an arithmetic expression in [Reverse Polish Notation](http://en.wikipedia.org/wiki/Reverse_Polish_notation).

Valid operators are `+`, ``, ``, `/`. Each operand may be an integer or another expression.

**Note:**

- Division between two integers should truncate toward zero.
- The given RPN expression is always valid. That means the expression would always evaluate to a result and there won't be any divide by zero operation.

**Example 1:**

```
Input: ["2", "1", "+", "3", "*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9

```

**Example 2:**

```
Input: ["4", "13", "5", "/", "+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6

```

**Example 3:**

```
Input: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]
Output: 22
Explanation: 
  ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
= ((10 * (6 / (12 * -11))) + 17) + 5
= ((10 * (6 / -132)) + 17) + 5
= ((10 * 0) + 17) + 5
= (0 + 17) + 5
= 17 + 5
= 22
```

## 题解

```python
class Solution:
    def evalRPN(self, tokens):
        """
        :type tokens: List[str]
        :rtype: int
        """
        stack = list()
        for t in tokens:
            if t == "+":
                b = stack.pop()
                a = stack.pop()
                stack.append(a + b)
            elif t == "-":
                b = stack.pop()
                a = stack.pop()
                stack.append(a - b)
            elif t == "*":
                b = stack.pop()
                a = stack.pop()
                stack.append(a * b)
            elif t == "/":
                b = stack.pop()
                a = stack.pop()
                flag = 1 if a * b >= 0 else -1
                stack.append(abs(a) // abs(b) * flag)
            else:
                stack.append(int(t))
        return stack.pop()
```