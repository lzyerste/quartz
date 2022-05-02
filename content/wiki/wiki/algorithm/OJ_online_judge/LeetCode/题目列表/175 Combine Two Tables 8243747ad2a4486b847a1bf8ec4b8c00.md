---
title: 175_Combine_Two_Tables_8243747ad2a4486b847a1bf8ec4b8c00
---

# 175. Combine Two Tables

Difficulty: Easy
ID: 175
Solved?: Yes
Tags: SQL
击败: 93.47
推荐指数: ⭐⭐

[Combine Two Tables - LeetCode](https://leetcode.com/problems/combine-two-tables/)

## 题意

SQL Schema

Table: `Person`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| PersonId    | int     |
| FirstName   | varchar |
| LastName    | varchar |
+-------------+---------+
PersonId is the primary key column for this table.

```

Table: `Address`

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| AddressId   | int     |
| PersonId    | int     |
| City        | varchar |
| State       | varchar |
+-------------+---------+
AddressId is the primary key column for this table.

```

Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of those people:

```
FirstName, LastName, City, State
```

## 思路

## 题解

```python
# Write your MySQL query statement below
SELECT Person.FirstName, Person.LastName, Address.City, Address.State
from Person LEFT JOIN Address on Person.PersonId = Address.PersonId;
```

击败93.47%