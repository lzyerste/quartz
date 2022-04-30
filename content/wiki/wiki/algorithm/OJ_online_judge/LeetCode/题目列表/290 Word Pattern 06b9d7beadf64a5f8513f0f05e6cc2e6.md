---
title: 290_Word_Pattern_06b9d7beadf64a5f8513f0f05e6cc2e6
---

# 290. Word Pattern

Difficulty: Easy
ID: 290
Solved?: Yes
Tags: Hash Table
击败: 71.36
推荐指数: ⭐⭐⭐

[Word Pattern - LeetCode](https://leetcode.com/problems/word-pattern/)

[205. Isomorphic Strings](205%20Isomorphic%20Strings%20118d93c5d9474fe18399b47db72212d7.md) 

## 题意

Given a `pattern` and a string `s`, find if `s` follows the same pattern.

Here **follow** means a full match, such that there is a bijection between a letter in `pattern` and a **non-empty** word in `s`.

**Example 1:**

```
Input: pattern = "abba", s = "dog cat cat dog"
Output: true

```

**Example 2:**

```
Input: pattern = "abba", s = "dog cat cat fish"
Output: false

```

**Example 3:**

```
Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false

```

**Example 4:**

```
Input: pattern = "abba", s = "dog dog dog dog"
Output: false

```

**Constraints:**

- `1 <= pattern.length <= 300`
- `pattern` contains only lower-case English letters.
- `1 <= s.length <= 3000`
- `s` contains only lower-case English letters and spaces `' '`.
- `s` **does not contain** any leading or trailing spaces.
- All the words in `s` are separated by a **single space**.

## 思路

1. 双向一一映射

## 题解

```python
class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        tokens = s.split()
        if len(tokens) != len(pattern): return False
        G = {}
        H = {}
        for a, b in zip(pattern, tokens):
            if a in G and G[a] != b: return False
            if a not in G and b in H: return False
            G[a] = b
            H[b] = a
        return True
```

击败71.36%