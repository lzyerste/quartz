---
title: 180_Consecutive_Numbers_f70900303242463d8025daeaebd27352
---

# 180. Consecutive Numbers

Difficulty: Medium
ID: 180
Solved?: Yes
Tags: SQL
击败: 90.77
推荐指数: ⭐⭐

[Consecutive Numbers - LeetCode](https://leetcode.com/problems/consecutive-numbers/)

## 题意

SQL Schema

Write a SQL query to find all numbers that appear at least three times consecutively.

```
+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+

```

For example, given the above `Logs` table, `1` is the only number that appears consecutively for at least three times.

```
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
```

## 思路

## 题解

```python
# Write your MySQL query statement below
Select DISTINCT l1.Num as ConsecutiveNums from Logs l1, Logs l2, Logs l3 
where l1.Id=l2.Id-1 and l2.Id=l3.Id-1 
and l1.Num=l2.Num and l2.Num=l3.Num
```

击败90.77%