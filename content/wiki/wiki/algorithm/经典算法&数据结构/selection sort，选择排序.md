---
title: selection_sort，选择排序
---

# selection sort，选择排序

algs4/SelectionSort.py

```python
class Selection:
    @staticmethod
    def sort(items):
        """选择排序。
        一直保持前面的已是排好序的。
        在剩余数中，寻找最小值，交换到前面来。
        
        Arguments:
            items {[type]} -- [description]
        """
        for i in range(len(items)):
            min = i
            for j in range(i+1, len(items)):
                if items[j] < items[min]:
                    min = j
            items[i], items[min] = items[min], items[i]

if __name__ == "__main__":
    nums = [1, 5, 3, 2, 4]
    Selection.sort(nums)
    print(nums)
```