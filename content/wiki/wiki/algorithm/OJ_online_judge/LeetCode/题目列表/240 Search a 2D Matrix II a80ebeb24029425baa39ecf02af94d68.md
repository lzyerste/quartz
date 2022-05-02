---
title: 240_Search_a_2D_Matrix_II_a80ebeb24029425baa39ecf02af94d68
---

# 240. Search a 2D Matrix II

Difficulty: Medium
ID: 240
Solved?: Yes
Tags: Binary Search, Divide and Conquer
击败: 67.58
推荐指数: ⭐⭐⭐⭐

[Search a 2D Matrix II - LeetCode](https://leetcode.com/problems/search-a-2d-matrix-ii/)

## 题意

Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

- Integers in each row are sorted in ascending from left to right.
- Integers in each column are sorted in ascending from top to bottom.

**Example:**

Consider the following matrix:

```
[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]

```

Given target = `5`, return `true`.

Given target = `20`, return `false`.

## 思路

1. 二分法：将搜索区间分为4块，如果中间元素比目标小，那么左上角那一块都比目标小，不用继续搜索，剩余的三块继续搜索；如果中间元素比目标大，那么右下角那一块都比目标大，不用继续搜索，剩余的三块继续搜搜；如果中间元素与目标相等，那么就是找打了。
    
    实际上，矩阵中可以存在多个与目标相同的元素，我们使用or关系，找到一个就结束了。
    
    不需要DP记忆，因为实际上是分治法，彼此没有重叠子结构。
    
    如果待搜索矩阵比较小了，直接暴力搜，这样就不用计较边界到底属于谁的问题了。
    
2. 分治法：从右上角开始搜索，如果比目标小，那么需要往下走；如果比目标大，那么需要往左走。

## 题解1：二分法

```python
class Solution:
    def searchMatrix(self, matrix, target):
        """
        :type matrix: List[List[int]]
        :type target: int
        :rtype: bool
        """
        def dfs(p1, p2):
            r1, c1 = p1
            r2, c2 = p2
            
            # small case
            if (r2 - r1 + 1) * (c2 - c1 + 1) <= 9:
                for r in range(r1, r2+1):
                    for c in range(c1, c2+1):
                        if matrix[r][c] == target: return True
                return False
            
            Mr, Mc = (r1 + r2) // 2, (c1 + c2) // 2
            ele = matrix[Mr][Mc]
            if ele == target:
                return True
            elif ele < target:
                return dfs((r1, Mc + 1), (Mr, c2)) or dfs((Mr+1, c1), (r2, Mc)) or dfs((Mr+1, Mc+1), (r2, c2))
            else:
                return dfs((r1, c1), (Mr-1, Mc)) or dfs((r1, Mc+1), (Mr-1, c2)) or dfs((Mr, c1), (r2, Mc-1))
        
        if not matrix or not matrix[0]: return False
        M, N = len(matrix), len(matrix[0])
        return dfs((0, 0), (M-1, N-1))
```

击败22.07%

## 题解2：分治法

```python
class Solution:
    def searchMatrix(self, matrix, target):
        """
        :type matrix: List[List[int]]
        :type target: int
        :rtype: bool
        """
        if not matrix or not matrix[0]: return False

        M, N = len(matrix), len(matrix[0])
        r, c = 0, N-1  # right up
        while r < M and c >= 0:
            elem = matrix[r][c]
            if elem == target:
                return True
            elif elem < target:
                r += 1
            elif elem > target:
                c -= 1
        return False
```

击败67.58%