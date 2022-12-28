
#gdb

[gdb.pdf](assets/gdb.pdf)

- [cdump](../../innogrit/zns/cdump.md)

https://sourceware.org/gdb/onlinedocs/gdb/index.html

https://www.cs.umd.edu/~srhuang/teaching/cmsc212/gdb-tutorial-handout.pdf

gdb 里回车键默认会执行上一次的命令。

## ⭐脚本配置文件

https://www.cse.unsw.edu.au/~learn/debugging/modules/gdb_init_file/

### gdb1.batch

gdb1.batch: 这个是给自己的测试机使用的

```c
set pagination off
set confirm off
set print pretty on
set trace-commands on
set logging file gdb1.log
set logging on
target remote hjb-pi.local:2331

define conn
tar rem hjb-pi.local:2331
end
```

使用方式：

```c
cd ~/git ; arm-none-eabi-gdb -x gdb1.batch -q tacoma-bin/main1
```

之后断连的话，输入自定义命令`conn`就可以连接了。

---

### tmp1.batch

tmp1.batch: 这个是用来连接到其他测试机器，临时的。把 log 记录到文件中。把调试过程中的所有命令和 gdb 输出写到文件 tmp1.log

```c
set pagination off
set confirm off
set print pretty on
set trace-commands on
set logging file tmp1.log
set logging on
target remote 10.80.0.132:2331

define conn
tar rem 10.80.0.132:2331
end
```

tmp1.log:

```c
+bt
#0  panic (str=str@entry=0x200b06a3 "from_assert_panic") at /git/alibaba_zns4_vzone/rtos/src/rtos.c:1062
#1  0x0000276c in assert_panic (file=file@entry=0x200b0851 "misc.c", line=line@entry=1668) at /git/alibaba_zns4_vzone/rtos/src/rtos.c:1192
#2  0x000031ce in cpu_clk_init (idx=825241904) at /git/alibaba_zns4_vzone/rtos/armv7r/misc.c:1668
#3  0x201603de in misc_init () at /git/alibaba_zns4_vzone/rtos/armv7r/misc.c:2729
#4  0x20160078 in fw_init () at /git/alibaba_zns4_vzone/main.c:116
#5  main () at /git/alibaba_zns4_vzone/main.c:200
```

---

```bash
$ cat djiang.gdb.1
set pagination off
set logging file ~/gdb.21.r5.log
set logging on
set trace-commands on
show logging
flush
tar rem:2331
mon mww 0xc0204000 0xf
```

使用方式：

```bash
gdb-multiarch --batch -x djiang.gdb.3 main3
```


## 启动

方式一：直接启动。

例子（带参数）：

```sh
sudo gdb --args ./build/zns/zns_cli write --zone-id=5 --bs=16k --size=16k --verbose
```

如果不带参数，直接`gdb <prog>`即可。

---

方式二：先启动 gdb，再加载程序。

```sh
(gdb) file prog1.x
```

## run

通过命令`run`开始执行程序。可以简写为`r`。

```sh
(gdb) run
```

如果程序没有错误，那么一直执行完毕。如果程序有 bug，那么出错时会打印些信息。比如：

```sh
Program received signal SIGSEGV, Segmentation fault.
0x0000000000400524 in sum array region (arr=0x7fffc902a270, r1=2, c1=5, r2=4, c2=6) at sum-array-region2.c:12
```

## breakpoints

通过命令`break`设置断点。可以简写为`b`。

==方式一：文件名+行号。==

```sh
(gdb) break file1.c:6
```

==方式二：函数名。==

```sh
(gdb) break my_func
```

==方式三：内存地址==

```sh
(gdb) b *0x400448
```

---

查看所有断点设置信息：

```sh
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x0000000000013779 in ig_hex_dump at zns_cli.c:265
```

删除断点：

```sh
(gdb) delete 1
```

默认 delete（不带参数）会删除所有断点。

https://stackoverflow.com/questions/59599200/clear-all-breakpoints-in-gdb

---

带条件的断点：

```sh
(gdb) break file1.c:6 if i >= ARRAYSIZE
```

## layout，显示代码窗口

```c
layout src
layout asm
layout split

Ctrl+X,A 退出
```

layout src, layout regs:

![](assets/Pasted%20image%2020221228150531.png)

layout split:

![](assets/Pasted%20image%2020221228150558.png)

`tui layout name`

`layout name`

