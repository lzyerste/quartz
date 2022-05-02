---
title: 110A_Nearly_Lucky_Number_8d307dcfbdb842bea8573cb26848e1a6
---

# 110A. Nearly Lucky Number

ID: 110
Tags: implementation
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 800

[Problem - A - Codeforces](http://codeforces.com/contest/110/problem/A)

## 题解

```python
def is_lucky(s):
    for c in s:
        if c not in "47":
            return False
    return True

def is_near_lucky(s):
    cnt = 0
    for c in s:
        if c in "47":
            cnt += 1
    return is_lucky(str(cnt))

n = input()
if is_near_lucky(n):
    print("YES")
else:
    print("NO")
```