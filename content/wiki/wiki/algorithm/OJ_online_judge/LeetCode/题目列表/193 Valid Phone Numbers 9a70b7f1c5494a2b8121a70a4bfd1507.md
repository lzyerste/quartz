---
title: 193_Valid_Phone_Numbers_9a70b7f1c5494a2b8121a70a4bfd1507
---

# 193. Valid Phone Numbers

Difficulty: Easy
ID: 193
Solved?: Yes
Tags: Shell
击败: 31
推荐指数: ⭐⭐

[Valid Phone Numbers - LeetCode](https://leetcode.com/problems/valid-phone-numbers/)

## 题意

Given a text file `file.txt` that contains list of phone numbers (one per line), write a one liner bash script to print all valid phone numbers.

You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)

You may also assume each line in the text file must not contain leading or trailing white spaces.

**Example:**

Assume that `file.txt` has the following content:

```
987-123-4567
123 456 7890
(123) 456-7890

```

Your script should output the following valid phone numbers:

```
987-123-4567
(123) 456-7890

```

## 思路

## 题解

```python
# Read from the file file.txt and output all valid phone numbers to stdout.
sed -n -r '/^([0-9]{3}-|\([0-9]{3}\) )[0-9]{3}-[0-9]{4}$/p' file.txt
```

击败31%