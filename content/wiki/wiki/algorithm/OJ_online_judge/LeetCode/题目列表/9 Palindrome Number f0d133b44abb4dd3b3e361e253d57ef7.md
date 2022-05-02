---
title: 9_Palindrome_Number_f0d133b44abb4dd3b3e361e253d57ef7
---

# 9. Palindrome Number

Difficulty: Easy
ID: 9
Solved?: Yes
Tags: Math
击败: 71.65
推荐指数: ⭐⭐

[Palindrome Number - LeetCode](https://leetcode.com/problems/palindrome-number/)

## 题意

判断一个`整数是否是回文数`。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。

示例 1:

```
输入: 121
输出: true
```

示例 2:

```
输入: -121
输出: false
解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
```

示例 3:

```
输入: 10
输出: false
解释: 从右向左读, 为 01 。因此它不是一个回文数。
```

**进阶:**

你能不将整数转为字符串来解决这个问题吗？

## 思路

- 转为字符串来判断回文
- 将整数倒转，然后比较两个整数是否相等

## 题解1：转为字符串

```python
class Solution:
    def isPalindrome(self, x: int) -> bool:
        s = str(x)
        return s == s[::-1]
```

击败71.65%

## 题解2：反转整数

类似：[7. Reverse Integer](7 Reverse Integer d3225ff3723e481eafc6c2cb43380337.md)

输入整数ABCDE，反转后变成EDCBA，比较这两个整数即可。

```python
class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x < 0: return False
        x1 = x
        y = 0
        while x > 0:
            x, r = divmod(x, 10)
            y = y * 10 + r
        return y == x1
```

击败37.00%

---

优化：反转一半就可以判断了。

比如输入整数为123321，走到一半时，x为123，y也是123了，说明是回文。

如果输入整数长度为奇数，比如12321，x走到12，y走到123，此时还要判断y去掉末位后是否与x相同。

注意0、10、100等以0结尾的整数。

```python
class Solution:
    def isPalindrome(self, x: int) -> bool:
        if x < 0 or (x != 0 and x % 10 == 0): return False
        y = 0
        while x > y:
            x, r = divmod(x, 10)
            y = y * 10 + r
        return x == y or x == y // 10
```

击败65.55%

## 历史解法

```python
# 整数求半
"""
将整数的右半部分重新逆序整合成一个数字，如12321生成123，原数字剩余部分为12。
"""

class Solution:
    def isPalindrome(self, x):
        """
        :type x: int
        :rtype: bool
        """
        if x < 0 or (x != 0 and x % 10 == 0):
            return False
        y = 0
        while x > y:
            x, r = divmod(x, 10)
            y = y * 10 + r
        return x == y or x == y // 10

if __name__ == "__main__":
    print(Solution().isPalindrome(1234321))  # True
    print(Solution().isPalindrome(110))  # False
```