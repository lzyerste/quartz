---
title: 整数区间的任意两个数的OR运算，最大值
---

# 整数区间的任意两个数的OR运算，最大值

先二进制表示对齐（高位补0），然后从高到低，遇到不一样的作为分割线，从它开始后面总是可以组成全1，它前面的则是保留共同部分。

```python
def to_bin(x):
    return bin(int(x))[2:]

def solve(a, b):
    if a == b: return a
    a, b = to_bin(a), to_bin(b)
    MAX = max(len(a), len(b))
    a = "0" * (MAX - len(a)) + a
    b = "0" * (MAX - len(b)) + b
    for i in range(MAX):
        if a[i] != b[i]:
            break
    res = a[:i] + "1" * (MAX - i)
    return int(res, base=2)

def main():
    assert solve(114, 515) == 1023
    assert solve(4611686018427387973, 4819578321603258783) == 4899916394579099647
```