---
title: KVCeph
---

# KVCeph

## 下载

```cpp
git clone lzyerste@lzyerste-pcu:~/git/storage-system
git clone root@172.17.42.66:/home/deploy/test/KVCeph

cp -rf storage-system/kv_libc++ KVCeph/src/kv_libcpp
```

## 编译

```cpp
# shannondb依赖bzip2
sudo apt install bzip2 libbz2-dev

# 安装zlib
sudo apt install zlib1g zlib1g-dev

# 安装依赖包
./install-deps.sh

ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_TESTS=OFF" ./do_cmake.sh

cd build
make -j8
```

## CentOS 7编译

问题1：

```bash
# 安装依赖包
./install-deps.sh
```

出现问题：

```bash
Transaction check error:
  file /etc/rpm/macros.python from install of python-rpm-macros-3-32.el7.noarch conflicts with file from package python-devel-2.7.5-80.el7_6.x86_64
```

可能跟系统安装了epel有关系？

[0016379: python-rpm-macros and python-devel conflict - CentOS Bug Tracker](https://bugs.centos.org/view.php?id=16379)

重新安装（升级？）下python2就能继续了。

```bash
sudo yum install python
```

第二步，将kv_libc++移到kvceph（已经成为子模块了，这一步就可以跳过了。）

```bash
rm -rf src/kv_libcpp
cp -rf ~/storage-system/kv_libc++ src/kv_libcpp
```

第三步，cmake生成配置文件。

```bash
ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_TESTS=OFF -DCMAKE_INSTALL_PREFIX=/usr" ./do_cmake.sh
```

第4步，编译

```bash
# 因为去掉了TEST，所以编译约为半小时。
make -j8
```

## systemd服务

```bash
cd systemd
mkdir build && cd build
cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib ..
sudo make install
```

不指定CMAKE_INSTALL_LIBEXECDIR的话，会默认安装到/systemd/system目录下。

或者make的时候指定目的也行：

```bash
sudo make DESTDIR=/usr/lib install
```