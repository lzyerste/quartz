---
title: 266B_Queue_at_the_School_6f44c15ce67c4c2fa5fe0942ffa87768
---

# 266B. Queue at the School

ID: 266
Tags: constructive algorithms, graph matchings, implementation, shortest paths
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 266B - Codeforces](http://codeforces.com/problemset/problem/266/B)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

n, t = read_ints()
s = list(input())
for _ in range(t):
    i = 0
    while i < n - 1:
        if s[i] == 'B' and s[i+1] == 'G':
            s[i], s[i+1] = s[i+1], s[i]
            i += 2
        else:
            i += 1
print("".join(s))
```