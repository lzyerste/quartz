---
title: 26_Remove_Duplicates_from_Sorted_Array_24c645a23c9c4412916ef0900f60b7ab
---

# 26. Remove Duplicates from Sorted Array

Difficulty: Easy
ID: 26
Solved?: Yes
Tags: Array, Two Pointers
击败: 79.42
推荐指数: ⭐⭐

[Remove Duplicates from Sorted Array - LeetCode](https://leetcode.com/problems/remove-duplicates-from-sorted-array/)

## 题意

给定一个`排序数组`，你需要在**`原地**删除重复`出现的元素，使得每个元素只出现一次，返回移除后数组的新长度。

不要使用额外的数组空间，你必须在**原地修改输入数组**并在使用 O(1) 额外空间的条件下完成。

**示例 1:**

```
给定数组 nums = [1,1,2], 

函数应该返回新的长度 2, 并且原数组 nums 的前两个元素被修改为 1, 2。 

你不需要考虑数组中超出新长度后面的元素。
```

**示例 2:**

```
给定 nums = [0,0,1,1,1,2,2,3,3,4],

函数应该返回新的长度 5, 并且原数组 nums 的前五个元素被修改为 0, 1, 2, 3, 4。

你不需要考虑数组中超出新长度后面的元素。
```

**说明:**

为什么返回数值是整数，但输出的答案是数组呢?

请注意，输入数组是以**“引用”**方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。

你可以想象内部操作如下:

```c
// nums 是以“引用”方式传递的。也就是说，不对实参做任何拷贝
int len = removeDuplicates(nums);

// 在函数里修改输入数组对于调用者是可见的。
// 根据你的函数返回的长度, 它会打印出数组中该长度范围内的所有元素。
for (int i = 0; i < len; i++) {
    print(nums[i]);
}
```

## 思路

- 常规双指针

## 题解1：双指针

i指向的是已整理好的结果数组的末尾，inclusive。

```python
class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        if not nums: return 0
        
        i = 0
        for d in nums:
            if d != nums[i]:
                i += 1
                nums[i] = d
        return i + 1
```

## 题解1变种

如果让i指向的是下一个存放结果的位置（exclusive），使用另一个变量pre表示结果数组的最后一个元素。这样就一开始不用判断nums是否为空。

```python
class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:
        i, pre = 0, None
        for d in nums:
            if d == pre: continue
            pre = d
            nums[i] = d
            i += 1
        return i
```