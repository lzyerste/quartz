---
title: merge_sort，归并排序
---

# merge sort，归并排序

algs4/MergeSort.py

```python
class Merge:
    """归并排序。
    思路：将序列对半拆成左右两部分，递归调用归并排序。
    各自排好序后再合并成一个大的排好序的序列。
    """

    @staticmethod
    def sort(items):
        items[:] = Merge._sort(items) 

    @staticmethod
    def _sort(items):
        n = len(items)
        if n <= 1:
            return items
        M = (n + 1) // 2  # 注意偏右
        A = Merge._sort(items[:M])
        B = Merge._sort(items[M:])
        return Merge.merge(A, B)

    @staticmethod
    def merge(A, B):
        T = []
        i = j = 0
        while i < len(A) and j < len(B):
            if A[i] < B[j]:
                T.append(A[i])
                i += 1
            else:
                T.append(B[j])
                j += 1
        T += A[i:]
        T += B[j:]
        return T

if __name__ == "__main__":
    nums = [1, 5, 3, 2, 4]
    Merge.sort(nums)
    print(nums)
```