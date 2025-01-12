---
title: 36_Valid_Sudoku_a431ffd8aced4dc29d131fdab47742f7
---

# 36. Valid Sudoku

Difficulty: Medium
ID: 36
Solved?: Yes
Tags: Hash Table
击败: 96.99
推荐指数: ⭐⭐⭐

[Valid Sudoku - LeetCode](https://leetcode.com/problems/valid-sudoku/)

## 题意

判断一个 9x9 的数独是否有效。只需要**根据以下规则**，验证已经填入的数字是否有效即可。

1. 数字 `1-9` 在每一行只能出现一次。
2. 数字 `1-9` 在每一列只能出现一次。
3. 数字 `1-9` 在每一个以粗实线分隔的 `3x3` 宫内只能出现一次。

![https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/250px-Sudoku-by-L2G-20050714.svg.png](https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/250px-Sudoku-by-L2G-20050714.svg.png)

上图是一个部分填充的有效的数独。

数独部分空格内已填入了数字，空白格用 `'.'` 表示。

**示例 1:**

```
输入:
[
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
输出: true
```

**示例 2:**

```
输入:
[
  ["8","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]
输出: false
解释: 除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。
     但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。
```

**说明:**

- 一个有效的数独（部分已被填充）不一定是可解的。
- 只需要根据以上规则，验证已经填入的数字是否有效即可。
- 给定数独序列只包含数字 `1-9` 和字符 `'.'` 。
- 给定数独永远是 `9x9` 形式的。

## 思路

- 暴力解法：每行、每列、每个方块有没有重复数字

## 题解1：暴力

```python
class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        valid = all([self.check_row(board, r) for r in range(9)])
        if not valid:
            return valid
        valid = all([self.check_col(board, c) for c in range(9)])
        if not valid:
            return valid
        valid = all([self.check_box(board, i) for i in range(9)])
        return valid
        
    def check_row(self, board, r):
        res = []
        for c in board[r]:
            if c != '.':
                res.append(c)
        return len(res) == len(set(res))
    
    def check_col(self, board, c):
        res = []
        for row in board:
            if row[c] != '.':
                res.append(row[c])
        return len(res) == len(set(res))
    
    def check_box(self, board, i):
        r, c = divmod(i, 3)
        r *= 3
        c *= 3
        res = []
        for i in range(3):
            for j in range(3):
                ch = board[r + i][c + j]
                if ch != ".":
                    res.append(ch)
        return len(res) == len(set(res))
```