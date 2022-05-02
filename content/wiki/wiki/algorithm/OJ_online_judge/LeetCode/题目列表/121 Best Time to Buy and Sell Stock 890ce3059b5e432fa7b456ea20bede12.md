---
title: 121_Best_Time_to_Buy_and_Sell_Stock_890ce3059b5e432fa7b456ea20bede12
---

# 121. Best Time to Buy and Sell Stock

Difficulty: Easy
ID: 121
Solved?: Yes
Tags: Array, DP
击败: 92.49
推荐指数: ⭐⭐⭐

[Best Time to Buy and Sell Stock - LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)

只准买卖一次，且先买后卖。

## 题意

Say you have an array for which the *i*th element is the price of a given stock on day *i*.

If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Note that you cannot sell a stock before you buy one.

**Example 1:**

```
Input: [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
             Not 7-1 = 6, as selling price needs to be larger than buying price.

```

**Example 2:**

```
Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.

```

## 思路

1. 在买的时候，如果知道将来的最大值，那么就可以直接直到最大收益。从右往左遍历，记录右边的最大值（卖），当前值作为买。

## 题解

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        MAX = 0
        high = 0
        for i in reversed(range(len(prices))):
            profit = high - prices[i]
            MAX = max(MAX, profit)
            high = max(high, prices[i])
        return MAX
```

击败92.49%