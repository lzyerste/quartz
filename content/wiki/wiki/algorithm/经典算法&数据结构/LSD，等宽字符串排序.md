---
title: LSD，等宽字符串排序
---

# LSD，等宽字符串排序

algs4/LSD.py

```python
class LSD:
    """least-significant-digit first (LSD) string sort.
    对等宽字符串进行排序，从右到左，对每一位做Radix Sort。
    """

    @staticmethod
    def sort(A, W):
        """LSD排序。
        
        Arguments:
            A {list[str]} -- 待排序的字符串数组
            W {int} -- 等宽字符串的长度
        """
        R = 256  # 字符的ASCII范围
        for d in range(W)[::-1]:
            # 1. count frequency
            count = [0 for _ in range(R + 1)]
            for a in A:
                count[ord(a[d])] += 1
            # 2. cal preSum
            preSum = [0 for _ in range(R + 1)]
            for i in range(R):
                preSum[i] = preSum[i-1] + count[i-1]
            # 3. move to aux
            aux = [None for _ in range(len(A))]
            for a in A:
                aux[preSum[ord(a[d])]] = a
                preSum[ord(a[d])] += 1
            # 4. copy back
            A[:] = aux

if __name__ == "__main__":
    W = 7
    A = ["4PGC938", "2IYE230", "3CIO720", "1ICK750", "1OHV845", "4JZY524",
         "1ICK750", "3CIO720", "1OHV845", "1OHV845", "2RLA629", "2RLA629",
         "3ATW723"]
    LSD.sort(A, W)
    print(A)
```