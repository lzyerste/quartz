---
title: 1456_Maximum_Number_of_Vowels_in_a_Substring_of_Gi_bf87519272b247dd867de2cf54b8b674
---

# 1456. Maximum Number of Vowels in a Substring of Given Length

Difficulty: Medium
ID: 1456
Solved?: Yes
Tags: Sliding Window, String
击败: 89.13
推荐指数: ⭐⭐⭐

[Maximum Number of Vowels in a Substring of Given Length - LeetCode](https://leetcode.com/problems/maximum-number-of-vowels-in-a-substring-of-given-length/)

## 题意

Given a string `s` and an integer `k`.

Return *the maximum number of vowel letters* in any substring of `s` with length `k`.

**Vowel letters** in English are (a, e, i, o, u).

**Example 1:**

```
Input: s = "abciiidef", k = 3
Output: 3
Explanation: The substring "iii" contains 3 vowel letters.

```

**Example 2:**

```
Input: s = "aeiou", k = 2
Output: 2
Explanation: Any substring of length 2 contains 2 vowels.

```

**Example 3:**

```
Input: s = "leetcode", k = 3
Output: 2
Explanation: "lee", "eet" and "ode" contain 2 vowels.

```

**Example 4:**

```
Input: s = "rhythms", k = 4
Output: 0
Explanation: We can see that s doesn't have any vowel letters.

```

**Example 5:**

```
Input: s = "tryhard", k = 4
Output: 1

```

**Constraints:**

- `1 <= s.length <= 10^5`
- `s` consists of lowercase English letters.
- `1 <= k <= s.length`

## 思路

1. 标准滑动窗口，统计窗口内的元音数量。

## 题解1：标准模板

```python
class Solution:
    def maxVowels(self, s: str, k: int) -> int:
        vowel = "aeiou"
        i = j = 0
        max_cnt = count = 0
        while j < len(s):
            # expand
            if s[j] in vowel: count += 1
            j += 1
            # shrink
            while j - i > k:  # 窗口内最多只能有k个元素
                if s[i] in vowel: count -= 1
                i += 1
            max_cnt = max(max_cnt, count)
        return max_cnt
```

击败35.68%，因为判断比较多。

## 题解2：快速

```python
class Solution:
    def maxVowels(self, s: str, k: int) -> int:
        vowel = "aeiou"
        n = len(s)
        i = j = 0
        count = 0
        for j in range(k):
            if j >= n: return count  # 处理了较大的k
            if s[j] in vowel: count += 1
        max_cnt = count
        for j in range(k, n):  # 同步滑动，窗口大小始终保持为k
            if s[j] in vowel: count += 1
            if s[i] in vowel: count -= 1
            i += 1
            max_cnt = max(max_cnt, count)
        return max_cnt
```

击败89.13%