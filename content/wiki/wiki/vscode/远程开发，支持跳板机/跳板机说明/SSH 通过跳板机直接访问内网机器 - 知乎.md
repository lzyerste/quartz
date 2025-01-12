---
title: SSH_通过跳板机直接访问内网机器_-_知乎_1decbf806fca4461ab3faec203953977
---

#cut

https://zhuanlan.zhihu.com/p/74193910

本文博客地址：

本文公众号地址：

公司的很多服务器没有外网地址只能通过内网访问。

这个时候就需要我们先登录跳板机，然后在跳板机上登录内网机器（本机 ssh -> 跳板机 -> 内网机器）。

因为跳板机是公用的，所以为了安全不能将跳板机的公钥放到内网机器上实现免密登录，更不能将本机的公钥和私钥放到跳板机上实现免密登录。因为懒所以就搜寻到一个解决方案。

Ps:懒人改变世界: )

## 正文

## ProxyJump

需要 `OpenSSH 7.3` 以上版本才可以使用 `ProxyJump`, 使用下列命令查看`OpenSSH` 版本：

`ProxyJump` 命令行使用方法：

```
ssh -J [email protected]:port1,[email protected]:port2
```

可以直接使用上述命令通过跳板机直接登录内网机器，比如：

```
ssh username@目标机器IP -p 22 -J username@跳板机IP:22
```

如果需要通过多个跳板机则以 `,` 分割：

```
ssh username@目标机器IP -p 22 -J username1@跳板机IP1:22,username2@跳板机IP2:22
```

如果你觉得每次都需要加上 `-J` 的配置很多麻烦，可以写到配置文件里。修改配置文件 `~\.ssh\config`，默认没有需要自己创建。增加以下内容：

```
Host target    # 代表目标机器的名字
    HostName 目标机器 IP    # 这个是目标机器的 IP
    Port 22    # 目标机器 ssh 的端口
    User username_target    # 目标机器的用户名
    ProxyJump username@跳板机IP:port

Host 10.10.0.*    # 使用通配符 * 代表 10.10.0.1 - 10.10.0.255
    Port 22    # 服务器端口
    User username    # 服务器用户名
    ProxyJump username@跳板机IP:port
```

也可以为跳板机器一个“别名”方便使用：

```
Host tiaoban1    # 代表跳板机 1
    HostName 跳板机 1 的 IP
    Port 22    # ssh 连接端口
    User username1    # 跳板机 1 的用户名

Host tiaoban2    # 代表跳板机 2
    HostName 跳板机 2 的 IP
    Port 22    # ssh 连接端口
    User username2    # 跳板机 2 的用户名

Host target    # 代表目标机器的名字
    HostName 目标机器 IP    # 这个是目标机器的 IP
    Port 22    # 目标机器 ssh 的端口
    User username_target    # 目标机器的用户名
    ProxyJump tiaoban1,tiaoban2

Host 10.10.0.*    # 使用通配符 * 代表 10.10.0.1 - 10.10.0.255
    Port 22    # 服务器端口
    User username    # 服务器用户名
    ProxyJump tiaoban1,tiaoban2
```

使用方法：

```
ssh target
ssh 10.10.0.1
ssh username@target -p22
ssh username@10.10.0.1 -p22
```

## ProxyCommand

如果 `OpenSSH` 版本低于 **7.3** 可以使用 `ProxyCommand`达到同样的效果。

`ProxyCommand` 命令行使用方法：

```
ssh username@目标机器IP -p 22 -o ProxyCommand='ssh -p 22 username@跳板机IP -W %h:%p'
```

同样可以在 `~/.ssh/config` 文件中增加配置文件：

```
Host tiaoban   # 任意名字，随便使用

    HostName 跳板机的 IP，支持域名

    Port 22      # 跳板机端口

    User username_tiaoban       # 跳板机用户



Host target      # 同样，任意名字，随便起

    HostName 目标服务器 IP    # 真正登陆的服务器，不支持域名必须IP地址

    Port 22   # 服务器的端口

    User username   # 服务器的用户

    ProxyCommand ssh tiaoban -W %h:%p



Host 10.10.0.*      # 可以用*通配符

    Port 22   # 服务器的端口

    User username   # 服务器的用户

    ProxyCommand ssh tiaoban -W %h:%p
```

使用方法同上：

```
ssh target
ssh 10.10.0.1
ssh username@target -p22
ssh username@10.10.0.1 -p22
```

## 参考

1.  [ssh如何通过跳板机直接访问到后端服务器(Mac&Linux&Windows解决方案)](https://link.zhihu.com/?target=https%3A//my.oschina.net/foreverich/blog/657075)
2.  [SSH命令行帮你实现六种“贴心”的安全应用](https://link.zhihu.com/?target=http%3A//netsecurity.51cto.com/art/201711/557999.htm)
3.  [\[转\]SSH隧道：内网穿透实战](https://link.zhihu.com/?target=https%3A//www.lzskyline.com/archives/478)
