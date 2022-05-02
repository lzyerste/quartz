---
title: 1420A_-_Cubes_Sorting_72bae19e62eb4641a99255fd48bc0ba4
---

# 1420A - Cubes Sorting

ID: 1420
Tags: math, sortings
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 900

[Problem - 1420A - Codeforces](https://codeforces.com/problemset/problem/1420/A)

## 思路

1. 暴力：超时。统计每个数字，右边比它小的数字的数量和。
2. 数学：n个数排序，最多需要多少次交换？(n-1) + (n-2) + ... + 1 = (n-1) * n // 2，而且在严格递减下才成立。题目要求的是与(n-1)*n // 2 - 1，也就是说，只要不是严格递减，那么总是可以完成。所以题目转为是否严格递减数组的判断。

## 题解：数学

```python
def solve():
    n = read_int()
    A = read_ints()
    for i in range(n - 1):
        if A[i] <= A[i+1]:
            YES()
            return
    NO()
```