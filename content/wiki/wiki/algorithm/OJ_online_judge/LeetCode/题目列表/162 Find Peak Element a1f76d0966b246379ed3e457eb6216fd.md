---
title: 162_Find_Peak_Element_a1f76d0966b246379ed3e457eb6216fd
---

# 162. Find Peak Element

Difficulty: Medium
ID: 162
Solved?: Yes
Tags: Array, Binary Search
击败: 99.7
推荐指数: ⭐⭐⭐⭐

[Find Peak Element - LeetCode](https://leetcode.com/problems/find-peak-element/)

## 题意

A peak element is an element that is greater than its neighbors.

Given an input array `nums`, where `nums[i] ≠ nums[i+1]`, find a peak element and return its index.

The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.

You may imagine that `nums[-1] = nums[n] = -∞`.

**Example 1:**

```
Input: nums = [1,2,3,1]
Output: 2
Explanation: 3 is a peak element and your function should return the index number 2.
```

**Example 2:**

```
Input: nums = [1,2,1,3,5,6,4]
Output: 1 or 5 
Explanation: Your function can return either index number 1 where the peak element is 2, 
             or index number 5 where the peak element is 6.

```

**Follow up:** Your solution should be in logarithmic complexity.

## 思路

1. 一遍扫描，或者说最大值
2. 二分搜索：因为相邻元素不相等，所以总是可以比较出大小。如果左边的小了，右边的也小，那么就找到了；反之，右边的是大的，那么就往右挪，也就是寻找更高的。

## 题解

```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        L, R = 0, len(nums) - 1
        while L <= R:
            M = (L + R) // 2
            left_ok = (M == 0) or (nums[M] > nums[M-1])
            right_ok = (M == len(nums) - 1) or (nums[M] > nums[M+1])
            if left_ok and right_ok: return M
            if left_ok: L = M + 1
            else: R = M - 1
```

击败73.75%

## ★题解：二分模板

```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        L, R = 0, len(nums) - 1
        while L <= R:
            M = (L + R) // 2
            if (M < len(nums) - 1) and (nums[M] < nums[M+1]):
                L = M + 1
            else:
                R = M - 1
        return L
```

击败97.98%

核心：思考L向右推进的基础是什么。看到更高的峰。如果保障L=M+1是合理的。

注意判断条件。常规情况下，L指向的元素一直满足山峰的左边条件，寻找的是满足右边条件。期望退出循环时L指向的元素要比右边的大，那么在循环里它的判断条件反一下。

当然，也可以反过来将R作为最终结果。

---

2020-10-28 14:46:06 思考退出时R的条件。

1. 退出时，A[R]比左边的大，比如<2, 4>，R指向4。那么我们期望最终是类似<2, 4, 3>，R指向4，L指向3，结果则是返回R。
2. 退出时，A[R]比右边的小，比如<2, 4>，R指向2。那么我们期望最终是类似<2, 4, 3>，R指向2，L指向4，结果则是返回L。
3. 另外两种情况，A[R]比左边的小，A[R]比右边的大，并没什么意义。

---

2020-10-28 15:16:25，接上

1. 退出时，A[R]比左边的大。拿这个作为判断条件，得到的结果是A[L]比左边的小（反）。类似<2, 4, 3>，R指向4，L指向3，R刚好符合预期。
    
    其实，退出循环时，肯定能保证A[L]比左边的小，但A[R]比左边的大需要进一步证明。
    
2. 退出时，A[R]比右边的小。拿这个作为判断条件，得到的结果是A[L]比左边的大（反）。类似<2, 4, 3>，R指向2，L指向4，L刚好符合预期。
3. 退出时，A[R]比左边的小。拿这个作为判断条件，得到的结果是A[L]比左边的大（反）。类似<4, 2, 3>，R指向2，L指向3，变成了洼地。
4. 退出时，A[R]比右边的大。拿这个作为判断条件，得到的结果是A[L]比右边的小（反）。类似<4, 2, 3>，R指向4，L指向2，变成了洼地。

---

返回R：注意if的判断条件

```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        L, R = 0, len(nums) - 1
        while L <= R:
            M = (L + R) // 2
            if (M == 0) or nums[M] > nums[M-1]:
                L = M + 1
            else:
                R = M - 1
        return R
```

击败99.70%

## 题解：[L, R]始终保存结果

```python
class Solution:
    def findPeakElement(self, nums: List[int]) -> int:
        # 73.75%
        # <3[M], 2>
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R) // 2
            if (M < len(nums) - 1) and nums[M] > nums[M+1]:
                R = M
            else:
                L = M + 1
        return L

    def findPeakElement1(self, nums: List[int]) -> int:
        # 73.75%
        # <2[M], 3>
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R) // 2
            if (M < len(nums) - 1) and nums[M] < nums[M+1]:
                L = M + 1
            else:
                R = M
        return L

    def findPeakElement2(self, nums: List[int]) -> int:
        # 91.33%
        # <2, 3[M]>
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R + 1) // 2
            if M == 0 or nums[M] > nums[M-1]:
                L = M
            else:
                R = M - 1
        return L

    def findPeakElement3(self, nums: List[int]) -> int:
        # 97.98%
        # <3, 2[M]>
        L, R = 0, len(nums) - 1
        while L < R:
            M = (L + R + 1) // 2
            if (M > 0) and nums[M] < nums[M-1]:
                R = M - 1
            else:
                L = M
        return L
```