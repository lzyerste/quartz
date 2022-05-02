---
title: 4_Median_of_Two_Sorted_Arrays_a342fd9fb68f470db95e26ec50e42dba
---

# 4. Median of Two Sorted Arrays

Difficulty: Hard
ID: 4
Solved?: Yes
Tags: Array, Binary Search, Divide and Conquer
击败: 54.62
推荐指数: ⭐⭐⭐⭐⭐

[Median of Two Sorted Arrays - LeetCode](https://leetcode.com/problems/median-of-two-sorted-arrays/)

## 题意

给定两个大小为 m 和 n 的有序数组 `nums1` 和 `nums2`。

请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。

你可以假设 `nums1` 和 `nums2` 不会同时为空。

**示例 1:**

```
nums1 = [1, 3]
nums2 = [2]

则中位数是 2.0
```

**示例 2:**

```
nums1 = [1, 2]
nums2 = [3, 4]

则中位数是 (2 + 3)/2 = 2.5
```

## 思路

直接看题解3

- merge之后再找
- 各自二分，m与n
- 统筹二分，m+n

## 题解1：merge

方法一：直接合并两个数组，再排序，然后得到中位数。

方法二：借鉴merge sort的合并过程，弹出中位数即可，不一样要保存合并结果。

这两种算法的时间复杂度并不符合题目要求。

代码就不贴了。

## 题解2：二分搜索

类比无序数组中查找第K大元素（中位数也就是第N/2大）。如果剔除了最小的X个数，剩下的问题就变成了找第（K-X）大元素，最后退化为找第0大元素，也就是最小元素。

现在题目输入两个有序数组nums1（记为A）和nums2（记为B），寻找第K大元素。随便在数组A中挑一个元素（二分法）作为分割线，数组分为左边部分LA（left of A），A[i]，RA（right of A）。在A已经分割好的情况下，对B进行分割就容易了。A的左边部分大小为LA，那么B的左边部分对应大小可以分配为LB=K-LA，分割点为B[j]，右边部分为RB。假设这次分割就是最终答案（A[i]和B[j]在合并有序数组中是相邻的，也就是没有其他元素的值介于它们中间），那么第K大元素就是A[i]和B[j]中的一个，取小值即可（中位数与第K大有点不一样，中位数可能是数组的最中间两个元素）。

上面是理想情况，A[i]与B[j]是相邻的元素，也就是有如下关系式：{LA, LB} ≤ {A[i], B[j]} ≤ {RA, RB}

> 其实能观察到，如果A[i]与B[j]相等的话，它们之间肯定插入不了其他值了（相等值无所谓），它们就是最终分割。
> 

但实际切割并不会这么理想，会有LA、LB、RA或RB中的元素夹杂在{A[i], B[j]}之间。但考虑到两个数组的有序性，还是能够将问题变小（分治思想）。

首先，根据数组有序性得到：LA ≤ A[i] ≤ RA, LB ≤ A[j] ≤ RB，LA + LB == K。

现在判断A[i]与A[j]的大小，假设A[i] ≤ B[j]（B[j] < A[i]镜像处理即可）。

那么，LA ≤ {A[i], B[j]} ≤ RB，而RA与LB是不确定的，可能有元素介于A[i]与B[j]之间。

可以简单证明，第K大元素不可能落在LA或RB内部，只能落在{A[i], RA}、{LB, B[j]}里面。那么就可以进行下一轮搜索，两个输入数组变成了{A[i], RA}、{LB, B[j]}，现在是搜第几大元素呢？很简答，移除了较小元素的LA，变成了搜索第K-LA大元素。

按照这个思想，问题一步步小变小，直到可直接解。

比如K为0，第0大，也就是最小元素，显然就是A[i]与B[j]中的一个，考虑到中位数，可以再把各自后一个数再拿进来比较。

比如两个数组都变的很小了，都只有各位元素了，直接合并后排序，返回第K大即可。

---

上面描述了基本思想，实际实现的时候要注意考虑边界情况，比如LA长度大于K了呢，LB就是负的了；再或者LA较小，需要在数组B提供较多的元素LB，以达到K个元素的要求，而实际数组B并没有LB个元素呢？

一般，用二分搜索的时候，中点的取法也是要注意的，因为中点取法可以偏左，也可以偏右。二分之后，是期望下一次的子问题是变小的，如果实际没有变小，那么就可能造成无限递归了。

比如A=[3]，B=[1, 2, 5, 6]，K为3，答案为5。

如果照搬前面的实现，先对A二分，i仍然是0，LA为空，RA也为空。LB长度需要为3（以达到K），所以j下标为3，对应元素B[j]为6，这时候RB为空。这时候A[i]<B[j]，下一次搜索可以剪枝LA与RB，但两者都是空的，问题并没有缩小，下一次还是同样的过程，会造成无限递归。

---

解决办法是二分对象总是较长的那个数组，比如将上面例子的两个数组对换，A=[1, 2, 5, 6]，B=[3]，K=3。

现在对A二分，i为1，A[i]=2，LA为{1}，长度为1。需要数组B提供2个元素，但实际上数组B只有1个元素。其实这时候可以证明，第K大元素不可能落在LA中，还是可以按照常规做法将LA移除，下一次的搜索状态就变成了[2, 5, 6], [3], K=2。问题规模就减小了。

```python
class Solution:
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
        def getValue(nums, begin, end, index, defVal=float("inf")):
            # 主要添加越界检查
            if index < begin or index > end:
                return defVal
            return nums[index]

        def helper(nums1, b1, e1, nums2, b2, e2, K):
            # 为了中位数，结果总是返回2个元素
            len1 = e1 - b1 + 1
            len2 = e2 - b2 + 1

            if K == 0:
                # 最小元素。中位数可能需要2个元素，所以额外添加各自的后一个元素
                res = [getValue(nums1, b1, e1, b1), getValue(nums1, b1, e1, b1 + 1),
                      getValue(nums2, b2, e2, b2), getValue(nums2, b2, e2, b2 + 1)]
                res.sort()  # 不存在的值默认为无穷大，排序在最后边
                return res[:2]

            if len1 <= 4 and len2 <= 4:
                # 小数组直接合并排序
                nums = nums1[b1: e1 + 1] + nums2[b2: e2 + 1]
                nums.sort()
                # 相当于移除前K个元素后，就变成了找最小元素问题（K为0）
                return helper(nums, K, len(nums) - 1, [], 0, -1, 0)

            # 较长的数组在前
            if len1 < len2:
                return helper(nums2, b2, e2, nums1, b1, e1, K)
            if len2 == 0:
                # 也就一个有序数组了，同样移除掉前K个元素，使K值变为0
                return helper(nums1, b1 + K, e1, nums2, b2, e2, 0)

            # 有上面的小数组处理及较长数组在前，所以能保证数组A总是可以分成3部分：
            # LA，A[i]，RA。且LA和RA都不可能为空。
            i = (b1 + e1) // 2  # 对数组A进行分割，i的左边为LA，[b1, i)
            LA = i - b1  # left part of nums1
            LB = K - LA  # left part of nums2, may < 0?
            j = b2 + LB  # j的左边为LB，[b2, j)
            if j < b2:
                # LA太大，LB都为负了，可以放心去除A的右部分（RA），K保持不变，但数组A变小了
                return helper(nums1, b1, i, nums2, b2, e2, K)
            elif j > e2:
                # LA太小，数组B提供不了LB个元素，可以放心去除A的左部分（LA），K减去LA
                return helper(nums1, i, e1, nums2, b2, e2, K - LA)
            else:
                # i和j都是各自合法的下标
                if nums1[i] <= nums2[j]:
                    # 移除LA及RB
                    return helper(nums1, i, e1, nums2, b2, j, K - LA)
                else:
                    # 镜像，移除LB及RA
                    return helper(nums1, b1, i, nums2, j, e2, K - LB)

        m, n = len(nums1), len(nums2)
        K = (m + n - 1) // 2  # 从0开始计数
        a, b = helper(nums1, 0, m - 1, nums2, 0, n - 1, K)
        if (m + n) % 2:
            return a
        else:
            return (a + b) / 2
```

## ★题解3：topK

题解2中是对数组进行二分，但数组的长度是不确定的。

另一种方法是对求解的K进行二分。我们需要剔除最小的K个元素，使得K的值归约为0。对K进行对半分，每个数组都提供K/2个元素（使得总体加起来有K个）。当然要考虑到数组并不一定有这么多元素，没关系，可以放宽条件，也就是尽可能多地提供元素（靠近K/2）。虽然总体加起来的元素没有K个，少了不影响正确结果，因为结果肯定还在剩余元素中。

这种分法下，每个数组都被分割成两部分（与题解2的三部分不同）：左部分有K/2个元素，右部分为剩余元素。分别标记为LA（left part of A）、RA（right part of A）、LB（left part of B）、RB（right part of B）。

现在，只需要比较LA与LB的最末元素，假设对应的下标分别为i和j。如果A[i]<B[j]，那么LA全部小于B[j]，也就是说可以将LA从下次搜索中移除，因为LA+LB元素个数才K个，第K大元素不可能在LA中。类似地，如果B[j]比较小，那么就可以对应地移除LB。

代码写起来比题解2简短清晰。

```python
class Solution:
    def findMedianSortedArrays(self, nums1: List[int], nums2: List[int]) -> float:
        def getKth(nums1, b1, e1, nums2, b2, e2, K):
            len1 = e1 - b1 + 1
            len2 = e2 - b2 + 1
            
            if len1 > len2:
                return getKth(nums2, b2, e2, nums1, b1, e1, K)
            if len1 == 0:
                return nums2[b2 + K]
            if K == 0:
                return min(nums1[b1], nums2[b2])

            # [0 .. i] --> (K + 1) // 2 items
            i = min(e1, b1 + (K - 1) // 2)  # always valid
            j = min(e2, b2 + (K - 1) // 2)  # always valid
            if nums1[i] < nums2[j]:
                return getKth(nums1, i + 1, e1, nums2, b2, e2, K - (i - b1 + 1))
            else:
                return getKth(nums1, b1, e1, nums2, j + 1, e2, K - (j - b2 + 1))

        m, n = len(nums1), len(nums2)
        a = getKth(nums1, 0, m - 1, nums2, 0, n - 1, (m + n - 1) // 2)
        b = getKth(nums1, 0, m - 1, nums2, 0, n - 1, (m + n) // 2)
        return (a + b) / 2
```

有几点地方还是要稍微讲一下。

getKth是求第K大元素（从0开始计数），而题目是要求中位数。

如果一组数有奇数个，中位数就是最中间的1个数；如果有偶数个，那么中位数就是最中间的2个数。这里可以把它们统一处理，奇数个的时候也表示成2个数，也就是最中间的那个数被求解了2次。所以代码中的a和b，在长度为偶数的情况下，相当于表示了第K大及第K+1大；如果长度为奇数，表示了第K大和第K大。最终取a和b的平均值。

---

数组A的左部分以i下标结束，数组B的左部分以j下标结束。LA的长度可能是i-b1+1=(K+1)//2，同样，LB的长度也可能是j-b2+1=(K+1)//2。两者加起来的长度不是有可能为K+1么（K为奇数的情况下），不是超过K了么，第K大不就可能在LA或LB中了么？

首先，虽然两者长度和加起来可能超过K，但单单一个数组的长度并没有超过K，也就是说(K+1)//2 ≤ K。显然，这在K ≥ 1的情况下总是成立的，而K为0的情况在函数入口就处理了，所以走到下面代码，K已经是≥1了。

然后，每次准备下一次搜索的时候，我们都是移除LA或者LB，而不是两者同时移除。单单移除一个，并不会超过K个元素，所以能保证正确答案仍然留在剩余元素中，而不是被移除的元素中。

比如假设A[i]<B[j]，LA+LB有K+1个元素，如果第K大元素落在LA+LB中，那么也只能是LA+LB的最末一个元素，也就是最大的元素，也就是B[j]。而按照算法，下次搜索是移除了LA，LB还是保留的，所以B[j]还是保留的。

那么，为什么允许LA+LB有K+1个元素呢，能不能严格控制K个元素？主要考虑到边界情况。我们的算法总是要求两个数组各自提供一半元素（如此才有A[i]与B[j]的比较），且至少提供1个。如果K的值为1，那么怎么分配呢？数组A提供1个，数组B不提供？还是数组A不提供，数组B提供1个？不论哪种方式，都破坏了我们的要求，各自至少提供1个。如果我们允许A提供1个，B不提供，那么我们怎么知道这个A的元素是该保留的还是被移除呢，总是要通过与B比较之后才知道。比如A=[2, 3, 4]，B=[1, 5, 6]，K=1，答案是2，A[0]不能删。

另外，我们要求每个数组至少提供1个元素，也是为了保证不管移除LA或者LB，总是有真的元素被移除，如此才能减小问题规模，否则移除一个空集，并没有减小问题规模，会出岔子。

---

参考：

[](https://leetcode.com/problems/median-of-two-sorted-arrays/discuss/2499/Share-my-simple-O(log(m%2Bn))-solution-for-your-reference)