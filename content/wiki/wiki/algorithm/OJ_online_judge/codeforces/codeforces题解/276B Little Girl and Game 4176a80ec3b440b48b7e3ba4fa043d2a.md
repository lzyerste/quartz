---
title: 276B_Little_Girl_and_Game_4176a80ec3b440b48b7e3ba4fa043d2a
---

# 276B. Little Girl and Game

ID: 276
Tags: games, greedy
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 1300

[Problem - 276B - Codeforces](https://codeforces.com/problemset/problem/276/B)

```python
def main():
    s = input()
    G = Counter(s)
    cnt = 0
    for v in G.values():
        if v % 2:
            cnt += 1
    if cnt % 2 or cnt < 2:
        print("First")
    else:
        print("Second")
```