---
title: 71_Simplify_Path_5098ceb90a424cf48fa95ef9937792af
---

# 71. Simplify Path

Difficulty: Medium
ID: 71
Solved?: Yes
Tags: Stack, String
击败: 97.42
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/simplify-path/)

## 题意

Given an **absolute path** for a file (Unix-style), simplify it. Or in other words, convert it to the **canonical path**.

In a UNIX-style file system, a period `.` refers to the current directory. Furthermore, a double period `..` moves the directory up a level.

Note that the returned canonical path must always begin with a slash `/`, and there must be only a single slash `/` between two directory names. The last directory name (if it exists) **must not** end with a trailing `/`. Also, the canonical path must be the **shortest** string representing the absolute path.

**Example 1:**

```
Input: "/home/"
Output: "/home"
Explanation: Note that there is no trailing slash after the last directory name.
```

**Example 2:**

```
Input: "/../"
Output: "/"
Explanation: Going one level up from the root directory is a no-op, as the root level is the highest level you can go.
```

**Example 3:**

```
Input: "/home//foo/"
Output: "/home/foo"
Explanation: In the canonical path, multiple consecutive slashes are replaced by a single one.
```

**Example 4:**

```
Input: "/a/./b/../../c/"
Output: "/c"
```

**Example 5:**

```
Input: "/a/../../b/../c//.//"
Output: "/c"
```

**Example 6:**

```
Input: "/a//b////c/d//././/.."
Output: "/a/b/c"
```

## 思路

1. 遇到`..`时要弹出路径

## 题解1：Stack

```python
class Solution:
    def simplifyPath(self, path: str) -> str:
        stack = list()
        tokens = path.split("/")
        for t in tokens:
            if t == "" or t == ".":
                continue
            elif t == "..":
                if stack:
                    stack.pop()
            else:
                stack.append(t)
        return "/" + "/".join(stack)
```