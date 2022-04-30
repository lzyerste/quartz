---
title: 155A_I_love_%username%_397b9c3120ed4b24a64ea324c8fb9c8b
---

# 155A. I_love_%username%

ID: 155
Tags: brute force
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 155A - Codeforces](http://codeforces.com/problemset/problem/155/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

n = read_int()
A = read_ints()
cnt = 0
MIN = MAX = A[0]
for d in A:
    if d > MAX:
        MAX = d
        cnt += 1
    elif d < MIN:
        MIN = d
        cnt += 1
print(cnt)
```