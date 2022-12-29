---
title: fio
---

# fio

https://fio.readthedocs.io/en/latest/

## 参数详解

### offset_increment

> [!tip]+ `offset_increment`=int[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-offset-increment)
> If this is provided, then the real offset becomes _offset + offset_increment * thread_number_, where the thread number is a counter that starts at 0 and is incremented for each sub-job (i.e. when [`numjobs`](https://fio.readthedocs.io/en/latest/fio_man.html#cmdoption-arg-numjobs) option is specified). This option is useful if there are several jobs which are intended to operate on a file in parallel disjoint segments, with even spacing between the starting points. Percentages can be used for this option. If a percentage is given, the generated offset will be aligned to the minimum `blocksize` or to the value of `offset_align` if provided. In ZBD mode, value can also be set as number of zones using ‘z’.
>
> fio 测试多 job（numjobs），应该考虑使用参数**offset_increment**，让各个 job 从不同的 offset 开始，彼此错开；否则所有 job 行为都一样，都从同一个 offset 开始。
>
> 为了防止各 job 测试范围重叠，参数 offset_increment 大小可设置为与参数 size 大小一致；另外，多 job 下的 size 应该是单 job 的 size 除以 numjobs（均分）。比如测试总范围是 100z，当 numjobs 为 4 时，offset_increment 和 size 可设置为 25z。

### continue_on_error

> [!tip]+ `continue_on_error`=str [](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-continue-on-error)
>
> Normally fio will exit the job on the first observed failure. If this option is set, fio will continue the job when there is a ‘non-fatal error’ (EIO or EILSEQ) until the runtime is exceeded or the I/O size specified is completed. If this option is used, there are two more stats that are appended, the total error count and the first error. The error field given in the stats is the first error that was hit during the run.
>
> The allowed values are:
>
> **none**
>
> Exit on any I/O or verify errors.
>
> **read**
>
> Continue on read errors, exit on all others.
>
> **write**
>
> Continue on write errors, exit on all others.
>
> **io**
>
> Continue on any I/O error, exit on all others.
>
> **verify**
>
> Continue on verify errors, exit on all others.
>
> **all**
>
> Continue on all errors.
>
> **0**
>
> Backward-compatible alias for ‘none’.
>
> **1**
>
> Backward-compatible alias for ‘all’.

### buffer_pattern

If set, fio will fill the I/O buffers with this pattern or with the contents of a file. If not set, the contents of I/O buffers are defined by the other options related to buffer contents. The setting can be any pattern of bytes, and can be prefixed with 0x for hex values. It may also be a string, where the string must then be wrapped with `""`. Or it may also be a filename, where the filename must be wrapped with `''` in which case the file is opened and read. Note that not all the file contents will be read if that would cause the buffers to overflow. So, for example:

```
buffer_pattern='filename'
```

or:

```
buffer_pattern="abcd"
```

or:

```
buffer_pattern=-12
```

or:

```
buffer_pattern=0xdeadface
```

Also you can combine everything together in any order:

```
buffer_pattern=0xdeadface"abcd"-12'filename'
```

### 1.13.17. Verification

#### verify_only

`verify_only`[](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-verify-only "Permalink to this definition")

Do not perform specified workload, only verify data still matches previous invocation of this workload. This option allows one to check data multiple times at a later date without overwriting it. This option makes sense only for workloads that write data, and does not support workloads with the [`time_based`](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-time-based) option set.

#### do_verify

`do_verify``=bool`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-do-verify "Permalink to this definition")

Run the verify phase after a write phase. Only valid if [`verify`](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-verify) is set. Default: true.

#### ⭐verify

`verify``=str`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify "Permalink to this definition")

If writing to a file, fio can verify the file contents after each iteration of the job. Each verification method also implies verification of special header, which is written to the beginning of each block. This header also includes meta information, like offset of the block, block number, timestamp when block was written, etc. [`verify`](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify) can be combined with [`verify_pattern`](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-pattern) option. The allowed values are:

