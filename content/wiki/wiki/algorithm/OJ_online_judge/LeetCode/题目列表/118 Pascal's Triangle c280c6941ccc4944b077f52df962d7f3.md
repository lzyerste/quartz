---
title: 118_Pascal's_Triangle_c280c6941ccc4944b077f52df962d7f3
---

# 118. Pascal's Triangle

Difficulty: Easy
ID: 118
Solved?: Yes
Tags: Array, Math
击败: 69.43
推荐指数: ⭐⭐

[Pascal's Triangle - LeetCode](https://leetcode.com/problems/pascals-triangle/)

## 题意

给定一个非负整数 *numRows，*生成`杨辉三角`的前 *numRows* 行。

![https://upload.wikimedia.org/wikipedia/commons/0/0d/PascalTriangleAnimated2.gif](https://upload.wikimedia.org/wikipedia/commons/0/0d/PascalTriangleAnimated2.gif)

在杨辉三角中，每个数是它左上方和右上方的数的和。

**示例:**

```
输入: 5
输出:
[
     [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]
]
```

## 思路

1. 直接递归

## 题解1：递归

要生成第k行，可以先生成前面的1~k-1行，根据之前的结果生成新的第k行，添加到结果中。

```python
class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        # basic cases
        if numRows == 0:
            return []
        if numRows == 1:
            return [[1]]
        if numRows == 2:
            return [[1], [1, 1]]
        res = self.generate(numRows - 1)
        row = res[-1]  # last row from previous result
        newRow = [1]  # new row to be generated
        for i in range(len(row) - 1):
            newRow.append(row[i] + row[i + 1])
        newRow.append(1)
        res.append(newRow)
        return res
```

击败69.43%