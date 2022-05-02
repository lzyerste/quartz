---
title: MSD，变长字符串排序
---

# MSD，变长字符串排序

```python
class MSD:
    """MSD变长字符串排序。
    从左到有进行基数排序。
    类似快排，需要partition，直接分成R组。
    注意越界的处理，视其为-1。
    对应algs4的算法5.2，712页。
    """

    @staticmethod
    def sort(A):
        MSD.__sort(A, 0, 0, len(A) - 1)

    @staticmethod
    def __sort(A, d, lo, hi):
        """对字符串数组A[lo..hi]进行排序，从第d位字符开始。
        d之前的字符大家都是一样的。
        
        Arguments:
            A {[type]} -- 字符串数组
            d {[type]} -- 对第d位进行基数排序
            lo {int} -- inclusive
            hi {int} -- inclusive
        """
        def idx(s, i):
            return -1 if i >= len(s) else ord(s[i])

        if hi <= lo: return  # 只有0或1个元素
        R = 256
        # 1. count
        count = [0 for _ in range(R + 1)]  # -1这里是有用的
        for s in A[lo:hi+1]:
            count[idx(s, d)] += 1
        # 2. preSum
        preSum = [0 for _ in range(R + 1)]
        for i in range(R):
            preSum[i] = preSum[i-1] + count[i-1]
        # 3. move to aux
        aux = [None for _ in range(hi - lo + 1)]
        for s in A[lo:hi+1]:
            aux[preSum[idx(s, d)]] = s
            preSum[idx(s, d)] += 1
        # 4. copy back
        A[lo: hi+1] = aux

        # 到这里，preSum含义稍微变了，preSum[i]已经表示i的末尾，或者说i+1的开始位置。
        # 所以，要对分组i进行递归，它的数组范围lo=preSum[i-1]，hi=preSum[i]-1
        # 而且，注意下，对分组-1不需要处理，因为它们已经到达了正确位置，剩余的都是空串。
        # 所以，i照常从0开始，一直到R（不包含）。

        # 5. recursive
        for i in range(R):
            MSD.__sort(A, d + 1, lo + preSum[i-1], lo + preSum[i] - 1)

if __name__ == "__main__":
    A = ["she", "sells", "seashells", "by", "the", "seashore", 
         "the", "shells", "she", "sells", "are", "surely", "seashells"]
    MSD.sort(A)
    print(A)
```