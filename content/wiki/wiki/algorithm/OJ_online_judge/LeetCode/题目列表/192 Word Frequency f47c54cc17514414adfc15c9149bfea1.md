---
title: 192_Word_Frequency_f47c54cc17514414adfc15c9149bfea1
---

# 192. Word Frequency

Difficulty: Medium
ID: 192
Solved?: Yes
Tags: Shell
击败: 100
推荐指数: ⭐⭐

[Word Frequency - LeetCode](https://leetcode.com/problems/word-frequency/)

## 题意

Write a bash script to calculate the frequency of each word in a text file `words.txt`.

For simplicity sake, you may assume:

- `words.txt` contains only lowercase characters and space `' '` characters.
- Each word must consist of lowercase characters only.
- Words are separated by one or more whitespace characters.

**Example:**

Assume that `words.txt` has the following content:

```
the day is sunny the the
the sunny is is

```

Your script should output the following, sorted by descending frequency:

```
the 4
is 3
sunny 2
day 1

```

**Note:**

- Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.
- Could you write it in one-line using [Unix pipes](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-4.html)?

## 思路

## 题解

```python
# Read from the file words.txt and output the word frequency list to stdout.
cat words.txt | tr -s ' ' '\n' | sort | uniq -c | sort -r | awk '{ print $2, $1 }'
```

击败100%