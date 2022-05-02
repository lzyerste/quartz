---
title: 239A_Two_Bags_of_Potatoes_b859ade95ee04b579551a70c0f91e07b
---

# 239A. Two Bags of Potatoes

ID: 239
Tags: greedy, implementation, math
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1200

[Problem - 239A - Codeforces](https://codeforces.com/problemset/problem/239/A)

```python
def main():
    y, k, n = read_ints()
    A = []
    x0 = (y + k) // k * k - y
    A = [x for x in range(x0, n - y + 1, k)]
    if len(A) == 0:
        print(-1)
    else:
        print_nums(A)
```