---
title: 339B_Xenia_and_Ringroad_bf1fb15dc2bb408499bfb80bc5b4dab3
---

# 339B. Xenia and Ringroad

ID: 339
Tags: implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1000

[Problem - 339B - Codeforces](https://codeforces.com/problemset/problem/339/B)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

n, m = read_ints()
task = read_ints()
k = 1
i = 0
steps = 0
while i < len(task):
    ai = task[i]
    if k == ai:
        i += 1
    elif k < ai:
        steps += ai - k
        k = ai
    else:
        steps += n - k + ai
        k = ai
print(steps)
```