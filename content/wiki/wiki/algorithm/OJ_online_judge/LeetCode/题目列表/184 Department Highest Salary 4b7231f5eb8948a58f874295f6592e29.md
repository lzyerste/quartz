---
title: 184_Department_Highest_Salary_4b7231f5eb8948a58f874295f6592e29
---

# 184. Department Highest Salary

Difficulty: Medium
ID: 184
Solved?: Yes
Tags: SQL
击败: 53.11
推荐指数: ⭐⭐

[Department Highest Salary - LeetCode](https://leetcode.com/problems/department-highest-salary/)

## 题意

SQL Schema

The `Employee` table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.

```
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+

```

The `Department` table holds all departments of the company.

```
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+

```

Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, your SQL query should return the following rows (order of rows does not matter).

```
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+

```

**Explanation:**

Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

## 思路

## 题解

```python
# Write your MySQL query statement below
SELECT dep.Name as Department, emp.Name as Employee, emp.Salary 
from Department dep, Employee emp 
where emp.DepartmentId=dep.Id 
and emp.Salary=(Select max(Salary) from Employee e2 where e2.DepartmentId=dep.Id)
```

击败53.11%