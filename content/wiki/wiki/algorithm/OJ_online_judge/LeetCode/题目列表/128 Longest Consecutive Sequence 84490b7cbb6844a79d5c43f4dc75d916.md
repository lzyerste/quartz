---
title: 128_Longest_Consecutive_Sequence_84490b7cbb6844a79d5c43f4dc75d916
---

# 128. Longest Consecutive Sequence

Difficulty: Hard
ID: 128
Solved?: Yes
Tags: Array, Union Find
击败: 94.88
推荐指数: ⭐⭐⭐⭐

[Longest Consecutive Sequence - LeetCode](https://leetcode.com/problems/longest-consecutive-sequence/)

## 题意

Given an unsorted array of integers `nums`, return *the length of the longest consecutive elements sequence.*

**Follow up:** Could you implement the `O(n)` solution?

**Example 1:**

```
Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

```

**Example 2:**

```
Input: nums = [0,3,7,2,5,8,4,6,0,1]
Output: 9

```

**Constraints:**

- `0 <= nums.length <= 104`
- `109 <= nums[i] <= 109`

## 思路

1. 使用哈希表记录每个值目前连续的范围，[left, right]。注意是列表，该范围内的数都会指向这个列表区间对象（同一个引用）。遇到一个新的数k，默认自己是[k, k]。尝试与左邻居合并，注意左邻居的right边界要更新，最后k与右边界都指向同一个引用。右邻居类似处理。
2. 使用数组下标串成链表（next数组）。统计长度的时候，不一定会从链表头开始统计，可能从中间开始统计；如果前面的又开始统计（更长），就会导致重复统计。一个简单的方法是标记节点是否已经统计过，而且长度是多少。可以用负数表示已统计，绝对值表示从它开始的连续长度。
3. union find：相邻元素对应的集合可以union。
4. 假设数组已经排好序了，那么就是一段段不连续的区间。面对这些区间，我们统计的原则是从区间的最左端开始统计，一直向右直到断开。如果一个数在区间中间（它有左邻居），我们可以不理会它，因为知道它的左邻居会发现它。
    
    同样的思路，不需要对数组排序，只需要针对每一个数，先判断它是不是一个区间的最左端（很简单，比它小1的数不存在即可）。如果它不是区间左端，那么跳过不处理；如果它是区间左端，那么一个个数字连续往后排查，这样就能统计出区间的大小了。而区间中其他数字都不会触发统计，只有最左端触发一次统计，所以复杂度是O(N)，并不会有重复统计。
    

## 题解1：哈希

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        G = {}  # int -> [left, right]
        res = 0
        for k in nums:
            if k in G: continue
            G[k] = [k, k]
            if k - 1 in G:  # left neighbor
                lst = G[k - 1]
                lst[1] = G[k][1]  # expand right
                G[k] = G[lst[1]] = lst  # update reference
            if k + 1 in G:  # right neighbor
                lst = G[k + 1]
                lst[0] = G[k][0]  # expand left
                G[k] = G[lst[0]] = lst  # update reference
            left, right = G[k]
            res = max(res, right - left + 1)
        return res
```

击败94.88%，以前的纪录。

## 题解2：数组链表

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        G = {d:i for i, d in enumerate(nums)}  # reverse index
        **NEXT = [G[d+1] if (d+1) in G else -1 for d in nums]**
        
        def dfs(i):
            if NEXT[i] < 0: return abs(NEXT[i])
            count = 1 + dfs(NEXT[i])
            NEXT[i] = -count  # neg as visited
            return count
        
        return max([dfs(i) for i in range(len(nums))], default=0)
```

击败35.17%

字典G是值与下标的反向映射。

注意下NEXT数组的构造。它与nums数组对应，NEXT数组记录的是纯下标，NEXT[i]表示nums[i]+1（右邻居）在nums数组中的下标（如果存在的话）。如果不存在右邻居，那么NEXT[i]值为-1。负数表示已经访问过（dfs递归终止），1表示连续长度，因为没有右邻居，只有自己，自然是1了。

## 题解3：UF

```python
class UF:
    def __init__(self):
        self.P = {}  # parent
        self.S = {}  # size
    
    def find(self, x):
        if self.P[x] != x:
            self.P[x] = self.find(self.P[x])
        return self.P[x]
    
    def union(self, x, y):
        rx = self.find(x)
        ry = self.find(y)
        if rx != ry:
            self.P[rx] = ry
            self.S[ry] += self.S[rx]
        
    def add(self, x):
        if x in self.P: return
        self.P[x] = x
        self.S[x] = 1
        if x - 1 in self.P:
            self.union(x, x - 1)
        if x + 1 in self.P:
            self.union(x, x + 1)
    
    def maxSize(self):
        return max(self.S.values(), default=0)

class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        uf = UF()
        for x in nums:
            uf.add(x)
        return uf.maxSize()
```

击败30.39%

## 题解4：区间左边界触发统计

```python
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        MAX = 0
        aset = set(nums)
        for x in nums:
            if x - 1 in aset: continue
            # x is a left border of a range
            count = 0
            while x in aset:
                count += 1
                x += 1
            MAX = max(MAX, count)
        return MAX
```

击败84.44%