> **md5**
>
> Use an md5 sum of the data area and store it in the header of each block.
>
> **crc64**
>
> Use an experimental crc64 sum of the data area and store it in the header of each block.
>
> ==**crc32c**==
>
> Use a crc32c sum of the data area and store it in the header of each block. This will automatically use hardware acceleration (e.g. SSE4.2 on an x86 or CRC crypto extensions on ARM64) but will fall back to software crc32c if none is found. Generally the fastest checksum fio supports when hardware accelerated.
>
> **crc32c-intel**
>
> Synonym for crc32c.
>
> **crc32**
>
> Use a crc32 sum of the data area and store it in the header of each block.
>
> **crc16**
>
> Use a crc16 sum of the data area and store it in the header of each block.
>
> **crc7**
>
> Use a crc7 sum of the data area and store it in the header of each block.
>
> **xxhash**
>
> Use xxhash as the checksum function. Generally the fastest software checksum that fio supports.
>
> **sha512**
>
> Use sha512 as the checksum function.
>
> **sha256**
>
> Use sha256 as the checksum function.
>
> **sha1**
>
> Use optimized sha1 as the checksum function.
>
> **sha3-224**
>
> Use optimized sha3-224 as the checksum function.
>
> **sha3-256**
>
> Use optimized sha3-256 as the checksum function.
>
> **sha3-384**
>
> Use optimized sha3-384 as the checksum function.
>
> **sha3-512**
>
> Use optimized sha3-512 as the checksum function.
>
> **meta**
>
> This option is deprecated, since now meta information is included in generic verification header and meta verification happens by default. For detailed information see the description of the [`verify`](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify) setting. This option is kept because of compatibility’s sake with old configurations. Do not use it.
>
> **pattern**
>
> Verify a strict pattern. Normally fio includes a header with some basic information and checksumming, but if this option is set, only the specific pattern set with [`verify_pattern`](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-pattern) is verified.
>
> **null**
>
> Only pretend to verify. Useful for testing internals with [`ioengine`](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-ioengine)=null, not for much else.

This option can be used for repeated burn-in tests of a system to make sure that the written data is also correctly read back. If the data direction given is a read or random read, fio will assume that it should verify a previously written file. If the data direction includes any form of write, the verify will be of the newly written data.

To avoid false verification errors, do not use the norandommap option when verifying data with async I/O engines and I/O depths > 1. Or use the norandommap and the lfsr random generator together to avoid writing to the same offset with multiple outstanding I/Os.

#### verify_offset

`verify_offset``=int`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-offset "Permalink to this definition")

Swap the verification header with data somewhere else in the block before writing. It is swapped back before verifying.

#### verify_interval

`verify_interval``=int`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-interval "Permalink to this definition")

Write the verification header at a finer granularity than the [`blocksize`](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-blocksize). It will be written for chunks the size of `verify_interval`. [`blocksize`](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-blocksize) should divide this evenly.

#### ⭐verify_pattern

`verify_pattern``=str`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-pattern "Permalink to this definition")

