---
title: 1453B_-_Suffix_Operations_ec7590024029465daa448d5aa82822da
---

# 1453B - Suffix Operations

ID: 1453
Tags: constructive algorithms, implementation
github: No
已解: Yes
推荐指数: ⭐⭐⭐⭐
难度: 1400

[Problem - 1453B - Codeforces](http://codeforces.com/problemset/problem/1453/B)

## 思路

- 先不考虑改变的机会，按照常规，最佳策略是从左到右，都向左邻居对齐，也就是a1往a0对齐，然后a2往a1对齐（此时的a1已经是a0了）。最终所有元素都是a0。

![1453B%20-%20Suffix%20Operations%20ec7590024029465daa448d5aa82822da/Untitled.png](1453B%20-%20Suffix%20Operations%20ec7590024029465daa448d5aa82822da/Untitled.png)

## 题解

```python
def solve():
    n = read_int()
    A = read_ints()
    if n <= 2:
        print(0)
        return
    G = [0 for _ in range(n)]
    for k in range(1, n):
        G[k] = G[k - 1] + abs(A[k] - A[k - 1])
    # all elements equal to A[0]
    MIN = min(G[n - 1] - G[1], G[n - 2])  # first one changes A[0] to A[1], second one changes A[n-1] finally to A[0]
    for k in range(1, n - 1):
        MIN = min(MIN, G[k-1] + G[n-1] - G[k+1] + abs(A[k-1] - A[k+1]))
    print(MIN)
```