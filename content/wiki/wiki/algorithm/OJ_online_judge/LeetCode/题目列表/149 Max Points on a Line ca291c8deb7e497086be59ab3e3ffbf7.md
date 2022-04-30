---
title: 149_Max_Points_on_a_Line_ca291c8deb7e497086be59ab3e3ffbf7
---

# 149. Max Points on a Line

Difficulty: Hard
ID: 149
Solved?: Yes
Tags: Hash Table, Math
击败: 81.4
推荐指数: ⭐⭐⭐⭐

[Max Points on a Line - LeetCode](https://leetcode.com/problems/max-points-on-a-line/)

## 题意

Given *n* points on a 2D plane, find the maximum number of points that lie on the same straight line.

**Example 1:**

```
Input: [[1,1],[2,2],[3,3]]
Output: 3
Explanation:
^
|
|        o
|     o
|  o  
+------------->
0  1  2  3  4

```

**Example 2:**

```
Input: [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
Output: 4
Explanation:
^
|
|  o
|     o        o
|        o
|  o        o
+------------------->
0  1  2  3  4  5  6

```

**NOTE:** input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.

## 思路

1. 所有点两两计算斜率k及与y轴交点b，形成四元组k, b, p1, p2。
注意，如果是垂线的话，k为无穷大，b记为与x轴的交点。
这一步只是预处理，而且得知道k和b的值其实是损失了精度的。
接下来，将所有四元组按照k，b排序。只需要统计一下连续的四元组是否共线即可。
如果相邻两个元素的k和b相差在精度之外，那么肯定是不共线。
如果在精度之内，还得进一步确定是否真的共线。
也就是四个点p1, p2, p3, p4是否共线。
方法很简单，用向量来做，判断p1, p2, p3是否共线，p1, p2, p4是否共线。
三点共线，只需要考虑向量P1P2与（dx1, dy1）向量P1P3（dx2, dy2）是否平行，也就是dy1 * dx2 == dy2 * dx1，也就是比较各自斜率k是否相等，只是把除法转为乘法，整数乘法不损失精度。
2. 直接法：选定一个点，然后针对剩余的点，计算出斜率，因为浮点数不精确，所以可以用最简分数形式<p, q>，p/q就是斜率。使用map维护同斜率的数量。注意点的重合与竖轴。竖轴时，通过一样的gcd，得到的p和q都是<1, 0>，所以并不需要特别处理。

## 题解

```python
class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        if n < 2: return n

        for i in range(n):
            points[i].append(i)  # id
        
        def kb(p1, p2):
            if p1[0] == p2[0]:
                return float("inf"), p1[0], p1, p2
            k = (p2[1] - p1[1]) / (p2[0] - p1[0])
            b = p1[1] - k * p1[0]
            return k, b, p1, p2
        
        res = []
        for i in range(n):
            for j in range(i + 1, n):
                res.append(kb(points[i], points[j]))
        res.sort(key=lambda x: x[:2])

        def oneline(p1, p2, p3):
            return (p2[1] - p1[1]) * (p3[0] - p1[0]) == (p3[1] - p1[1]) * (p2[0] - p1[0])

        delta = 0.1 ** 6
        k0, b0, q1, q2 = res[0]
        G = set()
        cnt = 0
        for k, b, p1, p2 in res:
            if (k == k0 or (k - k0 < delta)) and (b - b0 < delta) and oneline(q1, q2, p1) and oneline(q1, q2, p2):
                G.add(p1[-1])
                G.add(p2[-1])
            else:
                cnt = max(cnt, len(G))
                G = set()
                k0, b0, q1, q2 = k, b, p1, p2
        return max(cnt, len(G))
```

击败51.87%

## 题解2：直接法

```python
class Solution:
    def maxPoints(self, points: List[List[int]]) -> int:
        from collections import defaultdict
        res = 0
        n = len(points)
        
        def gcd(a, b):
            if b == 0: return a
            return gcd(b, a % b)
        
        for i in range(n):
            G = defaultdict(int)
            u = points[i]
            same = 1  # 重合点数量，包括自身
            for j in range(i+1, n):
                v = points[j]
                dy = v[1] - u[1]
                dx = v[0] - u[0]
                if dx == 0 and dy == 0:
                    same += 1
                    continue
                gcd_ = gcd(dy, dx)
                dy = dy // gcd_
                dx = dx // gcd_
                G[(dy, dx)] += 1  # 斜率
            res = max(res, max(G.values(), default=0) + same)
        return res
```

击败81.40%