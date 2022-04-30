---
title: 152A_Marks_6af813de3d2b40e0adbdedd02afecdb0
---

# 152A. Marks

ID: 152
Tags: implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 900

[Problem - 152A - Codeforces](https://codeforces.com/problemset/problem/152/A)

```python
def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

n, m = read_ints()
matrix = []
for _ in range(n):
    matrix.append(list(map(int, list(input()))))
ROW = [0 for _ in range(m)]
for c in range(m):
    for r in range(n):
        ROW[c] = max(ROW[c], matrix[r][c])
cnt = 0
for r in range(n):
    succ = False
    for c in range(m):
        if matrix[r][c] == ROW[c]:
            succ = True
            break
    cnt += int(succ)
print(cnt)
```