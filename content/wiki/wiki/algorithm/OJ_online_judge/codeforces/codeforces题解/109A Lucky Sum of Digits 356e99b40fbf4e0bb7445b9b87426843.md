---
title: 109A_Lucky_Sum_of_Digits_356e99b40fbf4e0bb7445b9b87426843
---

# 109A. Lucky Sum of Digits

ID: 109
Tags: brute force, implementation
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 1000

[Problem - 109A - Codeforces](https://codeforces.com/problemset/problem/109/A)

位数越少，也就使用更多的7。

```python
def main():
    n = read_int()
    for x in range(n // 7, -1, -1):
        y = n - x * 7
        if y % 4 == 0:
            print("4" * (y // 4) + "7" * x)
            return
    print(-1)
```