---
title: 236A_Boy_or_Girl_1d5fc207f498459188d8d2bcdbdb3d29
---

# 236A. Boy or Girl

ID: 236
Tags: brute force, implementation, strings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 236A - Codeforces](https://codeforces.com/problemset/problem/236/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

s = input()
cnt = len(set(s))
if cnt % 2:
    print("IGNORE HIM!")
else:
    print("CHAT WITH HER!")
```