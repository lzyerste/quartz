---
title: 118B_Present_from_Lena_62d95d62807f460cbcbe9451e2ddd70c
---

# 118B. Present from Lena

ID: 118
Tags: constructive algorithms, implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1000

[Problem - 118B - Codeforces](https://codeforces.com/problemset/problem/118/B)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

def gen(k, n):
    res = []
    for i in range(n - k):
        res.append(" ")
    for i in range(k):
        res.append(str(i))
    res.append(str(k))
    for i in reversed(range(k)):
        res.append(str(i))
    return " ".join(res)

n = read_int()
for i in range(n):
    print(gen(i, n))
print(gen(n, n))
for i in reversed(range(n)):
    print(gen(i, n))
```