---
title: 85_Maximal_Rectangle_655879aa8df844fdb49a107863a23f30
---

# 85. Maximal Rectangle

Difficulty: Hard
ID: 85
Solved?: Yes
Tags: DP, Matrix, Stack
击败: 24.96
推荐指数: ⭐⭐⭐⭐

[Maximal Rectangle - LeetCode](https://leetcode.com/problems/maximal-rectangle/)

## 题意

## 思路

- 基于 [84. Largest Rectangle in Histogram](84%20Largest%20Rectangle%20in%20Histogram%2018812cd530d149258528d978dd390e9c.md) 解决

## 题解1

基于上一题的直方图最大面积来做。

将矩阵的每一行作为直方图的底，统计高度，计算最大面积。

下移一行的时候，要更新直方图的高度。

```python
class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        if not matrix or not matrix[0]: return 0
        
        m, n = len(matrix), len(matrix[0])
        heights = [0] * n
        maxarea = 0
        for row in matrix:
            for i, c in enumerate(row):
                if c == '0':
                    heights[i] = 0
                else:
                    heights[i] += 1
            maxarea = max(maxarea, self.largestRectangleArea(heights))
        return maxarea
    
    def largestRectangleArea(self, heights: List[int]) -> int:
        def genML(n, H):
            # 统计每条bar的最左边界（≥本身）
            ML = list(range(n))  # 默认是自身
            # 使用单调递增队列，保存的是下标
            # 比如最后的两个下标i和j，那么[i+1, j-1]区间的值都比H[j]要大（≥）
            # 新来一个值，如果更大，那么入栈；否则，要弹出栈顶，更新ML
            stack = []
            for i, h in enumerate(H):
                while stack and h <= H[stack[-1]]:
                    # 持续消除
                    top = stack.pop()
                    ML[i] = ML[top]
                stack.append(i)
            return ML
        
        n = len(heights)
        
        # 统计每条bar的最左边界（≥本身）
        ML = genML(n, heights)
        
        # 对应地，统计最远右边界，倒转过来就行
        MR = genML(n, heights[::-1])
        MR = [n-1-MR[i] for i in range(n)][::-1]  # 下标倒转回来

        # 针对每条bar，计算对应的最大面积
        return max([heights[i] * (MR[i] - ML[i] + 1) for i in range(n)], default=0)
```