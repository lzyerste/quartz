---
title: 51_N-Queens_c98bbda0e41c4fcc866444efafd8f5be
---

# 51. N-Queens

Difficulty: Hard
ID: 51
Solved?: Yes
Tags: Backtracking
击败: 16.61
推荐指数: ⭐⭐⭐⭐

[N-Queens - LeetCode](https://leetcode.com/problems/n-queens/)

## 题意

## 题解1：回溯

先放置第一行，然后放置下一行，放置的时候要判断当前是否存在冲突（记录之前的坐标）。

现在是无脑判断冲突，这里有优化的空间。

[](https://leetcode.com/problems/n-queens/discuss/19810/Fast-short-and-easy-to-understand-python-solution-11-lines-76ms)

```python
class Solution:
    def solveNQueens(self, n: int) -> List[List[str]]:
        def genBoard(poses, n):
            board = [["." for c in range(n)] for r in range(n)]
            for r, c in poses:
                board[r][c] = "Q"
            return ["".join(row) for row in board]
        
        def conflict(r0, c0, r1, c1):
            return r0 == r1 or c0 == c1 or abs(r0 - r1) == abs(c0 - c1)
    
        def bp(res, poses, r, n):
            # poses: [(0, 1), (1, 3), ..]
            if r == n:
                # done
                res.append(genBoard(poses, n))
                return
            for c in range(n):
                if not any(conflict(r0, c0, r, c) for r0, c0 in poses):
                    # no conflict
                    poses.append((r, c))
                    bp(res, poses, r + 1, n)
                    poses.pop()
        
        res = []
        bp(res, [], 0, n)
        return res
```