---
title: "anki"
---

本地路径：`%APPDATA\Anki2`

## 手工添加音频

英文单词发音可以从有道词典下载：

```c
https://dict.youdao.com/dictvoice?type=2&audio=glitch
```

本地音频路径：

```c
C:\Users\A\AppData\Roaming\Anki2\账户1\collection.media
```

文件名可以直接保存为单词名，比如`glitch.mp3`。

修改 anki 词条，audio 字段添加音频：注意 sound 冒号后面不要有空格。

```c
[sound:glitch.mp3]
```

## 过滤不带音频的单词

https://www.reddit.com/r/Anki/comments/grh36z/search_cards_with_a_specific_empty_field/

```c
deck:单词 audio:
```

## 插件：Online Dictionary Help

- chrome 插件：Online Dictionary Help， https://zhuanlan.zhihu.com/p/33799112

正面：

![600](assets/Pasted%20image%2020221112110839.png)

反面：

![600](assets/Pasted%20image%2020221112110857.png)