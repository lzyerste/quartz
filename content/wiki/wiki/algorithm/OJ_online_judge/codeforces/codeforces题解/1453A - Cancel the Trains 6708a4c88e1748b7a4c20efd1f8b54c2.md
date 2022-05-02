---
title: 1453A_-_Cancel_the_Trains_6708a4c88e1748b7a4c20efd1f8b54c2
---

# 1453A - Cancel the Trains

ID: 1453
github: No
已解: Yes
推荐指数: ⭐⭐

注意，相撞点只能在对角线上。

```jsx
def solve():
    n, m = read_ints()
    A = read_ints()
    B = read_ints()
    C = set(A) & set(B)
    print(len(C))
```