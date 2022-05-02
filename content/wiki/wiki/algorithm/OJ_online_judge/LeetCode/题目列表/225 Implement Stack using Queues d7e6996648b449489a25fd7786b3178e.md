---
title: 225_Implement_Stack_using_Queues_d7e6996648b449489a25fd7786b3178e
---

# 225. Implement Stack using Queues

Difficulty: Easy
ID: 225
Solved?: Yes
Tags: Design, Stack
击败: 92.58
推荐指数: ⭐⭐⭐

[Implement Stack using Queues - LeetCode](https://leetcode.com/problems/implement-stack-using-queues/)

## 题意

Implement a last in first out (LIFO) stack using only two queues. The implemented stack should support all the functions of a normal queue (`push`, `top`, `pop`, and `empty`).

Implement the `MyStack` class:

- `void push(int x)` Pushes element x to the top of the stack.
- `int pop()` Removes the element on the top of the stack and returns it.
- `int top()` Returns the element on the top of the stack.
- `boolean empty()` Returns `true` if the stack is empty, `false` otherwise.

**Notes:**

- You must use **only** standard operations of a queue, which means only `push to back`, `peek/pop from front`, `size`, and `is empty` operations are valid.
- Depending on your language, the queue may not be supported natively. You may simulate a queue using a list or deque (double-ended queue), as long as you use only a queue's standard operations.

**Follow-up:** Can you implement the stack such that each operation is **[amortized](https://en.wikipedia.org/wiki/Amortized_analysis)** `O(1)` time complexity? In other words, performing `n` operations will take overall `O(n)` time even if one of those operations may take longer.

**Example 1:**

```
Input
["MyStack", "push", "push", "top", "pop", "empty"]
[225 Implement Stack using Queues d7e6996648b449489a25fd7786b3178e](.md)
Output
[null, null, null, 2, 2, false]

Explanation
MyStack myStack = new MyStack();
myStack.push(1);
myStack.push(2);
myStack.top(); // return 2
myStack.pop(); // return 2
myStack.empty(); // return False

```

**Constraints:**

- `1 <= x <= 9`
- At most `100` calls will be made to `push`, `pop`, `top`, and `empty`.
- All the calls to `pop` and `top` are valid.

## 思路

1. 使用queue保持stack的正确顺序，也就是queue的左边作为栈顶，右边作为栈底。pop从栈顶出去，也就是queue的dequeue，顺序一致；push的时候需要想办法将新元素放到栈顶，可通过辅助queue来实现。先将新元素加入到新队列，然后将老队列的所有元素按序搬过来。

## 题解

```python
from collections import deque

class MyStack:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        self.queue = deque()

    def push(self, x: int) -> None:
        """
        Push element x onto stack.
        """
        q2 = deque()
        q2.append(x)
        for x in self.queue:
            q2.append(x)
        self.queue = q2
        

    def pop(self) -> int:
        """
        Removes the element on top of the stack and returns that element.
        """
        return self.queue.popleft()
        

    def top(self) -> int:
        """
        Get the top element.
        """
        return self.queue[0]
        

    def empty(self) -> bool:
        """
        Returns whether the stack is empty.
        """
        return len(self.queue) == 0

# Your MyStack object will be instantiated and called as such:
# obj = MyStack()
# obj.push(x)
# param_2 = obj.pop()
# param_3 = obj.top()
# param_4 = obj.empty()
```

击败92.58%