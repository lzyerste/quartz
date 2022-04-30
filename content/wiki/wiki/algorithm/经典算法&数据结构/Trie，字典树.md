---
title: Trie，字典树
---

# Trie，字典树

algs4/Trie.py

```python
class Trie:
    """字典树的实现。
    利用Python的defaultdict。
    API对应algs4的730页。
    包括空字符串。
    Value为None表示不合法。
    """

    def __init__(self):
        from collections import defaultdict
        self.val = None  # None表示不合法
        self.next = defaultdict(Trie)  # 子树也可视为一颗Trie树，key代表了边

    def put(self, key: str, val):
        """添加key，value对。
        利用defaultdict的特性，会自动建立Trie子树。
        
        Arguments:
            key {str} -- [description]
            val {[type]} -- [description]
        """
        node = self
        for c in key:
            node = node.next[c]
        node.val = val

    def get(self, key: str):
        node = self
        for c in key:
            if c not in node.next:
                return None
            node = node.next[c]
        return node.val

    def delete(self, key: str):
        """删除后同时清理悬挂的无用节点。
        也就是本身不包含值，且next为空，即没有作为中间节点。
        A --a--> B --b--> C --c--> D
        key为abc，长度为3，经过的节点为ABCD，为4个，D是目标节点。
        Arguments:
            key {str} -- [description]
        """
        stack = []
        node = self
        for c in key:
            if c not in node.next: return
            stack.append(node)
            node = node.next[c]
        stack.append(node)  # 注意目标节点也要入栈

        if node.val is None: return
        node.val = None  # hit

        for c in key[::-1]:  # 反过来遍历
            node = stack.pop()
            parent = stack[-1]  # 注意对应关系，parent.next[c] is node
            if node.val is None and not node.next:  # 悬空节点
                del parent.next[c]
            else:
                return

    def contains(self, key: str):
        return self.get(key) is not None

    def isEmpty(self):
        return not self.next and self.val is None

    def size(self) -> int:
        """返回字典树大小。
        递归实现。
        """
        cnt = 0
        if self.val is not None:
            cnt += 1
        for node in self.next.values():
            cnt += node.size()
        return cnt

    def longestPrefixOf(self, s: str):
        """在遍历过程中，实时记录合法的前缀。
        
        Arguments:
            s {str} -- [description]
        
        Returns:
            [type] -- [description]
        """
        pre = ""  # 目前记录的最长合法前缀
        node = self
        for i, c in enumerate(s):
            if c not in self.next: break
            node = node.next[c]
            if node.val is not None:
                pre = s[:i+1]  # 合法前缀
        return pre

    def keysWithPrefix(self, s: str):
        """遍历完s，找到目标点，接下来就是keys()做法。
        
        Arguments:
            s {str} -- [description]
        
        Returns:
            [type] -- [description]
        """
        res = []
        node = self
        for c in s:
            if c not in node.next:
                return []
            node = node.next[c]
        for k in node.keys():  # keys()是从node开始算的，所以要添上前缀
            res.append(s + k)
        return res

    def keysThatMatch(self, s: str):
        """支持通配符`.`，表示匹配任意一个字符。
        递归来做。当前字符匹配的话，剩余的继续递归，返回后拼接上前缀。
        
        Arguments:
            s {str} -- [description]
        """
        if s == "":
            return [""] if self.val is not None else []
        res = []
        c = s[0]
        if c == '.':
            for c, node in self.next.items():  # 覆盖c没关系
                for k in node.keysThatMatch(s[1:]):
                    res.append(c + k)
        elif c in self.next:
            node = self.next[c]
            for k in node.keysThatMatch(s[1:]):
                res.append(c + k)
        return res

    def keys(self):
        """返回所有key。
        递归来做。
        """
        def helper(root, pre):
            res = []
            if root.val is not None:
                res.append(pre)
            for c, n in root.next.items():
                res += helper(n, pre + c)
            return res
        
        return helper(self, "")

if __name__ == "__main__":
    trie = Trie()
    print(trie.size())
    print(trie.isEmpty())
    for i in range(100):
        trie.put(str(i), i * i)
    print(trie.size())
    print(trie.isEmpty())
    print(trie.contains("0"))
    print(trie.contains("3"))
    print(trie.contains("123"))
    print(trie.get("0"))
    print(trie.get("3"))
    print(trie.get("42"))
    print(trie.keys())
    for k in trie.keys():
        print(k, trie.get(k))
    print(trie.keysWithPrefix("9"))

    print("-" * 20)
    print("keysThatMatch:")
    print(trie.keysThatMatch("93"))
    print(trie.keysThatMatch("."))

    print("-" * 20)
    print("longestPrefix:")
    print(trie.longestPrefixOf("12345"))  # 12
    print(trie.longestPrefixOf("abcd"))  # 空
    print(trie.longestPrefixOf("42"))  # 42

    print("-" * 20)
    trie = Trie()
    trie.put("she", "she")
    trie.delete("she")
    print(trie.size())
    print(trie.isEmpty())
```