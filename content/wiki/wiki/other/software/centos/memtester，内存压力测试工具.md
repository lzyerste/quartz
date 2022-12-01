---
title: memtester，内存压力测试工具
---

#ddr

https://linux.die.net/man/8/memtester

> [!NOTE]+ ubuntu 安装
> apt install memtester

下载链接：

https://centos.pkgs.org/7/repoforge-x86_64/memtester-4.2.0-1.el7.rf.x86_64.rpm.html

```cpp
https://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/memtester-4.2.0-1.el7.rf.x86_64.rpm
```

简单使用：

```cpp
# 占用30G并测试，默认会无限次数循环，可加上轮数限制。
memtester 30G
```
