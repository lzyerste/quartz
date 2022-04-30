---
title: Radix_Sort，基数排序
---

# Radix Sort，基数排序

algs4/RadixSort.py

```python
class Radix:
    """基数排序
    输入一堆小范围的数（如0到9），将它们排好序。
    """
    
    @staticmethod
    def sort(A, N):
        """A中元素数值范围为[0..N]。
        count与preSum是可以合并的（count的索引往后挪1），但分开比较好理解。
        基数排序的一大特性是stable。
        """
        # count[i]表示数值i出现的次数。
        count = [0 for _ in range(N + 2)]  # 多一个给-1
        for a in A:
            count[a] += 1
        # preSum[i]表示数值i之前（小于）的元素个数，接下来就可以放置数值i。
        preSum = [0 for _ in range(N + 2)]  # 0..N+1，最后一个也表示-1
        for i in range(N + 1):  # 统计preSum
            preSum[i] = preSum[i-1] + count[i-1]
        aux = [None for _ in range(len(A))]
        for a in A:
            aux[preSum[a]] = a
            preSum[a] += 1
        A[:] = aux

if __name__ == "__main__":
    N = 9
    A = [9, 8, 8, 7, 7, 7, 6, 5, 5, 4, 4, 3, 2, 1, 1, 0]
    Radix.sort(A, N)
    print(A)
```