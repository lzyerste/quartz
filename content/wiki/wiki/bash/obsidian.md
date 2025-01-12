---
aliases:
- ob
title: obsidian
---

#markdown #vim #obsidian #神器 #必备

[obsidian.pdf](assets/obsidian.pdf)

[obsidian](https://obsidian.md/) ：非常优秀。

帮助文档： https://help.obsidian.md/Obsidian/Index

markdown 文件管理及浏览使用 obsidian，编辑可使用 [typora](../other/software/typora.md)，自带的编辑也基本满足需求了，表格弱一点。

- [y] 写个脚本，导出一个 md 文档，连带它的引用，主要是图片，也可以是其他附件，比如 pdf，xlsx。 ⏫ ✅ 2022-02-02

# 快捷键

- Ctrl+P: 快速打开文件。这是修改过的，原来默认是 Ctrl+O。
- Ctrl+Shift+P: 快速打开控制面板。原来默认是 Ctrl+P。保持跟 vscode 一致。
- Ctrl+T: 使用默认 APP 打开文件，比如 Typora。
- Ctrl+O: 浏览往后退
- Ctrl+I: 浏览往前进，原来是作为斜体效果的。
- Ctrl+E: `inline code`
- Ctrl+H: ==高亮所选==
- Ctrl+L: 变成 wiki 链接，两个双括号
- gd / Alt+Enter: 链接跳转，vim 模式下也有效。
- J (vim normal mode): 选择左边的 pane
- K (vim normal mode): 选择右边的 pane
- Ctrl+Shift+S: 格式化当前文档，在中文英文混合之间加空格
- ~~ge: inline code~~
- ~~gh: 高亮所选~~
- ~~gl: 变成 wiki 链接~~
- ~~Ctrl+Shift+H: 选择左边的 pane~~
- ~~Ctrl+Shift+L: 选择右边的 pane~~
- ~~Win + '.'是跳出表情包，但只能点击选择，不能搜索？❤🧡💛💚⭕❌❓❎✅~~

# 优点

- 支持 tag
- 支持 alias 别名
- 支持双链: `[link](link)`，link 就是文件名，不用全路径，如果有文件重名它才会全路径区分。文件重命名后（文件夹也可以），会提示更新双链。
- 支持 vim 模式
- 跨平台完美。包括插件同步，包括当前打开的状态。
- 可以直接粘贴图片。
- 直接内嵌 md 文件，类似插入图片，会直接显示内容。但是没有 outline。而且是固定高度的 frame。
- 插件丰富。
- 可以学英语、背单词、背古汉语

# 缺点

- [ ] 图片会莫名其妙被删除？是因为外部 typora 同时打开了？使用 git 管理，可以查知文件删除，可以恢复回来。
- [x] 导出 pdf 时，没有标签，mermaid 没有缩放，超出页面的就截掉了。建议使用 typora 转换。
- [x] 文件内，跳转标题。有插件可以做，但好像也没太大必要。 ✅ 2022-01-21
- [x] 预览模式下没有 vim mode，类似 chrome 浏览器的 vimium？可以尽量呆在编辑模式。一直呆在编辑模式，使用 vim 即可。
- [x] vim 模式下，怎么打开链接？ctrl+], ctrl+enter。修改配置，支持`gd`了。
  ```
  exmap follow obcommand editor:follow-link
  nmap gd :follow
  ```
- [x] vim 模式下，easymotion？插件，`ctrl+;`
- [x] ~~emoji 不支持？`:emoji:`形式。可以使用插件。~~

# 迁移：新建仓库

- .obsidian目录
- template目录
- .obsidian.vimrc文件
- 新建daily空目录

# 数学公式

![[mathjax]]

# 插件

## consistent

它把附件挪到文档本地

![Pasted image 20220502132956](assets/Pasted%20image%2020220502132956.png)

## calendar，3 星

日历，适合当天日志，不好任意跳转。

## ❌emoji shortcodes，4 星

#emoji

弃用，因为可以映射到输入法快捷键，直接输入 emoji。

| emoji | unicode name                    |
| ----- | ------------------------------- |
| ✅    | `:white_check_mark:`            |
| ❎    | `:negative_squared_cross_mark:` |
| ⌛    | `:hourglass:`                   |
| ⭐    | `:star:`                        |
| 💡    | `:bulb:`                        |
| ❤     | `:heart:`                       |
| ❌    | `:x:`                           |
| 💖    | `:sparkling_heart:`             |
| ⏫    | `:arrow_double_up`              |

## highlightr

