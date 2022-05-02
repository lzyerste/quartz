---
title: 330A_Cakeminator_ed94901fe38d448ca3f2c1968d4f2eba
---

# 330A. Cakeminator

ID: 330
Tags: brute force, implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 330A - Codeforces](http://codeforces.com/problemset/problem/330/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

M, N = read_ints()
rows = set()
cols = set()
for r in range(M):
    s = input()
    for c, x in enumerate(s):
        if x == 'S':
            rows.add(r)
            cols.add(c)
R = M - len(rows)
C = N - len(cols)
total = R * N + C * M - R * C
print(total)
```