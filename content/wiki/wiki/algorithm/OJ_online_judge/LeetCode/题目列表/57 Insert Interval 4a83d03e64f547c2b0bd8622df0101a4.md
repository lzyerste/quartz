---
title: 57_Insert_Interval_4a83d03e64f547c2b0bd8622df0101a4
---

# 57. Insert Interval

Difficulty: Hard
ID: 57
Solved?: Yes
Tags: Array, Binary Search, Sort
击败: 31.61
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/insert-interval/)

## 题意

## 题解：二分搜索

二分搜索两次，最左边与最右边，可能的交集。

比如最左边，可能刚好有个交集（hit），如果没有交集的，那就找右边的最接近它的。

```
[[1,3],[6,9]]
```

如果新来的是[2, 5]，那么2刚好落在[1, 3]。

如果新来的是[4, 5]，那么应该选取[6, 9]，因为与[1, 3]不可能有交集。

```python
# Definition for an interval.
# class Interval:
#     def __init__(self, s=0, e=0):
#         self.start = s
#         self.end = e

class Solution:
    def insert(self, intervals: List[Interval], newInterval: Interval) -> List[Interval]:
        # most left, A[L] >= T
        A = intervals
        n = len(intervals)
        L, R = 0, n - 1
        T = newInterval.start
        while L <= R:
            M = (L + R) // 2
            if A[M].end < T:
                L = L + 1
            else:
                R = M - 1
        idx1 = L
        # most right, A[R] <= T
        L, R = 0, n - 1
        T = newInterval.end
        while L <= R:
            M = (L + R) // 2
            if A[M].start > T:
                R = M - 1
            else:
                L = M + 1
        idx2 = R
        
        if 0 <= idx1 < n:
            newInterval.start = min(newInterval.start, A[idx1].start)
        if 0 <= idx2 < n:
            newInterval.end = max(newInterval.end, A[idx2].end)
        
        intervals[idx1:idx2+1] = [newInterval]
        return intervals
```