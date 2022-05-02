---
title: 211_Design_Add_and_Search_Words_Data_Structure_9703cc9457f14148b99ca6061cec4a2e
---

# 211. Design Add and Search Words Data Structure

Difficulty: Medium
ID: 211
Solved?: Yes
Tags: Backtracking, Design, Trie
击败: 7.63
推荐指数: ⭐⭐⭐

[Design Add and Search Words Data Structure - LeetCode](https://leetcode.com/problems/design-add-and-search-words-data-structure/)

## 题意

Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the `WordDictionary` class:

- `WordDictionary()` Initializes the object.
- `void addWord(word)` Adds `word` to the data structure, it can be matched later.
- `bool search(word)` Returns `true` if there is any string in the data structure that matches `word` or `false` otherwise. `word` may contain dots `'.'` where dots can be matched with any letter.

**Example:**

```
Input
["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
[211 Design Add and Search Words Data Structure 9703cc9457f14148b99ca6061cec4a2e](.md)
Output
[null,null,null,null,false,true,true,true]

Explanation
WordDictionary wordDictionary = new WordDictionary();
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True

```

**Constraints:**

- `1 <= word.length <= 500`
- `word` in `addWord` consists lower-case English letters.
- `word` in `search` consist of `'.'` or lower-case English letters.
- At most `50000` calls will be made to `addWord` and `search`.

## 思路

1. 使用Trie数据结构，注意`.`的任意匹配。

## 题解

```python
class WordDictionary:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        from collections import defaultdict
        self.next = defaultdict(WordDictionary)
        self.val = None

    def addWord(self, word):
        """
        Adds a word into the data structure.
        :type word: str
        :rtype: void
        """
        # Trie
        node = self
        for c in word:
            node = node.next[c]
        node.val = True

    def search(self, word):
        """
        Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter.
        :type word: str
        :rtype: bool
        """
        return self._search(self, word, 0)
            
    def _search(self, node, word, d):
        if not node: return False
        if d == len(word) and node.val:
            return True
        if d == len(word):
            return False
        c = word[d]
        res = False
        if c == '.':
            res = any(self._search(node.next[k], word, d + 1) for k in node.next)
        elif c in node.next:
            res = self._search(node.next[c], word, d + 1)
        return res

# Your WordDictionary object will be instantiated and called as such:
# obj = WordDictionary()
# obj.addWord(word)
# param_2 = obj.search(word)
```

击败7.63%

为什么这么少？