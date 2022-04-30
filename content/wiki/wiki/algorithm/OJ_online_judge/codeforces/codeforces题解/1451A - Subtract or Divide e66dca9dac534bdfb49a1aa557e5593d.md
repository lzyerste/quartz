---
title: 1451A_-_Subtract_or_Divide_e66dca9dac534bdfb49a1aa557e5593d
---

# 1451A - Subtract or Divide

ID: 1451
Tags: greedy, math
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 800

[Problem - 1451A - Codeforces](https://codeforces.com/problemset/problem/1451/A)

别想太多，奇数减1成偶数，偶数直达数字2。

```python
def solve():
    def dfs(n):
        if n <= 2: return n - 1
        if n % 2:
            return 1 + dfs(n - 1)
        return 1 + dfs(2)

    n = read_int()
    print(dfs(n))
```