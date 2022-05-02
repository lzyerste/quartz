---
title: 1447A_-_Add_Candies_45405d06a9e1461eb51b07fc43fcc5bc
---

# 1447A - Add Candies

ID: 1447
Tags: constructive algorithms, math, 反向思维
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 800

[Problem - 1447A - Codeforces](https://codeforces.com/problemset/problem/1447/A)

## 思路

1. 反向思维：其他全加相当于自身减，其他不动。

## 题解

```python
def solve():
    n = read_int()
    m = n - 1
    A = [i + 2 for i in range(m)]
    print(m)
    print_nums(A)
```