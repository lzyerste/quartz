---
title: 04_快速上手几个Linux命令：每家公司都有自己的黑话_ff5ebe46570f4a3bb5dca4900294aa5b
---

# 04 | 快速上手几个Linux命令：每家公司都有自己的黑话

[04 | 快速上手几个Linux命令：每家公司都有自己的黑话-极客时间](https://time.geekbang.org/column/article/88761)

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled.png)

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

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%201.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%201.png)

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

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%202.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%202.png)

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%203.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%203.png)

```python
# ls -l
drwxr-xr-x 6 root root    4096 Oct 20  2017 apt
-rw-r--r-- 1 root root     211 Oct 20  2017 hosts
```

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%204.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%204.png)

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%205.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%205.png)

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

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%206.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%206.png)

```python
export JAVA_HOME=/root/jdk-XXX_linux-x64
export PATH=$JAVA_HOME/bin:$PATH
```

```python
ps -ef |grep 关键字  |awk '{print $2}'|xargs kill -9
```

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%207.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%207.png)

![04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%208.png](04%20%E5%BF%AB%E9%80%9F%E4%B8%8A%E6%89%8B%E5%87%A0%E4%B8%AALinux%E5%91%BD%E4%BB%A4%EF%BC%9A%E6%AF%8F%E5%AE%B6%E5%85%AC%E5%8F%B8%E9%83%BD%E6%9C%89%E8%87%AA%E5%B7%B1%E7%9A%84%E9%BB%91%E8%AF%9D%20ff5ebe46570f4a3bb5dca4900294aa5b/Untitled%208.png)