---
title: 223_Rectangle_Area_379ab86e80f34cfe9bf33915638ff2e1
---

# 223. Rectangle Area

Difficulty: Medium
ID: 223
Solved?: Yes
Tags: Math
击败: 84.08
推荐指数: ⭐⭐

[Rectangle Area - LeetCode](https://leetcode.com/problems/rectangle-area/)

## 题意

Find the total area covered by two **rectilinear** rectangles in a **2D** plane.

Each rectangle is defined by its bottom left corner and top right corner as shown in the figure.

![https://assets.leetcode.com/uploads/2018/10/22/rectangle_area.png](https://assets.leetcode.com/uploads/2018/10/22/rectangle_area.png)

**Example:**

```
Input: A = -3, B = 0, C = 3, D = 4, E = 0, F = -1, G = 9, H = 2
Output: 45
```

**Note:**

Assume that the total area is never beyond the maximum possible value of **int**.

## 思路

1. x轴交集，y轴交集

## 题解

```python
class Solution:
    def computeArea(self, A: int, B: int, C: int, D: int, E: int, F: int, G: int, H: int) -> int:
        area1 = (C - A) * (D - B)
        area2 = (G - E) * (H - F)
        total = area1 + area2
        dx = min(C, G) - max(A, E)
        dy = min(D, H) - max(B, F)
        if dx > 0 and dy > 0:
            overlap = dx * dy
            total -= overlap
        return total
```

击败84.08%