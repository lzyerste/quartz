---
title: 188_Best_Time_to_Buy_and_Sell_Stock_IV_0feac6b9c89546519314b64efea7c888
---

# 188. Best Time to Buy and Sell Stock IV

Difficulty: Hard
ID: 188
Solved?: Yes
Tags: DP
击败: 100
推荐指数: ⭐⭐⭐⭐⭐

[Best Time to Buy and Sell Stock IV - LeetCode](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/)

## 题意

You are given an integer array `prices` where `prices[i]` is the price of a given stock on the `ith` day.

Design an algorithm to find the maximum profit. You may complete at most `k` transactions.

**Notice** that you may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

**Example 1:**

```
Input: k = 2, prices = [2,4,1]
Output: 2
Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2.

```

**Example 2:**

```
Input: k = 2, prices = [3,2,6,5,0,3]
Output: 7
Explanation: Buy on day 2 (price = 2) and sell on day 3 (price = 6), profit = 6-2 = 4. Then buy on day 5 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.

```

**Constraints:**

- `0 <= k <= 109`
- `0 <= prices.length <= 104`
- `0 <= prices[i] <= 1000`

## 思路

1. 使用题目123的解法，一个小优化：如果k很大，超过N的一半，那么总是可以采用贪心算法。
    
    更新了测试用例，有几个case会超时？price范围最大为1000是否可利用？
    
2. 复杂度从O(kN)降到O(N)
    
    [C++ Solution with O_n + klgn time using Max Heap and Stack - LeetCode Discuss](https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iv/discuss/54118/C%2B%2B-Solution-with-O(n-%2B-klgn)-time-using-Max-Heap-and-Stack)
    
3. DP的复杂度达到O(kN)，可以用贪心算法，复杂度降为O(klgN)。
    
    首先预处理，将价格分解为一个个区间，<valley, peak>。
    
    因为有限次交易，出现的问题是不知道在哪段区间交易，而且分一次交易还是多次交易。
    
    可以采用如下交易策略：
    
    - 如果大跌，那么，前面的区间就可以独立作为一次交易候选，因为后面的交易没必要连接它形成更长的交易区间。比如<5, 9>，新来一个<3, 7>，不管将来如何，<5, 9>都可以先拿出去了，因为将来要与<5, 9>结合的话，为什么不直接选用<3, 7>呢，因为它的买入成本更低，3 < 5。
    - 大跌处理完之后，就可能出现微跌情况，这时候要它接下来是否大涨。如果大涨，那么就可能出现如下情况：如果只剩一次交易机会，那么这次交易需要跨区间，买点在左，卖点在右；如果还有多次交易机会，那么独立交易的总和会得到最大。针对这种情况，有巧妙的处理方式：两个区间为<v1, p1>和<v2, p2>，且v2 ≥ v1，p2 > p1，合并这两个区间，左边的买点与右边的卖点形成一个新的大区间（原来的两个摘掉），这个区间满足了一次交易的最大收益；如果有多次交易机会呢，丢掉的收益哪去了？可以计算出这部分收益是p1-v2，也就是下跌部分可以吃到。
    - 经上面方式处理后，剩下的区间形式都是收缩型的，也就是v1 ≤ v2 ≤ p2 ≤ p1，比如<1, 10>, <4, 8>, <3, 7>。
    - 可能有个疑问，一次跨区间的长交易，中间会不会有独立交易呢？这不是破坏题目的先卖再买规则了么？比如上面的例子新来一个区间<3, 12>，它会把<4, 8>和<3, 7>都摘掉作为候选，然后与<1, 10>合并形成<1, 12>，当然附带有个<3, 10>候选。一次交易的话选择<1, 12>，如果还有交易机会的话，它会选择中间的独立交易吗，比如<4, 8>？这样是会破坏规则的。实际上，第二次交易不会选择中间的独立交易，而是选择之前的附带区间<3, 10>，这样之前的跨区间长交易就变成了两次独立交易了。接下来再有机会的话，再选其中的独立区间都是可以的。也就是说，两个区间合并之后，除了形成最大的交易区间以外，还附带了次大的交易区间。

## 题解

```python
class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        K, N = k, len(prices)
        if N < 2: return 0
        if K >= N // 2:
            # greedy
            return sum(max(0, prices[i] - prices[i - 1]) for i in range(1, N))
        
        dp = [[0 for c in range(N)] for r in range(K+1)]
        for k in range(1, K+1):
            minCost = prices[0]
            for i in range(1, N):
                dp[k][i] = max(dp[k][i-1], prices[i] - minCost)
                minCost = min(minCost, prices[i] - dp[k-1][i])
        return dp[K][N-1]
```

## 题解2：别人的解法

```python
class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        
        if len(prices) <= 1:
            return 0

        #This algorithm do a one time scan        
        profit = []
        vp_pair = []
        
        i = 0
        v, p = -1, -1
        while i + 1 < len(prices):
            #find the valley
            while i + 1 < len(prices) and prices[i+1] <= prices[i]:
                i += 1
            v = i
            #find the peak
            while i+1 < len(prices) and prices[i+1] > prices[i]:
                i += 1
            p = i
            
            if vp_pair:
                while vp_pair and prices[v] < prices[vp_pair[-1][0]]:
                    prev_vp = vp_pair.pop()
                    profit.append(prices[prev_vp[0]]-prices[prev_vp[1]])
                
                while vp_pair and prices[p] > prices[vp_pair[-1][1]]:
                    prev_vp = vp_pair.pop()
                    profit.append(prices[v]-prices[prev_vp[1]])
                    v = prev_vp[0]
            
            vp_pair.append([v,p])
        
        while vp_pair:
            vp = vp_pair.pop()
            profit.append(prices[vp[0]]-prices[vp[1]])
        #print(profit)
        heapify(profit)
        
        ans = 0
        while profit and k > 0:
            ans += max(0,-heappop(profit))
            k -= 1
        return ans
```

击败87.12%

## 题解3：贪心，基于他人解法

因为要制造最大堆，但heap是最小堆，所以profit用负数表示。

```python
class Solution:
    def maxProfit(self, k: int, prices: List[int]) -> int:
        def gen_vp_pairs(prices):
            n = len(prices)
            pairs = []
            i = 0
            while i + 1 < n:
                while i + 1 < n and prices[i+1] <= prices[i]:
                    i += 1
                v = i
                while i + 1 < n and prices[i+1] > prices[i]:
                    i += 1
                p = i
                pairs.append((v, p))
            return pairs
        
        vps = gen_vp_pairs(prices)  # <valley, peak> pairs
        # print(vps)
        profits = []  # profit candidate
        stack = []  # vp stack
        for v, p in vps:
            if stack:
                while stack and prices[v] <= prices[stack[-1][0]]:
                    v2, p2 = stack.pop()
                    profits.append(-(prices[p2] - prices[v2]))
                    # print(v, p, v2, p2, profits)
                while stack and prices[p] > prices[stack[-1][1]]:
                    v2, p2 = stack.pop()
                    profits.append(-(prices[p2] - prices[v]))
                    # print(v, p, v2, p2, profits)
                    v = v2
            stack.append((v, p))
            # print("stack:", stack)
        
        for v, p in stack:
            profits.append(-(prices[p] - prices[v]))
            
        # print(profits)
        
        if k >= len(profits):
            return -sum(profits)
        
        res = 0
        heapq.heapify(profits)
        while profits and k:
            res += -heapq.heappop(profits)
            k -= 1
        return res
```

击败100%