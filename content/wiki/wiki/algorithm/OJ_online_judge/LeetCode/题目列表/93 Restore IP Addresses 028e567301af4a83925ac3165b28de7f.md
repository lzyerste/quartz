---
title: 93_Restore_IP_Addresses_028e567301af4a83925ac3165b28de7f
---

# 93. Restore IP Addresses

Difficulty: Medium
ID: 93
Solved?: Yes
Tags: Backtracking, DP
击败: 92.86
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/restore-ip-addresses/)

## 题意

## 题解1：DP

dp(i, j)表示从字符串下标`i`开始，分割成`j`段IP子段，有多少种合法的割法。

当前字段长度可能是1~3，选好之后，剩余的继续递归。

比如dp(i, j)与dp(i+1, j-1), dp(i+2, j-1), dp(i+3, j-1)有关。

```python
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        def dp(G, s, i, j):
            p = i, j
            if p in G: return G[p]
            if j == 0:  # 不需要再分割了，如果当前剩余字符串刚好为空那就是合法的
                return [[]] if i >= len(s) else []
            res = []
            for d in range(1, 4):
                right = i + d
                if right > len(s): break  # 字符越界
                ip = s[i:right]  # 当前ip段
                if int(ip) > 255: break  # 比如666
                if str(int(ip)) != ip: break  # 比如012
                for t in dp(G, s, right, j - 1):
                    res.append([ip] + t)
            G[p] = res
            return G[p]
        
        res = dp({}, s, 0, 4)
        return [".".join(_) for _ in res]
```

## 题解2：回溯

以前写的

```python
def restore(s):
    res = []
    backtrack(res, [], 4, s, 0)
    return res

def check(s):
    return s == '0' or (int(s) <= 255 and s[0] != '0')

def backtrack(res, temp, cnt, s, start):
    if cnt == 0:
        if start == len(s):
            res.append(".".join(temp))
    elif start == len(s):
        return
    else:
        for i in range(start, len(s)):
            subs = s[start: i + 1]
            if check(subs):
                temp.append(subs)
                backtrack(res, temp, cnt - 1, s, i + 1)
                temp.pop()
            else:
                break

class Solution:
    def restoreIpAddresses(self, s):
        """
        :type s: str
        :rtype: List[str]
        """
        return restore(s)
```