---
title: 201_Bitwise_AND_of_Numbers_Range_70a448e6499746dabe3f385553fac03a
---

# 201. Bitwise AND of Numbers Range

Difficulty: Medium
ID: 201
Solved?: Yes
Tags: Bit Manipulation
击败: 92.66
推荐指数: ⭐⭐⭐⭐

[Bitwise AND of Numbers Range - LeetCode](https://leetcode.com/problems/bitwise-and-of-numbers-range/)

## 题意

Given a range [m, n] where 0 <= m <= n <= 2147483647, return the bitwise AND of all numbers in this range, inclusive.

**Example 1:**

```
Input: [5,7]
Output: 4

```

**Example 2:**

```
Input: [0,1]
Output: 0
```

## 思路

1. 暴力遍历。
2. 如果n比m大，那么[m, n]之间必定有个数的末位是0，或者说是偶数，所以最终AND的结果的末位是0。所以这种情况下，m和n都右移1位，然后可以递归调用，调用结果自然要左移1位来恢复。
3. AND的最终结果肯定不会超过数字m，但是m的二进制表示中的1能否保留呢？这个要看m与n之间有没有横跨一个2次幂，跨过2次幂这一位的结果就是0。比如m值为10**1**00，它的下一个2次幂是10**100** + **100** = 11000，检查n有没有超过这个数。如何从10100中提取100？这个就是上面提到的rightmost one问题，x & -x即可。
    
    2020-11-05 16:27:07，反过来先考虑n，我们看看n怎么保住它的1。看它的最右的一个1000，只要n-1这个数存在（只要n > m），那么，它的末尾就是，0111，AND一下就消失了。接下来，xxxx0000~xxxx1000（这个是n）部分的数字可以不用考虑了，它们AND的结果就是xxxx0000，前缀是一样的。这样就可以减小n的范围，继续考虑它的下一个1。
    
4. 如果有2次幂横亘在a和b之间，那么结果就是0，比如a为011010，b为101000，中间有2次幂100000，所以结果就是0。但是如果它们的高位都是1呢，比如a为111010，b为101000。这时候，我们先保留并忽略高位的1，那么a变为11010，b变为01000，这时候中间有个2次幂10000，这个临时结果就是0，拼上原来保留的1，最终结果就是100000。现在问题转化为寻找最大的2次幂c，使得a+c仍然落在区间[a, b]，这样的话，2次幂c可用来低位清零，另外其余高位保留。首先a^b，高位的0表示保留的位（即大家的bit是一致的，AND之后需要保留）。从异或结果的最高位1开始（包含），它右边的低位用来清零。我们首先将异或结果的低位全部置为1（或者说，计算比它大的最小2次幂，然后减1），然后取反，最后与a或者b取与即可。
5. 2020-11-05 16:14:53，如果m与n相等，直接返回m；要不然m < n，计算离n最近的2次幂，但要比n小，也就是2^k ≤ n < 2^(k+1)。如果m与2^k相等，那么直接返回2^k；如果m < 2^k ≤ n，那么结果是0，因为[2^k, n]部分AND结果就是2^k，但m比2^k小，那么唯一的1也保不住了；如果2^k < m < n < 2^(k+1)，说明区间[m, n]全部落在两个相邻2次幂之间，可以确定的是，[m, n]里的值第k位都是1，所以AND操作后，这个1是保住了，也就是2^k，剩余的怎么操作呢？可以将[m, n]的范围全部减去2^k，然后递归调用这个过程，dfs(m-2^k, n-2^k)。

## ★题解2：递归

```python
class Solution:
    def rangeBitwiseAnd(self, m: int, n: int) -> int:
        return self.rangeBitwiseAnd(m >> 1, n >> 1) << 1 if m < n else m
```

击败39.06%

## ★题解3

```python
class Solution:
    def rangeBitwiseAnd(self, m: int, n: int) -> int:
        while n >= m + (m & -m) and m > 0:
            m = m & (m - 1)  # m最右的1保不住
        return m
```

击败92.66%

```python
class Solution:
    def rangeBitwiseAnd(self, m: int, n: int) -> int:
        while n > m:
            n &= n -1
        return n
```

击败92.66%

## 题解4

```python
class Solution:
    def rangeBitwiseAnd(self, m: int, n: int) -> int:
        def bitands2(a, b):
            c = a ^ b
            c |= c >> 1
            c |= c >> 2
            c |= c >> 4
            c |= c >> 8
            c |= c >> 16
            return a & ~c

        return bitands2(m, n)
```

击败39.06%