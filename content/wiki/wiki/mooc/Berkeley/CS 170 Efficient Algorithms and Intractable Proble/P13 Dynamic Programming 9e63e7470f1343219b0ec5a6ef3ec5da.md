---
title: P13_Dynamic_Programming_9e63e7470f1343219b0ec5a6ef3ec5da
---

# P13: Dynamic Programming

- Longest Increasing Subsequence, LIS
    - [7, 3, 5, 6, 8, 2, 10, 4, 9, 1]
    - 方法一：转为Graph，DAG
        - Subproblem: `L[i]` = length of LIS ending at a[i]
        - Recurrence Relation，递推式
            
            ![b9d0c5e8cf123ae73f8e0d4dca68cf00](P13 Dynamic Programming 9e63e7470f1343219b0ec5a6ef3ec5da/b9d0c5e8cf123ae73f8e0d4dca68cf00.png)
            
        - iterative call VS. recursive call
        - 递归也是可以的，但要加上记忆（memorization），防止重复计算
- Optimal Gambling
- Edit Distance
    
    ![f45a3205800da2011e1ccd2abd882450](P13 Dynamic Programming 9e63e7470f1343219b0ec5a6ef3ec5da/f45a3205800da2011e1ccd2abd882450.png)
    
-