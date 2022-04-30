---
title: 30_Substring_with_Concatenation_of_All_Words_436e2fa9054b4b59bcf3eb29ec5302fe
---

# 30. Substring with Concatenation of All Words

Difficulty: Hard
ID: 30
Solved?: Yes
Tags: Hash Table, String, Two Pointers
击败: 74.17
推荐指数: ⭐⭐⭐⭐

[Substring with Concatenation of All Words - LeetCode](https://leetcode.com/problems/substring-with-concatenation-of-all-words/)

## 题意

给定一个字符串 **s** 和一些`长度相同`的单词words。找出 **s** 中恰好可以由 **words** 中所有单词串联形成的子串的起始位置。

注意子串要与 **words** 中的单词`完全匹配`，中间不能有其他字符，但不需要考虑 **words** 中单词串联的顺序。

**示例 1：**

```
输入：
  s = "barfoothefoobarman",
  words = ["foo","bar"]
输出：[0,9]
解释：
从索引 0 和 9 开始的子串分别是 "barfoo" 和 "foobar" 。
输出的顺序不重要, [9,0] 也是有效答案。
```

**示例 2：**

```
输入：
  s = "wordgoodgoodgoodbestword",
  words = ["word","good","best","word"]
输出：[]
```

## 思路

- 暴力双指针，划出等长字符串，分割成单词，统计结果是否相等。暴力在起始指针每次只移动一个字符。
- 滑动窗口。指针每次都是移动一个单词的距离，那么中间的单词是可以重用的。

## 题解1

```python
class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not words: return []
        from collections import Counter
        wc = len(words)  # word count
        wl = len(words[0])  # single word length
        g1 = Counter(words)
        
        res = []
        for i in range(len(s) - (wc * wl) + 1):
            tmp = []
            for j in range(i, i + wc * wl, wl):
                tmp.append(s[j:j+wl])
            if Counter(tmp) == g1:
                res.append(i)
        return res
```

## 题解2：滑动窗口

[Loading...](https://leetcode.com/problems/minimum-window-substring/discuss/26808/here-is-a-10-line-template-that-can-solve-most-substring-problems)

```python
class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not words: return []
        wc = len(words)
        wl = len(words[0])
        g1 = {}
        for w in words:
            g1[w] = g1.get(w, 0) + 1
        
        res = []
        
        for i in range(wl):
            begin = end = i
            g2 = {}
            counter = 0  # 匹配数量
            while end <= len(s) - wl:
                word = s[end: end + wl]
                end += wl  # end已指向下一个
                g2[word] = g2.get(word, 0) + 1
                counter += 1
                while g2[word] > g1.get(word, 0):  # 包括超出或者在g1中不存在
                    word2 = s[begin: begin + wl]
                    begin += wl
                    g2[word2] -= 1
                    counter -= 1
                if counter == wc:
                    res.append(begin)
        return res
```

## 题解2优化

```python
class Solution:
    def findSubstring(self, s: str, words: List[str]) -> List[int]:
        if not words: return []
        wc = len(words)
        wl = len(words[0])
        g1 = {}
        for w in words:
            g1[w] = g1.get(w, 0) + 1
        
        res = []
        
        for i in range(wl):
            begin = end = i
            g2 = {}
            counter = 0  # 匹配数量
            while end <= len(s) - wl:
                word = s[end: end + wl]
                end += wl  # end已指向下一个
                g2[word] = g2.get(word, 0) + 1
                counter += 1
                if word not in g1:  # 需要完全清空
                    begin = end
                    g2.clear()
                    counter = 0
                    continue
                while g2[word] > g1.get(word, 0):  # 包括超出或者在g1中不存在
                    word2 = s[begin: begin + wl]
                    begin += wl
                    g2[word2] -= 1
                    counter -= 1
                if counter == wc:
                    res.append(begin)
        return res
```

如果新扫描的word在g1中并不存在，那么，可以全部清空。

击败74.17%