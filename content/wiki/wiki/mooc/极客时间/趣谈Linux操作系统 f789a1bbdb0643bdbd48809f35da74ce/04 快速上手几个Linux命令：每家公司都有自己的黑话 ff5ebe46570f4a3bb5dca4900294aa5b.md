---
title: 04_快速上手几个Linux命令：每家公司都有自己的黑话_ff5ebe46570f4a3bb5dca4900294aa5b
---

# 04 | 快速上手几个Linux命令：每家公司都有自己的黑话

[04 | 快速上手几个Linux命令：每家公司都有自己的黑话-极客时间](https://time.geekbang.org/column/article/88761)

![2022-05-02_11-21-48](04%20快速上手几个Linux命令：每家公司都有自己的黑话%20ff5ebe46570f4a3bb5dca4900294aa5b/2022-05-02_11-21-48.png)

```python
# passwd
Changing password for user root.
New password:
```

```python
useradd cliu8
```

```python
[root@deployer ~]# useradd -h
Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
  -g, --gid GROUP               name or ID of the primary group of the new account
```

![Untitled 1](assets/0ea9a219a85a2fa4dc45ebb2ae80271d.png)

```python
# cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
......
cliu8:x:1000:1000::/home/cliu8:/bin/bash

# cat /etc/group
root:x:0:
......
cliu8:x:1000:
```

![Untitled 2](assets/6f63ad00b4c0606471d04907419c6db8.png)

![Untitled 3](assets/77154fee5f1fd4334738c5628d5531ee.png)

```python
# ls -l
drwxr-xr-x 6 root root    4096 Oct 20  2017 apt
-rw-r--r-- 1 root root     211 Oct 20  2017 hosts
```

![Untitled 4](assets/69aaa9f2341f32b8acb4c0e99f582177.png)

![Untitled 5](assets/02da1370b9c698e4e713f1d131ca9bba.png)

```python
[base]
name=CentOS-$releasever - Base - 163.com
baseurl=http://mirrors.163.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7
```

```python
deb http://mirrors.163.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ xenial-backports main restricted universe multiverse
```

```python
yum install zip.x86_64 unzip.x86_64
apt-get install zip unzip
```

![Untitled 6](assets/c9bcb9c6d7938b77381f91017e8996cc.png)

```python
export JAVA_HOME=/root/jdk-XXX_linux-x64
export PATH=$JAVA_HOME/bin:$PATH
```

```python
ps -ef |grep 关键字  |awk '{print $2}'|xargs kill -9
```

![Untitled 7](assets/c8e8cc67dbcd9eec8c6c4da4bcb280b1.png)

![Untitled 8](assets/25b5dab3916cae1ed30f724d013d91a7.png)