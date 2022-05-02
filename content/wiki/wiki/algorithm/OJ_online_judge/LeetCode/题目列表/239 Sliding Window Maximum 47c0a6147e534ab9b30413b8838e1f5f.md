---
title: 239_Sliding_Window_Maximum_47c0a6147e534ab9b30413b8838e1f5f
---

# 239. Sliding Window Maximum

Difficulty: Hard
ID: 239
Solved?: Yes
Tags: Heap, Sliding Window
击败: 57.56
推荐指数: ⭐⭐⭐⭐

[Sliding Window Maximum - LeetCode](https://leetcode.com/problems/sliding-window-maximum/)

## 题意

You are given an array of integers `nums`, there is a sliding window of size `k` which is moving from the very left of the array to the very right. You can only see the `k` numbers in the window. Each time the sliding window moves right by one position.

Return *the max sliding window*.

**Example 1:**

```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation: 
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
```

**Example 2:**

```
Input: nums = [1], k = 1
Output: [1]

```

**Example 3:**

```
Input: nums = [1,-1], k = 1
Output: [1,-1]

```

**Example 4:**

```
Input: nums = [9,11], k = 2
Output: [11]

```

**Example 5:**

```
Input: nums = [4,-2], k = 2
Output: [4]

```

**Constraints:**

- `1 <= nums.length <= 105`
- `104 <= nums[i] <= 104`
- `1 <= k <= nums.length`

## 思路

滑动条件是窗口的长度小于k。j一直往前，直到破坏条件，也就是使得窗口的长度刚好等于k；然后i一直往前（其实也就一次），直到窗口长度重新小于k。

1. 滑动窗口+最大堆：在一个合法的窗口中，通过最大堆获取该窗口的最大值。注意，堆中含有过期的数据，所以要检查下标是否合法。
2. 滑动窗口+max stack：维护窗口里的元素形成max stack，也就是stack里是从大到小（可以相等）的顺序，进来一个元素，比前面的值大，那么就把前面的元素pop掉。那么，窗口里的最大元素总是stack[0]。i往前挪的时候，有可能stack[0]那个元素刚好要过期，所以要检查下它是否与stack[j-k]相等。相等的话就popleft删掉。

## 题解1：最大堆

```python
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        res = []
        Q = []
        heapq.heapify(Q)
        i = j = 0
        while j < len(nums):
            heapq.heappush(Q, (-nums[j], j))
            j += 1
            while j - i == k:
                while True:
                    x, y = Q[0]  # top
                    if y < j - k:  # too old item
                        heapq.heappop(Q)
                    else:
                        res.append(-x)
                        break
                i += 1
        return res
```

击败14.75

## 题解2：max stack

```python
class Solution:
    def maxSlidingWindow(self, nums: List[int], k: int) -> List[int]:
        from collections import deque
        n = len(nums)
        res = []
        stk = deque([])
        i = j = 0
        while j < len(nums):
            while stk and nums[j] > stk[-1]:
                stk.pop()
            stk.append(nums[j])
            j += 1
            while j - i == k:
                res.append(stk[0])
                if stk[0] == nums[j-k]:
                    stk.popleft()  # become old
                i += 1
        return res
```

击败57.56%