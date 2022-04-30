---
title: 52_N-Queens_II_c38fcb89ce8b42aba937a86a7874ea0a
---

# 52. N-Queens II

Difficulty: Hard
ID: 52
Solved?: Yes
Tags: Backtracking
击败: 11.14
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/n-queens-ii/)

## 题意

## 题解1：回溯

统计个数，参考 [51. N-Queens](51%20N-Queens%20c98bbda0e41c4fcc866444efafd8f5be.md) 就行。

```python
class Solution:
    def totalNQueens(self, n: int) -> int:
        def conflict(r0, c0, r1, c1):
            return r0 == r1 or c0 == c1 or abs(r0 - r1) == abs(c0 - c1)
    
        def bp(poses, r, n):
            # poses: [(0, 1), (1, 3), ..]
            if r == n:
                # done
                return 1
            cnt = 0
            for c in range(n):
                if not any(conflict(r0, c0, r, c) for r0, c0 in poses):
                    # no conflict
                    poses.append((r, c))
                    cnt += bp(poses, r + 1, n)
                    poses.pop()
            return cnt
        
        return bp([], 0, n)
```