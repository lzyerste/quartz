---
title: Quick3string，字符串三路分组排序
---

# Quick3string，字符串三路分组排序

algs4/Quick3stringSort.py

```python
class Quick3string:
    """字符串的三路快速排序。
    对应algs4的算法5.3，720页。
    """
    @staticmethod
    def sort(A):
        return Quick3string.__sort(A, 0, 0, len(A) - 1)

    @staticmethod
    def __sort(A, d, lo, hi):
        def idx(s, i):
            return -1 if i >= len(s) else ord(s[i])
        
        if hi <= lo: return
        pivot = idx(A[lo], d)  # 可能为-1
        lt, gt = lo, hi
        i = lt
        while i <= gt:
            if idx(A[i], d) < pivot:
                A[i], A[lt] = A[lt], A[i]
                lt += 1
            elif idx(A[i], d) > pivot:
                A[i], A[gt] = A[gt], A[i]
                gt -= 1
            else:
                i += 1
        Quick3string.__sort(A, d + 1, lo, lt - 1)
        if pivot >= 0:  # 如果是-1，接下来为空串了，不需要再排序
            Quick3string.__sort(A, d + 1, lt, gt)
        Quick3string.__sort(A, d + 1, gt + 1, hi)

if __name__ == "__main__":
    A = ["she", "sells", "seashells", "by", "the", "seashore", 
         "the", "shells", "she", "sells", "are", "surely", "seashells"]
    Quick3string.sort(A)
    print(A)
```