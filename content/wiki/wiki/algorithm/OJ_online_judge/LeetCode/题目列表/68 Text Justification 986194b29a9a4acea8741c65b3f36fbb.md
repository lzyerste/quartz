---
title: 68_Text_Justification_986194b29a9a4acea8741c65b3f36fbb
---

# 68. Text Justification

Difficulty: Hard
ID: 68
Solved?: Yes
Tags: String
击败: 76.74
推荐指数: ⭐⭐⭐⭐

[Text Justification - LeetCode](https://leetcode.com/problems/text-justification/)

## 题意

## 题解：

- 先补齐一行，能塞多少单词就塞多少（注意间隔空格至少为1）。剩余的递归生成。
- 一行的单词要在中间补充空格，主要空格数量不是恒定的。

```python
class Solution:
    def fullJustify(self, words: List[str], maxWidth: int) -> List[str]:
        def makeSentence(words, maxWidth):  # 拼接一行
            length = sum(map(len, words))
            K = len(words) - 1  # 间隔数量
            M = maxWidth - length  # 空格数
            if K == 0: return words[0] + " " * M
            E, R = divmod(M, K)  # E为基本空格数，R为余数，补给前面各1个
            s = words[0]
            i = 1
            while i < len(words):
                e = E
                if R:
                    e += 1
                    R -= 1
                s += " " * e + words[i]
                i += 1
            return s
        
        def rec(words, maxWidth):
            if len(words) == 0: return []
            tmp = [words[0]]
            left = maxWidth - len(words[0])
            i = 1
            while i < len(words) and len(words[i]) + 1 <= left:
                tmp.append(words[i])
                left -= len(words[i]) + 1
                i += 1
            if i == len(words):
                # last line
                s = " ".join(tmp)
                s += " " * (maxWidth - len(s))
                return [s]
            else:  # 剩余递归
                sentence = makeSentence(tmp, maxWidth)
                return [sentence] + rec(words[i:], maxWidth)
                
        return rec(words, maxWidth)
```