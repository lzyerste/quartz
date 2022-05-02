---
title: 1136A_-_Nastya_Is_Reading_a_Book_ef69b8267a1d440f9543f90feb4915c1
---

# 1136A - Nastya Is Reading a Book

ID: 1136
Tags: binary search, implementation
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 800

[Problem - 1136A - Codeforces](https://codeforces.com/problemset/problem/1136/A)

## 思路

1. 暴力
2. 二分：停留时为RL，让R指向正确结果，即A[R][0] ≤ t

## 题解：二分

```python
def solve():
    n = read_int()
    G = []
    for i in range(n):
        G.append(read_ints())

    def bs(t):
        L, R = 0, n - 1
        while L <= R:
            M = (L + R) // 2
            if G[M][0] <= t:
                L = M + 1
            else:
                R = M - 1
        return R

    t = read_int()
    idx = bs(t)
    print(n - idx)
```