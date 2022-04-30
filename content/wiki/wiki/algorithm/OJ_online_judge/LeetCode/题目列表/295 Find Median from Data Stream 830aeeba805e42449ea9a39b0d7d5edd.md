---
title: 295_Find_Median_from_Data_Stream_830aeeba805e42449ea9a39b0d7d5edd
---

# 295. Find Median from Data Stream

Difficulty: Hard
ID: 295
Solved?: Yes
Tags: Design, Heap
击败: 77.66
推荐指数: ⭐⭐⭐⭐

[Find Median from Data Stream - LeetCode](https://leetcode.com/problems/find-median-from-data-stream/)

## 题意

Median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value. So the median is the mean of the two middle value.

For example,

`[2,3,4]`, the median is `3`

`[2,3]`, the median is `(2 + 3) / 2 = 2.5`

Design a data structure that supports the following two operations:

- void addNum(int num) - Add a integer number from the data stream to the data structure.
- double findMedian() - Return the median of all elements so far.

**Example:**

```
addNum(1)
addNum(2)
findMedian() -> 1.5
addNum(3) 
findMedian() -> 2

```

**Follow up:**

1. If all integer numbers from the stream are between 0 and 100, how would you optimize it?
2. If 99% of all integer numbers from the stream are between 0 and 100, how would you optimize it?

## 思路

1. 使用两个堆，小的用最大堆，大的用最小堆，大小相差保持不超过1（比如宁愿让大的多1）。中位数就在两个堆的top元素。插入元素时，如果右堆多1个，那么先插入右堆，然后匀一个给左堆；如果左右堆大小一样，那么先插入左端，然后匀一个给右堆。这么做的原因是免去判断堆是否为空，还有元素跟左右堆top元素的大小关系，在匀一个操作之前至少保证了该堆非空。
    
    如果元素越加越多，存储开销？
    

## 题解

```python
from heapq import *

class MedianFinder:

    def __init__(self):
        """
        initialize your data structure here.
        """
        self.heapL = []  # max heap
        self.heapR = []  # min heap

    def addNum(self, num: int) -> None:
        # leftL or leftR may be empty
        if len(self.heapR) > len(self.heapL):
            # insert to right and adjust
            heappush(self.heapR, num)
            x = heappop(self.heapR)
            heappush(self.heapL, -x)
        else:
            # insert to left and adjust
            heappush(self.heapL, -num)
            x = heappop(self.heapL)
            heappush(self.heapR, -x)

    def findMedian(self) -> float:
        right = self.heapR[0]
        if len(self.heapL) != len(self.heapR):
            return right
        left = -self.heapL[0]
        return (left + right) / 2

# Your MedianFinder object will be instantiated and called as such:
# obj = MedianFinder()
# obj.addNum(num)
# param_2 = obj.findMedian()
```

击败77.66%