---
title: gtest、gmock
---

# gtest、gmock

[gtest指南](gtest%E3%80%81gmock/gtest%E6%8C%87%E5%8D%97%203daafdfbed4c4bd8b11c7574d6cf0b63.md)

## Ubuntu安装

动态库：

```c
sudo apt install libgtest-dev
cd /usr/src/gtest/
sudo mkdir build && cd build
sudo cmake -DBUILD_SHARED_LIBS=ON ..
sudo make
sudo cp *.so /usr/local/lib
sudo ldconfig
```

```c
sudo apt install google-mock
```

## CentOS安装

```c
sudo yum install gtest-devel gmock-devel
```