---
title: 285C_Building_Permutation_e5bc656607c74cd984b465c38084e5dc
---

# 285C. Building Permutation

ID: 285
Tags: greedy, implementation, sortings
github: No
已解: Yes
推荐指数: ⭐⭐⭐
难度: 1200

[Problem - 285C - Codeforces](https://codeforces.com/problemset/problem/285/C)

```python
def main():
    n = read_int()
    A = read_ints()
    A.sort()
    total = 0
    for i, x in enumerate(A):
        total += abs(i + 1 - x)
    print(total)

from collections import *

MOD = 998244353

#---------------------------------FAST_IO---------------------------------------

import os
import sys
from io import BytesIO, IOBase
# region fastio

BUFSIZE = 8192

class FastIO(IOBase):
    newlines = 0

    def __init__(self, file):
        self._fd = file.fileno()
        self.buffer = BytesIO()
        self.writable = "x" in file.mode or "r" not in file.mode
        self.write = self.buffer.write if self.writable else None

    def read(self):
        while True:
            b = os.read(self._fd, max(os.fstat(self._fd).st_size, BUFSIZE))
            if not b:
                break
            ptr = self.buffer.tell()
            self.buffer.seek(0, 2), self.buffer.write(b), self.buffer.seek(ptr)
        self.newlines = 0
        return self.buffer.read()

    def readline(self):
        while self.newlines == 0:
            b = os.read(self._fd, max(os.fstat(self._fd).st_size, BUFSIZE))
            self.newlines = b.count(b"\n") + (not b)
            ptr = self.buffer.tell()
            self.buffer.seek(0, 2), self.buffer.write(b), self.buffer.seek(ptr)
        self.newlines -= 1
        return self.buffer.readline()

    def flush(self):
        if self.writable:
            os.write(self._fd, self.buffer.getvalue())
            self.buffer.truncate(0), self.buffer.seek(0)

class IOWrapper(IOBase):
    def __init__(self, file):
        self.buffer = FastIO(file)
        self.flush = self.buffer.flush
        self.writable = self.buffer.writable
        self.write = lambda s: self.buffer.write(s.encode("ascii"))
        self.read = lambda: self.buffer.read().decode("ascii")
        self.readline = lambda: self.buffer.readline().decode("ascii")

sys.stdin, sys.stdout = IOWrapper(sys.stdin), IOWrapper(sys.stdout)
input = lambda: sys.stdin.readline().rstrip("\r\n")

#----------------------------------IO_WRAP--------------------------------------

def read_int():
    return int(input())

def read_ints():
    return list(map(int, input().split()))

def print_nums(nums):
    print(" ".join(map(str, nums)))

def YES():
    print("YES")

def Yes():
    print("Yes")

def NO():
    print("NO")

def No():
    print("No")

#----------------------------------FIB--------------------------------------

def fib(n):
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a

def fib_ns(n):
    assert n >= 1
    f = [0 for _ in range(n + 1)]
    f[0] = 0
    f[1] = 1
    for i in range(2, n + 1):
        f[i] = f[i - 1] + f[i - 2]
    return f

#----------------------------------MOD--------------------------------------

def gcd(a, b):
    if a == 0:
        return b
    return gcd(b, a % b)

def xgcd(a, b):
    """return (g, x, y) such that a*x + b*y = g = gcd(a, b)"""
    x0, x1, y0, y1 = 0, 1, 1, 0
    while a != 0:
        (q, a), b = divmod(b, a), a
        y0, y1 = y1, y0 - q * y1
        x0, x1 = x1, x0 - q * x1
    return b, x0, y0

def modinv(a, m):
    """return x such that (a * x) % m == 1"""
    g, x, _ = xgcd(a, m)
    if g != 1:
        raise Exception('gcd(a, m) != 1')
    return x % m

def mod_add(x, y):
    x += y
    while x >= MOD:
        x -= MOD
    while x < 0:
        x += MOD
    return x

def mod_mul(x, y):
    return (x * y) % MOD

def mod_pow(x, y):
    if y == 0:
        return 1
    if y % 2:
        return mod_mul(x, mod_pow(x, y - 1))
    p = mod_pow(x, y // 2)
    return mod_mul(p, p)

def mod_inv(y):
    return mod_pow(y, MOD - 2)

def mod_div(x, y):
    # y^(-1): Fermat little theorem, MOD is a prime
    return mod_mul(x, mod_inv(y))

#---------------------------------MAIN---------------------------------------

main()
```