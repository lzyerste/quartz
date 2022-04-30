---
title: KVCeph_14_2_8编译的坑
---

# KVCeph 14.2.8编译的坑

使用gcc8环境：

```bash
scl enable devtoolset-8 bash
```

使用较新的npm，切换到taobao源。

[How to Install Node.js and npm on CentOS 7](https://linuxize.com/post/how-to-install-node-js-on-centos-7/)

```bash
$ curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
$ sudo yum install nodejs
$ node --version
v10.22.0
$ npm --version
6.14.6
```

切换taobao源：

[切换 NPM 镜像源](https://www.jianshu.com/p/ddc0b8f8f72a)

```bash
$ sudo npm install -g nrm
$ nrm ls
# 切换到taobao
$ nrm use taobao
```

之前编译的时候卡在pybind/mgr/dashboard/frontend，nodejs找不到模块concat-map，使用之前更新过的npm手工安装。

目录在<ceph>/src/pybind/mgr/dashboard/frontend，

```bash
npm install concat-map
```

之后编译正常了。