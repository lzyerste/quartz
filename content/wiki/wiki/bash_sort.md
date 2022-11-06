---
title: "bash_sort"
---

## 按数字排序

https://stackoverflow.com/questions/16129403/sorting-by-integer-value

```bash
 ps -e -o %cpu | sort -nr
```

`n` for numeric, `r` for reverse. If you also want to remove the header:

```bash
 ps -e -o %cpu | sed '1d' | sort -nr
```
