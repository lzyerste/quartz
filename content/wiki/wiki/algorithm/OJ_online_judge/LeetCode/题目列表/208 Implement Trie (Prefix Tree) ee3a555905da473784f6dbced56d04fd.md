---
title: 208_Implement_Trie__Prefix_Tree__ee3a555905da473784f6dbced56d04fd
---

# 208. Implement Trie (Prefix Tree)

Difficulty: Medium
ID: 208
Solved?: Yes
Tags: Design, Trie
击败: 29.54
推荐指数: ⭐⭐⭐

[Implement Trie (Prefix Tree) - LeetCode](Prefix Tree) - LeetCode)%20-%20LeetCode](https://leetcode.com/problems/implement-trie-prefix-tree/)

## 题意

Implement a trie with `insert`, `search`, and `startsWith` methods.

**Example:**

```
Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true

```

**Note:**

- You may assume that all inputs are consist of lowercase letters `a-z`.
- All inputs are guaranteed to be non-empty strings.

## 思路

1. Trie的实现：每个节点都视为Trie，它保存有next映射。

## 题解

```python
class Trie:

    def __init__(self):
        """
        Initialize your data structure here.
        """
        from collections import defaultdict
        self.next = defaultdict(Trie)
        self.val = None  # key -> value, None for not valid

    def insert(self, word: str) -> None:
        """
        Inserts a word into the trie.
        """
        node = self
        for c in word:
            node = node.next[c]
        node.val = True

    def search(self, word: str) -> bool:
        """
        Returns if the word is in the trie.
        """
        node = self
        for c in word:
            if c not in node.next: return False
            node = node.next[c]
        return node.val is not None

    def startsWith(self, prefix: str) -> bool:
        """
        Returns if there is any word in the trie that starts with the given prefix.
        """
        node = self
        for c in prefix:
            if c not in node.next: return False
            node = node.next[c]
        return True

# Your Trie object will be instantiated and called as such:
# obj = Trie()
# obj.insert(word)
# param_2 = obj.search(word)
# param_3 = obj.startsWith(prefix)
```

击败29.54%