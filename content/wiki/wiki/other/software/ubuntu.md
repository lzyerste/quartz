---
title: ubuntu
---

#ubuntu

[centos](centos.md)

package搜索： https://pkgs.org/

# ubuntu

[ubuntu重装系统](../../../personal/ubuntu重装系统.md)

[安装不同内核](ubuntu/安装不同内核.md)

[⭐给root用户添加密码，允许ssh以root连接](ubuntu/给root用户添加密码，允许ssh以root连接.md)

[修改鼠标滚轮速度，往前、往后](ubuntu/修改鼠标滚轮速度，往前、往后%20d1403a1b24584cc1a1758c9c80378a39.md)

[耳机麦克风没声音](ubuntu/耳机麦克风没声音%2093ef3bf01a4b4a30b56dcd221f2a3618.md)

[ubuntu桌面卡顿](ubuntu/ubuntu桌面卡顿.md)

## ubuntu 休眠，锁屏？

[lightdm](../../lightdm.md)

查看哪些进程在阻止休眠： https://askubuntu.com/questions/1071514/how-to-find-a-program-which-is-preventing-sleeping

```c
dbus-send --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager org.gnome.SessionManager.GetInhibitors

method return time=1659505553.722936 sender=:1.35 -> destination=:1.952 serial=2629 reply_serial=2
   array [
      object path "/org/gnome/SessionManager/Inhibitor201"
      object path "/org/gnome/SessionManager/Inhibitor76"
   ]

$ dbus-send --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager/Inhibitor76 org.gnome.SessionManager.Inhibitor.GetAppId
这是向日葵远程

method return time=1659505571.100906 sender=:1.35 -> destination=:1.953 serial=2630 reply_serial=2
   string "My SDL application"

$ dbus-send --print-reply --dest=org.gnome.SessionManager /org/gnome/SessionManager/Inhibitor201 org.gnome.SessionManager.Inhibitor.GetAppId
这是音乐播放器

method return time=1659505582.362587 sender=:1.35 -> destination=:1.954 serial=2631 reply_serial=2
   string "org.gnome.Rhythmbox3"
```

---

2022-11-11 18:37:40，手工方法

脚本lzy-sleep：绑定到快捷键win+L，息屏再锁屏

```c
#!/bin/bash

sleep 1 ; xset dpms force standby ; gnome-screensaver-command -l
```

2022-11-14 10:28:08，脚本检测

https://askubuntu.com/questions/17679/how-can-i-put-the-display-to-sleep-on-screen-lock

脚本lock-check，如果发现处于lock状态，直接息屏。定期检查时间设置为30秒。注意不能太短，因为需要唤醒后输入密码。

不要判断yes/no，只要锁屏，直接息屏。

```sh
#!/bin/bash

ALREADY_SHUTOFF="yes"

while true; do

    if (gnome-screensaver-command -q | grep "is active");
    then

        echo $ALREADY_SHUTOFF
        xset dpms force off
        if [ "$ALREADY_SHUTOFF" == "no" ];
        then

            # this command turns off the display
            xset dpms force off
        fi


        ALREADY_SHUTOFF="yes"

    else

        ALREADY_SHUTOFF="no"
    fi

    sleep 30

done
```

# 新建用户

[How To Create a Sudo User on Ubuntu](https://linuxize.com/post/how-to-create-a-sudo-user-on-ubuntu/)

```python
adduser lzy
```

加入sudo：

```c
usermod -aG sudo lzy
```

# 发行版内核版本及glibc版本

![Pasted image 20220210143050](assets/Pasted%20image%2020220210143050.png)

# 锁屏后显示Authentication Failure Switch to greeter...

[ubuntu锁定屏幕后显示"Authentication Failure Switch to greeter..."](https://www.jianshu.com/p/f54c1d84e70d)

# 修改时区

[Ubuntu修改时区和更新时间 - zhengchaooo的博客 - CSDN博客](https://blog.csdn.net/zhengchaooo/article/details/79500032)

# 网络问题

2019-12-23 20:16:15

Ubuntu 16.04安装4.15.0-42（降级）内核后，没有网络了，看不到网卡。

解决办法：重装网络驱动。

[How To get your Realtek RTL8111/RTL8168 working](https://unixblogger.com/how-to-get-your-realtek-rtl8111rtl8168-working-updated-guide/)