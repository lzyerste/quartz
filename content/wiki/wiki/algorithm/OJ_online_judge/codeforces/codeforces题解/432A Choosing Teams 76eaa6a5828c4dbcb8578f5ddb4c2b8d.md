---
title: 432A_Choosing_Teams_76eaa6a5828c4dbcb8578f5ddb4c2b8d
---

# 432A. Choosing Teams

ID: 432
Tags: greedy, implementation, sortings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - 432A - Codeforces](https://codeforces.com/problemset/problem/432/A)

## 题解

```python
def readints():
    return list(map(int, input().split()))

Y, K = readints()
A = readints()

A = [_ for _ in A if _ <= 5 - K]
groups = len(A) // 3
print(groups)
```