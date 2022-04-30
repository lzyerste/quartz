---
title: 148A_Insomnia_cure_27bbae137d7b4040af63ffce02e84acc
---

# 148A. Insomnia cure

ID: 148
Tags: constructive algorithms, implementation, math
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 148A - Codeforces](https://codeforces.com/problemset/problem/148/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

k = read_int()
l = read_int()
m = read_int()
n = read_int()
d = read_int()

nums = [0 for _ in range(d + 1)]
for x in [k, l, m, n]:
    for i in range(x, d + 1, x):
        nums[i] = 1
print(sum(nums))
```