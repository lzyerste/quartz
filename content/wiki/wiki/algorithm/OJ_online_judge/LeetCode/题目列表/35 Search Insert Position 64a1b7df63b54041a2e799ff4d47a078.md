---
title: 35_Search_Insert_Position_64a1b7df63b54041a2e799ff4d47a078
---

# 35. Search Insert Position

Difficulty: Easy
ID: 35
Solved?: Yes
Tags: Array, Binary Search
击败: 91.23
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/search-insert-position/)

[https://leetcode.com/problems/search-insert-position/](https://leetcode.com/problems/search-insert-position/)

## 题意

给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。

你可以假设数组中`无重复`元素。

**示例 1:**

```
输入: [1,3,5,6], 5
输出: 2
```

**示例 2:**

```
输入: [1,3,5,6], 2
输出: 1
```

**示例 3:**

```
输入: [1,3,5,6], 7
输出: 4
```

**示例 4:**

```
输入: [1,3,5,6], 0
输出: 0
```

## 思路

- 二分搜索。
- 顺序遍历，找到首个不比target小的元素。

## 题解1：二分

如果二分找到了，那么直接返回下标。

如果没找到呢，插入点应该是L还是R？

另外，是否需要额外考虑数组是否为空，target是否为最小，最大等情况？

这里，需要返回的是L。

考虑二分逼近，最后只剩2个元素（1个元素也类似）：X，Y。L指向X，R指向Y。

如果target的值介于X和Y之间，那么，二分搜索结束时，L指向了Y，R指向了X。target要插入的地方应该是替代Y，然后将Y往后挪，现在指向Y的正是L。

---

一开始，我们假定nums[L] ≤ target ≤ nums[R]，如果找不到target，退出时，nums[R] < target < nums[L]，所以也是target放到L，原来的L往后挪。

如果target的值最大，比所有元素都大，最后停止时R指向最后一个元素，L指向最后一个元素的后一个位置，就好像数组后面还有一个元素，这个元素的值是无穷大，nums[R] < target < nums[L]式子仍然成立。

如果target的值最小，那么相当于数组左边还有个无穷小的元素。

如果数组为空，那么，就好像左边有个无穷小，右边有个无穷大。L指向0，R指向-1。

```python
class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        def bsearch(nums, L, R, T):
            while L <= R:
                M = (L + R) // 2
                if nums[M] < T:
                    L = M + 1
                elif nums[M] > T:
                    R = M - 1
                else:  # found
                    return M
            return L  # insert position, target < A[L]
        
        return bsearch(nums, 0, len(nums) - 1, target)
```

## 题解2：不同理解的二分

2019-04-08 22:39:40

```python
class Solution:
    def searchInsert(self, nums: List[int], target: int) -> int:
        # 如果找到，那么就是该位置。
        # 如果没找到，那么应该停留在比它大的位置。
        # 综合起来，停止的时候，A[L] >= T，A[R] < T，返回L。
        # 如果有重复值，那么就会停留在hit的最左位置。
        def bsearch(A, L, R, T):
            while L <= R:
                M = (L + R) // 2
                if A[M] < T:  # 不符合A[L] >= T
                    L = M + 1
                else:  # 相等情况也不用特殊处理
                    R = M - 1
            return L
        
        return bsearch(nums, 0, len(nums) - 1, target)
```