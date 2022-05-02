---
title: 125_Valid_Palindrome_ff76ee4151f14a98aeaa3100ddf1e095
---

# 125. Valid Palindrome

Difficulty: Easy
ID: 125
Solved?: Yes
Tags: String, Two Pointers
击败: 66.96
推荐指数: ⭐⭐

[Valid Palindrome - LeetCode](https://leetcode.com/problems/valid-palindrome/)

## 题意

Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

**Note:** For the purpose of this problem, we define empty string as valid palindrome.

**Example 1:**

```
Input: "A man, a plan, a canal: Panama"
Output: true

```

**Example 2:**

```
Input: "race a car"
Output: false

```

**Constraints:**

- `s` consists only of printable ASCII characters.

## 思路

1. 左右指针

## 题解

```python
class Solution:
    def isPalindrome(self, s: str) -> bool:
        s = s.lower()
        lf, rt = 0, len(s) - 1
        while lf <= rt:
            if not s[lf].isalnum():
                lf += 1
                continue
            if not s[rt].isalnum():
                rt -= 1
                continue
            if s[lf] != s[rt]:
                return False
            lf += 1
            rt -= 1
        return True
```

击败66.96%