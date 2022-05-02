---
title: 58A_Chat_room_eff6b4ee784542928c6b476bd9c84ee7
---

# 58A. Chat room

ID: 58
Tags: greedy, strings
github: No
已解: Yes
推荐指数: ⭐⭐
难度: 1000

[Problem - 58A - Codeforces](https://codeforces.com/problemset/problem/58/A)

```python
s = input()
t = "hello"
i = 0
j = 0
while i < len(s) and j < len(t):
    if s[i] == t[j]:
        j += 1
    i += 1
if j == len(t):
    print("YES")
else:
    print("NO")
```