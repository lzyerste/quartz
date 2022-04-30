---
title: 71A_Way_Too_Long_Words_db9a389860b74e0dafbb49bd320b8a74
---

# 71A. Way Too Long Words

ID: 71
Tags: strings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 71A - Codeforces](https://codeforces.com/problemset/problem/71/A)

## 题解

```python
def solve(s):
    n = len(s)
    if n <= 10:
        print(s)
    else:
        print("%s%d%s" % (s[0], n-2, s[-1]))

n = int(input())
for _ in range(n):
    s = input()
    solve(s)
```