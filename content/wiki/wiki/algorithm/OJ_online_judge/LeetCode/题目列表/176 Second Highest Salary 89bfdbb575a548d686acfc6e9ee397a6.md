---
title: 176_Second_Highest_Salary_89bfdbb575a548d686acfc6e9ee397a6
---

# 176. Second Highest Salary

Difficulty: Easy
ID: 176
Solved?: Yes
Tags: SQL
击败: 71
推荐指数: ⭐⭐

[Second Highest Salary - LeetCode](https://leetcode.com/problems/second-highest-salary/)

## 题意

SQL Schema

Write a SQL query to get the second highest salary from the `Employee` table.

```
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

```

For example, given the above Employee table, the query should return `200` as the second highest salary. If there is no second highest salary, then the query should return `null`.

```
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

## 思路

## 题解

```python
# Write your MySQL query statement below
SELECT MAX( Salary) as SecondHighestSalary
FROM Employee
WHERE Salary < ( SELECT MAX(Salary) FROM Employee )
```

击败71%