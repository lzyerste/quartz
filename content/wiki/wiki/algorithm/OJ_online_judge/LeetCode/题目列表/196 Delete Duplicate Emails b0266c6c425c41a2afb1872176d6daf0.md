---
title: 196_Delete_Duplicate_Emails_b0266c6c425c41a2afb1872176d6daf0
---

# 196. Delete Duplicate Emails

Difficulty: Easy
ID: 196
Solved?: Yes
Tags: SQL
击败: 75.77
推荐指数: ⭐⭐

[Delete Duplicate Emails - LeetCode](https://leetcode.com/problems/delete-duplicate-emails/)

## 题意

Write a SQL query to **delete** all duplicate email entries in a table named `Person`, keeping only unique emails based on its smallest **Id**.

```
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
Id is the primary key column for this table.

```

For example, after running your query, the above `Person` table should have the following rows:

```
+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+

```

**Note:**

Your output is the whole `Person` table after executing your sql. Use `delete` statement.

## 思路

## 题解

```python
# Write your MySQL query statement below
DELETE p1
FROM Person p1, Person p2
WHERE p1.Email = p2.Email AND
p1.Id > p2.Id
```

击败75.77%