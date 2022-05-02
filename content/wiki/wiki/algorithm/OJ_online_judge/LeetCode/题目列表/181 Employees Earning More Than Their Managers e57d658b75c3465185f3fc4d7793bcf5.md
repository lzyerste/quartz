---
title: 181_Employees_Earning_More_Than_Their_Managers_e57d658b75c3465185f3fc4d7793bcf5
---

# 181. Employees Earning More Than Their Managers

Difficulty: Easy
ID: 181
Solved?: Yes
Tags: SQL
击败: 37.74
推荐指数: ⭐⭐

[Employees Earning More Than Their Managers - LeetCode](https://leetcode.com/problems/employees-earning-more-than-their-managers/)

## 题意

SQL Schema

The `Employee` table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.

```
+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+

```

Given the `Employee` table, write a SQL query that finds out employees who earn more than their managers. For the above table, Joe is the only employee who earns more than his manager.

```
+----------+
| Employee |
+----------+
| Joe      |
+----------+
```

## 思路

## 题解

```python
# Write your MySQL query statement below
select E1.Name as Employee
from Employee as E1, Employee as E2 
where E1.ManagerId = E2.Id and E1.Salary > E2.Salary
```

击败37.74%