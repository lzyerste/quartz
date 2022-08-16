---
title: _watch
---

#bash

定期观察命令执行结果。

比如观察slabinfo：

```sh
watch -n 1 'cat /proc/slabinfo | sort -n -k 2 -r'
```

如果需要保存到文件，可以结合 tee 使用。

https://superuser.com/questions/297283/store-the-output-of-date-and-watch-command-to-a-file

```bash
watch -n 10 './build/zns/zns_cli smart_log --show-expand | grep -E "ddr|Thermal|Temperature" | tee -a 20089.log'
```