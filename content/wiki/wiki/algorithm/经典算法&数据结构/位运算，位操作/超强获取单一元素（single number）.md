---
title: 超强获取单一元素（single_number）
---

# 超强获取单一元素（single number）

[bit_manipulation](https://docs.google.com/document/d/1qU2pNbLgpvTy8YIGYch05aBtEyd9XHXM6wTDOAfRNpM/edit#)

题目：一个数组中，一个元素出现m次，其他元素都出现k次，找出这个出现m次的元素。m不整除k。

[137. Single Number II](../../OJ_online_judge/LeetCode/题目列表/137%20Single%20Number%20II%207c620f521db14c908b3fe279405f11a1.md) 

---

方法一：统计每个位上1的个数，分别对k取模即可。

方法二：使用状态机。

使用状态机，每个状态对应的是1的出现次数，如0个、1个...（k - 1）个，出现k次的话就轮转到0次。每个状态碰到输入0则保持，碰到输入1则切换到下一状态。

当k为3的时候，只需要3个状态，分别记录0个1,1个1和2个1。状态切换如下所示：

[https://docs.google.com/drawings/u/0/d/stKgzrFaP8t3mgGpI8QWfVA/image?w=245&h=255&rev=170&ac=1&parent=1qU2pNbLgpvTy8YIGYch05aBtEyd9XHXM6wTDOAfRNpM](https://docs.google.com/drawings/u/0/d/stKgzrFaP8t3mgGpI8QWfVA/image?w=245&h=255&rev=170&ac=1&parent=1qU2pNbLgpvTy8YIGYch05aBtEyd9XHXM6wTDOAfRNpM)

方框代表的是状态，<0, 0>表示0个1输入，<1, 0>表示有1个1输入，<0, 1>表示有2个1输入。当有3个1输入时，状态机又回到<0, 0>。方框里的上面的数字表示为**ones**（表示低位），下面的数字表示为**twos**（表示高位）。输入为0的情况下，状态不转移。

接下来，我们需要求出ones和twos的真值表达式，也就是在什么情况下它们的值为1。从状态图中可看到，只有在状态<1, 0>的时候，ones才为1。而状态<1, 0>的来源有二：一个是自身遇到0保持状态；一个是有前一个状态<0, 0>遇到输入1时切换到状态<1, 0>。根据这两个来源，就可以写出ones的表达式。

```python
**ones = (ones & ~twos & ~n) | (~ones & ~twos & n) = ~twos & (ones ^ n)**
```

ones代表状态里的ones为1的情况，~ones代表状态里的ones为0，所以ones & ~twos表示的状态就是<1, 0>，ones使能，twos非使能。n表示输入的数字为1的情况，~n表示输入的数字n为0的情况。

类似地，可写出twos的表达式：

```python
**twos = (~ones & twos & ~n) | (ones & ~twos & n)**
```

每次输入一个数字n的时候，都需要重新计算ones和twos的值。但ones和twos的计算有先后顺序，理想情况是根据表达式瞬间同时完成计算，同时更新ones和twos的值。否则的话，我们在计算好ones后，ones已更新，而twos的表达式是根据ones的旧值推导的，所以不能使用当前的ones值。一种方法就是避免原地更新，不要用新的ones直接覆盖，而是先保存到其他地方如**ones’**。同理，twos的新值也另外保存到**twos’**。当更新完毕后，再将所有新值覆盖到旧值。很显然，这种方法需要另外一倍的存储空间，而且复制拷贝也增加了时间开销。那么，有没有另外的方法来避免这些开销，或者说，有没有**原地更新**的方法？

那么，我们来观察，更新ones过程中发生了什么。假设当前状态为<1, 0>，且输入为1，根据ones的表达式，ones的值更新为0（也可以从状态转移图中可看出，最终状态是<0, 1>，也就是说ones的值为0）。此时，我们尚未去更新twos的值，那么，内部临时状态<ones, twos>为**<0, 0>**。ones为0是因为我们刚刚更新的，twos为0是因为twos本来就是0（在状态<1, 0>下），而且我们没去更新twos。

[https://docs.google.com/drawings/u/0/d/sPz7aKCAsN3VF76EoItzHGw/image?w=245&h=252&rev=20&ac=1&parent=1qU2pNbLgpvTy8YIGYch05aBtEyd9XHXM6wTDOAfRNpM](https://docs.google.com/drawings/u/0/d/sPz7aKCAsN3VF76EoItzHGw/image?w=245&h=252&rev=20&ac=1&parent=1qU2pNbLgpvTy8YIGYch05aBtEyd9XHXM6wTDOAfRNpM)

接下来，我们要更新twos，但我们不能使用twos的原来表达式。不过，我们已经知晓了表达式的原理（状态+输入），只需要根据原理重新调整表达式即可。当前看到的状态为<0, 0>，输入为1，该部分表达式为

```python
~ones & ~twos & n
```

而输入为0的那部分保持不变。所以twos的新表达式为：

```python
twos = (~ones & twos & ~n) | (~ones & ~twos & n) = ~ones & (twos ^ n)
```

看这个表达式，它的形式是跟ones的表达式是一致的（ones = ~twos & (ones ^ n)）。根据这些表达式，我们可以形成通用的概念。换言之，在**顺序求表达式**的情况下，当输入为0的情况下，保持状态；当输入为1的情况下，如果看到**当前状态全为0**，那么需要把自身置1，就好像退化到<0, 0> + 1 → <1, 0>，只不过置1的位置不一样。或者说，什么情况下出现当前状态全为0？只有在置1的那个变量（不管ones还是twos，或者更多的threes，fours）遇到输入1的时候，刚好清空这个1，变为全0，为下一个变量更新做准备。

需要强调的是**顺序求表达式**，如果支持同时计算表达式，那么就是另外一副光景了。比如，用python可以同时计算ones，twos：

```python
ones, twos = ~twos & (ones ^ n), ****(~ones & twos & ~n) | (ones & ~twos & n)
```

等号右边的ones和twos都是旧值，计算完毕后，再赋值给等号左边。

---

接下来，我们要推导通项，其他数（比如n）出现k次，只有一个出现1次（后面再推广到m次）。

首先，我们需要（k - 1）个变量来表达状态（记录1出现的次数），还有一个状态是全为0，加起来刚好k个状态。这（k - 1）个变量分别表示为A0，A1，...，Ak-3，Ak-2，当出现0个1时，全为0； 出现1个n时，A0为1，其余为0；出现2个n时，A1为1，其余为0；以此类推，出现（k - 1）个n时，Ak-2为1，其余为0；第k个1出现时，又切换到全为0状态。

状态集（k=6）：

[Untitled](assets/Untitled%20Database%203c6caf1e02bb4260bbc705829e2757b7.csv)

表格中每一行代表了一个状态，状态转移方式如前所述：输入为0时保持状态；输入为1时从前一个状态迁移到下一个状态，表格尾部则回到表头。

按照静态方式，写出表达式通项，也就是求Ai何时为1。

比如`A2 = (~A4 & ~A3 & A2 & ~A1 & ~A0 & ~n) | (~A4 & ~A3 & ~A2 & A1 & ~A0 & n)`，注意A0的表达式略有区别，因为它的前一个状态全是0，没出现一个1，但也可以通过再添加一个状态A5，初始状态设置为A5为1，其余为0。

如果按照顺序求表达式的方式，后半项要改写，即状态全为0的时候：

```python
**A2** = (~A4 & ~A3 & **A2** & ~A1 & ~A0 & ~n) | (~A4 & ~A3 & ~A2 & ~**A1** & ~A0 & n)
   = (~A4 & ~A3 & ~A1 & ~A0) & ((A2 & ~n) | (~A2 & n))
   **= (~A4 & ~A3 & ~A1 & ~A0) & (A2 ^ n)**
```

表达式分为两部分，前部分为除去A2本身外的所有变量的取反再与操作，后部分为A2本身与输入n的异或结果，两者再与操作。前部分除去A2，后部分包含A2和输入。

```python
A[i] = (~A[k-2] & ~A[k-3] & … & **~A[i+1] & ~A[i-1]** & … & ~A[1] & ~A[0]) & (**A[i]** ^ n)
```

如果m为1，那么返回A0的结果；如果m为2，返回A1的结果；以此类推；如果m为k的倍数，那么结果自然是0，因为它与其他数看不出差异。

python示例代码：

```python
def singleNumber(nums, k, m=1):
    """
    :type nums: List[int]
    :rtype: int
    """
    A = [0 for _ in range(k - 1)]
    for n in nums:
        for i in range(k - 1):
            tmp = n ^ A[i]
            for j in range(k - 1):
                if j != i:
                    tmp &= ~A[j]
            A[i] = tmp
    if m % k:
        return A[(m - 1) % k]
    else:
        return 0
```