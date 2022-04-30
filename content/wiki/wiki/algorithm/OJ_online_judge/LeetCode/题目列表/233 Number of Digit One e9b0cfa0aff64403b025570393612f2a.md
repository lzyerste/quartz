---
title: 233_Number_of_Digit_One_e9b0cfa0aff64403b025570393612f2a
---

# 233. Number of Digit One

Difficulty: Hard
ID: 233
Solved?: Yes
Tags: Math
击败: 37.5
推荐指数: ⭐⭐⭐⭐

[Number of Digit One - LeetCode](https://leetcode.com/problems/number-of-digit-one/)

## 题意

Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.

**Example:**

```
Input: 13
Output: 6 
Explanation: Digit 1 occurred in the following numbers: 1, 10, 11, 12, 13.

```

## 思路

1. 递归：H(s)表示1的个数。假设数字为abcdefg，它是7位数。那么，它包含所有6位数，也就是H(999 999)。接下来要考虑的都是7位数，比如1xxxxxx, 2xxxxxx, (a-1)xxxxxx, [a000000, abcdefg]，H(2xxxxxx)这种首位非1的数字，它的数量就是H(xxxxxx)，也就是所有6位数，H(999999)。1xxxxxx稍微特殊点，所有数都包含首位的1，所以要额外增加1000000个数。而剩余的[a000000, abcdefg]，a不为1的话，那就可以把首位拿掉，变成H(bcdefg)。
    
    简单分类讨论：
    
    首位a为0，不起作用，前进一位数。
    
    首位为1，H(abcdefg) = H(999999) + (bcdefg + 1) + H(bcdefg)
    
    首位非1，H(abcdefg) = H(999999) + (1000000 + H(999999) + (a-2) * H(999999) + H(bcdefg) = 1000000 + a * H(999999) + H(bcdefg)
    
    观察下，1跟非1，主要部分类似的，a*H(999999) + H(bcdefg)，剩余的数量稍有差异。
    

## 题解

```python
class Solution:
    def countDigitOne(self, n: int) -> int:
        if n <= 0: return 0
        G = {str(i): 1 if i > 0 else 0 for i in range(10)}
        G[""] = 0
        return self.dfs(G, str(n))
    
    def dfs(self, G, s):
        if s in G: return G[s]
        n = len(s)
        a = s[0]
        if a == '0': return self.dfs(G, s[1:])
        if a == '1':
            G[s] = self.dfs(G, '9' * (n-1)) + self.dfs(G, s[1:]) + int(s[1:]) + 1
        else:
            G[s] = 10 ** (n-1) + int(a) * self.dfs(G, '9' * (n-1)) + self.dfs(G, s[1:])
        return G[s]
```

击败37.50%