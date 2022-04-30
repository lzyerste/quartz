---
title: 65_Valid_Number_8eac2e4245b64db8ba54c62c08254aa7
---

# 65. Valid Number

Difficulty: Hard
ID: 65
Solved?: Yes
Tags: Math
击败: 79.52
推荐指数: ⭐⭐⭐⭐

[Valid Number - LeetCode](https://leetcode.com/problems/valid-number/)

## 题意

## 题解：仔细分解

正负号解析；是否可以为空。

```python
class Solution:
    def isNumber(self, s: str) -> bool:
        s = s.strip()

        def assertUnsigned(s, allowNull):
            if s == "": return allowNull  # 是否允许为空
            return all(c.isnumeric() for c in s)
            
        def assertSigned(s, allowNull):
            if s == "": return allowNull
            if s[0] in "+-": s = s[1:]  # 处理符号
            return assertUnsigned(s, allowNull)
        
        def assertFloat(s):
            if s == "": return False  # 不可为空
            if s[0] in "+-": s = s[1:]  # 处理符号
            if s == ".": return False  # 单单一个点号是不行的
            # unsigned now
            idx = s.find(".")
            if idx >= 0:
                # 不会两者皆为空，因为之前点号判断过的
                # 支持3.和.4的情况
                return assertUnsigned(s[:idx], True) and assertUnsigned(s[idx + 1:], True)
            else:
                return assertUnsigned(s, False)  # 不能为空

        def check(s):
            if s == "": return False
            eIdx = s.find("e")
            if eIdx >= 0:  # e的左右两边皆不可为空
                return assertFloat(s[:eIdx]) and assertSigned(s[eIdx + 1:], False)
            else:
                return assertFloat(s)
        
        return check(s)
```