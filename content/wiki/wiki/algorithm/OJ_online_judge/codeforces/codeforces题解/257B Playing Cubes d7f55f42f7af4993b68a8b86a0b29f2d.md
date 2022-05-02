---
title: 257B_Playing_Cubes_d7f55f42f7af4993b68a8b86a0b29f2d
---

# 257B. Playing Cubes

ID: 257
Tags: games, greedy, implementation
github: Yes
已解: Yes
推荐指数: ⭐⭐⭐⭐
难度: 1300

[Problem - 257B - Codeforces](https://codeforces.com/problemset/problem/257/B)

[](Div. 2) Разбор Задач - Codeforces](Div. 2|Codeforces Round #159 (Div. 2) Разбор Задач - Codeforces)%20Разбор%20Задач%20-%20Codeforces](https://codeforces.com/blog/entry/6357)

## 思路

1. 不妨假设n（红） ≤ m（蓝），首先证明异色的pair至少可以达到n组，也就是Vasya至少能得到n分；接下来Petya选取合适的策略使得Vasya的分数限定在n分。
    - 因为Vasya是后手，Petya不管前面放置什么颜色，Vasya总是可以放置一个异色，直到剩下的全是同色。
        - 球可以组合成<R, B>, <R, B>, ..., <BBBBB>，前面有n组<R, B>，最后剩余的全是B（可能为0）。<R, B>一组中，不管Petya选哪一个，Vasya选另一个就行了。所以Vasya至少可以拿到n分。
    - 现在Petya思考如何限定Vasya不能拿到更多分。也就是剩余的B全让自己拿分，也就是前面的n对<R, B>组合后，以B结尾即可。
        - 前面n对的排列是两种情况：
        - 以R开始，则为<R, B>, <B, R>, <R, B>, <B, R>, ...，n为奇数，则以<R, B>结尾；n为偶数，则以<B, R>结尾。
        - 类似地，以B开始，则为<B, R>, <R, B>, <B, R>, <R, B>, ...，n为奇数，则以<B, R>结尾；n为偶数，则以<R, B>结尾。
        - 所以根据n的奇偶性，Petya选取不同的颜色开始。n为奇数，则以R开始，结尾为<R, B>；n为偶数，则以B开始，结尾为<R, B>。Vasya只能得n分。
        - 如果不需要详细排列的话，只需要存在性即可。也就是不管n的奇偶性，Petya先随便选取一个颜色，n对之后，如果结尾不是B，那么把初始颜色置换一下即可，就变成了结尾是B。n对之后，总是可以让B结尾。
    - 综上，Vasya获取n分，Petya则获取m+n-1-n = m-1分。因为除了第一步，后面每一步总分都会增加1分，不管是记谁头上。
        - 基于上面的分析，也可以直接计算Petya的得分。前面RB两两配对（n对），后面剩余的B（m-n）都是Petya得分。前面的n对中，除了第一次先手不得分，后面每一对Petya都得分，所以得n-1分，后面得m-n分，所以总共m-1分。
2. 模拟构造法，依次一个个落子。根据第一个颜色的选择分为两组，取大值作为Petya的分数。

## 题解2：模拟

```python
from collections import *

def count(A):
    cnt = 0
    i = 1
    while i < len(A):
        if A[i] == A[i-1]:
            cnt += 1
        i += 1
    return cnt

def build(color, n, m):
    A = [color]
    if color == 'R':
        n -= 1
    else:
        m -= 1
    petya = False
    while n and m:
        if petya:  # same
            if A[-1] == 'R':
                n -= 1
                A.append('R')
            else:
                m -= 1
                A.append('B')
        else:
            if A[-1] == 'R':
                m -= 1
                A.append('B')
            else:
                n -= 1
                A.append('R')
        petya = not petya
    A.extend(['R'] * n)
    A.extend(['C'] * m)
    return A

def main():
    n, m = read_ints()
    A = build('R', n, m)
    cnt1 = count(A)
    A = build('B', n, m)
    cnt2 = count(A)
    cnt = max(cnt1, cnt2)
    print("%d %d" % (cnt, n + m - 1 - cnt))
```