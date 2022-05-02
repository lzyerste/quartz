---
title: 11_Container_With_Most_Water_452069c0dcde4229b2c7bb12b6b6df6d
---

# 11. Container With Most Water

Difficulty: Medium
ID: 11
Solved?: Yes
Tags: Array, Two Pointers
击败: 93.47
推荐指数: ⭐⭐⭐⭐

[Loading...](https://leetcode.com/problems/container-with-most-water/)

## 题意

给定 *n* 个非负整数 *a*1，*a*2，...，*a*n，每个数代表坐标中的一个点 (*i*, *ai*) 。在坐标内画 *n* 条垂直线，垂直线 *i* 的两个端点分别为 (*i*, *ai*) 和 (*i*, 0)。找出其中的两条线，使得它们与 *x* 轴共同构成的容器可以容纳最多的水。

**说明：**你不能倾斜容器，且 *n* 的值至少为 2。

![https://aliyun-lc-upload.oss-cn-hangzhou.aliyuncs.com/aliyun-lc-upload/uploads/2018/07/25/question_11.jpg](https://aliyun-lc-upload.oss-cn-hangzhou.aliyuncs.com/aliyun-lc-upload/uploads/2018/07/25/question_11.jpg)

图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。

**示例:**

```
输入: [1,8,6,2,5,4,8,3,7]
输出: 49
```

## 思路

- 暴力法不可取（N平方）
- 利用DP思想，怎么将问题进行归约缩小，见题解1

2019-03-14 12:06:57，看题，没想起之前是怎么做的。

这个解释蛮直观：

[Loading...](https://leetcode.com/problems/container-with-most-water/discuss/6099/Yet-another-way-to-see-what-happens-in-the-O(n)-algorithm)

## 题解1：双指针

这道题典型的编码容易，但思考证明不易。

题目需要挑选两根柱：左柱与右柱，与x轴围成一个矩形，计算面积。x轴视为矩形的长，柱可视为矩形的高（两柱高度的小值）。理想情况下，当然是选择又长又高的矩形，也就是两根柱离的远，而且还高。

首先，挑选最高的柱子，将数组分成左右两部分（不包含最高柱），可简单证明最优的两根柱不可能全落在左侧或者右侧。比如假设在最高柱的左侧选2根，那么显然可以将矩形的右边变换为最高柱，在高度不减的情况下，矩形的长变大了（距离变远了），矩形面积肯定是变大了。那么矩形右边直接选最高边行不行呢？不行的，因为最高柱虽然高度没问题，但长度毕竟不及它的右侧部分，而且高度是取小值的。

左部分，从左往右看，应该形成一个递增序列，需要一直变高（变低的柱可以过滤掉），因为从左往右x轴宽度一直变小，高度变小是没意义的。

同样，有部分，从右往左看，也形成一个递增序列。

现在已经将数组分成左右两部分了，各自挑选一条，形成最大的矩形。我们的策略是从数组的两边往中间靠近，每次处理`高度较小`的那条边。为什么要处理短边，因为处理高边没有带来实际收益：高边变的更高并不能增加矩形的高度（取高度低值），而且往中间靠近，说明矩形的宽度变窄了，矩形面积反而变小。

现在我们假设已经处理到左边的第i根柱（包括它的所有左部分），右边的第j根柱（包括它的所有右部分），得到当前的最大值dp(i, j)。先不管是怎么计算出最大值的，简单想就两两相乘暴力计算出来的。

我们假设右柱比较高，height[i] < height[j]。根据我们的策略，`第i根柱虽然比第j根柱要低，但肯定比第j根柱右侧的柱子要高`。否则的话，height[i] < height[j]，又height[i] < height[j+1]，解子问题dp(i, j+1)的时候，就要处理短边i了，而不是去处理高边j+1。

现在处理左边i，往中间走一步，到i+1（height[i] < height[i+1]）。这时候，要为它寻找一条右边，看能不能形成一个更大的矩形。右边的寻找范围是[j, j+1, ..., n]。这时候，可以简单证明，它只需要跟边j组合就行。因为j右边的边都比边i要低，只需要边i出马就行，不需要i+1，因为矩形的高度由右边决定了，边i比边i+1离右侧更远。

---

处理起来就像两个人玩纸牌，比大小。一方不停地出牌，直到压倒对方，然后对方不停出牌，再大回来。

```python
class Solution:
    def maxArea(self, height: List[int]) -> int:
        i, j = 0, len(height) - 1
        maxVol = 0
        while i < j:
            hl = height[i]  # 左边当前最高的柱
            hr = height[j]  # 右边当前最高的柱
            maxVol = max(maxVol, (j - i) * min(hl, hr))
            if hl <= hr:
                while i < j and height[i] <= hl:  # 左边，寻找更高的柱
                    i += 1
            else:
                while i < j and height[j] <= hr:  # 右边，寻找更高的柱
                    j -= 1
        return maxVol
```

击败93.47%