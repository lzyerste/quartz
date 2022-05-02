---
title: 177_Nth_Highest_Salary_61187c811a6744f391abeebb6a40f924
---

# 177. Nth Highest Salary

Difficulty: Medium
ID: 177
Solved?: Yes
Tags: SQL
击败: 35.09
推荐指数: ⭐⭐

[Nth Highest Salary - LeetCode](https://leetcode.com/problems/nth-highest-salary/)

## 题意

Write a SQL query to get the *n*th highest salary from the `Employee` table.

```
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+

```

For example, given the above Employee table, the *n*th highest salary where *n* = 2 is `200`. If there is no *n*th highest salary, then the query should return `null`.

```
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

```

## 思路

## 题解

```python
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
DECLARE M INT;
SET M=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT M, 1
  );
END
```

击败35.09%