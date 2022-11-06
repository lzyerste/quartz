---
title: grep
---

#grep #xargs

[TOC]

[How to Use Grep Command in Linux](https://linuxize.com/post/how-to-use-grep-command-to-search-files-in-linux/)

## 基本用法

```c
grep -rn "string" file_or_directory

如果需要正则表达式，使用参数-E
```

在某个文件或某类文件里搜索关键字：

```c
# Search for the given string in a single file
grep "literal_string" filename

# Searching in all files recursively using grep -r
grep -r "ramesh" *

# 正则表达式

grep -E "REGEX" filename

# Checking for the given string in multiple files.
grep "string" FILE_PATTERN

# Case insensitive search using grep -i
grep -i "string" FILE

# Match regular expression in files
grep "REGEX" filename

-w: full word

-v: Invert match using grep -v

-n: Show line number while displaying the output using grep -n

Displaying lines before/after/around the match using grep -A, -B and -C
```

## 结合xargs高级用法

需求：将固件日志中的所有pda信息转为具体的geo信息。

步骤：

1. 通过grep获取所有pda地址
2. 传入xargs，针对每个pda，调用python脚本解析

```shell
grep -a -oP 'pda=\K(0x[a-fA-F0-9]+)' log___dev_ttyUSB3__20211222__18_09_21.txt | xargs -I {} sh -c 'echo {} ; python3 ~/git/tacoma/scripts/zns_parse_pda.py {}'

0x1000001
spb=8, page=0, itlv=0, du=1
0x1000029
spb=8, page=0, itlv=10, du=1
```

grep里的`\K`是为了group？

xargs的{}相当于变量，在后面的命令中直接使用。

## 搜索特定类型文件

https://stackoverflow.com/a/35280826/1148981

在日志文件里找timeout信息：

```shell
grep -irn --include='log*2022*.txt' 'timeout' ./
```

## 显示上下文

比如关键字的上下若干行。

```jsx
# 显示file文件中匹配foo字串那行以及上下5行
grep -C 5 foo file

# 显示foo及前5行
grep -B 5 foo file

# 显示foo及后5行
grep -A 5 foo file
```

## 指定文件类型

```bash
# 在java文件中搜索字符串findString
find . -name "*.java" | xargs grep -e findString -2
```

## 针对一个变量进行grep

[grep on a variable](https://unix.stackexchange.com/questions/163810/grep-on-a-variable)

```bash
# 注意echo的变量要双引号包起来
$ echo "$line" | grep select
```

## ⭐正则表达式，group

https://unix.stackexchange.com/questions/13466/can-grep-output-only-specified-groupings-that-match

获取链接：

```bash
cat README.md | grep -a -oP '\[.*\]\(\K(.*)(?=\))'
```

---

比如下面的文本例子，提取 max 的值。

```c
    clat (usec): min=147, max=80271, avg=1470.78, stdev=2281.87
    clat (usec): min=59, max=48702, avg=1545.87, stdev=2668.07
    clat (usec): min=82, max=164054, avg=1473.57, stdev=2604.32
    clat (usec): min=56, max=52795, avg=1562.50, stdev=2842.84
    clat (usec): min=80, max=108258, avg=1375.96, stdev=2374.88
    clat (usec): min=59, max=48943, avg=1571.25, stdev=2718.51
    clat (usec): min=85, max=115397, avg=1468.58, stdev=2541.96
    clat (usec): min=57, max=53291, avg=1564.84, stdev=2675.30
    clat (usec): min=85, max=110641, avg=1474.96, stdev=2503.01
    clat (usec): min=57, max=42772, avg=1549.88, stdev=2694.51
```

```c
grep -oP 'max=\K(\d*)(?=,)' b.txt
```

`\K`表示开始 group，`(?=pattern)`表示结束。中间的就是要抓取的。

```c
The `\K` is the short-form (and more efficient form) of `(?<=pattern)` which you use as a zero-width look-behind assertion before the text you want to output. `(?=pattern)` can be used as a zero-width look-ahead assertion after the text you want to output.

For instance, if you wanted to match the word between `foo` and `bar`, you could use:

$ grep -oP 'foo \K\w+(?= bar)' test.txt
```