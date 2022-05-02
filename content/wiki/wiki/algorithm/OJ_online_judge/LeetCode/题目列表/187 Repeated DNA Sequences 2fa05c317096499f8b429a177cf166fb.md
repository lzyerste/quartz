---
title: 187_Repeated_DNA_Sequences_2fa05c317096499f8b429a177cf166fb
---

# 187. Repeated DNA Sequences

Difficulty: Medium
ID: 187
Solved?: Yes
Tags: Bit Manipulation, Hash Table
击败: 42.37
推荐指数: ⭐⭐⭐

[Repeated DNA Sequences - LeetCode](https://leetcode.com/problems/repeated-dna-sequences/)

## 题意

All DNA is composed of a series of nucleotides abbreviated as `'A'`, `'C'`, `'G'`, and `'T'`, for example: `"ACGAATTCCG"`. When studying DNA, it is sometimes useful to identify repeated sequences within the DNA.

Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule.

**Example 1:**

```
Input: s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT"
Output: ["AAAAACCCCC","CCCCCAAAAA"]

```

**Example 2:**

```
Input: s = "AAAAAAAAAAAAA"
Output: ["AAAAAAAAAA"]

```

**Constraints:**

- `0 <= s.length <= 105`
- `s[i]` is `'A'`, `'C'`, `'G'`, or `'T'`.

## 思路

1. 使用哈希表来计数
2. 使用集合可能会更快

## 题解

```python
class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        from collections import defaultdict
        G = defaultdict(int)  # 0 for non-exist key
        for i in range(len(s) - 9):
            G[s[i:i+10]] += 1
        return [k for k, v in G.items() if v > 1]
```

击败42.37%