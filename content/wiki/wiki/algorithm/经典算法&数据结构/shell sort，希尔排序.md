---
title: shell_sort，希尔排序
---

# shell sort，希尔排序

基于插入排序。

插入排序的时候，每次交换都是相邻的两个，距离为1，这样会造成很多交换。

希尔排序则是将交换距离变大，使得一次交换相当于插入排序的多次交换。但为了正确性，最后一次的距离仍然为1。但此时虽然是相邻交换，很大可能是交换几次就停止了。

> Shellsort is a simple extension of insertion sort that gains speed by allowing exchanges of array entries that are far apart, to produce partially sorted arrays that can be efficiently sorted, eventually by insertion sort.
> 

partial order

---

algs4/ShellSort.py

```python
class Shell:
    @staticmethod
    def sort(items):
        """希尔排序，基于插入排序。
        先稀疏地将部分排好序（元素间隔h），然后渐渐变密，知道完全变为插入排序（间隔1）。
        
        Arguments:
            items {[type]} -- [description]
        """
        n = len(items)
        hs = [1]
        while hs[-1] < n // 3:
            hs.append(hs[-1] * 3 + 1)
        for h in hs[::-1]:
            for i in range(h, n):
                j = i
                while j >= h and items[j] < items[j-h]:
                    items[j], items[j-h] = items[j-h], items[j]
                    j -= h

if __name__ == "__main__":
    nums = list(range(50, 0, -1))
    Shell.sort(nums)
    print(nums)
```