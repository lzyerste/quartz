---
title: 112A_Petya_and_Strings_4b6927506b3c4cd9a756ff7e94d24cae
---

# 112A. Petya and Strings

ID: 112
Tags: implementation, strings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 112A - Codeforces](https://codeforces.com/problemset/problem/112/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

s = input().lower()
t = input().lower()
if s < t:
    print(-1)
elif s > t:
    print(1)
else:
    print(0)
```