---
title: 316_Remove_Duplicate_Letters_1025f2ccbfa14a0bb12e4f215dc449ce
---

# 316. Remove Duplicate Letters

Difficulty: Medium
ID: 316
Solved?: Yes
Tags: Greedy, Stack, String
击败: 98.97
推荐指数: ⭐⭐⭐⭐

[Remove Duplicate Letters - LeetCode](https://leetcode.com/problems/remove-duplicate-letters/)

## 题意

Given a string `s`, remove duplicate letters so that every letter appears once and only once. You must make sure your result is **the smallest in lexicographical order** among all possible results.

**Note:** This question is the same as 1081: [https://leetcode.com/problems/smallest-subsequence-of-distinct-characters/](https://leetcode.com/problems/smallest-subsequence-of-distinct-characters/)

**Example 1:**

```
Input: s = "bcabc"
Output: "abc"

```

**Example 2:**

```
Input: s = "cbacdcbc"
Output: "acdb"

```

**Constraints:**

- `1 <= s.length <= 104`
- `s` consists of lowercase English letters.

## 思路

1. 结果字符串尽量按照从小到大的顺序递增排列。新处理一个字符的时候，首先查看是否已经在临时结果中。如果已经在了，那么没必要处理它了，因为它最多也就到达之前出现的位置，并没有正向收益；如果尚不存在，那么尽量往前靠，也就是尽量删掉前面的较大的字符，但是删掉的前提是被删字符在后面还会出现，所以需要跟踪各个字符的剩余个数。
    
    例子：dacbabc，初期演化过程是d → da → dac，接下来遇到b，b可以顶掉c，因为后面还有c，结果是dab；接下来遇到a，虽然它可以顶掉b，但没意义，因为它最多也只能走到d之后，跟原来的a一样，所以跳过这个a；接下来是b，类似不处理；最后是c。最终结果是dabc。
    

## 题解

```python
class Solution:
    def removeDuplicateLetters(self, s: str) -> str:
        from collections import defaultdict
        G = defaultdict(int)
        for c in s:
            G[c] += 1
        stack = []
        # vis是与stack对应的集合，为了快速查找
        vis = set()
        for c in s:
            G[c] -= 1
            if c in vis: continue
            while stack:
                top = stack[-1]
                if G[top] and c < top:
                    stack.pop()
                    vis.remove(top)
                else:
                    break
            stack.append(c)
            vis.add(c)
        return "".join(stack)
```

击败98.97%