可先用 vim 选中文字，然后调出命令窗口，选择颜色。

<mark style="background: #FF5582A6;">red: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #BBFABBA6;">green: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #ADCCFFA6;">blue: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #FFB86CA6;">orange: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #D2B3FFA6;">purple: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #FFB8EBA6;">pink: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #ABF7F7A6;">cyan: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #CACFD9A6;">grey: 使用一个 md 文件来做 kanban。</mark>
<mark style="background: #FFF3A3A6;">yellow: 使用一个 md 文件来做 kanban。</mark>

## kanban，4 星

使用一个 md 文件来做 kanban。

![Pasted image 20220117100624](assets/Pasted%20image%2020220117100624.png)

## link-converter，4 星

https://github.com/ozntel/obsidian-link-converter

移动文件时，有些 url 的相对路径其实已经不对了（比如在 typora 中显示不了图片），但在 obsidian 中仍能正常显示。这是因为 obsidian 认为这个文件名唯一？

插件 link-converter 可以不管三七二十一，直接在文件上右键选择`All Links to Relative Path`，就会把文件内的链接转为相对路径。

但是目前会把文件扩展名给省略掉。

## remember cursor position，4 星

记得文档上一次打开的位置。

## ⭐ tasks，5 星

https://github.com/schemar/obsidian-tasks

https://schemar.github.io/obsidian-tasks/queries/

## ⭐ templater，5 星

模板，比 ob 自带的要好。

## ⭐ text-snippets-obsidian

snippets 展开

## ⭐ timelines，5 星

时间轴显示，比如日记。

## ⭐ vimrc-support，5 星

https://github.com/esm7/obsidian-vimrc-support

### 配置文件

.obsidian.vimrc

```c
" keymap
"imap jj <C-[>
imap jj <Esc>
"imap <C-o> <Esc><C-o>
nmap j gj
nmap k gk
nmap f }zz
nmap F <C-d>zz
nmap b {zz
nmap B <C-u>zz
nmap gb viw
"let @q="c``\<Esc>hp"
"vmap ge @q
"vmap gh @h
"vmap gl @l
" Surround text with [[ ]] to make a wikilink
" NOTE: must use 'map' and not 'nmap'
exmap wiki surround [[ ]]
map [[ :wiki
map gl :wiki

"nmap gh <C-h>
"exmap highlight surround == ==
"map gh :highlight
"exmap highlight obcommand editor:toggle-highlight
"map gh :highlight

"nmap ge <C-e>
"exmap quote surround ` `
"map ge :quote

"exmap highlight obcommand editor:toggle-highlight
"nmap gh :highlight
"exmap quote obcommand editor:toggle-code
"nmap ge :quote

exmap mark surround <mark> </mark>
map gm :mark
exmap fontcolor surround <font\ color="FF69B4"> </font>
map gc :fontcolor
"noremap gD <C-]>
exmap newpane obcommand editor:open-link-in-new-leaf
nmap gD :newpane
exmap follow obcommand editor:follow-link
nmap gd :follow

exmap lefttab obcommand workspace:previous-tab
nmap J :lefttab
exmap righttab obcommand workspace:next-tab
nmap K :righttab

" Yank to system clipboard
set clipboard=unnamed

" unsupport
" set whichwrap+=>,l,<,h
```


## excalidraw

![](assets/obsidian%202022-05-10%2009.29.45.excalidraw.md)

## execute-code

```python
def hello(name):
    print("Hello", name)

if __name__ == "__main__":
    hello("Eve")
```

# TIPS

## 包含文件时完全内嵌

-  https://forum.obsidian.md/t/transclude-without-scroll-box/17642
-  https://forum.obsidian.md/t/how-do-i-embed-notes-without-the-title/11427

也就是把 scrollbar 给去掉。

添加 css 片段。

```c
/* eliminate scrollbars in transclusions */
.markdown-source-view .markdown-embed-content,
.markdown-source-view .markdown-embed-content>.markdown-source-view {
      max-height: unset;
}

/* eliminate scrollbars in transclusions */
.markdown-preview-view .markdown-embed-content,
.markdown-preview-view .markdown-embed-content>.markdown-preview-view {
      max-height: unset;
}
```

导出 pdf 的时候，是包含完整内嵌内容吗？

## 代码块里换行

插件 spaced repetition，浏览的时候，代码块里没有换行。

解决：增加自定义 CSS

https://stackoverflow.com/questions/248011/how-do-i-wrap-text-in-a-pre-tag

