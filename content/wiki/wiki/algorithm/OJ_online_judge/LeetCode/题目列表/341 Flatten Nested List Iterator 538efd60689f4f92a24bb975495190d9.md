---
title: 341_Flatten_Nested_List_Iterator_538efd60689f4f92a24bb975495190d9
---

# 341. Flatten Nested List Iterator

Difficulty: Medium
ID: 341
Solved?: Yes
Tags: Design, Stack
推荐指数: ⭐⭐⭐

[Flatten Nested List Iterator - LeetCode](https://leetcode.com/problems/flatten-nested-list-iterator/)

## 题意

Given a nested list of integers, implement an iterator to flatten it.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

**Example 1:**

```
Input: [1,1](1,1)
Output: [1,1,2,1,1]
Explanation: By calling next repeatedly until hasNext returns false, 
             the order of elements returned by next should be: [1,1,2,1,1].
```

**Example 2:**

```
Input: [1,[4,[6]]]
Output: [1,4,6]
Explanation: By calling next repeatedly until hasNext returns false, 
             the order of elements returned by next should be: [1,4,6].

```

## 思路

1. 直接一次性全部展开。
2. 用到时才展开。如果是Integer，那么可以直接消费掉；如果是List，那么只展开一层，如果展开后首个还是List，那么继续展开。

## 题解1：全部展开

```python
def convert(nestedList):
    result = []
    for item in nestedList:
        if item.isInteger():
            result += [item.getInteger()]
        else:
            result += convert(item.getList())
    return result

class NestedIterator1(object):
    def __init__(self, nestedList):
        """
        Initialize your data structure here.
        :type nestedList: List[NestedInteger]
        """
        self.lst = convert(nestedList)
        self.idx = 0
        
    def next(self):
        """
        :rtype: int
        """
        val = self.lst[self.idx]
        self.idx += 1
        return val
        
    def hasNext(self):
        """
        :rtype: bool
        """
        return self.idx < len(self.lst)
```

## 题解2：lazy

```python
# """
# This is the interface that allows for creating nested lists.
# You should not implement it, or speculate about its implementation
# """
#class NestedInteger(object):
#    def isInteger(self):
#        """
#        @return True if this NestedInteger holds a single integer, rather than a nested list.
#        :rtype bool
#        """
#
#    def getInteger(self):
#        """
#        @return the single integer that this NestedInteger holds, if it holds a single integer
#        Return None if this NestedInteger holds a nested list
#        :rtype int
#        """
#
#    def getList(self):
#        """
#        @return the nested list that this NestedInteger holds, if it holds a nested list
#        Return None if this NestedInteger holds a single integer
#        :rtype List[NestedInteger]
#        """

class NestedIterator(object):
    def __init__(self, nestedList):
        """
        Initialize your data structure here.
        :type nestedList: List[NestedInteger]
        """
        self.stack = nestedList[::-1]

    def next(self):
        """
        :rtype: int
        """
        return self.stack.pop().getInteger()

    def hasNext(self):
        """
        :rtype: bool
        """
        while self.stack:
            top = self.stack[-1]
            if top.isInteger():
                return True
            top = self.stack.pop().getList()
            self.stack += top[::-1]
        return False
```