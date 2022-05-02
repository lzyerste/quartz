---
title: 750A_-_New_Year_and_Hurry_819b567dbce3476aa1be84819825cd9e
---

# 750A - New Year and Hurry

ID: 750
Tags: binary search, brute force, implementation, math
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 800

[Problem - 750A - Codeforces](https://codeforces.com/problemset/problem/750/A)

## 思路

1. 暴力
2. 二分，类似开根号。结束的时候为RL，R对应的为≤，L对应的位大于。

## 题解：二分

```python
def main():
    n, k = read_ints()
    t = 240 - k
    L, R = 0, n
    while L <= R:
        M = (L + R) // 2
        if 5 * M * (M + 1) // 2 <= t:
            L = M + 1
        else:
            R = M - 1
    print(R)
```