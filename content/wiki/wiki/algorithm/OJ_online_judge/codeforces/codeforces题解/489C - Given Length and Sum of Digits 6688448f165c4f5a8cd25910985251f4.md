---
title: 489C_-_Given_Length_and_Sum_of_Digits_6688448f165c4f5a8cd25910985251f4
---

# 489C - Given Length and Sum of Digits...

ID: 489
Tags: dp, greedy, implementation
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 1400

[Problem - 489C - Codeforces](https://codeforces.com/problemset/problem/489/C)

## 思路

1. 暴力枚举：比如求最大值，只要有可行解，那么总是可以使用贪心算法，每次挑可行的最大的，剩余的肯定能组成答案。最小值，可以将最大值反转，但是注意开头的0，比如9200反转成0029时，第一位的0要加1变成1，首个非0的数字2要减1变成1，所以结果就是1019。

## 题解

```python
def solve():
    m, s = read_ints()
    if m == 1:
        if s > 9 or s < 0:
            print(-1, -1)
        else:
            print(s, s)
        return
    if s <= 0 or s > 9 * m:
        print(-1, -1)
        return

    def dfs(m, s):
        if s == 0:
            return "0" * m
        x = min(s, 9)
        return str(x) + dfs(m - 1, s - x)

    MAX = dfs(m, s)
    MIN = MAX[::-1]
    dbg(MIN, MAX)
    if MIN[0] == '0':
        for i in range(len(MIN)):
            if MIN[i] != '0':
                dbg(i)
                MIN = '1' + MIN[1:i] + str(int(MIN[i])-1) + MIN[i+1:]
                break
    print(MIN, MAX)
```