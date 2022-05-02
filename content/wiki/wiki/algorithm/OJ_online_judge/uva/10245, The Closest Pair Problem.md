---
title: 10245,_The_Closest_Pair_Problem
---

# 10245, The Closest Pair Problem

tag: 最近点对问题。

[Online Judge](https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1186)

25632605	10245	The Closest Pair Problem	Accepted	PYTH3	1.150	2020-10-19 06:34:48

## 题解

```python
def distance(p1, p2):
    return ((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2) ** 0.5

def solve_brute_force(X, Y):
    n = len(X)
    d = float("inf")
    for i in range(n - 1):
        p1 = X[i]
        for j in range(i + 1, n):
            p2 = X[j]
            d = min(d, distance(p1, p2))
    return d

def solve_divide_conquer(X, Y):
    # X: 所有点排序方式：先x后y
    # Y: 所有点排序方式：先y后x
    n = len(X)
    if n < 4:
        return solve_brute_force(X, Y)
    half = n // 2
    XL = X[:half]  # left part of X
    XR = X[half:]  # right part of X
    mid = XL[-1][0]
    YL = []
    YR = []
    for p in Y:
        if p[0] < mid or (p[0] == mid and len(YL) < half):
            YL.append(p)  # YL与XL数量保持一致
        else:
            YR.append(p)
    d1 = solve_divide_conquer(XL, YL)
    d2 = solve_divide_conquer(XR, YR)
    d = min(d1, d2)
    # SX = [p for p in X if abs(p[0] - mid) <= d]
    # 只需考虑中线附近的点，按照Y轴排序
    SY = [p for p in Y if abs(p[0] - mid) <= d]
    n = len(SY)
    for i in range(n):
        p1 = SY[i]
        # 最多只需要考虑7个点
        for j in range(i + 1, min(i + 8, n)):
            p2 = SY[j]
            d = min(d, distance(p1, p2))
    return d

if __name__ == '__main__':
    while True:
        N = int(input())
        if N == 0: break
        P = []
        for i in range(N):
            x, y = map(float, input().split())
            P.append((x, y))
        X = sorted(P)
        Y = sorted(P, key=lambda p: (p[1], p[0]))
        d = solve_divide_conquer(X, Y)
        if d < 10000:
            print("{:.4f}".format(d))
        else:
            print("INFINITY")
```