If set, fio will fill the I/O buffers with this pattern. ==Fio defaults to filling with totally random bytes==, but sometimes it’s interesting to fill with a ==known pattern== for I/O verification purposes. Depending on the width of the pattern, fio will fill 1/2/3/4 bytes of the buffer at the time (it can be either a decimal or a hex number). The    `verify_pattern` if larger than a 32-bit quantity has to be a hex number that starts with either “0x” or “0X”. Use with [`verify`](https://fio.readthedocs.io/en/latest/fio_doc.html #cmdoption-arg-verify). Also, `verify_pattern` supports `%o` format, which means that for each block offset will be written and then verified back, e.g.:

```
verify_pattern=%o
```

Or use combination of everything:

```
verify_pattern=0xff%o"abcd"-12
```

---

`verify_pattern=%o`的效果：数据填充内容是`LBA*4096`。

```
0000000000003000: CA AC 11 00 00 10 00 00-00 00 00 00 00 00 00 00  ................
0000000000003010: 00 30 00 00 00 00 00 00-00 00 00 00 53 14 32 0F  .0..........S.2.
0000000000003020: 01 00 03 00 F1 9C 41 11-00 30 00 00 00 00 00 00  ......A..0......
0000000000003030: 00 30 00 00 00 00 00 00-00 30 00 00 00 00 00 00  .0.......0......
```

#### verify_fatal

`verify_fatal``=bool`[¶](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-fatal "Permalink to this definition")

Normally fio will keep checking the entire contents before quitting on a block verification failure. If this option is set, fio will exit the job on the first observed failure. Default: false.

#### verify_dump

`verify_dump``=bool`[](https://fio.readthedocs.io/en/latest/fio_doc.html#cmdoption-arg-verify-dump "Permalink to this definition")

If set, dump the contents of both the original data block and the data block we read off disk to files. This allows later analysis to inspect just what kind of data corruption occurred. Off by default.

### norandommap, randrepeat

[[Understanding fio norandommap and randrepeat parameters]]

## old

仓库：

[axboe/fio](https://github.com/axboe/fio)

文档：

[fio](https://fio.readthedocs.io/en/latest/fio_doc.html)

fio 重要参数：

- 重要概念：IO type，Block size，IO size，IO engine，IO depth，Target file/device，Threads/Jobs
- 调试帮助信息

    ```jsx
    --debug=type
    --cmdhelp=command
    --enghelp=[ioengine]
    --showcmd=jobfile
    ```

- `name=str`, ASCII name of the job
- `filename=str`, 比如/dev/sda
- `readwrite=str, rw=str`, 读写类型
- `rwmixread=int`, `rwmixwrite=int`，读写混合比例
- `offset=int`，测试起始地址
- `size=int`, 测试文件大小
- `blocksize=int[,int][,int], bs=int[,int][,int]`, IO 请求大小
- `iodepth=int`
- `numjobs=int`, 并行任务数量
- `loops=int`, 循环次数
- `runtime=time`, `time_based`, 控制运行时间
- `number_ios=int`，运行多少次 IO 为止
- `io_size=int, io_limit=int`，测试跑多少量为止，默认大小为 size
- `ioengine=str`，比如 libaio
- `ioscheduler=str`
- `direct=bool`
- `filesize=irange(int)`
- `cpus_allowed=str`
- `verify=str`
- `zonemode=str`, 比如 zbd
    - `zonesize=int`, `zonecapacity=int`, `read_beyond_wp=bool`, `max_open_zones=int`,  `zonerange=int`
    - 如果设备是 zbd 类型，会自动获取 zonesize 和 zonecapacity

## 例子

写：

```c
fio -filename=/dev/nvme0n1 -ioengine=libaio -direct=1 -iodepth=4 -thread -name=fio_name -numjobs=1 -group_reporting -rw=write -zonemode=zbd -significant_figures=10 -offset=0 -size=200G -iodepth_batch_complete=1 -bs=1m
```

读：

```c
fio -filename=/dev/nvme0n1 -ioengine=libaio -direct=1 -thread -name=fio_name -group_reporting -zonemode=zbd -significant_figures=10 -offset=0 -size=200G -iodepth_batch_complete=1 -bs=16k -rw=read -iodepth=1 -numjobs=1 -runtime=60 -time_based
```

## 测性能

baidu:

写 iops：1000k 多

```c
fio --name=128kB_WR_1job_QD1 '--filename=trtype=PCIe traddr=0000.07.00.0 ns=1' --ioengine=/home/ZNS_test_project/spdk/build/fio/spdk_nvme --zonemode=zbd --direct=1 --thread=1 --numjobs=1 --size=400GB --norandommap=1 --randrepeat=0 --group_reporting --shm_id=1 --time_based=1 --runtime=60 --rw=write --iodepth=256 --bs=4k
```

随机读 iops：1000k 多

```c
fio --name=128kB_WR_1job_QD1 '--filename=trtype=PCIe traddr=0000.07.00.0 ns=1' --ioengine=/home/ZNS_test_project/spdk/build/fio/spdk_nvme --zonemode=zbd --direct=1 --thread=1 --numjobs=1 --size=400GB --norandommap=1 --randrepeat=0 --group_reporting --shm_id=1 --time_based=1 --runtime=60 --rw=randread --iodepth=256 --bs=4k
```

ali: 带 hmeta，用 sgl

写 iops：

```c
fio --name=128kB_WR_1job_QD1 '--filename=trtype=PCIe traddr=0000.07.00.0 ns=1' --ioengine=/home/ZNS_test_project/spdk/build/fio/spdk_nvme --zonemode=zbd --direct=1 --thread=1 --numjobs=1 --size=400GB --norandommap=1 --randrepeat=0 --group_reporting --fill_user_meta=1 --enable_sgl=1 --shm_id=1 --time_based=1 --runtime=60 --rw=write --iodepth=256 --bs=4k
```

读 iops：

```c
fio --name=128kB_WR_1job_QD1 '--filename=trtype=PCIe traddr=0000.07.00.0 ns=1' --ioengine=/home/ZNS_test_project/spdk/build/fio/spdk_nvme --zonemode=zbd --direct=1 --thread=1 --numjobs=1 --size=400GB --norandommap=1 --randrepeat=0 --group_reporting --fill_user_meta=1 --enable_sgl=1 --shm_id=1 --time_based=1 --runtime=60 --rw=randread --iodepth=256 --bs=4k
```

## ⭐verify_header

fio 校验的头部元数据结构（40 字节）：

```c
/*
 * A header structure associated with each checksummed data block. It is
 * followed by a checksum specific header that contains the verification
 * data.
 */
struct verify_header {
	uint16_t magic;		// 0:
	uint16_t verify_type;	// 2:
	uint32_t len;		// 4:
	uint64_t rand_seed;	// 8:
	uint64_t offset;	// 16: 除以4096就是LBA
	uint32_t time_sec;	// 24:
	uint32_t time_nsec;	// 28:
	uint16_t thread;	// 32:
	uint16_t numberio;	// 34:
	uint32_t crc32;		// 36:
};
```

magic 一般是 CA AC

例子：

```
0000000400000000: CA AC 05 00 00 00 02 00-80 A9 63 E6 CF 96 B0 2E  ..........c.....
0000000400000010: 00 00 00 00 04 00 00 00-03 00 00 00 4D 44 91 0F  ............MD..
0000000400000020: 01 00 80 1B DE D7 85 B6-0D AE 77 0F 78 41 77 0E  ..........w.xAw.
```

比如上面的 offset（也就是 LBA）是 0x4_00000000，它对应的是字节偏移，换成 block 的话，就是 0x400000，也就是 zone2 的起始地址。

## rw

ZNS，rw，read有可能会读到unmap。read应该是会遵循wp，到头了有重新开始读。

```c
  911968 3690, 4779, 1, 4096, 429496729600, 0
  911969 3690, 6191, 0, 4096, 429496729600, 0
  911970 3692, 2536378, 1, 4096, 429496733696, 0
  911971 3692, 2536889, 0, 4096, 429496729600, 0
  911972 3692, 2535716, 0, 4096, 429496733696, 0
  911973 3692, 2534163, 0, 4096, 429496737792, 0
  911974 3692, 2532540, 0, 4096, 429496741888, 0
  911975 3692, 2535356, 1, 4096, 429496737792, 0
  911976 3692, 2534704, 1, 4096, 429496741888, 0
  911977 3692, 15499, 0, 4096, 429496729600, 0
  911978 3692, 15068, 0, 4096, 429496733696, 0
  911979 3692, 14758, 0, 4096, 429496737792, 0
  911980 3692, 14387, 0, 4096, 429496741888, 0
  911981 3695, 2550625, 1, 4096, 429496745984, 0
  911982 3695, 2550084, 1, 4096, 429496750080, 0
  911983 3695, 2550995, 0, 4096, 429496729600, 0
  911984 3695, 2549543, 0, 4096, 429496733696, 0
  911985 3695, 2549222, 0, 4096, 429496737792, 0
  911986 3695, 2547709, 0, 4096, 429496741888, 0
```