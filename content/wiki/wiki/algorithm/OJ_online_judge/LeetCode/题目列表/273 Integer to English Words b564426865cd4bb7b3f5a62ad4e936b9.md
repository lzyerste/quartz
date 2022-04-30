---
title: 273_Integer_to_English_Words_b564426865cd4bb7b3f5a62ad4e936b9
---

# 273. Integer to English Words

Difficulty: Hard
ID: 273
Solved?: Yes
Tags: Math, String
击败: 66.95
推荐指数: ⭐⭐⭐⭐

[Integer to English Words - LeetCode](https://leetcode.com/problems/integer-to-english-words/)

## 题意

Convert a non-negative integer `num` to its English words representation.

**Example 1:**

```
Input: num = 123
Output: "One Hundred Twenty Three"

```

**Example 2:**

```
Input: num = 12345
Output: "Twelve Thousand Three Hundred Forty Five"

```

**Example 3:**

```
Input: num = 1234567
Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"

```

**Example 4:**

```
Input: num = 1234567891
Output: "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety One"

```

**Constraints:**

- `0 <= num <= 231 - 1`

## 思路

1. 递归：从低位到高位，3个一组，处理方式一样，只是单位不同。
    
    注意0的处理，注意返回前字符串要做stripe。
    
    3个一组中，先处理百位，然后分20及以上、20以下。
    

## 题解

```python
to19 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
       "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
to99 = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
units = ["", "Thousand", "Million", "Billion"]

class Solution:
    def numberToWords(self, num: int) -> str:
        if num == 0: return "Zero"
        return self._convert(str(num), 0).strip()
    
    def _convert(self, s, unit):
        if len(s) > 3:
            return " ".join([self._convert(s[:-3], unit+1), self._convert(s[-3:], unit)]).strip()
        res = []
        d = int(s)
        if d == 0: return ""
        if d >= 100:
            q, d = divmod(d, 100)
            res.append("%s Hundred" % to19[q])
        if d >= 20:
            q, d = divmod(d, 10)
            res.append(to99[q])
        res.append(to19[d])
        return (" ".join(res).strip() + " " + units[unit]).strip()
```

击败66.95%