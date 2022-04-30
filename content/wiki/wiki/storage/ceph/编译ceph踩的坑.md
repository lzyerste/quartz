---
title: 编译ceph踩的坑
---

# 编译ceph踩的坑

```cpp
# 编译release版本
ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo" ./do_cmake.sh
# 指定gcc版本
ARGS="-DCMAKE_C_COMPILER=gcc-7 -DCMAKE_BUILD_TYPE=RelWithDebInfo" ./do_cmake.sh
```

- 使用gcc-7
- dashboard frontend（54%进度左右），npm折腾了好久，甚至升级nodejs到最新。
    - 最后结果是heap分配的太小。
    
    [FATAL ERROR: Ineffective mark-compacts near heap limit Allocation failed - JavaScript heap out of memory in ionic 3](https://stackoverflow.com/questions/53230823/fatal-error-ineffective-mark-compacts-near-heap-limit-allocation-failed-javas)
    
    - 编译前设置环境变量export NODE_OPTIONS="--max-old-space-size=8192"，顺利编译了。
    - 还要报错@import defaults找不到。
- 链接kafka，未找到rd_kafka_flush（64%）
    - 但是之前手工安装过librdkafka，1.4.0，最新版，在/usr/local/lib下
    - 貌似与系统的kafka冲突了？0.8.6的版本。
    - sudo apt remove librdkafka-dev
    - 可以继续编译了