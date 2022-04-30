---
title: 优先级队列，Priority_Queue
---

# 优先级队列，Priority Queue

[cs61b 2018 ds5 lec24 heaps and pq](https://docs.google.com/presentation/d/1ySYTxnvoHJc7_2U0L90WH3kx0toWA4vpNiIR2r1vqKU)

- algs4/Heap.py，按照Python的heapq接口
    
    ```python
    class Heap:
        """最小堆实现。
        仿照Python的heapq接口。
           0
         1   2
        3 4 5 6
        parent(i) = (i - 1) // 2
        left(i) = 2 * i + 1
        right(i) = 2 * i + 2
        """
    
        @staticmethod
        def heapify(heap):
            """从最后一个非叶结点开始往前依次下沉。
            """
            k = ((len(heap) - 1) - 1) // 2  # 最后一个节点的父节点
            for  i in range(k, -1, -1):
                Heap._down(heap, i)
    
        @staticmethod
        def heappush(heap, item):
            """插入新元素。
            先放到末尾，然后往上调整。
            
            Arguments:
                heap {list} -- 最下堆
                item {[type]} -- [description]
            """
            heap.append(item)
            Heap._up(heap, len(heap) - 1)
    
        @staticmethod
        def heappop(heap):
            """弹出根节点（最小元素）。
            与队尾元素交换，弹出队尾，调整根节点（下沉）。
            
            Arguments:
                heap {[type]} -- [description]
            """
            n = len(heap)
            heap[0], heap[n-1] = heap[n-1], heap[0]
            item = heap.pop()
            Heap._down(heap, 0)
            return item
        
        @staticmethod
        def _down(heap, k):
            """下沉当前节点，使最小的孩子上来。
            递归做法。
            
            Arguments:
                heap {list} -- 最小堆
                k {int} -- 当前节点
            """
            n = len(heap)
            left = 2 * k + 1  # left child index
            right = left + 1  # right child index
    
            if left >= n: return  # 当前节点是叶子
            
            smaller = left  # 记录较小的孩子节点
            if right < n and heap[right] < heap[left]:
                smaller = right
            
            if heap[smaller] < heap[k]:
                # swap & recursive down
                heap[smaller], heap[k] = heap[k], heap[smaller]
                Heap._down(heap, smaller)
    
        @staticmethod
        def _up(heap, k):
            """上升当前节点，只需与父节点比较，一直到根节点。
            递归做法
            
            Arguments:
                heap {list} -- 最小堆
                k {int} -- 当前节点
            """
            if k == 0: return  # 已经是根节点
    
            p = (k - 1) // 2
            if heap[k] < heap[p]:
                heap[k], heap[p] = heap[p], heap[k]
                return Heap._up(heap, p)
    
        @staticmethod
        def heapsort(items):
            Heap.heapify(items)
            tmp = []
            while items:
                tmp.append(Heap.heappop(items))
            items[:] = tmp
    
    if __name__ == "__main__":
        import random
        heap = list(range(10))
        random.shuffle(heap)
        Heap.heapify(heap)
        while heap:
            print(Heap.heappop(heap))
    
        print("-" * 20)
        
        heap = []
        for i in range(10):
            Heap.heappush(heap, i)
        while heap:
            print(Heap.heappop(heap))
        
        print("-" * 20)
    
        heap = list(range(10))
        random.shuffle(heap)
        Heap.heapsort(heap)
        print(heap)
    ```
    
- algs4/MinPQ.py，按照algs4的接口，基于Heap实现
    
    ```python
    from Heap import Heap
    
    class MinPQ(Heap):
        """最小堆的实现，基于Heap封装，与algs4的API保持一致。
        """
        
        def __init__(self, items=None):
            self.heap = []
            if items is not None:
                self.heap = items[:]
            self.heapify(self.heap)
    
        def insert(self, item):
            """插入一个新元素。
            """
            self.heappush(self.heap, item)
    
        def min(self):
            """返回最小值（根节点）。
            
            Returns:
                [type] -- [description]
            """
            return self.heap[0]
    
        def delMin(self):
            """删除最小元素。
            
            Returns:
                [type] -- [description]
            """
            return self.heappop(self.heap)
    
        def isEmpty(self):
            return self.size() == 0
        
        def size(self):
            return len(self.heap)
    
    if __name__ == "__main__":
        pq = MinPQ()
        for i in range(10):
            pq.insert(i)
        while not pq.isEmpty():
            print(pq.delMin())
    ```
    

## 个人实现

```python
def heapify(heap, less):
    n = len(heap)
    for i in range(n//2)[::-1]:
        down(heap, i, less)

def heappush(heap, item, less):
    heap.append(item)
    up(heap, len(heap) - 1, less)

def heappop(heap, less):
    swap(heap, 0, len(heap) - 1)
    top = heap.pop()
    down(heap, 0, less)
    return top

def up(heap, k, less):
    if k == 0: return
    parent = (k - 1) // 2
    if less(heap[k], heap[parent]):
        swap(heap, k, parent)
        up(heap, parent, less)

def down(heap, k, less):
    n = len(heap)
    left = 2 * k + 1  # left child
    right = left + 1  # right child

    if left >= n: return

    smaller = left
    if right < n and less(heap[right], heap[left]):
        smaller = right

    if less(heap[smaller], heap[k]):
        swap(heap, smaller, k)
        down(heap, smaller, less)

def swap(heap, i, j):
    heap[i], heap[j] = heap[j], heap[i]

if __name__ == '__main__':
    heap = list(range(10)[::-1])
    print(heap)
    less = lambda a, b: a < b
    heapify(heap, less)
    print(heap)
    while heap:
        print(heappop(heap, less))
    for i in range(10)[::-1]:
        heappush(heap, i, less)
    print(heap)
```