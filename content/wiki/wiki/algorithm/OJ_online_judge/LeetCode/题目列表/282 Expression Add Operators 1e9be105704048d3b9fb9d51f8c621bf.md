---
title: 282_Expression_Add_Operators_1e9be105704048d3b9fb9d51f8c621bf
---

# 282. Expression Add Operators

Difficulty: Hard
ID: 282
Solved?: Yes
Tags: Backtracking, Divide and Conquer
击败: 77.8
推荐指数: ⭐⭐⭐⭐

[Expression Add Operators - LeetCode](https://leetcode.com/problems/expression-add-operators/)

## 题意

Given a string that contains only digits `0-9` and a target value, return all possibilities to add **binary** operators (not unary) `+`, `-` or `*` between the digits so they evaluate to the target value.

**Example 1:**

```
Input: num = "123", target = 6
Output: ["1+2+3", "1*2*3"] 

```

**Example 2:**

```
Input: num = "232", target = 8
Output: ["2*3+2", "2+3*2"]
```

**Example 3:**

```
Input: num = "105", target = 5
Output: ["1*0+5","10-5"]
```

**Example 4:**

```
Input: num = "00", target = 0
Output: ["0+0", "0-0", "0*0"]

```

**Example 5:**

```
Input: num = "3456237490", target = 9191
Output: []

```

**Constraints:**

- `0 <= num.length <= 10`
- `num` only contain digits.

## 思路

1. backtracking: 注意乘法的处理，它的前一个乘数已经先一步处理了，现在要让它回吐出来，再做计算。
    
    [Java Standard Backtrace AC Solutoin, short and clear - LeetCode Discuss](https://leetcode.com/problems/expression-add-operators/discuss/71895/Java-Standard-Backtrace-AC-Solutoin-short-and-clear)
    

## 题解

```python
class Solution:
    def addOperators(self, num: str, target: int) -> List[str]:
        def bp(res, path, pos, eval, prev):
            if pos == len(num):
                if eval == target:
                    res.append(path)
                return
            for i in range(pos, len(num)):
                if i > pos and num[pos] == '0': break  # '05' is not allowed
                word = num[pos:i+1]
                cur = int(word)
                if pos == 0:
                    bp(res, path + word, i+1, cur, cur)
                else:
                    bp(res, path + "+" + word, i+1, eval + cur, cur)
                    bp(res, path + "-" + word, i+1, eval + (-cur), -cur)
                    bp(res, path + "*" + word, i+1, eval - prev + (prev * cur), prev * cur)
        
        if not num or len(num) == 0: return []
        res = []
        bp(res, "", 0, 0, 0)
        return res
```

击败77.80%