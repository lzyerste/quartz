---
title: "mkdocs"
---

https://github.com/mkdocs/mkdocs/

安装方便，静态网站可以很方便生成，可以本地使用，也可以推到 github pages。

图文显示没问题，支持相对链接。

本地：mkdocs serve

github pages：mkdocs gh-pages

但有一个缺点，就是文件很多的情况下，生成一次太慢，而且生成太大（几乎一个 md 文件变成了 1M 的页面）。增量更新不太好使，会把索引清空。

另一个缺点，目前还不支持中文搜索（用插件？），搜索速度有点慢。

## 中文搜索

https://zhuanlan.zhihu.com/p/411854801

```python
        # 给正文分词
        text_seg_list = jieba.cut_for_search(text) # 结巴分词，搜索引擎模式，召回率更高
        text = " ".join(text_seg_list) # 用空格连接词语

        # 给标题分词
        title_seg_list = jieba.cut(title, cut_all=False) # 结巴分词，精确模式，更可读
        title = " ".join(title_seg_list) # 用空格连接词语
```

## 搜索配置

https://www.mkdocs.org/user-guide/configuration/

仅搜索标题，不要搜索全文，因为索引文件太大，加载时间太长。

```c
plugins:
  - search:
      lang:
        - en
        - ja
      separator: '[\s\-\.]+'
      indexing: titles
```