Changes which TUI windows are displayed. The name parameter controls which layout is shown. It can be either one of the built-in layout names, or the name of a layout defined by the user using `tui new-layout`.

The built-in layouts are as follows:

`next`

Display the next layout.

`prev`

Display the previous layout.

`src`

Display the source and command windows.

`asm`

Display the assembly and command windows.

`split`

Display the source, assembly, and command windows.

`regs`

When in `src` layout display the register, source, and command windows. When in `asm` or `split` layout display the register, assembler, and command windows.

## continue

程序执行到断点后，会停顿。如果想要继续执行，使用命令`continue`。简写为`c`。

它会一直执行，直到遇到下一个断点。

```sh
(gdb) continue
```

## next

只执行一条语句，函数调用会直接执行完毕，不会进入函数。简写为`n`。

## step

单步执行，会进入调用函数。简写为`s`。

这里的单步是一行代码，如果要单步一条汇编指令，可以使用`si`，也就是 stepi。

https://stackoverflow.com/questions/2420813/using-gdb-to-single-step-assembly-code-outside-specified-executable-causes-error

## print

打印信息。简写为`p`。

```sh
# 打印变量值
(gdb) print my_var
# 16进制打印
(gdb) print/x my_var
```

支持的 format：

```sh
o - octal
x - hexadecimal
u - unsigned decimal
t - binary
f - floating point
a - address
c - char
s - string
```

打印指针：

```sh
# 打印指针的值
(gdb) print/x my_pointer
# 打印指针指向的对象
(gdb) print *my_pointer
```

打印数组：

```sh
(gdb) p *array[index]@len

(gdb) p/x *bytes@16
$8 = {0xb9, 0xd8, 0x49, 0x47, 0x0, 0xa0, 0x0, 0x6, 0x2, 0xa8, 0x49, 0x47, 0x0, 0xa0, 0x0, 0x7}
```

漂亮打印设置（要不然结构体成员都堆到一起去了）：

```sh
set print pretty on
```

例子：

```sh
(gdb) p/x *req
$13 = {buf = 0x2000003bf000, bufsize = 0x4000, bz = 0x4, real_bz = 0x4, lba = 0xa00008, dif_ctx = {block_size = 0x1000, md_size = 0x8, md_interleave = 0x0, guard_interval = 0x0, dif_type = 0x1,
    dif_flags = 0x1c000000, init_ref_tag = 0xa00008, app_tag = 0x4947, apptag_mask = 0xffff, data_offset = 0x0, ref_tag_offset = 0x0, last_guard = 0x0, guard_seed = 0x0, remapped_init_ref_tag = 0x0},
  md_buf = 0x2000003be000, io_flags = 0x1c000000, zone_seed = 0x75ce92465dd74136, zns = 0x5555558dc4a0, cmd = 0x7fffffffe270, fill_config = {qword = 0x0, {fill_pattern = 0x0, pad = {0x0, 0x0, 0x0, 0x0,
        0x0, 0x0}, flag = 0x0}}}
(gdb) set print pretty on
(gdb) p/x *req
$14 = {
  buf = 0x2000003bf000,
  bufsize = 0x4000,
  bz = 0x4,
  real_bz = 0x4,
  lba = 0xa00008,
  dif_ctx = {
    block_size = 0x1000,
    md_size = 0x8,
    md_interleave = 0x0,
    guard_interval = 0x0,
    dif_type = 0x1,
    dif_flags = 0x1c000000,
    init_ref_tag = 0xa00008,
    app_tag = 0x4947,
    apptag_mask = 0xffff,
    data_offset = 0x0,
    ref_tag_offset = 0x0,
    last_guard = 0x0,
    guard_seed = 0x0,
    remapped_init_ref_tag = 0x0
  },
  md_buf = 0x2000003be000,
  io_flags = 0x1c000000,
  zone_seed = 0x75ce92465dd74136,
  zns = 0x5555558dc4a0,
  cmd = 0x7fffffffe270,
  fill_config = {
    qword = 0x0,
    {
      fill_pattern = 0x0,
      pad = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
      flag = 0x0
    }
  }
}
```

## 打印寄存器

```
i r
```

也就是`info registers`缩写。

## watch

跟踪变量被修改。

https://www.cse.unsw.edu.au/~learn/debugging/modules/gdb_watch_display/

https://sourceware.org/gdb/download/onlinedocs/gdb/Set-Watchpoints.html

