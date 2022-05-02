---
title: 1337B_-_Kana_and_Dragon_Quest_game_0d8c381dc26949419bca2c1f46b21f09
---

# 1337B - Kana and Dragon Quest game

ID: 1337
Tags: greedy, implementation, math
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 900

[Problem - 1337B - Codeforces](https://codeforces.com/problemset/problem/1337/B)

## 思路

1. 除2优先，但要注意，数字较小时，没必要除，除了再加反而变大。

## 题解

```python
def solve():
    x, n, m = read_ints()
    while x > 20 and n > 0:
        n -= 1
        x = x // 2 + 10
    dbg(x, n, m)
    x -= m * 10
    if x <= 0:
        YES()
    else:
        NO()
```