---
title: 59_Spiral_Matrix_II_317e4f3fc48d4df7a716ecc14e19f953
---

# 59. Spiral Matrix II

Difficulty: Medium
ID: 59
Solved?: Yes
Tags: Math, 规律
击败: 70.27
推荐指数: ⭐⭐⭐

[Spiral Matrix II - LeetCode](https://leetcode.com/problems/spiral-matrix-ii/)

## 题意

## 题解：找规律

```python
class Solution:
    def generateMatrix(self, n: int) -> List[List[int]]:
        if n == 0: return []
        # None表示未被填充，可作为边界。
        matrix = [[None for c in range(n)] for r in range(n)]
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # 右、下、左、上
        d = 0  # 初始方向
        r, c = 0, 0  # 待填充位置
        cnt = 0  # 计数
        num = 1  # 待填充数字
        while True:
            matrix[r][c] = num  # 填充当前位置
            num += 1
            cnt += 1
            if cnt == n * n:
                break
            # 试探步，检查下一步是否越界
            r1, c1 = r + dirs[d][0], c + dirs[d][1]
            if not (0 <= r1 < n and 0 <= c1 < n) or matrix[r1][c1] is not None:
                d = (d + 1) % 4  # 撞墙，切换方向
                r, c = r + dirs[d][0], c + dirs[d][1]  # 真正下一步
            else:
                r, c = r1, c1  # 试探步没问题
        return matrix
```