```sh
(gdb) watch <variable_name>

(gdb) info breakpoints

(gdb) disable <watchpoint_number>
```

观察内存地址对应的内容：

```sh
(gdb) watch *0x10793ad0
```

---

https://stackoverflow.com/questions/3470704/setting-gdb-hardware-watchpoint-how-to-set-software-watchpoint

2022-11-30 14:23:37，有时候会报 too many hardware breakpoints/watchpoints

```c
Could not insert hardware breakpoints: You may have requested too many hardware breakpoints/watchpoints.
```

可以禁用 hw watchpoint，只使用 sw watchpoint，但速度可能会非常慢，几百倍？

```c
set can-use-hw-watchpoints 0
```

## backtrace

打印程序崩溃时的调用栈。简写为`bt`。

https://sourceware.org/gdb/onlinedocs/gdb/Backtrace.html

---

## stack frame

切换 stack frame：https://sourceware.org/gdb/onlinedocs/gdb/Selection.html

```sh
frame [ frame-selection-spec ]
f [ frame-selection-spec ]
```

比如：

```sh
(gdb) frame 3
(gdb) frame level 3
```

> [!cite]+
> ```sh
> up n
> ```
>
> Move n frames up the stack; n defaults to 1. For positive numbers n, this advances toward the outermost frame, to higher frame numbers, to frames that have existed longer.
>
> ```sh
> down n
> ```
>
> Move n frames down the stack; n defaults to 1. For positive numbers n, this advances toward the innermost frame, to lower frame numbers, to frames that were created more recently. You may abbreviate `down` as `do`.

## until

https://www.irya.unam.mx/computo/sites/manuales/fce12/debugger/cl/commandref/gdb_mode/cmd_until.htm

- 运行到某一行。
- 缩写是`u`

```c
until [line]
until [file:line]
```

## 反汇编

objdump 工具。

```sh
arm-none-eabi-objdump -dS main1.elf > main1.asm
```

```assembly
0000d324 <memcpy>:
    d324:	1e43      	subs	r3, r0, #1
    d326:	440a      	add	r2, r1
    d328:	b510      	push	{r4, lr}
    d32a:	4291      	cmp	r1, r2
    d32c:	d100      	bne.n	d330 <memcpy+0xc>
    d32e:	bd10      	pop	{r4, pc}
    d330:	f811 4b01 	ldrb.w	r4, [r1], #1
    d334:	f803 4f01 	strb.w	r4, [r3, #1]!
    d338:	e7f7      	b.n	d32a <memcpy+0x6>
```

`-T`可以加上符号表，包括文件里的 static 变量。

## 修改内存/打印内存

打印内存：

https://sourceware.org/gdb/current/onlinedocs/gdb/Memory.html

```c
x/nfu addr
x addr
x
Use the x command to examine memory.
```

例子：

```c
(gdb) x/16 0xa1fa0
0xa1fa0 <btn_wd_uptd0>: 0x7f140bc0      0x00000000     0x80141fb8      0x000a0bc0
0xa1fb0 <btn_wd_uptd0+16>:      0xc0010160    0x00000000       0x00000000      0x00000000
0xa1fc0 <btn_wd_uptd1>: 0x7f140dc0      0x00000000     0x80141fd8      0x000a0dc0
0xa1fd0 <btn_wd_uptd1+16>:      0xc00101b4    0x00000000       0x00000000      0x00000000
```

---

修改内存或变量：

https://sourceware.org/gdb/current/onlinedocs/gdb/Assignment.html#Assignment

```c
(gdb) set i = 10
(gdb) p i
$1 = 10

(gdb) p &i
$2 = (int *) 0xbfbb0000
(gdb) set *((int *) 0xbfbb0000) = 20
(gdb) p i
$3 = 20
```

## dump 内存到文件

例子：

```
dump memory vcd_raw.bin vcd_buffer (u32)vcd_buffer+sizeof(*vcd_buffer)
```

dump memory + 文件名 + 内存起始地址 + 内存结束地址

## 更改寄存器内容？

使用 set 命令。参考后面的案例。

## 直接执行函数

```sh
(gdb) p nvmet_get_req()
$2 = (req_t *) 0x87498 <_reqs>
```

> [!cite]+
> given this prototyped C or C++ function with float parameters:
>
> ```
> float multiply (float v1, float v2) { return v1 * v2; }
> ```
>
> these calls are equivalent:
>
> ```
> (gdb) p (float) multiply (2.0f, 3.0f)
> (gdb) p ((float (*) (float, float)) multiply) (2.0f, 3.0f)
> ```

