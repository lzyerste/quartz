---
title: vim
---

#vim #神器 #必备

.vimrc位置: config/.vimrc

[★vim8推荐配置](../other/software/vim/★vim8推荐配置.md)

https://learnbyexample.github.io/vim_reference/

# vim new

## macro

q号macro，先将选中的复制，然后两边加引用符号：

`@q`触发，可以再映射成快捷键ge。

```
qqc``<ESC>hpq
```

h号macro，先将选中的复制，然后两边加高亮符号`==`：

`@h`触发，可以再映射成快捷键gh。

```
qhc====<ESC>hhpq
```

---

日记模板替换标题：

```
qt/''<ENTER>pq
```

日记模板替换图片路径：

```
qp/timeline.png<ENTER>vt'pq
```

## 搜索&替换

https://vim.fandom.com/wiki/Search_and_replace

`/`触发搜索。

替换所有行：

```
:%s/foo/bar/g
```

替换当前行：

```
:s/foo/bar/g
```

## 二进制文件查看及编辑

[How can I use Vim as a hex editor?](https://vi.stackexchange.com/questions/2232/how-can-i-use-vim-as-a-hex-editor)

打开的时候加上参数`-b`，要不然文件末尾会多个换行符。

```c
vim -b <filename>
```

二进制转可视化文本：

```bash
:%!xxd
```

样式：

```bash
0000000: 5468 6973 2069 7320 6120 7465 7374 0a41  This is a test.A
0000010: 6e6f 7468 6572 206c 696e 650a 416e 6420  nother line.And 
0000020: 7965 7420 616e 6f74 6865 720a            yet another.
```

文本转回二进制（显示乱码不用管）：

```bash
:%!xxd -r
```

---

如果要修改二进制文件的话，比如删除中间的某几行，可以使用如下方式编辑：

```c
:%!xxd -p -c 32
```

这样打开的话，只显示二进制文本，之前的第一列跟最后列的信息就不显示了。

`-c 32`表明一行显示32个字节，方便计算。

修改完之后，使用如下命令保存：

```c
:%!xxd -p -r
```

## tips

### 左右两个窗口一起滚动

```
:windo set scrollbind
```

### vib: 选中括号里内容

https://stackoverflow.com/questions/1061933/how-to-select-between-brackets-or-quotes-or-in-vim

如果有多层级嵌套，vib选中之后，继续按`ib`就会选中下一级。

# vim old

[安装vim 8.2](../other/software/vim/安装vim%208_2.md)

[vim常用命令](../other/software/vim/vim常用命令%20020b1e9960e94647ae0038a80d9192c1.md)

[Vim Cheat Sheet](https://vim.rtorr.com/)

[VimGolf - real Vim ninjas count every keystroke!](https://www.vimgolf.com/)

[尽量少的插件配置](../other/software/vim/尽量少的插件配置%2060183931f42f4094881568f2bf845113.md)

[基本配置](../other/software/vim/基本配置%202d6c03e900744ec2a25263313ce268a0.md)

[修改配置貌似不起作用](../other/software/vim/修改配置貌似不起作用%20c7571b19da5a4a608b4f47b1e81bc46e.md)

[spacevim](../other/software/vim/spacevim%206dc004bd705e42ac9a97e42049cab440.md)

[《Practical Vim》](../other/software/vim/《Practical%20Vim》%207abf29bdaf504642a0b9a31deeb86c54.md)

[Vim for VSCode: Remap ctrl + e to go to end of line in insert mode](https://stackoverflow.com/questions/53897590/vim-for-vscode-remap-ctrl-e-to-go-to-end-of-line-in-insert-mode)

映射vscode命令

[Understanding Vim’s Jump List. One of the great joys of Vim is its… | by Kade Killary | Medium](../other/software/vim/Understanding%20Vim’s%20Jump%20List%20One%20of%20the%20great%20joy%2003d0b9522f1d4fa488b880e3e454fd0d.md)