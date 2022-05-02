---
title: 38_Count_and_Say_6892bd1af9374b0bb006a7c8f4ebce95
---

# 38. Count and Say

Difficulty: Easy
ID: 38
Solved?: Yes
Tags: Math, String, 模拟
击败: 77.11
推荐指数: ⭐⭐

[Count and Say - LeetCode](https://leetcode.com/problems/count-and-say/)

## 题意

报数序列是一个整数序列，按照其中的整数的顺序进行报数，得到下一个数。其前五项如下：

```
1.     1
2.     11
3.     21
4.     1211
5.     111221
```

`1` 被读作 `"one 1"` (`"一个一"`) , 即 `11`。
`11` 被读作 `"two 1s"` (`"两个一"`）, 即 `21`。
`21` 被读作 `"one 2"`, "`one 1"` （`"一个二"` , `"一个一"`) , 即 `1211`。

给定一个正整数 *n*（1 ≤ *n* ≤ 30），输出报数序列的第 *n*项。

注意：整数顺序将表示为一个字符串。

**示例 1:**

```
输入: 1
输出: "1"
```

**示例 2:**

```
输入: 4
输出: "1211"
```

## 思路

- 找连续串，进行翻译。

## 题解：模拟

```python
class Solution:
    def countAndSay(self, n: int) -> str:
        def next(s):
            lst = []
            pre = None
            count = 0
            for c in s:
                if c == pre:
                    count += 1
                    continue
                # 转折点
                if count > 0:
                    lst.append("%d%s" % (count, pre))
                count = 1
                pre = c
            if count > 0:
                lst.append("%d%s" % (count, pre))
            return ''.join(lst)
        
        s = "1"
        for i in range(n - 1):
            s = next(s)
        return s
```

换种写法，从连续的第一个字符开始，找到最后一个字符。

```python
class Solution:
    def countAndSay(self, n: int) -> str:
        def next(s):
            lst = []
            i = 0
            while i < len(s):
                j = i  # 连续串的起始位置
                while i + 1 < len(s) and s[i+1] == s[i]:
                    i += 1
                # 刚退出循环时i指向连续串的最后一个位置
                i += 1  # 下个不同的字符
                lst.append("%d%s" % (i - j, s[j]))
            return ''.join(lst)
        
        s = "1"
        for i in range(n - 1):
            s = next(s)
        return s
```