## 退出不要确认

https://stackoverflow.com/questions/4355978/get-rid-of-quit-anyway-prompt-using-gdb-just-kill-the-process-and-quit

```c
set confirm off
```

## 源代码路径不匹配

Mostly it’s necessary to map the debug steps to the lines of source codes.

In fact, normally, your binary, if not stripped, would contains DWARF sections, which contains the path of the source codes. So all you need to do is to download the matching source codes and specify a correct perfix.

Determine the `DW_AT_comp_dir` from the DWARF of the binary first:

```
objdump -Wi /usr/local/openresty-debug/nginx/sbin/nginx |grep DW_AT_comp_dir -m 1
    <15>   DW_AT_comp_dir    : (indirect string, offset: 0x1b20): /tmp/tmp.FthtgW2A3R/openresty-1.21.4.1/build/nginx-1.21.4
```

Substitute the prefix with the path of the corresponding source codes:

`~/.gdbinit`

```
set substitute-path /tmp/tmp.FthtgW2A3R /path/to/source
```

## tips

### 载入多个 elf

https://stackoverflow.com/questions/20380204/how-to-load-multiple-symbol-files-in-gdb

比如载入 rom 和 loader 的 elf。

Additional symbols can be loaded to the `gdb` debug session with:

```c
add-symbol-file filename address
```

Parameter `address` is the address for `.text` section. This address can be retrieved with:

```c
readelf -WS path/to/file.elf | grep .text | awk '{ print "0x"$5 }'
```

## 案例

### sdpk 程序单步执行

### spdk crash core 分析

生成 core dump: https://stackoverflow.com/questions/17965/how-to-generate-a-core-dump-in-linux-on-a-segmentation-fault

```sh
# gdb ./build/zns/zns_iocheck

(gdb) core core
Core was generated by `/home/root/workspace/spdk_zns_iocheck_Malloc/build/zns/zns_iocheck -m [15] -r M'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  spdk_accel_task_complete (accel_task=accel_task@entry=0x55a777da3288, status=status@entry=0) at accel_engine.c:130
130                     batch->count--;
(gdb) bt
#0  spdk_accel_task_complete (accel_task=accel_task@entry=0x55a777da3288, status=status@entry=0) at accel_engine.c:130
#1  0x000055a77739daa2 in spdk_accel_submit_copy (ch=ch@entry=0x55a777d7f850, dst=<optimized out>, src=src@entry=0x200035f45000, nbytes=<optimized out>, cb_fn=cb_fn@entry=0x55a777322600 <malloc_done>,
    cb_arg=cb_arg@entry=0x200009246468) at accel_engine.c:209
#2  0x000055a7773227f8 in bdev_malloc_readv (mdisk=<optimized out>, offset=<optimized out>, len=<optimized out>, iovcnt=<optimized out>, iov=<optimized out>, task=0x200009246468, ch=0x55a777d7f850)
    at bdev_malloc.c:159
#3  _bdev_malloc_submit_request (bdev_io=<optimized out>, ch=0x55a777d7f850) at bdev_malloc.c:251
#4  bdev_malloc_submit_request (ch=0x55a777d7f850, bdev_io=<optimized out>) at bdev_malloc.c:319
#5  0x000055a777396dee in bdev_io_do_submit (bdev_io=<optimized out>, bdev_ch=<optimized out>) at bdev.c:1901
#6  _bdev_io_submit (ctx=<optimized out>) at bdev.c:2398
#7  bdev_io_submit (bdev_io=0x200009246100) at bdev.c:2515
#8  0x000055a777397bbe in bdev_read_blocks_with_md (desc=0x55a777c1c7f0, ch=0x55a777dc15c0, buf=0x200011a7a540, md_buf=md_buf@entry=0x0, offset_blocks=130373, num_blocks=1,
    cb=0x55a7773211d0 <ig_do_single_io_read_complete>, cb_arg=0x55a777dc9cb8) at bdev.c:3664
#9  0x000055a777397bfb in spdk_bdev_read_blocks (desc=<optimized out>, ch=<optimized out>, buf=<optimized out>, offset_blocks=<optimized out>, num_blocks=<optimized out>,
    cb=cb@entry=0x55a7773211d0 <ig_do_single_io_read_complete>, cb_arg=0x55a777dc9cb8) at bdev.c:3688
