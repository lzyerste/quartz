---
title: quick_sort，快速排序
---

# quick sort，快速排序

algs4/Quick3waySort.py

```python
class Quick3waySort:
    """分三路的快排：小于，等于，大于。
    分三路比两路还要好写。
    """

    @staticmethod
    def sort(items):
        Quick3waySort._sort(items, 0, len(items) - 1)

    @staticmethod
    def _sort(items, lo, hi):
        if hi <= lo: return
        v = items[lo]
        lt = lo  # 存放下一个小于的位置
        gt = hi  # 存放下一个大于的位置
        # A[lo..lt-1] < v = A[lt..gt] < A[gt+1..hi]
        i = lo + 1
        # [i, gt]之间未探索，[lo, lt)为小于，[lt, i)为等于，(gt, hi]为大于
        # 这个不变式要一直保持成立。
        # 注意，只有相等的情况下i才往下走。
        while i <= gt:  # 注意等号
            if items[i] < v:
                items[lt], items[i] = items[i], items[lt]
                lt += 1
            elif v < items[i]:
                items[gt], items[i] = items[i], items[gt]
                gt -= 1
            else:
                i += 1
        Quick3waySort._sort(items, lo, lt - 1)
        Quick3waySort._sort(items, gt + 1, hi)

if __name__ == "__main__":
    nums = [1, 5, 3, 2, 4]
    Quick3waySort.sort(nums)
    print(nums)
```

## TopK

## 其他

```python
def insertion_sort(nums, lo, hi):
    for i in range(lo + 1, hi):
        j = i
        while j > lo and nums[j] < nums[j-1]:
            nums[j], nums[j-1] = nums[j-1], nums[j]
            j -= 1

def quicksplit(nums, lo, hi):
    """
    [lo, hi)
    return [mlo, mhi)
    """
    pivot = nums[lo]
    i = lo + 1
    j = hi
    # nums[lo+1, j) <= pivot
    # nums[j, hi) > pivot
    while i < j:
        if pivot < nums[i]:
            j -= 1
            nums[i], nums[j] = nums[j], nums[i]
        else:
            i += 1
    mhi = j

    i = lo + 1
    # nums[lo+1, mlo) < pivot
    # nums[mlo, mhi) = pivot
    while i < j:
        if nums[i] < pivot:
            i += 1
        else:
            j -= 1
            nums[i], nums[j] = nums[j], nums[i]
    mlo = j - 1
    nums[lo], nums[mlo] = nums[mlo], nums[lo]  # handle pivot
    return mlo, mhi

def _quicksort(nums, lo, hi):
    """
    [lo, hi)
    """
    if hi - lo < 8:
        insertion_sort(nums, lo, hi)
        return
    mlo, mhi = quicksplit(nums, lo, hi)  # [mlo, mhi)
    _quicksort(nums, lo, mlo)
    _quicksort(nums, mhi, hi)

def quicksort(nums):
    _quicksort(nums, 0, len(nums))

if __name__ == '__main__':
    nums = list(range(20))[::-1]
    insertion_sort(nums, 0, len(nums))
    print(nums)
    nums = list(range(50))[::-1]
    quicksort(nums)
    print(nums)
    nums = [1] * 25 + [0] * 25
    quicksort(nums)
    print(nums)
```