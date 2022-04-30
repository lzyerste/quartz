---
title: TopK
---

# TopK

- 返回数组最小的K个元素（有序），用堆。
- 返回数组最小的K个元素（无序），用快排的partition思想。
- 返回第K大元素（从0开始计数）。先选最小的K+1个元素，然后选最大即可。

algs4/TopK.py

```python
class TopK:
    @staticmethod
    def ordered(A, k):
        """返回数组A中最小的k个值（有序），k从1开始计数。也就是假设排好序后的前k个元素。
        假设k<=len(A)。
        思路：保持k个元素的最大堆，一直往里塞元素，以及丢弃当前最大的元素，
        剩下的一直是当前最小的k个元素。
        """
        from Heap import Heap
        # 使用最大堆
        heap = [-A[i] for i in range(k)]
        Heap.heapify(heap)
        for i in range(k, len(A)):
            Heap.heappush(heap, -A[i])
            Heap.heappop(heap)  # 丢弃当前最小值
        res = []
        while heap:
            res.append(-Heap.heappop(heap))
        return res[::-1]

    @staticmethod
    def unordered(A, k):
        """返回数组A中最小的k个元素，不需要有序。
        使用快排的partition思想。
        """
        def helper(A, k, lo, hi):
            # [lt..gt]为等于pivot部分
            # [lo, lt)为小于pivot部分
            # (gt, hi]为大于pivot部分
            pivot = A[lo]
            lt = lo
            gt = hi
            i = lo + 1
            while i <= gt:
                if A[i] < pivot:
                    A[lt], A[i] = A[i], A[lt]
                    lt += 1  # i不变，因为交换后需要继续排查
                elif A[i] > pivot:
                    A[gt], A[i] = A[i], A[gt]
                    gt -= 1  # i不变，因为交换后需要继续排查
                else:
                    i += 1
            if k <= lt - lo:  # 左部分元素个数不少于k个，且内部顺序未知
                helper(A, k, lo, lt - 1)  # 只需要处理左部分
            if k > gt - lo + 1:  # 有部分元素落在右部分，而右部分的内部顺序未知
                helper(A, k - (gt - lo + 1), gt + 1, hi)  # 只需要处理右部分
            # 如果位于[lt..gt]，那就相当于分好了，不用进一步处理。
            # 因为中间部分都是等于pivot，相当于排好序了。
        
        helper(A, k, 0, len(A) - 1)
        return A[:k]  # 分好元素后，保证前k个是整体最小的，但内部是无序的

    @staticmethod
    def kth(A, k):
        """返回数组第k大元素，从0开始计数。
        第k大，包含它本身，那就是前面有k+1个元素。
        将这k+1个元素捞出来之后，挑选最大的就行。
        """
        TopK.unordered(A, k + 1)
        return max(A[:k+1])

if __name__ == "__main__":
    import random
    A = list(range(100))
    random.shuffle(A)
    k = 10
    print(TopK.ordered(A, k))

    print("-" * 20)

    A = list(range(100))
    random.shuffle(A)
    k = 10
    print(TopK.unordered(A, k))

    print("-" * 20)
    A = list(range(100))
    random.shuffle(A)
    k = 0
    print(TopK.kth(A, k))
    k = 42
    print(TopK.kth(A, k))
```