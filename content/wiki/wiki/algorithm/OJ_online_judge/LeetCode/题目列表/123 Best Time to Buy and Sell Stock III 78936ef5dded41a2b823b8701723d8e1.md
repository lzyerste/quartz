---
title: 123_Best_Time_to_Buy_and_Sell_Stock_III_78936ef5dded41a2b823b8701723d8e1
---

# 123. Best Time to Buy and Sell Stock III

Difficulty: Hard
ID: 123
Solved?: Yes
Tags: Array, DP
击败: 30.66
推荐指数: ⭐⭐⭐⭐⭐

[Best Time to Buy and Sell Stock III - LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/)

[121. Best Time to Buy and Sell Stock](121 Best Time to Buy and Sell Stock 890ce3059b5e432fa7b456ea20bede12.md) 

[122. Best Time to Buy and Sell Stock II](122 Best Time to Buy and Sell Stock II fd0b32a4a77c4ef88dd926030734ad2c.md) 

[188. Best Time to Buy and Sell Stock IV](188 Best Time to Buy and Sell Stock IV 0feac6b9c89546519314b64efea7c888.md) 

## 题意

Say you have an array for which the *i*th element is the price of a given stock on day *i*.

Design an algorithm to find the maximum profit. You may complete at most *two* transactions.

**Note:** You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

**Example 1:**

```
Input: prices = [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
```

**Example 2:**

```
Input: prices = [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.

```

**Example 3:**

```
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.

```

**Example 4:**

```
Input: prices = [1]
Output: 0

```

**Constraints:**

- `1 <= prices.length <= 105`
- `0 <= prices[i] <= 105`

## 思路

1. DP：最多交易两次，那么可以从中间划一刀，左边交易一次，右边交易一次。左边的形式为dp(0, k)，右边的形式为dp(k, n-1)，左边的左边界不变，右边的右边界不变，所以实际上是一维。
    
    dp(0, k) = max(dp(0, k-1), prices[k] - Low[k])，后一项表示在第k天卖出，什么时候买入呢，Low[k]表示k及k之前的最小价格。Low可以预先一遍遍历生成（从左到右）。
    
    类似的，dp(k, n-1) = max(dp(k+1, n-1), High[k] - prices[k])，后一项表示在第k天买入，在之后的最高价时卖出。High可以预先一遍遍历生成（从右到左）。
    
2. 通用解法：二维DP
    
    [A clean DP solution which generalizes to k transactions - LeetCode Discuss](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/discuss/39608/A-clean-DP-solution-which-generalizes-to-k-transactions)
    
    [Detail explanation of DP solution - LeetCode Discuss](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/discuss/135704/Detail-explanation-of-DP-solution)
    
    二维dp(k, i)，表示有k次交易，价格范围为[0..i]。可以写出递推式：
    
    dp(k, i) = max(dp(k, i-1), max(prices[i] - prices[j] + dp(k-1, j) for 0 ≤ j ≤ i-1)，第一项表示放弃第i项，在前i-1范围内交易；第二项表示在第i天卖出，对应的最佳买入在哪里呢？第j天，j的范围显然是[0..i-1]。第二项将prices[i]拎出来，max里面保留j相关的：prices[i] + max(dp(k-1, j) - prices[j])。
    
    画出dp的二维图，横轴为prices，纵轴为k，观察dp(k, i)与什么相关，以及dp往后走的时候，相关量是怎么变化的。第二项中，dp(k, i+1)与max(dp(k-1, j) - prices[j])相关，这个跟dp(k, i)是很像的，只是j的取值范围大了一个。所以，从左到右遍历的时候，这个max值可以保存并复用。
    
    另外，空间虽然用了O(kN)，但实际上是可以压缩的，当前行给下一行用，压缩后只需要一行就够了，O(N)。
    
3. 极致压缩空间，使用O(k)，dp(k, i)的时候把i作为第一层循环，把k作为第二层循环，类似i作为纵轴，k作为横轴？其实相当于有2个dp在里面，H[k, i] = min(prices[j] - D[k-1, j]) for 0 <= j <= i，这是新加的dp递推式，它实际代表的含义则是：在[0..i]范围内交易k-1次，然后再买入一笔，这一笔买入的成本被之前的k-1次交易所得的利润抵消，成本大大降低。

## 题解1

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        if not prices: return 0
        n = len(prices)
        self.High = {}  # High[k], highest after k
        self.High[n] = float("-inf")
        for i in reversed(range(n)):
            self.High[i] = max(prices[i], self.High[i+1])
        self.Low = {}  # Low[k], lowest before k
        self.Low[-1] = float("inf")
        for i in range(n):
            self.Low[i] = min(prices[i], self.Low[i-1])
        
        G = {0:0}
        H = {n-1:0}
        MAX = 0
        for k in range(n):
            profit = self.dp_left(G, k, prices) + self.dp_right(H, k, prices)
            MAX = max(MAX, profit)
        return MAX

    def dp_left(self, G, k, prices):
        # max profit in range [0..k]
        if k in G: return G[k]
        # sell at k
        profit = prices[k] - self.Low[k]
        G[k] = max(self.dp_left(G, k-1, prices), profit)
        return G[k]
    
    def dp_right(self, H, k, prices):
        # max profit in range [k..n-1]
        if k in H: return H[k]
        # buy at k
        profit = self.High[k] - prices[k]
        H[k] = max(self.dp_right(H, k+1, prices), profit)
        return H[k]
```

击败9.76%

复杂度的系数比较高么？

## 题解2

```python
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        K = 2
        N = len(prices)
        if N < 2: return 0
        dp = [[0 for c in range(N)] for r in range(K+1)]
        for c in range(N):
            dp[0][c] = 0
        
        for k in range(1, K+1):
            **prevMax = dp[k-1][0] - prices[0]**
            for i in range(1, N):
                **prevMax = max(prevMax, dp[k-1][i-1] - prices[i-1])**
                dp[k][i] = max(dp[k][i-1], prices[i] + prevMax)
        return dp[K][N-1]
```

击败30.66%

## 题解3

```python
# let H[k, i] = min(prices[j] - D[k-1, j]) for 0 <= j <= i
#     it represents the minimum net buy cost before i 
# D[k, i] = max(D[k, i-1], prices[i] - H[k-1, i-1])
# H[k-1, i] = min(H[k-1, i-1], prices[i] - D[k-1, i])
#
# next loop based on i:
# D[k, i+1] = max(D[k, i], prices[i+1] - H[k-1, i])
# H[k-1, i] is prepared in the previous loop
# i in D[k, i] and H[k, i] can be eliminated.
class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        K, N = 2, len(prices)
        D = [0 for _ in range(K+1)]
        H = [prices[0] for _ in range(K+1)]
        for i in range(1, N):
            for k in range(1, K+1):
                D[k] = max(D[k], prices[i] - H[k-1])
                H[k-1] = min(H[k-1], prices[i] - D[k-1])
        return D[K]
```

击败26.86%