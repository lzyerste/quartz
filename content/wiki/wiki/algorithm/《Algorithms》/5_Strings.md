---
title: 5_Strings
---

# 5. Strings

- **`√ 5.1 String Sorts`**
    - `Radix Sort`，基数排序
        - 统计频率
        - 统计前序和
        - 各自归位（辅助数组）
        - 拷贝回原数组
        
        ---
        
        实现请查看 [Radix Sort，基数排序](../经典算法&数据结构/Radix%20Sort，基数排序.md)。
        
    - `LSD`，least-significant-digit first (LSD) string sort
        - 等宽字符串排序，基于Radix Sort
        - 从右到左，依次做基数排序。
        - 也可将32位的无符号整数分割为4个字节来做基数排序
        - 如果是有符号整数，注意最高字节的符号性。
        
        ---
        
        实现请查看 [LSD，等宽字符串排序](../经典算法&数据结构/LSD，等宽字符串排序.md)。
        
    - `MSD`，most-significant-digit-first (MSD) string sort
        - 字符串不一定等宽。
        - 从左到右。
        - 类似快排，对数组进行partition，快排是分成三组，MSD是分成R组（R为基数，值的范围）。分好组之后，高位相同的为一组，对低位进行递归排序。
        - 宽度不一如何处理？超出末尾的视为-1。
        
        ---
        
        实现请查看 [MSD，变长字符串排序](../经典算法&数据结构/MSD，变长字符串排序.md)。
        
    - `Three-way string quicksort`
        - 类似快排的三路分组，而不用分成R组。
        
        实现请查看 [Quick3string，字符串三路分组排序](../经典算法&数据结构/Quick3string，字符串三路分组排序.md)。
        
- **`√ 5.2 Tries`**
    
    实现请查看 [Trie，字典树](../经典算法&数据结构/Trie，字典树.md)。
    
- `√ 5.3 Substring Search`
    - `Brute-force substring search`
        
        不错，就是如你所想的那样。
        
        首先采用暴力搜索。针对文本txt的每一个可能起始位置`i`，比较从它开始的M个字符是不是跟搜索字符串pat相匹配。不匹配的话，i往右挪一个位置，继续这个流程比较。
        
        如果找到匹配，返回对应的起始位置`i`；如果全部找完了，也没有匹配，那么返回`N`，已经超出文本txt的范围了（当然，返回-1也可以表示没有找到）。
        
        ```python
        # page 760
        def search(pat, txt):
            M = len(pat)
            N = len(txt)
            for i in range(N - M + 1):  # 保证txt中有M个字符
                for j in range(M):
                    if txt[i + j] != pat[j]:
                        break
                else:
                    return i  # found
            return N  # not found
        
        pat = "ABRA"
        txt = "ABACADABRAC"
        print(search(pat, txt))  # 6
        ```
        
        `i`限定到`[0, N - M]`是因为要保留足够长的字符去匹配，如果txt的剩余字符数少于M了，那肯定不用检查了。
        
        在内部循环j比较时，i是不变的，指向比较的起始位置，通过偏移量j加上起始位置i来得到txt中的位置。
        
        可看到，最坏情况下，`i`要循环`N-M+1`次，而且每次`j`要比较`M`次（即前面字符都匹配，直到最后一个字符不匹配），那么最坏情况下的总比较次数为`M(N-M+1)`。
        
        但是，一般情况下（比如English text），内循环j可能首次比较的时候就不匹配了，从而避免了后续的比较，平均代价并不一定会很高。如果搜索的是二进制文件，那么都是0和1的匹配，前面匹配的可能性还是挺大的。
        
        例子示意图：注意i那一列是一个个递增上去的。
        
        ![5%20Strings%20f7c9a2f2411a4a81b0e6c109fa5ec98e/Untitled.png](5%20Strings%20f7c9a2f2411a4a81b0e6c109fa5ec98e/Untitled.png)
        
        ---
        
        暴力变种：
        
        ```python
        # page 761
        def search(pat, txt):
            M = len(pat)
            N = len(txt)
            i = j = 0
            while i < N and j < M:
                if txt[i] == pat[j]:
                    j += 1
                else:
                    i -= j  # i回到比较的起点
                    j = 0
                i += 1  # i总是往前
            return i - M if j == M else N
        
        pat = "AAAAB"
        txt = "AAAAAAAAAB"
        print(search(pat, txt))  # 5
        ```
        
        以上代码是上面暴力搜索的变种，指针i和j分别指向文本txt和字符串pat。如果在当前位置两者的字符相同时，i和j都往右移一个位置。如果它们不同，那么j要重置为0，i要回退到本次匹配的起点，同时往右挪1，开始新一轮的比较。
        
        while的内部逻辑也可以改写为：
        
        ```python
        if txt[i] == pat[j]:
            i += 1
            j += 1
        else:
            i -= j - 1
            j = 0
        ```
        
        但不建议修改，因为这个算法实际上是下面KMP的铺垫，这里是回退i，但实际上可以相对地用回退j来操作，而i只有一个方向，那就是每次加1。
        
        作者的编排真有深意。
        
        例子示意图：
        
        []()
        
    - `KMP`
        
	[KMP字符串匹配 [wiki]](../经典算法&数据结构/KMP字符串匹配%20[wiki].md)
        
- 5.4 Regular Expressions，TODO