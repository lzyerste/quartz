---
title: 33_Search_in_Rotated_Sorted_Array_34995e6fdd004df9bdcd1888167627f3
---

# 33. Search in Rotated Sorted Array

Difficulty: Medium
ID: 33
Solved?: Yes
Tags: Array, Binary Search
击败: 99.17
推荐指数: ⭐⭐⭐⭐⭐

[Search in Rotated Sorted Array - LeetCode](https://leetcode.com/problems/search-in-rotated-sorted-array/)

## 题意

假设按照升序排序的数组在预先未知的某个点上进行了旋转。

( 例如，数组 `[0,1,2,4,5,6,7]` 可能变为 `[4,5,6,7,0,1,2]` )。

搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 `-1` 。

你可以假设数组中不存在重复的元素。

你的算法时间复杂度必须是 *O*(log *n*) 级别。

**示例 1:**

```
输入: nums = [4,5,6,7,0,1,2], target = 0
输出: 4
```

**示例 2:**

```
输入: nums = [4,5,6,7,0,1,2], target = 3
输出: -1
```

## 思路

- 直接在旋转数组里二分搜索
- 先找到转折点（最小值），然后在左右其中一个进行常规二分搜索

## 题解1：直接二分搜索

中值M是趋向于L的，将M归于左边部分。

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        def bsearch(nums, L, R, T):
            while L <= R:
                M = (L + R) // 2
                if nums[M] == T:
                    return M
                elif nums[L] <= nums[M]:  # 左部分递增，注意等号
                    if nums[L] <= T <= nums[M]:
                        R = M - 1
                    else:
                        L = M + 1
                else:  # 右部分递增
                    if nums[M] <= T <= nums[R]:
                        L = M + 1
                    else:
                        R = M - 1
            return -1
        
        return bsearch(nums, 0, len(nums) - 1, target)
```

击败19.38%

主要是里面比较太多了，复杂度的常数项系数比较大。

## 题解2：转折点，再二分

相当于做了两次二分，注意while的判断条件区分。

findMin中的二分，我们是明确最小值是肯定存在的（数组不为空情况下），区间范围为[L, R]。

退出条件设置为L < R，退出的时候，L==R，指向的就是最小值。

注意nums[M]是与nums[R]比较，而不是与nums[L]比较，因为数组整体上是从左到右递增的。

```python
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        def findMin(nums, L, R):
            while L < R:  # 停止的时候L==R
                M = (L + R) // 2
                if nums[M] < nums[R]:  # 递增
                    R = M
                else:
                    L = M + 1
            return L
        
        def bsearch(nums, L, R):
            while L <= R:
                M = (L + R) // 2
                if nums[M] < target:
                    L = M + 1
                elif nums[M] > target:
                    R = M - 1
                else:
                    return M
            return -1
        
        if not nums: return -1
        
        index = findMin(nums, 0, len(nums) - 1)
        if nums[index] <= target <= nums[-1]:
            return bsearch(nums, index, len(nums) - 1)
        return bsearch(nums, 0, index - 1)
```