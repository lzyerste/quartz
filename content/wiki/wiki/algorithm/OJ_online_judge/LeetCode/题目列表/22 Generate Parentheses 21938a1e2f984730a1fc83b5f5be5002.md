---
title: 22_Generate_Parentheses_21938a1e2f984730a1fc83b5f5be5002
---

# 22. Generate Parentheses

Difficulty: Medium
ID: 22
Solved?: Yes
Tags: Backtracking, String
击败: 77.93
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/generate-parentheses/)

## 题意

给出 *n* 代表生成括号的对数，请你写出一个函数，使其能够生成`所有`可能的并且**`有效的`**括号组合。

例如，给出 *n* = **3，生成结果为：

```
[
  "((()))",
  "(()())",
  "(())()",
  "()(())",
  "()()()"
]
```

## 思路

- 注意，不是简单的递归，先定下一对括号，其余递归生成是不行的，会有重复。使用回溯生成，保证当前的字符串是合法的，也就是对每个右括号来说，都能在前面找到对应的左括号。也就是说，要保证每一步生成过程中，左括号数量要 ≥ 右括号数量；反过来，也就是剩余数量中，`#左括号 ≤ #右括号`，如此就能保证生成的字符串都是合法配对的。见题解1。

## 题解1：回溯

```python
class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        def bp(num1, num2, pre, result):
            # num1: left number of '('
            # num2: left number of ')'
            # num1 <= num2 is valid
            if num1 > num2: return  # invalid
            if num1 == 0:  # 左括号用完，后续只用填充右括号
                result.append(pre + ")" * num2)
                return
            bp(num1 - 1, num2, pre + "(", result)
            bp(num1, num2 - 1, pre + ")", result)
        
        result = []
        bp(n, n, "", result)
        return result
```