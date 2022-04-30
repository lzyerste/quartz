---
title: 14_Longest_Common_Prefix_7d5dc117dd0e4c5b8b02c48dca53bdc7
---

# 14. Longest Common Prefix

Difficulty: Easy
ID: 14
Solved?: Yes
Tags: String
击败: 71.82
推荐指数: ⭐⭐⭐

[](https://leetcode.com/problems/longest-common-prefix)

## 题意

编写一个函数来查找字符串数组中的最长公共前缀。

如果不存在公共前缀，返回空字符串 `""`。

**示例 1:**

```
输入: ["flower","flow","flight"]
输出: "fl"
```

**示例 2:**

```
输入: ["dog","racecar","car"]
输出: ""
解释: 输入不存在公共前缀。
```

**说明:**

所有输入只包含小写字母 `a-z` 。

## 思路

- 先整体排序，然后比较第一个与最后一个字符串的公共前缀。它们的公共前缀必定也是它们中间字符串的公共前缀。
- 老老实实大家一起遍历

## 题解1：排序

```python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if len(strs) == 0: return ""
        strs.sort()
        first = strs[0]
        last = strs[-1]
        for i, c in enumerate(first):
            if not (i < len(last) and c == last[i]):
                return first[:i]
        return first
```

击败71.82%

## 题解2：一个个遍历

```python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if len(strs) == 0: return ""
        word = strs[0]  # 随便挑一个作为基准
        for i, c in enumerate(word):
            for s in strs:
                if not (i < len(s) and c == s[i]):
                    return word[:i]
        return word
```

击败71.82

---

稍微修改下，先确定最短单词，以它为基准，每次遍历的时候，将大家对应位置的字符加到集合set里，看集合大小是否为1。

```python
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if len(strs) == 0: return ""
        n = min(map(len, strs))
        for i in range(n):
            aset = {s[i] for s in strs}
            if len(aset) > 1:
                return strs[0][:i]
        return strs[0][:n]
```

击败27.04%

## 题解3：Trie树，TODO

复杂度与题解2是一样的。