---
title: 224A_Parallelepiped_a3b9d9331ff6451a9b651748f186ecb1
---

# 224A. Parallelepiped

ID: 224
Tags: brute force, geometry, math
github: No
已解: Yes
推荐指数: ⭐⭐⭐⭐
难度: 1100

[Problem - 224A - Codeforces](https://codeforces.com/problemset/problem/224/A)

## 题解：暴力

```python
def main():
    areas = read_ints()
    areas.sort()
    A, B, C = areas

    # x <= y <= z
    # xy = A, xz = B, yz = C
    for x in range(1, int(A ** 0.5) + 1):
        if A % x == 0 and B % x == 0:
            y = A // x
            z = B // x
            if y * z == C:
                print(4 * (x + y + z))
                break
```

## 题解：几何

![2022-05-02_11-25-50](224A%20Parallelepiped%20a3b9d9331ff6451a9b651748f186ecb1/2022-05-02_11-25-50.png)