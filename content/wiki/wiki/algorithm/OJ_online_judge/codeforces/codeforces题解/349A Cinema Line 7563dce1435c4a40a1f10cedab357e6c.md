---
title: 349A_Cinema_Line_7563dce1435c4a40a1f10cedab357e6c
---

# 349A. Cinema Line

ID: 349
Tags: greedy, implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1100

[Problem - 349A - Codeforces](https://codeforces.com/problemset/problem/349/A)

```python
def main():
    n = read_int()
    A = read_ints()
    CG_25 = 0
    CG_50 = 1
    changes = [0, 0]  # 25, 50. 100 are ignored

    def do_change(x, changes):
        if x == 25:
            changes[CG_25] += 1
            return True
        elif x == 50:
            if changes[CG_25] > 0:
                changes[CG_50] += 1
                changes[CG_25] -= 1
                return True
        elif x == 100:
            x -= 25
            if changes[CG_50] > 0:
                changes[CG_50] -= 1
                x -= 50
            if changes[CG_25] >= x // 25:
                changes[CG_25] -= x // 25
                return True
        return False

    for x in A:
        ret = do_change(x, changes)
        if ret is False:
            NO()
            return
    YES()
```