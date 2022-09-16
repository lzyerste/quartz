---
title: "redmine"
---

#markdown

## 文字样式

### color

基本格式就是：

```c
%{color:<color_name>}Your text%
```

```c
%{color:red}red% %{color:green}green% %{color:yellow}yellow% %{color:#82B6E1}blue'ish%
%{color:red}red%<notextile></notextile>%{color:green}green%<notextile></notextile>%{color:yellow}yellow%<notextile></notextile>%{color:#82B6E1}blue'ish%
%{background:lightgreen}Lightgreen Background% %{background:yellow}Yellow Background%
%{background:lightgreen}Lightgreen Background%<notextile></notextile>%{background:yellow}Yellow Background%
```

## table

- 在线转换： https://www.joecullin.com/data_converter/

```c
|_. head1 |_. head 2 |_. head foo | bar |
| foo     |          |  bar       | baz |
```

`_.`只是对齐方式，所以跟 Markdown 表格差不多，只是还多了一行`----`的东西。

所以，简单方式是，先把表格拷贝到 typora，然后再拷贝到 redmine。