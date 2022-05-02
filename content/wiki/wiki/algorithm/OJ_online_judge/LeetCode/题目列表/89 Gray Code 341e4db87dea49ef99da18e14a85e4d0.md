---
title: 89_Gray_Code_341e4db87dea49ef99da18e14a85e4d0
---

# 89. Gray Code

Difficulty: Medium
ID: 89
Solved?: Yes
Tags: Backtracking, Recursive, 规律
击败: 98.4
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/gray-code/)

## 题意

## 题解：观察+递归

观察n从2变为3是如何变化的。

n = 2:

```python
00
01
11
10
```

n = 3:

```python
000
001
011 <-----
010 <--  |
---   |  |
110 <--  |
111 <-----
101
100
```

观察n=3，分割为上下两部分，刚好是镜像对称，除了最高位分别是0和1，低位是镜像对称的。

所以，如果求出了上半部分，下半部分只需要高位变为1倒转下即可。

```python
class Solution:
    def grayCode(self, n: int) -> List[int]:
        if n == 0: return [0]
        if n == 1: return [0, 1]
        part1 = self.grayCode(n - 1)
        off = 1 << (n -1)
        part2 = [off + _ for _ in reversed(part1)]
        return part1 + part2
```

思考：能快速得到格雷码中第k个元素吗？

```python
n ^ (n >> 1)
```