---
title: 1452C_Two_Brackets_d3438ab0f7c34cc4846fd403f96feac5
---

# 1452C. Two Brackets

ID: 1452
Tags: greedy
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 1452C - Codeforces](https://codeforces.com/problemset/problem/1452/C)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

def solve():
    from collections import defaultdict
    s = input()
    ans = 0
    G = defaultdict(int)
    for c in s:
        if c == ']' and G['['] > 0:
            ans += 1
            G['['] -= 1
        elif c == ')' and G['('] > 0:
            ans += 1
            G['('] -= 1
        else:
            G[c] += 1  # '[' or '('
    print(ans)

T = read_int()
for _ in range(T):
    solve()
```