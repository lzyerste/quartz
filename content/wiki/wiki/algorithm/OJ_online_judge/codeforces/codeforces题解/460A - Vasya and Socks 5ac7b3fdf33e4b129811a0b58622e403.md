---
title: 460A_-_Vasya_and_Socks_5ac7b3fdf33e4b129811a0b58622e403
---

# 460A - Vasya and Socks

ID: 460
Tags: brute force, implementation, math
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 900

[Problem - 460A - Codeforces](https://codeforces.com/problemset/problem/460/A)

## 思路

1. 递归：假设从位置s触发，出发时有k双袜子。正常走的话，到s+k-1时，剩余1双袜子，刚好这天穿，所以会停在位置s+k-1。那么区间[s, s+k-1]中间有多少个m倍数呢？x//m表示x之前有多少个m倍数（包括x），所以delta的第二项是s-1。
    
    如果delta为0，那么就是没有续命，停在s+k-1。
    
    如果有delta，在位置s+k-1时，自身有1双袜子，可以先消耗掉，走到s+k，此时还有delta双袜子。继续递归。
    
2. 数据量较小，直接模拟。

## 题解：递归

```python
def solve():
    n, m = read_ints()
    def dfs(s, k):
        delta = (s + k - 1) // m - (s - 1) // m
        if delta == 0:
            return s + k - 1
        return dfs(s + k, delta)
    print(dfs(1, n))
```