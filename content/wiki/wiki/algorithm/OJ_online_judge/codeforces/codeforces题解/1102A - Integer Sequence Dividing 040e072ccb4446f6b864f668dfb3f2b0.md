---
title: 1102A_-_Integer_Sequence_Dividing_040e072ccb4446f6b864f668dfb3f2b0
---

# 1102A - Integer Sequence Dividing

ID: 1102
Tags: math
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 800

[Problem - 1102A - Codeforces](https://codeforces.com/problemset/problem/1102/A)

## 思路

1. 注意证明

![2022-05-02_11-26-05](1102A%20-%20Integer%20Sequence%20Dividing%20040e072ccb4446f6b864f668dfb3f2b0/2022-05-02_11-26-05.png)

## 题解

```python
def solve():
    n = read_int()
    total = n * (n + 1) // 2
    if total % 2:
        print(1)
    else:
        print(0)
```