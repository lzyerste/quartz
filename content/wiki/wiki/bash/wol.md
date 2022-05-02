---
title: wol
---

#wol

https://wiki.debian.org/WakeOnLan

* 进入BIOS，电源管理，允许pcie唤醒（wol）

* 强行关机

  ```sh
  sudo bash -c 'sync ; echo o > /proc/sysrq-trigger'
  ```

* 局域网其他电脑发送命令唤醒，使用mac地址。

  ```sh
  $ wakeonlan 7c:10:c9:3f:03:56
  Sending magic packet to 255.255.255.255:9 with 7c:10:c9:3f:03:56
  ```