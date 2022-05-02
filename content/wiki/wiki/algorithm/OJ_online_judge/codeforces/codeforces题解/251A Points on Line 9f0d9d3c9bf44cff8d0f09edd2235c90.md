---
title: 251A_Points_on_Line_9f0d9d3c9bf44cff8d0f09edd2235c90
---

# 251A. Points on Line

ID: 251
Tags: binary search, combinatorics, two pointers
github: No
已解: Yes
推荐指数: ⭐⭐⭐⭐
难度: 1300

[Problem - 251A - Codeforces](https://codeforces.com/problemset/problem/251/A)

```python
def main():
    n, d = read_ints()
    A = read_ints()
    total = 0
    i, j = 0, 0
    for i in range(n):  # 先确定左起点
        while j < n and A[j] - A[i] <= d:
            j += 1
        [i, j)
        total += max(0, (j-i-1) * (j-i-2) // 2)

    print(total)
```

```python
def main():
    n, d = read_ints()
    A = read_ints()
    total = 0
    L = 0
    for R in range(n):  # 先确定右终点
        while A[R] - A[L] > d:
            L += 1
        # [L, R] inclusive
        total += max(0, (R-L) * (R-L-1) // 2)
    print(total)
```