#10 0x000055a77731f20d in ig_do_single_io_read (ctx=0x55a777dc9cb8, task=0x55a777dbad00) at io_engine.c:521
#11 ig_io_issue_read (ctx=0x55a777dc9cb8, task=0x55a777dbad00) at io_engine.c:294
#12 ig_io_issue (ctx=0x55a777dc9cb8, task=0x55a777dbad00) at io_engine.c:201
#13 ig_do_single_io (task=0x55a777dbad00, ctx=0x55a777dc9cb8) at io_engine.c:105
#14 0x000055a777321413 in ig_do_single_io_read_complete (bdev_io=<optimized out>, success=<optimized out>, cb_arg=0x55a777dc9cb8) at io_engine.c:599
#15 0x000055a7773a6686 in msg_queue_run_batch (max_msgs=<optimized out>, thread=0x55a777dbe8b0) at thread.c:544
#16 thread_poll (thread=thread@entry=0x55a777dbe8b0, max_msgs=max_msgs@entry=0, now=now@entry=7684914257947836) at thread.c:623
#17 0x000055a7773a7300 in spdk_thread_poll (thread=thread@entry=0x55a777dbe8b0, max_msgs=max_msgs@entry=0, now=7684914257947836) at thread.c:733
#18 0x000055a7773a2919 in _reactor_run (reactor=0x55a777d75cc0) at reactor.c:906
#19 reactor_run (arg=0x55a777d75cc0) at reactor.c:944
#20 0x000055a7773a2c97 in spdk_reactors_start () at reactor.c:1052
#21 0x000055a77739fbcc in spdk_app_start (opts_user=<optimized out>, start_fn=0x55a77731ca80 <zns_iocheck_start>, arg1=0x0) at app.c:577
#22 0x000055a77731818c in main (argc=5, argv=0x7fffd56acf58) at zns_iocheck.c:1024
```

### 固件现场恢复

固件 crash 打印的信息（ARM32）：

```sh
cpu1: 00040F5F A rtos/src/rtos.c +504 exception_handler() - ===> Kernel CRASH!!!
cpu1: Exception: data abort 001855BE
cpu1: R[0]: 00040F5F R[1]: 20055440
cpu1: R[2]: 000000D9 R[3]: 00089698
cpu1: R[4]: 20055440 R[5]: 20055440
cpu1: R[6]: 0008ACD0 R[7]: 00192930
cpu1: R[8]: 00000001 R[9]: 000000BD
cpu1: R[10]: 000AD95C R[11]: 00000000
cpu1: R[12]: 00000001 R[13]: 000AED38
cpu1: R[14] 0018888F CPSR: 00000197
```

data abort 指向的是$PC=0x001855BE；

R13 对应的是 SP 寄存器；

R14 对应的是 LR 寄存器（function return address）。

恢复现场：

```sh
(gdb) set $sp=0x000AED38
(gdb) set $lr=0x0018888F
(gdb) set $pc=0x001855BE
(gdb) bt
#0  0x001855be in nvmet_get_req () at /home/lzy/tacoma-clean/nvme/src/nvme_ctrl/nvme_core.c:200
#1  0x0018888e in nvmet_rx_handle_cmd (sqid=494414, cmd=0x1 <_start>, nvm_cmd_id=2, rx_cmd=0x2f <do_exception+6>, fun_id=40 '(') at /home/lzy/tacoma-clean/nvme/src/nvme_ctrl/nvme_io_cmd.c:777
#2  0x2b2929a0 in ?? ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
```

## 资源

- [gdbgui](gdbgui.md)
* cgdb？关注
* [gdb调试的基本使用](https://blog.csdn.net/zdy0_2004/article/details/80102076)
* [gdb-tutorial-handout.pdf](https://www.cs.umd.edu/~srhuang/teaching/cmsc212/gdb-tutorial-handout.pdf)
* [GDB Tutorial: Essential GDB Tips to Learn Debugging](https://www.techbeamers.com/how-to-use-gdb-top-debugging-tips/)
* [GDB Command Reference](http://visualgdb.com/gdbreference/commands/)
- [[How to read variables optimized out in GDB]]

---

> [!faq]+ Missing separate debuginfos
>
> [Why gdb is showing message "Missing separate debuginfos"? - Red Hat Customer Portal](https://access.redhat.com/solutions/1506273)
>
> 照提示安装即可。
