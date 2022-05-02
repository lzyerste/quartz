---
title: 320A_Magic_Numbers_7a1fa8bc54ba4202bcc32ba8b45c333f
---

# 320A. Magic Numbers

ID: 320
Tags: brute force, greedy
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 900

[Problem - 320A - Codeforces](https://codeforces.com/problemset/problem/320/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

s = input()
s = s.replace("144", "A")
s = s.replace("14", "A")
s = s.replace("1", "A")
s = s.replace("A", "")
if s == "":
    print("YES")
else:
    print("NO")
```