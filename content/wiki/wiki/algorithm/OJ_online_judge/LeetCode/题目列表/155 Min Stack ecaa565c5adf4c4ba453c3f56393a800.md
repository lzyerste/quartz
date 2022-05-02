---
title: 155_Min_Stack_ecaa565c5adf4c4ba453c3f56393a800
---

# 155. Min Stack

Difficulty: Easy
ID: 155
Solved?: Yes
Tags: Design, Stack
推荐指数: ⭐⭐⭐⭐

[Min Stack - LeetCode](https://leetcode.com/problems/min-stack/)

## 题意

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

- push(x) -- Push element x onto stack.
- pop() -- Removes the element on top of the stack.
- top() -- Get the top element.
- getMin() -- Retrieve the minimum element in the stack.

**Example 1:**

```
Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[155 Min Stack ecaa565c5adf4c4ba453c3f56393a800](.md)

Output
[null,null,null,null,-3,null,0,-2]

Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2

```

**Constraints:**

- Methods `pop`, `top` and `getMin` operations will always be called on **non-empty** stacks.

## 思路

1. 需要记录历史push过程中出现的最小值。也就是说，当新的最小值（包括相等）出现时，要保留以前的最小值，而把新的最小值放到顶端。这么做的话，当开始pop的时候，如果被pop的值是最小值，那么需要找到次小值（从历史记录中找）。最小值的维护使用stack结构。所以，这里使用了两个堆栈，一个用于常规数据操作，一个用于最小值的维护。
2. 也可以将两者整合为一个stack，只需要在新的最小值出现时，先入栈旧的最小值，然后再入栈数据元素（同时也是新的最小值），同步更新当前最小值。当pop出的值等于当前最小值时，需要再pop一次，作为之后的最小值。

## 题解1

```python
class MinStack(object):
    def __init__(self):
        """
        initialize your data structure here.
        """
        self.stack = []
        self.min_stack = [float("inf")]
        self.min = self.min_stack[-1]
 
    def push(self, x):
        """
        :type x: int
        :rtype: void
        """
        self.stack.append(x)
        if x <= self.min:
            self.min = x
            self.min_stack.append(x)
 
    def pop(self):
        """
        :rtype: void
        """
        top = self.stack.pop()
        if top == self.min:
            self.min_stack.pop()
            self.min = self.min_stack[-1]
 
    def top(self):
        """
        :rtype: int
        """
        if self.stack:
            return self.stack[-1]
 
    def getMin(self):
        """
        :rtype: int
        """
        if self.stack:
            return self.min
```

## 题解2

```python
class MinStack(object):
    def __init__(self):
        """
        initialize your data structure here.
        """
        self.stack = []
        self.min = float("inf")
 
    def push(self, x):
        """
        :type x: int
        :rtype: void
        """
        if x <= self.min:
            self.stack.append(self.min)
            self.min = x
        self.stack.append(x)
 
    def pop(self):
        """
        :rtype: void
        """
        top = self.stack.pop()
        if top == self.min:
            self.min = self.stack.pop()
 
    def top(self):
        """
        :rtype: int
        """
        return self.stack[-1]
 
    def getMin(self):
        """
        :rtype: int
        """
        return self.min
```