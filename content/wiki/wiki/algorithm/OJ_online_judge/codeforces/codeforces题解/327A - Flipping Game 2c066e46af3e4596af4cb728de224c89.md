---
title: 327A_-_Flipping_Game_2c066e46af3e4596af4cb728de224c89
---

# 327A - Flipping Game

ID: 327
Tags: brute force, dp, implementation
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 1200

[Problem - 327A - Codeforces](https://codeforces.com/problemset/problem/327/A)

## 思路

1. DP：dp(k)表示以k为翻转终点时能得到最大的收益，起点在k的左边，具体在哪先不关心。收益的定义是翻转区间里0的个数减去1的个数，因为翻转后，0变成了1，1变成了0。收益有可能是负的（比如全是1的区间）。
    
    接下来考虑下一个k+1，如果它是0，它有两种选择，一种是接上k，那么结果是dp(k)+1；一种是不接k，从自己重新开始，那么结果是1。如果它是1，同样可以有两种选择，一种是接上k，那么结果是dp(k)-1；一种是不接k，从自己重新开始，那么结果是-1。最终，dp(k+1)就是上面所有结果的最大值。
    

## 题解

```python
def main():
    n = read_int()
    A = read_ints()
    MAX = float("-inf")
    profit = 0
    for x in A:
        if x == 1:
            profit = max(profit - 1, -1)
        else:
            profit = max(profit + 1, 1)
        MAX = max(MAX, profit)
    print(A.count(1) + MAX)
```