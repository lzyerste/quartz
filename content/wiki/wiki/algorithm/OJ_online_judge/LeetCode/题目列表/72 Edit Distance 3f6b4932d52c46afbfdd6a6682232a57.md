---
title: 72_Edit_Distance_3f6b4932d52c46afbfdd6a6682232a57
---

# 72. Edit Distance

Difficulty: Hard
ID: 72
Solved?: Yes
Tags: DP
击败: 98.76
推荐指数: ⭐⭐⭐⭐

[](https://leetcode.com/problems/edit-distance/)

## 题意

## 题解：DP

word1横着，word2竖着。

注意，如果当前字符相等的话，直接走斜向上方向，不用横着竖着比较了。

注意越过边界的情况（相当于不停删除或者不停增加）。

```python
class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        def dp(G, r, c):
            # r -> word2, c -> word1
            p = r, c
            if p in G: return G[p]
            if c < 0: return r + 1
            if r < 0: return c + 1
            G[p] = dp(G, r-1, c-1)  # 相等直接走斜角
            if word2[r] != word1[c]:
                G[p] += 1  # replace
                G[p] = min(G[p], dp(G, r, c-1) + 1, dp(G, r-1, c) + 1)  # delete, add
            return G[p]
        
        return dp({}, len(word2) - 1, len(word1) - 1)
```