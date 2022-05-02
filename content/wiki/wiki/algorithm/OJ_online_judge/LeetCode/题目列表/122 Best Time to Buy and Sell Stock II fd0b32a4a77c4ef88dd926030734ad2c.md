---
title: 122_Best_Time_to_Buy_and_Sell_Stock_II_fd0b32a4a77c4ef88dd926030734ad2c
---

# 122. Best Time to Buy and Sell Stock II

Difficulty: Easy
ID: 122
Solved?: Yes
Tags: Array, Greedy
击败: 99.87
推荐指数: ⭐⭐⭐⭐

[Best Time to Buy and Sell Stock II - LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/)

[121. Best Time to Buy and Sell Stock](121 Best Time to Buy and Sell Stock 890ce3059b5e432fa7b456ea20bede12.md) 

## 题意

Say you have an array `prices` for which the *i*th element is the price of a given stock on day *i*.

Design an algorithm to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times).

**Note:** You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

**Example 1:**

```
Input: [7,1,5,3,6,4]
Output: 7
Explanation: Buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
             Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.

```

**Example 2:**

```
Input: [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
             Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
             engaging multiple transactions at the same time. You must sell before buying again.

```

**Example 3:**

```
Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.
```

**Constraints:**

- `1 <= prices.length <= 3 * 10 ^ 4`
- `0 <= prices[i] <= 10 ^ 4`

## 思路

1. 将价格数组分解为各个递增区间，在区间的起始处买入，区间的终点处卖出，也就是一直追涨，在当前看到的最高点卖出（贪心算法？）。
2. 可以将上面的一个递增大区间划分为一个个小区间，小区间的收益总和就是大区间的收益。这样可以简化处理：只要今天价格比昨天的高，那么就执行昨天买，今天卖。

## 题解1

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices: return 0
        profit = 0
        begin = end = prices[0]
        for price in prices:
            if price >= end:  # increasing
                end = price
            else:  # drop
                profit += end - begin
                begin = end = price
        profit += end - begin
        return profit
```

击败69.67%

begin和end代表了一个递增的价格区间。if判断仅仅将区间往右扩展；else则是发现价格下降了，需要结算前一个区间，然后重新开一个区间。注意退出循环时最后一个区间需要结算。如果区间只有一个元素，相当于买卖在当天，收益为0。

## 题解2

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        profit = 0
        prev = float("inf")
        for price in prices:
            profit += max(0, price - prev)
            prev = price
        return profit
```

击败99.87%