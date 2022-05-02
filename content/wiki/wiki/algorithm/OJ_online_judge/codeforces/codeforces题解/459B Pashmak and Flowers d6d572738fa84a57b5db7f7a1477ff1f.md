---
title: 459B_Pashmak_and_Flowers_d6d572738fa84a57b5db7f7a1477ff1f
---

# 459B. Pashmak and Flowers

ID: 459
Tags: combinatorics, implementation, sortings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1300

[Problem - 459B - Codeforces](https://codeforces.com/problemset/problem/459/B)

```python
def main():
    n = read_int()
    A = read_ints()
    MIN = min(A)
    MAX = max(A)
    min_cnt = A.count(MIN)
    max_cnt = A.count(MAX)
    if MIN == MAX:
        cnt = min_cnt * (min_cnt - 1) // 2
    else:
        cnt = min_cnt * max_cnt
    print("%d %d" % (MAX - MIN, cnt))
```