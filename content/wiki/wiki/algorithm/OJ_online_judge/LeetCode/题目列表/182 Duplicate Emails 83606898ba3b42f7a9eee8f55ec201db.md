---
title: 182_Duplicate_Emails_83606898ba3b42f7a9eee8f55ec201db
---

# 182. Duplicate Emails

Difficulty: Easy
ID: 182
Solved?: Yes
Tags: SQL
击败: 93.54
推荐指数: ⭐⭐

[Duplicate Emails - LeetCode](https://leetcode.com/problems/duplicate-emails/)

## 题意

SQL Schema

Write a SQL query to find all duplicate emails in a table named `Person`.

```
+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+

```

For example, your query should return the following for the above table:

```
+---------+
| Email   |
+---------+
| a@b.com |
+---------+

```

**Note**: All emails are in lowercase.

## 思路

## 题解

```python
# Write your MySQL query statement below
select Email
from Person
group by Email
having count(*) > 1
```

击败93.54%