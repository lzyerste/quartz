---
title: insertion_sort，插入排序
---

# insertion sort，插入排序

algs4/InsertionSort.py

```python
class Insertion:
    @staticmethod
    def sort(items):
        """插入排序。
        保持前面已是排好序的。
        处理当前值，如果比前面的小，那么一直交换过去。
        
        Arguments:
            items {[type]} -- [description]
        """
        n = len(items)
        for i in range(1, n):
            j = i
            while j > 0 and items[j] < items[j-1]:
                items[j], items[j-1] = items[j-1], items[j]
                j -= 1

if __name__ == "__main__":
    nums = [1, 5, 3, 2, 4]
    Insertion.sort(nums)
    print(nums)
```

from go sort:

```python
def insertion_sort(nums, lo, hi):
    for i in range(lo + 1, hi):
        j = i
        while j > lo and nums[j] < nums[j-1]:
            nums[j], nums[j-1] = nums[j-1], nums[j]
            j -= 1
```