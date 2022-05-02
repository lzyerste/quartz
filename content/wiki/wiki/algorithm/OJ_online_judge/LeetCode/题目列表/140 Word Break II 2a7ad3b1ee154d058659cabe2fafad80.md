---
title: 140_Word_Break_II_2a7ad3b1ee154d058659cabe2fafad80
---

# 140. Word Break II

Difficulty: Hard
ID: 140
Solved?: Yes
Tags: Backtracking, DP
击败: 75.75
推荐指数: ⭐⭐⭐

[Word Break II - LeetCode](https://leetcode.com/problems/word-break-ii/)

[139. Word Break](139%20Word%20Break%20a3930ca65d22413389a15dc9e475c146.md) 

## 题意

Given a **non-empty** string *s* and a dictionary *wordDict* containing a list of **non-empty** words, add spaces in *s* to construct a sentence where each word is a valid dictionary word. Return all such possible sentences.

**Note:**

- The same word in the dictionary may be reused multiple times in the segmentation.
- You may assume the dictionary does not contain duplicate words.

**Example 1:**

```
Input:
s = "catsanddog"
wordDict = ["cat", "cats", "and", "sand", "dog"]Output:
[
  "cats and dog",
  "cat sand dog"
]
```

**Example 2:**

```
Input:
s = "pineapplepenapple"
wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
Output:
[
  "pine apple pen apple",
  "pineapple pen apple",
  "pine applepen apple"
]
Explanation: Note that you are allowed to reuse a dictionary word.

```

**Example 3:**

```
Input:
s = "catsandog"
wordDict = ["cats", "dog", "sand", "and", "cat"]
Output:
[]
```

## 思路

1. DP：思路跟139毫无区别，只是要记录所有可能。正向dp（选定的单词在左边）跟反向dp（选定的单词在右边）时间相差好多？

## 题解：反向DP

```python
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        G = {}
        return self.dp(G, s, wordDict, 0, len(s) - 1)
    
    def dp(self, G, s, wordDict, i, j):
        p = i, j
        if p in G: return G[p]
        res = []
        if s[i:j+1] in wordDict:
            res.append(s[i:j+1])
        for k in range(i + 1, j + 1):
            word = s[k:j+1]
            if word in wordDict:
                for lst in self.dp(G, s, wordDict, i, k-1):
                    res.append(lst + " " + word)
        G[p] = res
        return G[p]
```

击败75.75%

## 题解：正向DP

```python
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        G = {}
        res = self.dp(G, s, wordDict, 0, len(s) - 1)
        return [" ".join(lst) for lst in res]
    
    def dp(self, G, s, wordDict, i, j):
        if i > j: return [140 Word Break II 2a7ad3b1ee154d058659cabe2fafad80](.md)
        p = i, j
        if p in G: return G[p]
        res = []
        for k in range(i, j + 1):
            word = s[i:k+1]
            if word in wordDict:
                for lst in self.dp(G, s, wordDict, k + 1, j):
                    res.append([word] + lst)
        G[p] = res
        return G[p]
```

击败11.39%