```
pre {
    white-space: pre-wrap;       /* Since CSS 2.1 */
}
```

## callout

https://help.obsidian.md/How+to/Use+callouts

> [!NOTE]+ note
> Contents

> [!abstract]+ abstract
> Contents

> [!info]+ info
> Contents

> [!todo]+ todo
> Contents

> [!tip]+ tip, hint, important
> Contents

> [!success]+ success, check, done
> Contents

> [!faq]+ faq, help, question
> Contents

> [!warning]+ warning, caution, attention
> Contents

> [!failure]+ fail, failure, missing
> Contents

> [!error]+ error, danger
> Contents

> [!bug]+ bug
> Contents

> [!example]+ example
> Contents

> [!quote]+ quote, cite
> Contents

## 高亮

https://stackoverflow.com/a/63851626/1148981

```
==高亮文字==
```

效果：

==高亮文字==

用作一问一答不错，高亮表示问题。

## 图片大小

显示 400 宽度的图片：

```
![400](image%20file)
```

## 块引用

比如引用另一个页面里的某个 heading，甚至某个 block。

标题引用： https://help.obsidian.md/How+to/Internal+link#Link+to+headings

`[[`选择页面之后敲`#`来搜索。

块引用： https://help.obsidian.md/How+to/Link+to+blocks

`[[`选择页面之后敲`^`来搜索。

## ubuntu 安装没有图标

直接运行 appimage，没有图标。

先安装 [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher)，然后打开 appimage，会提示安装。再次打开就正常了（Win 搜索）。

## alias 文件别名

https://help.obsidian.md/How+to/Add+aliases+to+note

比如给文件`btn_cmd_t`加个别名`bcmd`：

```
---
aliases: [bcmd]
---
```

这一段代码要放到文件最开头。

## ⭐代码块中高亮，使用 pre 标签

https://xkcd.com/color/rgb/

https://www.color-hex.com/color-names.html

<font color="green">green</font>
<font color="red">red</font>
<font color="#7CFC00">Grass Green</font>
<font color="#FF4433">Red Orange</font>
<font color="#1F51FF">Neon Blue</font>
<font color="#0FFF50">Neon Green</font>
<font color="#FF5F1F">Neon Orange</font>
<font color="#FF10F0">Neon Pink</font>
<font color="#FF3131">Neon Red</font>
<font color="#9D00FF">Neon Purple</font>

高亮文本颜色选用粉色（hotpink）：`FF69B4`，<font color="FF69B4"> 效果 </font>

<pre>
<mark style="background: #FF5582A6;"> for i in range(10): </mark>
	print(i)
</pre>

```
cpu1: Zone 1581: IMP_OPEN spb=1866, spb_ec=6, spb_sn=8901
cpu1: actv_ctx=2 wp=C5A00070 dtag_cnt=0 receive_index=0 program_index=0, seq:0x19A95CC2
cpu1: Zone 1584: FULL spb=1685, spb_ec=6, spb_sn=8876
cpu1: Zone 1593: FULL spb=1818, spb_ec=6, spb_sn=8897
```

<pre style="font-family: Source Code Pro, Cascadia Code, monospace; font-size: 17px;">
cpu1: Zone 1581: IMP_OPEN spb=1866, spb_ec=6, spb_sn=8901
cpu1: actv_ctx=2 wp=C5A00070 dtag_cnt=0 receive_index=0 program_index=0, seq:0x19A95CC2
cpu1: Zone 1584: FULL spb=1685, spb_ec=6, spb_sn=8876
cpu1: Zone 1593: FULL spb=1818, spb_ec=6, spb_sn=8897
cpu1: Zone 1602: FULL spb=1843, spb_ec=5, spb_sn=8848
cpu1: Zone 1617: FULL spb=1697, spb_ec=6, spb_sn=8877
cpu1: Zone 1640: FULL spb=1602, spb_ec=5, spb_sn=8820
cpu1: Zone 1662: FULL spb=1684, spb_ec=6, spb_sn=8875
cpu1: Zone 1673: IMP_OPEN spb=1835, spb_ec=6, spb_sn=8899
<font color="FF69B4">cpu1: actv_ctx=0 wp=D12000D2 dtag_cnt=100 receive_index=0 program_index=0, seq:0x19A95CC0 </font>
cpu1: Zone 1697: FULL spb=1620, spb_ec=5, spb_sn=8822
cpu1: Zone 1702: FULL spb=1498, spb_ec=4, spb_sn=8776
cpu1: Zone 1703: FULL spb=1842, spb_ec=5, spb_sn=8847
cpu1: Zone 1707: FULL spb=1605, spb_ec=5, spb_sn=8821
cpu1: Zone 1757: FULL spb=1865, spb_ec=5, spb_sn=8850
cpu1: Zone 1761: IMP_OPEN spb=1854, spb_ec=6, spb_sn=8900
<mark>cpu1: actv_ctx=1 wp=DC2000A6 <font color="FF69B4"> dtag_cnt </font> =54 receive_index=0 program_index=0, seq:0x19A95CC1 </mark>
<font color="FF1493">cpu1: Zone 1787: FULL spb=1527, spb_ec=4, spb_sn=8777 </font>
<font color="FF5582A6">cpu1: Zone 1793: FULL spb=1572, spb_ec=5, spb_sn=8819 </font>
<font color="FF69B4">cpu1: Zone 1813: IMP_OPEN spb=1867, spb_ec=6, spb_sn=8902 </font>
cpu1: actv_ctx=3 <font color="FF69B4"> wp=E2A0003C </font> <font color="FF1493"> dtag_cnt=0 </font> receive_index=0 <font color="00FF7F"> program_index=0 </font>, seq:0x19A95CC3
cpu1: Zone 1817: FULL spb=1844, spb_ec=5, spb_sn=8849
cpu1: Zone 1849: FULL spb=1819, spb_ec=6, spb_sn=8898
cpu1: Active zones=4 others=1511 capacity=0011B800 size=00200000 dtags=154
</pre>

