---
title: 3_Longest_Substring_Without_Repeating_Characters_0f50fa42de3940bab3cea9b676b80a6c
---

# 3. Longest Substring Without Repeating Characters

Difficulty: Medium
ID: 3
Solved?: Yes
Tags: Hash Table, String, Two Pointers
击败: 84.77
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/longest-substring-without-repeating-characters/)

## 题意

给定一个字符串，请你找出其中不含有重复字符的 **`最长子串`** 的长度。

**示例 1:**

```
输入: "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
```

**示例 2:**

```
输入: "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
```

**示例 3:**

```
输入: "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
```

## 思路：

- 双指针
- 滑动窗口

## 题解1：双指针？

`一句话`：保持**当前子串**是不含重复字符的。

一句话不好讲清楚，等下举个例子就很容易理解了。遍历字符串，查看当前遍历到的字符是否可以添加到当前子串形成一个更大的子串（不含重复字符）。当前字符是否在当前子串中出现用哈希表就能查，而且可以知晓位置。如果不冲突，那么继续加到子串即可；如果冲突，那么就要对当前子串进行截断，从冲突的下一个位置作为当前子串的开始。如此，可以保持当前子串的特性，即不含重复字符。

举个例子，字符串为abcdcaefg，注意下标。

首先一直到子串`abcd`，接下来是字符c（下标4），在子串中已经出现过（下标2），当前子串的使命就完成了，它就是abcd，下标[0, 3]。

接下来的子串就是`dc`开始，这里d的下标是3，是冲突字符c（下标2）的下一个位置。下一个字符是a。虽然前面也有个a，但它已经不属于当前子串`dc`了，所以并没有冲突。接下来的字符都没有冲突，最终子串就是`dcaefg`，它比`abcd`要长。

这里的关键点就是冲突的判断了，而且需要确切知道冲突的位置。需要跟踪当前子串中每个字符的下标，注意当前子串之前的字符都是属于历史字符，不参与冲突判断。

总结：最大化当前子串，直到冲突，那么就得到当前子串的首尾位置，用于比较最长。

```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        if len(s) == 0:
            return 0
        s = s + s[-1]  # 为了强行制造冲突
        longest = 0
        begin = 0
        G = dict()
        for end, c in enumerate(s):
            idx = G.get(c, -1)
            if idx >= begin:
                longest = max(longest, end - begin)  # end不包含
                begin = idx + 1
            G[c] = end
        return longest
```

## 题解1变种

基于题解1，思考稍稍变一下，并不需要当前子串走到尽头后才开始比较，而是每一步都参与比较。如果有冲突的话，需要先截断生成新的当前子串再参与比较。

仍以上面的`abcdcaefg`为例，不再是抽取出完整的一段`abcd`才做比较，而是每一步都在比较。一开始为a，下标0，无冲突，最长为1。下一个为b，当前子串为ab，长度为2，最长。接下来遍历到c，当前子串为abc，长度为3，最长。接下来是d，当前子串为abcd，长度为4，最长。

再下一个是c，有冲突，解决冲突就是找到上一个c，取下一个位置，也就是从d开始。当前子串为dc，长度为2，不是最长。接下来是a，当前子串是dca，长度为3，不是最长。接下来是e，形成dcae。接下来是f，形成dcaef，长度为5，最长。接下来是g，形成dcaefg，长度为6，最长。结束。

---

上一解法写起来还有个麻烦处是最后子串的处理，遍历退出后，当前子串是dcaefg，要在循环外作比较处理；中间的当前子串则是在循环内部实现（遇到冲突）。遍历的退出并没有遇到冲突，而仅仅是字符串结束而已。当然，一个小技巧是给输入字符串再添加个末尾字符，强行制造冲突，循环外就不再处理了。

而变种解法写起来就方便了，遍历进来一个字符，检查与当前子串是否冲突，冲突的话要重新计算当前子串的起始点。遍历结束，那就自然结束吧，不需要额外操作。

```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        begin, end = 0, 0  # both inclusive
        longest = 0
        G = {}
        for end, c in enumerate(s):
            if c in G and G[c] >= begin:
                begin = G[c] + 1
            G[c] = end
            longest = max(longest, end - begin + 1)
        return longest
```

begin，end代表了当前不重复子串的左右边界（均包含，且总是合法）。往右移动end，看新字符是否在区间[begin, end)之间出现，未出现，begin不用动；出现了，需要更新begin到出现点的后一个位置，保持[begin, end]是合法的不重复子串。

> 击败95.60%
> 

稍微优化下，在有冲突产生的情况下，新生成的当前子串不可能是最长的（最多打平，收尾冲突的情况下），所以这时候没必要做max比较。

> Python2中有影响，Python3中并没什么效果，反而变差。
> 

```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        begin, end = 0, 0  # both inclusive
        longest = 0
        G = {}
        for end, c in enumerate(s):
            if c in G and G[c] >= begin:
                begin = G[c] + 1
            else:
                longest = max(longest, end - begin + 1)
            G[c] = end
        return longest
```

> 击败99.54%
> 

---

之前原来是提交到python2的，而提交到python3，数据差了一截。

三个解法击败率分别是：、61.09%、84.77%、78.96%

## 题解2：滑动窗口

```python
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        begin = end = 0
        g1 = {}
        d = 0
        while end < len(s):
            c = s[end]
            end += 1
            g1[c] = g1.get(c, 0) + 1
            while g1[c] > 1:  # 造成了重复
                c2 = s[begin]
                begin += 1
                g1[c2] -= 1
            d = max(d, end - begin)  # end已指向下一个了
        return d
```