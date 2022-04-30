---
title: 183_Customers_Who_Never_Order_be094ab94f464d3786b25453696b322e
---

# 183. Customers Who Never Order

Difficulty: Easy
ID: 183
Solved?: Yes
Tags: SQL
击败: 26.92
推荐指数: ⭐⭐

[Customers Who Never Order - LeetCode](https://leetcode.com/problems/customers-who-never-order/)

## 题意

SQL Schema

Suppose that a website contains two tables, the `Customers` table and the `Orders` table. Write a SQL query to find all customers who never order anything.

Table: `Customers`.

```
+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+

```

Table: `Orders`.

```
+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+

```

Using the above tables as example, return the following:

```
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+
```

## 思路

## 题解

```python
# Write your MySQL query statement below
SELECT A.Name as Customers
from Customers A
LEFT JOIN Orders B on a.Id = B.CustomerId
WHERE b.CustomerId is NULL
```

击败26.92%