> [!tip]+ 太亮了
>
> 比如引用另一个页面里的某个 <font color="FF1493"> heading </font>，甚至某个 block。
>
> <mark> 比如引用另一个页面里的某个 <font color="FF1493"> heading </font>，甚至某个 block。</mark>
>
> <font color="FF1493"> 比如引用另一个页面里的某个 <font color="FF1493"> heading </font>，甚至某个 block。</font>

> [!tip]+ 当前
>
> 比如引用另一个页面里的某个 <font color="FF69B4"> heading </font>，甚至某个 block。
>
> <mark> 比如引用另一个页面里的某个 <font color="FF69B4"> heading </font>，甚至某个 block。</mark>
>
> <font color="FF69B4"> 比如引用另一个页面里的某个 <font color="FF69B4"> heading </font>，甚至某个 block。</font>

> [!tip]+ highlight red
>
> 比如引用另一个页面里的某个 <font color="#FF5582A6"> heading </font>，甚至某个 block。
>
> <font color="FF5582A6"> 比如引用另一个页面里的某个 <font color="#FF5582A6"> heading </font>，甚至某个 block。</font>
>
> <mark> 比如引用另一个页面里的某个 <font color="#FF5582A6"> heading </font>，甚至某个 block。</mark>

> [!tip]+ highlight pink
>
> 比如引用另一个页面里的某个 <font color="#FFB8EBA6"> heading </font>，甚至某个 block。
>
> <font color="FFB8EBA6"> 比如引用另一个页面里的某个 <font color="#FFB8EBA6"> heading </font>，甚至某个 block。</font>
>
> <mark> 比如引用另一个页面里的某个 <font color="#FFB8EBA6"> heading </font>，甚至某个 block。</mark>

深色主题效果：

![Pasted image 20220424175829](assets/Pasted%20image%2020220424175829.png)

![Pasted image 20220424175921](assets/Pasted%20image%2020220424175921.png)

---

<mark style="background: #FF5582A6;"> highlight red </mark>

<mark style="background: #FFB8EBA6;"> highlight pink </mark>

# 发布？

Hugo，Zola，Quartz，Netlify

wikmd?

## ⭐mkdocs

![mkdocs](mkdocs.md)

## Hugo

可以本地托管。

## Quartz

托管在 github pages

## 添加 hugo front matter

yaml 格式，需要提供 title 字段。

https://www.sametbh.com/docs/64-programming/static-site-generators/hugo/frontmatter-tools/

> [!NOTE]+ Python Frontmatter
> https://python-frontmatter.readthedocs.io/en/latest/index.html
> 这个 Python 库不错，可以解析文本的 metadata 跟 content，那就自己编程来统一改。
>
> ```bash
> find . -name "*.md" -print0 | xargs -0 -I file python3 hugo_frontmatter.py file
> ```

# 资源

https://github.com/kmaasrud/awesome-obsidian

> [!NOTE]+ [Markdownload](https://github.com/deathau/markdown-clipper)
>
> A Firefox and Google Chrome extension to clip websites and download them into a readable markdown file.
