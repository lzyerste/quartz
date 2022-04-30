---
title: 84_Largest_Rectangle_in_Histogram_18812cd530d149258528d978dd390e9c
---

# 84. Largest Rectangle in Histogram

Difficulty: Hard
ID: 84
Solved?: Yes
Tags: Stack
击败: 21.08
推荐指数: ⭐⭐⭐⭐⭐

[Largest Rectangle in Histogram - LeetCode](https://leetcode.com/problems/largest-rectangle-in-histogram/)

## 题意

## 思路

- 暴力，左右边界确定底，再确定该区间的高（最小值）。超时
- 针对每条bar（作为矩形的最小高度），尽量向左跟向右延伸（高度要不小于），得到最大宽度。

## 题解1：暴力，超时

minHeight()得到区间[i,j]之间的最低高度。

```python
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        def minHeight(G, H, i, j):
            p = i, j
            if p in G: return G[p]
            if i == j: return H[i]  # 其实已经在外边初始化了
            G[p] = min(H[i], minHeight(G, H, i+1, j))
            return G[p]
        
        maxArea = 0
        G = {(i, i): h for i, h in enumerate(heights)}
        n = len(heights)
        for i in range(n):
            for j in range(i, n):
                maxArea = max(maxArea, (j-i+1) * minHeight(G, heights, i, j))
        return maxArea
```

## ★题解2：根据bar延伸边界

```python
class Solution:
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

击败21.08%

## 题解3：历史解法

```python
class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        maxarea = 0
        stack = []
        
        def elim(rt):
            nonlocal maxarea
            h = heights[stack.pop()]
            lf = stack[-1] if stack else -1
            w = rt - lf - 1
            maxarea = max(maxarea, w * h)
            
        i = 0
        while i < len(heights):
            if not stack or heights[i] > heights[stack[-1]]:
                stack.append(i)
                i += 1
            else:
                elim(i)
        while stack:
            elim(i)
        return maxarea
```

击败37.05%