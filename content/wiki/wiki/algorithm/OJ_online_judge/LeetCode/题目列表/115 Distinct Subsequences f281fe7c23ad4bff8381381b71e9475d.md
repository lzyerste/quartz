---
title: 115_Distinct_Subsequences_f281fe7c23ad4bff8381381b71e9475d
---

# 115. Distinct Subsequences

Difficulty: Hard
ID: 115
Solved?: Yes
Tags: DP, String
击败: 97.27
推荐指数: ⭐⭐⭐⭐

[Distinct Subsequences - LeetCode](https://leetcode.com/problems/distinct-subsequences/)

## 题意

Given two strings `s` and `t`, return *the number of distinct subsequences of `s` which equals `t`*.

A string's **subsequence** is a new string formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., `"ACE"` is a subsequence of `"ABCDE"` while `"AEC"` is not).

It's guaranteed the answer fits on a 32-bit signed integer.

**Example 1:**

```
Input: s = "rabbbit", t = "rabbit"
Output: 3
Explanation:
As shown below, there are 3 ways you can generate "rabbit" from S.
rabbbitrabbbitrabbbit
```

**Example 2:**

```
Input: s = "babgbag", t = "bag"
Output: 5
Explanation:
As shown below, there are 5 ways you can generate "bag" from S.
babgbagbabgbagbabgbagbabgbagbabgbag
```

**Constraints:**

- `0 <= s.length, t.length <= 1000`
- `s` and `t` consist of English letters.

## 思路

- 常规二维DP。优化一下的话，空间可以压缩为一维（只需要当前行与上一行）。

## 题解1：DP

先举例子：S = "babgbag", T = "bag"，S水平铺开，T垂直铺开。

```sql
    0 1 2 3 4 5 6
    b a b g b a g
0 b 
1 a 
2 g 
```

dp(r, c)代表的含义就是S[c]与T[r]子串的不同序列数量。

我们要求的答案就是dp(2, 6)。

观察T[2]与S[6]，两者都是g，相等，那么S[6]可以用来匹配T[2]，各自往前走一步（斜向上），变成了求解dp(1, 5)；另一方面，S认为自己还有足够的字符，当前字符不选择匹配，而是放弃，那么S往前走一步，T保持不动（因为并没有匹配），变成了求解dp(2, 5)。

如果T[r]与S[c]不相等，那么T保持不变，S往前走一步，变成求解dp(r, c-1)。

注意，边界情况的确定。当T为空时，不管S是否为空，总是认为能匹配1种。但反过来，T不为空，而S为空时，没有序列匹配，结果为0。

这样可保持递推式不变。

```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        def dp(G, s, t, r, c):
            # s水平向，为列c；t垂直向，为行r
            p = r, c
            if p in G: return G[p]
            if r < 0: return 1  # t为空，表示1种匹配（即使s也为空）
            if c < 0: return 0  # s为空，t不空，匹配不了
            if t[r] == s[c]:
                G[p] = dp(G, s, t, r - 1, c - 1) + dp(G, s, t, r, c - 1)
            else:
                G[p] = dp(G, s, t, r, c - 1)
            return G[p]
        
        return dp({}, s, t, len(t) - 1, len(s) - 1)
```

## 题解2：iterative

两重循环，一行行下来。

```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        dp = [[0 for c in range(len(s) + 1)] for r in range(len(t) + 1)]
        for i in range(len(s) + 1):
            dp[-1][i] = 1  # 注意-1索引
        for r, c1 in enumerate(t):
            for c, c2 in enumerate(s):
                if c1 == c2:
                    dp[r][c] = dp[r-1][c-1] + dp[r][c-1]
                else:
                    dp[r][c] = dp[r][c-1]
        return dp[len(t)-1][len(s)-1]
```

下标-1看起来是在0的上方，实际是列表的最后一行/列。

## 题解3：行列交换

之前是把s水平铺开，把t垂直铺开，递推方向有向左跟斜向上，导致不好压缩空间。

可以反过来想想，将t作为横轴，将s作为竖轴，相当于矩阵转置，递推方向变为向上及斜向上。

```python
a b c
  d e
```

这时候，竖直向上的方向可以视为过去历史记录（上一次），斜向上可视为左边邻居的历史记录。

上面示例中，计算第2行时，e ← c, b，d ← b, a。

如果用一维空间的话，A[i] ← A[i], A[i-1]。

注意，要从右往左计算，先计算e，再计算d。因为先计算d的话，就相当于覆盖了b，会影响e的值。

---

行列方向不同从宏观上看影响了什么呢？

相当于要考虑的是，假设已经对s和t做完处理了，接下来要延伸，延伸s还是延伸t呢？

之前是延伸t（把t作为竖轴，按行遍历下来，相当于在延伸t），这样有个后果是可能把之前的结果都会推翻，比如新加的字符是全新的，对它来说，就要全清零了。

如果选择延伸s，即使是全新的，那就不参与匹配t，之前的结果是不用动的。

```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        dp = [0 for _ in range(len(t) + 1)]
        dp[-1] = 1
        for r in range(len(s)):
            for c in range(len(t))[::-1]:
                if t[c] == s[r]:
                    dp[c] += dp[c-1]
        return dp[len(t) - 1]
```

击败91.48%

---

2020-11-03 10:02:52

可以正常从前往后，prev表示斜向上左，up表示向上，小心覆盖情况。下一轮时prev=up，用up变量记录更新之前的值，防止覆盖。

```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        dp = [0 for _ in range(len(t) + 1)]
        dp[-1] = 1
        for r in range(len(s)):
            prev = dp[-1]
            for c in range(len(t)):
                up = dp[c]
                if t[c] == s[r]:
                    dp[c] += prev
                prev = up
                
        return dp[len(t) - 1]
```

## 题解3优化：过滤

如果延伸s的时候，该字符不在t中出现，那么dp数组可以保持不动，因为不需要操作斜上角方向。

```python
class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        dp = [0 for _ in range(len(t) + 1)]
        dp[-1] = 1
        for r, x in enumerate(s):
            if x not in t: continue  # 加速
            for c in range(len(t))[::-1]:
                if t[c] == s[r]:
                    dp[c] += dp[c-1]
        return dp[len(t) - 1]
```

97.27%