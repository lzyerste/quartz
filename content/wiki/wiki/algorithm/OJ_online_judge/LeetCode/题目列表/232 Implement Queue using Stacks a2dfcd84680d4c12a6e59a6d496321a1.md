---
title: 232_Implement_Queue_using_Stacks_a2dfcd84680d4c12a6e59a6d496321a1
---

# 232. Implement Queue using Stacks

Difficulty: Easy
ID: 232
Solved?: Yes
Tags: Design, Stack
击败: 50.37
推荐指数: ⭐⭐⭐

[Implement Queue using Stacks - LeetCode](https://leetcode.com/problems/implement-queue-using-stacks/)

[225. Implement Stack using Queues](225 Implement Stack using Queues d7e6996648b449489a25fd7786b3178e.md) 

## 题意

Implement a first in first out (FIFO) queue using only two stacks. The implemented queue should support all the functions of a normal queue (`push`, `peek`, `pop`, and `empty`).

Implement the `MyQueue` class:

- `void push(int x)` Pushes element x to the back of the queue.
- `int pop()` Removes the element from the front of the queue and returns it.
- `int peek()` Returns the element at the front of the queue.
- `boolean empty()` Returns `true` if the queue is empty, `false` otherwise.

**Notes:**

- You must use **only** standard operations of a stack, which means only `push to top`, `peek/pop from top`, `size`, and `is empty` operations are valid.
- Depending on your language, the stack may not be supported natively. You may simulate a stack using a list or deque (double-ended queue) as long as you use only a stack's standard operations.

**Follow-up:** Can you implement the queue such that each operation is **[amortized](https://en.wikipedia.org/wiki/Amortized_analysis)** `O(1)` time complexity? In other words, performing `n` operations will take overall `O(n)` time even if one of those operations may take longer.

**Example 1:**

```
Input
["MyQueue", "push", "push", "peek", "pop", "empty"]
[232 Implement Queue using Stacks a2dfcd84680d4c12a6e59a6d496321a1](.md)
Output
[null, null, null, 1, 1, false]

Explanation
MyQueue myQueue = new MyQueue();
myQueue.push(1); // queue is: [1]
myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
myQueue.peek(); // return 1
myQueue.pop(); // return 1, queue is [2]
myQueue.empty(); // return false

```

**Constraints:**

- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `peek`, and `empty`.
- All the calls to `pop` and `peek` are valid.

## 思路

1. 与225题类似

## 题解

```python
class MyQueue:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.stack = []

    def push(self, x: int) -> None:
        """
        Push element x to the back of queue.
        """
        tmp = []
        # move out
        while self.stack:
            tmp.append(self.stack.pop())
        self.stack.append(x)
        # move in
        while tmp:
            self.stack.append(tmp.pop())

    def pop(self) -> int:
        """
        Removes the element from in front of queue and returns that element.
        """
        return self.stack.pop()

    def peek(self) -> int:
        """
        Get the front element.
        """
        return self.stack[-1]

    def empty(self) -> bool:
        """
        Returns whether the queue is empty.
        """
        return len(self.stack) == 0

# Your MyQueue object will be instantiated and called as such:
# obj = MyQueue()
# obj.push(x)
# param_2 = obj.pop()
# param_3 = obj.peek()
# param_4 = obj.empty()
```

击败50.37%