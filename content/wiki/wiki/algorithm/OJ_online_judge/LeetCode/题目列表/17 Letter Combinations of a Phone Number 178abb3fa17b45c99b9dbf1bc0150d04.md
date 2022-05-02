---
title: 17_Letter_Combinations_of_a_Phone_Number_178abb3fa17b45c99b9dbf1bc0150d04
---

# 17. Letter Combinations of a Phone Number

Difficulty: Medium
ID: 17
Solved?: Yes
Tags: Backtracking, String
击败: 71.59
推荐指数: ⭐⭐⭐⭐

[Letter Combinations of a Phone Number - LeetCode](https://leetcode.com/problems/letter-combinations-of-a-phone-number/)

## 题意

给定一个仅包含数字 `2-9` 的字符串，返回所有它能表示的字母组合。

给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。

![http://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Telephone-keypad2.svg/200px-Telephone-keypad2.svg.png](http://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Telephone-keypad2.svg/200px-Telephone-keypad2.svg.png)

**示例:**

```
输入："23"
输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
```

**说明:**尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。

## 思路

- `递归`。先保持第一个数字不动，求解剩余数字的所有组合，然后再与第一个数字的组合拼接（相乘）。
- `回溯`。与递归方向相反，递归是将右边的子问题求解了传上来，回溯是将前面的临时结果求解了传下去，传到最终后，判断是否属于合法结果，符合则加入最终结果。

## 题解1：递归

注意，dfs递归时的base case，digits为空串的时候，返回的不是空集合（[]），而是一个集合包含空串（[""]）。如果返回空集合的话，for遍历不到，最终结果都是空了。

当然，也可以在digits长度为1的时候作为base case。

```python
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        G = {
            "2": "abc",
            "3": "def",
            "4": "ghi",
            "5": "jkl",
            "6": "mno",
            "7": "pqrs",
            "8": "tuv",
            "9": "wxyz"
        }
        
        def dfs(digits, G):
            if len(digits) == 0: return [""]  # 注意不是[]
            res = []
            tmp = dfs(digits[1:], G)  # 子问题求解
            for c in G[digits[0]]:  # 两两组合
                for r in tmp:
                    res.append(c + r)
            return res
        
        if digits == "": return []  # 注意与dfs里的区别
        return dfs(digits, G)
```

## 题解2：回溯

注意bp的参数。digits一直保持不变，index表示当前bp将要求解时已经走到了哪一步，path表示走到当前bp时之前的临时结果，res用于保存最终结果。

函数内部的递归bp直接构造了新的path = path + c，也可以类似用stack结构，在bp调用之前入栈，bp返回之后出栈，保持在本层bp中path看起来是一样的。

```python
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        G = {
            "2": "abc",
            "3": "def",
            "4": "ghi",
            "5": "jkl",
            "6": "mno",
            "7": "pqrs",
            "8": "tuv",
            "9": "wxyz"
        }
        
        def bp(G, digits, index, path, res):
            if index == len(digits):
                res.append(path)
                return
            for c in G[digits[index]]:
                bp(G, digits, index + 1, path + c, res)
        
        if digits == "": return []
        res = []
        bp(G, digits, 0, "", res)
        return res
```