---
title: "find"
---

## 找到并删除符合某 pattern 的文件

https://askubuntu.com/questions/43709/how-do-i-remove-all-files-that-match-a-pattern

注意最后的 delete 是注释掉的，如果真的想删除，把注释去掉。

```bash
find . -name '*.orig' #-delete
```
