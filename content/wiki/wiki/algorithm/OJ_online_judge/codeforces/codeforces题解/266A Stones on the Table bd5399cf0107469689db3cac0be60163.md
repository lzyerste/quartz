---
title: 266A_Stones_on_the_Table_bd5399cf0107469689db3cac0be60163
---

# 266A. Stones on the Table

ID: 266
Tags: implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 266A - Codeforces](https://codeforces.com/problemset/problem/266/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

n = read_int()
s = input()
cnt = 0
i = 1
while i < n:
    if s[i] == s[i-1]:
        cnt += 1
    i += 1
print(cnt)
```