---
title: 259A_Little_Elephant_and_Chess_3ee94fab87af425db6df11612209a997
---

# 259A. Little Elephant and Chess

ID: 259
Tags: brute force, strings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1000

[Problem - 259A - Codeforces](http://codeforces.com/problemset/problem/259/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

ans = True
for _ in range(8):
    if ans is False:
        break
    row = input()
    for i in range(1, 8):
        if row[i] == row[i-1]:
            ans = False
            break
if ans:
    print("YES")
else:
    print("NO")
```