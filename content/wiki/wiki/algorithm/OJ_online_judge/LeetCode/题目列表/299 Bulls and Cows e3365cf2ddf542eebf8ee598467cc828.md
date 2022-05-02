---
title: 299_Bulls_and_Cows_e3365cf2ddf542eebf8ee598467cc828
---

# 299. Bulls and Cows

Difficulty: Medium
ID: 299
Solved?: Yes
Tags: Hash Table
击败: 29.18
推荐指数: ⭐⭐⭐

[Bulls and Cows - LeetCode](https://leetcode.com/problems/bulls-and-cows/)

## 题意

You are playing the **[Bulls and Cows](https://en.wikipedia.org/wiki/Bulls_and_Cows)** game with your friend.

You write down a secret number and ask your friend to guess what the number is. When your friend makes a guess, you provide a hint with the following info:

- The number of "bulls", which are digits in the guess that are in the correct position.
- The number of "cows", which are digits in the guess that are in your secret number but are located in the wrong position. Specifically, the non-bull digits in the guess that could be rearranged such that they become bulls.

Given the secret number `secret` and your friend's guess `guess`, return *the hint for your friend's guess*.

The hint should be formatted as `"xAyB"`, where `x` is the number of bulls and `y` is the number of cows. Note that both `secret` and `guess` may contain duplicate digits.

**Example 1:**

```
Input: secret = "1807", guess = "7810"
Output: "1A3B"
Explanation: Bulls are connected with a '|' and cows are underlined:
"1807"
  |
"7810"
```

**Example 2:**

```
Input: secret = "1123", guess = "0111"
Output: "1A1B"
Explanation: Bulls are connected with a '|' and cows are underlined:
"1123"        "1123"
  |      or     |
"0111"        "0111"
Note that only one of the two unmatched 1s is counted as a cow since the non-bull digits can only be rearranged to allow one 1 to be a bull.

```

**Example 3:**

```
Input: secret = "1", guess = "0"
Output: "0A0B"

```

**Example 4:**

```
Input: secret = "1", guess = "1"
Output: "1A0B"

```

**Constraints:**

- `1 <= secret.length, guess.length <= 1000`
- `secret.length == guess.length`
- `secret` and `guess` consist of digits only.

## 思路

1. 注意要分两趟，第一趟处理完全匹配的情况（bulls），如果不匹配，需要统计secret中字符出现的次数，用于下一趟匹配用。第二趟遍历的时候，要跳过bulls的情况，然后根据之前的计数来消减。分两趟的原因是，防止bulls所在的位置被看到，另外cows需要看到secret的整体情况，比如字母对了，但位置在secret的将来。

## 题解

```python
class Solution:
    def getHint(self, secret: str, guess: str) -> str:
        from collections import defaultdict
        G = defaultdict(int)

        bulls = 0
        cows = 0
        for x, y in zip(secret, guess):
            if x == y:
                bulls += 1
            else:
                G[x] += 1
        for x, y in zip(secret, guess):
            if x != y and G[y] > 0:
                cows += 1
                G[y] -= 1
        return "%dA%dB" % (bulls, cows)
```

击败29.18%