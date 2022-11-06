---
title: "How to read variables optimized out in GDB"
---

#cut

http://luajit.io/post/2022/gdb-black-magics/

# Gdb Black Magics

Oct 6, 2022

![Voldemort](http://luajit.io/post/2022/gdb-black-magics/Voldemort.png)

Without questioin, gdb is a brilliant weapon to debug our program. However, the reality is complex. We need black magics to handle these cases.

## Magic1: optimized out?

Your program is normally compiled in optimized mode (e.g. `-O2`), sometimes even without debug info!

With optimized option, `gcc` would most likely use registers instead of the stack to store the function arguments and local variables. In some circumstances, gdb would said they are `<optimized out>`, then you could not inspect their values. Even worse, in the flow of the code, those registers would be overrided, so it’s impossible to check their original values anymore!

Normally, to tackle these issues, you have to recompile your program without optimized options.

But what if you could not? Think about you’re facing your client’s production environment.

You would be frustrated, isn’t it?

Then the only way is to read the assembly codes and inspect everything you need at the right places!

### Input registers

From the x86-64 System V ABI manual, these register store the function arguments:

```
%rdi first argument
%rsi second argument
%rdx third argument
%rcx fourth argument
...
```

So if the arguments are optimized out, check the registers!

Take an example, `ngx_http_core_run_phases` runs all phase handlers to handle the http request.

```
(gdb) b ngx_http_lua_content_handler
Breakpoint 2 at 0x564ab5dcf4e0: file ../ngx_lua-0.10.21/src/ngx_http_lua_contentby.c, line 158.
(gdb) c
Continuing.

Breakpoint 2, ngx_http_lua_content_handler (r=0x564ab7545900) at ../ngx_lua-0.10.21/src/ngx_http_lua_contentby.c:158
158     {
(gdb) bt
#0  ngx_http_lua_content_handler (r=0x564ab7545900) at ../ngx_lua-0.10.21/src/ngx_http_lua_contentby.c:158
#1  0x0000564ab5d178c6 in ngx_http_core_content_phase (r=0x564ab7545900, ph=<optimized out>) at src/http/ngx_http_core_module.c:1277
#2  0x0000564ab5d11bed in ngx_http_core_run_phases (r=r@entry=0x564ab7545900) at src/http/ngx_http_core_module.c:888
```

The `ph` is optimized out.

Let’s check the assembly codes:

```
(gdb) disas /s ngx_http_core_content_phase
Dump of assembler code for function ngx_http_core_content_phase:
src/http/ngx_http_core_module.c:
1270    {
   0x0000564ab5d17890 <+0>:     endbr64
   0x0000564ab5d17894 <+4>:     push   %rbp
   0x0000564ab5d17895 <+5>:     mov    %rdi,%rbp
   0x0000564ab5d17898 <+8>:     push   %rbx
   0x0000564ab5d17899 <+9>:     sub    $0x38,%rsp
   0x0000564ab5d1789d <+13>:    mov    %fs:0x28,%rax
   0x0000564ab5d178a6 <+22>:    mov    %rax,0x28(%rsp)
   0x0000564ab5d178ab <+27>:    xor    %eax,%eax

1271        size_t     root;
1272        ngx_int_t  rc;
1273        ngx_str_t  path;
1274
1275        if (r->content_handler) {
   0x0000564ab5d178ad <+29>:    mov    0x498(%rdi),%rax
   0x0000564ab5d178b4 <+36>:    test   %rax,%rax
   0x0000564ab5d178b7 <+39>:    je     0x564ab5d178f0 <ngx_http_core_content_phase+96>

1276            r->write_event_handler = ngx_http_request_empty_handler;
   0x0000564ab5d178b9 <+41>:    lea    0x20c0(%rip),%rdx        # 0x564ab5d19980 <ngx_http_request_empty_handler>
   0x0000564ab5d178c0 <+48>:    mov    %rdx,0x38(%rdi)

1277            ngx_http_finalize_request(r, r->content_handler(r));
   0x0000564ab5d178c4 <+52>:    callq  *%rax
=> 0x0000564ab5d178c6 <+54>:    mov    %rbp,%rdi
   0x0000564ab5d178c9 <+57>:    mov    %rax,%rsi
   0x0000564ab5d178cc <+60>:    callq  0x564ab5d1cf60 <ngx_http_finalize_request>
```

You could see that gdb does not save `%rsi` into the stack, so at the frame position `=> 0x0000564ab5d178c6 <+54>: mov %rbp,%rdi`, it said `ph` is unknown, but in fact, luckily, the `%rsi` has not been overrided, so just print it!

```
(gdb) p /x $rsi
$2 = 0x564ab7571a60
```

Someone would say why do you think you get the correct value?

Well, let’s break at `ngx_http_core_content_phase` directly and retrigger the breakpint again:

```
(gdb) b ngx_http_core_content_phase
Breakpoint 1 at 0x564ab5d17890: file src/http/ngx_http_core_module.c, line 1270.
(gdb) c
Continuing.

Breakpoint 1, ngx_http_core_content_phase (r=0x564ab7545900, ph=0x564ab7571a60) at src/http/ngx_http_core_module.c:1270
1270    {
(gdb) bt 3
#0  ngx_http_core_content_phase (r=0x564ab7545900, ph=0x564ab7571a60) at src/http/ngx_http_core_module.c:1270
#1  0x0000564ab5d11bed in ngx_http_core_run_phases (r=r@entry=0x564ab7545900) at src/http/ngx_http_core_module.c:888
#2  0x0000564ab5d11cc4 in ngx_http_handler (r=r@entry=0x564ab7545900) at src/http/ngx_http_core_module.c:871
(More stack frames follow...)
```

In this case, the `ph` is not optimized out, because it’s the entry of `ngx_http_core_content_phase`. We could verify we get the correct value.

As a side note, gdb sometimes behaves jumpy for optimized out variables, so if we have trouble, we may change a suitable breakpoint and we may have surprise there.

### Check the stack or history

Sometimes at some position, the register get overrided, and gdb reports a fake `<optimized out>`.

Take `ngx_http_lua_run_thread` as example:

```
Breakpoint 1, ngx_http_lua_run_thread (L=L@entry=0x7f64d244f380, r=r@entry=0x564ab7545900, ctx=ctx@entry=0x564ab7546700, nrets=nrets@entry=0) at ../ngx_lua-0.10.21/src/
ngx_http_lua_util.c:1112
1112    {
(gdb) p nrets
$1 = 0
(gdb) n
1123        ngx_log_debug2(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
(gdb)
1128        lua_atpanic(L, ngx_http_lua_atpanic);
(gdb)
1130        NGX_LUA_EXCEPTION_TRY {
(gdb)
1140            if (ctx->cur_co_ctx->thread_spawn_yielded) {
(gdb)
1155                old_pool = ngx_http_lua_pcre_malloc_init(r->pool);
(gdb) p nrets
$2 = <optimized out>
```

Check the assembly codes:

```
(gdb) disas ngx_http_lua_run_thread,+300
Dump of assembler code from 0x564ab5dcb2a0 to 0x564ab5dcb3cc:
...
   0x0000564ab5dcb2c3 <ngx_http_lua_run_thread+35>:     mov    %ecx,0x5c(%rsp)
...
   0x0000564ab5dcb352 <ngx_http_lua_run_thread+178>:    mov    0x30(%rsp),%rcx
   0x0000564ab5dcb357 <ngx_http_lua_run_thread+183>:    mov    0x18(%rcx),%rcx
...
   0x0000564ab5dcb39d <ngx_http_lua_run_thread+253>:    nopl   (%rax)
=> 0x0000564ab5dcb3a0 <ngx_http_lua_run_thread+256>:    mov    (%rsp),%rax
   0x0000564ab5dcb3a4 <ngx_http_lua_run_thread+260>:    mov    0x58(%rax),%rdi
   0x0000564ab5dcb3a8 <ngx_http_lua_run_thread+264>:    callq  0x564ab5dd1e60 <ngx_http_lua_pcre_malloc_init>
```

The `%ecx` (the fourth argument, remember?) gets overrided, but `0x5c(%rsp)` also stores the `nrets` value.

```
(gdb) p /x *(int*)(int64_t *)($rsp+0x5c)
$3 = 0x0
```

Bingo!

But wait, how about both stack and register get overrided? Well, let’s use `record` magic! We could take the time machine to find out the historical value we need.

```
Breakpoint 1, ngx_http_lua_run_thread (L=L@entry=0x7f64d244f380, r=r@entry=0x564ab7545900, ctx=ctx@entry=0x564ab7546700, nrets=nrets@entry=0) at ../ngx_lua-0.10.21/src/ngx_http_lua_util.c:1112
1112    {
(gdb) record
(gdb) n
1123        ngx_log_debug2(NGX_LOG_DEBUG_HTTP, r->connection->log, 0,
(gdb)
1128        lua_atpanic(L, ngx_http_lua_atpanic);
(gdb)
1130        NGX_LUA_EXCEPTION_TRY {
(gdb)
1140            if (ctx->cur_co_ctx->thread_spawn_yielded) {
(gdb)
1155                old_pool = ngx_http_lua_pcre_malloc_init(r->pool);
(gdb) p nrets
$4 = <optimized out>
(gdb) reverse-next
1140            if (ctx->cur_co_ctx->thread_spawn_yielded) {
(gdb) p nrets
$5 = 0
```

### Inline function

Inline function has no function frame, the function call does not really happen. gdb just simulate the call. In optimized code, there are two issues:

-   function arguments are optimized out
-   break at weird instruction

Let’s take a practical example:

```
(gdb) b lj_mem_free
Breakpoint 1 at 0x7fb7daa7178f: lj_mem_free. (40 locations)
(gdb) c
Continuing.

Breakpoint 1, lj_mem_free (osize=<optimized out>, p=<optimized out>, g=<optimized out>) at lj_tab.c:291
291         lj_mem_freevec(g, oldnode, oldhmask+1, Node);
(gdb) bt 3
#0  lj_mem_free (osize=<optimized out>, p=<optimized out>, g=<optimized out>) at lj_tab.c:291
#1  lj_tab_resize (L=0x7fb7d95e3380, t=0x7fb7d95fb800, asize=<optimized out>, hbits=<optimized out>) at lj_tab.c:291
#2  0x00007fb7daa73e9e in rehashtab (L=L@entry=0x7fb7d95e3380, t=t@entry=0x7fb7d95fb800, ek=ek@entry=0x7ffc0f6d6688) at lj_tab.c:369
(More stack frames follow...)
```

`lj_mem_free` is an inline function.

```
static LJ_AINLINE void lj_mem_free(global_State *g, void *p, size_t osize)
{
  g->gc.total -= (GCSize)osize;
  g->allocf(g->allocd, p, osize, 0);
}
```

`lj_tab_resize` is the caller.

```
/* Resize a table to fit the new array/hash part sizes. */
void lj_tab_resize(lua_State *L, GCtab *t, uint32_t asize, uint32_t hbits)
{
    ...
    g = G(L);
    lj_mem_freevec(g, oldnode, oldhmask+1, Node);
  }
}

#define lj_mem_freevec(g, p, n, t)lj_mem_free(g, (p), (n)*sizeof(t))
```

You could see all arguments are optimized out, and even the argument order is wrong.

Let’s dig in the assembly code:

```
(gdb) disas lj_tab_resize
Dump of assembler code for function lj_tab_resize:
...
   0x00007fb7daa73b29 <+617>:   mov    0xc(%rsp),%esi
   0x00007fb7daa73b2d <+621>:   mov    0x10(%rbp),%rax
=> 0x00007fb7daa73b31 <+625>:   xor    %ecx,%ecx
   0x00007fb7daa73b33 <+627>:   lea    0x1(%rsi),%edx
   0x00007fb7daa73b36 <+630>:   mov    0x8(%rax),%rdi
   0x00007fb7daa73b3a <+634>:   mov    %r15,%rsi
   0x00007fb7daa73b3d <+637>:   lea    (%rdx,%rdx,2),%rdx
   0x00007fb7daa73b41 <+641>:   shl    $0x3,%rdx
   0x00007fb7daa73b45 <+645>:   sub    %rdx,0x10(%rax)
   0x00007fb7daa73b49 <+649>:   mov    (%rax),%rax
   0x00007fb7daa73b4c <+652>:   add    $0x28,%rsp
   0x00007fb7daa73b50 <+656>:   pop    %rbx
   0x00007fb7daa73b51 <+657>:   pop    %rbp
   0x00007fb7daa73b52 <+658>:   pop    %r12
   0x00007fb7daa73b54 <+660>:   pop    %r13
   0x00007fb7daa73b56 <+662>:   pop    %r14
   0x00007fb7daa73b58 <+664>:   pop    %r15
   0x00007fb7daa73b5a <+666>:   jmpq   *%rax
...
```

It’s interesting that `lj_mem_free` also calls `g->allocf`, which points to `lj_alloc_f`, so `lj_tab_resize` actually prepare the arguments for `lj_alloc_f`, and `lj_mem_free` is embedded in the between.

It breaks at `xor %ecx,%ecx`, in this time point, no arguments are prepared, so gdb breaks at the wrong place! For example, the `void *p` is `%rsi`, but currectly not set. But from the codes, you could see that it woule be set from `r15`. So the simplest way to check `*p` is:

```
(gdb) p /x $r15
$2 = 0x7fb7d95a9620
(gdb) f 1
#1  lj_tab_resize (L=0x7fb7d95e3380, t=0x7fb7d95fb800, asize=<optimized out>, hbits=<optimized out>) at lj_tab.c:291
291         lj_mem_freevec(g, oldnode, oldhmask+1, Node);
(gdb) p oldnode
$3 = (Node *) 0x7fb7d95a9620
```

Jump to the parent frame (frame 1), we could validate it’s correct.

But sometimes, the mapping between register and argument is not so obvious. We need to step forward a bit and check the value again. `jmpq *%rax` is the instruction to call `lj_alloc_f`, so let’s break it.

```
(gdb) b *0x00007fb7daa73b5a
Breakpoint 2 at 0x7fb7daa73b5a: file lj_gc.h, line 122.
(gdb) c
Continuing.

Breakpoint 2, 0x00007fb7daa73b5a in lj_mem_free (osize=48, p=0x7fb7d95a9620, g=<optimized out>) at lj_gc.h:122
122       g->allocf(g->allocd, p, osize, 0);
```

Now you get the value of `*p`! Amazing, right? :)

## Magic2: gdb script

gdb has builtin scripting. You could use it to define variables to r/w the program symbols and do some control flows upon them. It’s really useful when you want to inspect complex context infomation.

Take a practical example, a few weeks ago, I found a [bug](https://github.com/openresty/lua-nginx-module/issues/2099) in openresty.

If you do `ngx.say` without `ngx.flush`, and use cosockets to send messages, the message buffers would be appended to the busy buffer list and do not get released until the main request finish. The busy buffer list would become bigger and bigger, and slow down the send operation dramatically.

`ngx_chain_update_chains` has a buggy loop (verified via `perf top`):

```
       │    for (cl = *busy; cl->next; cl = cl->next) { /* void */ }
  5.95 │20:   mov     %rax,%r9
  0.02 │      mov     0x8(%rax),%rax
 93.94 │      test    %rax,%rax
       │    ↑ jne     20
```

The busy buffer list is shared by the main request and cosockets created from the same main request. If the head part of the list (unflushed `ngx.say`) keeps still, the following of the list would not be cleared and get accumulated when you send more and more message via the cosocket).

How to verify I am correct? Someone may say how about adding codes to openresty?

But how to achieve the same goal in non-intrusive way?

Because mostly, we could not touch the source codes of the target process. Think about you’re facing the client’s environment

The answer is gdb script:

```
b ngx_chain_update_chains
    command 1
    set $v = *busy
    set $cnt = 0
    while ($v != 0)
        set $cnt++
        set $v=$v->next
    end
    p $cnt
    continue
end
```

Script outout:

```
Breakpoint 1, ngx_chain_update_chains (p=0x55a53413e850, free=free@entry=0x55a53413f7b8, busy=busy@entry=0x55a53413f7c0, out=out@entry=0x7f80f353fe50, tag=0x55a5326887a0 <ngx_http_lua_module>) at src/core/ngx_buf.c:187
187     {
$11 = 80399

Breakpoint 1, ngx_chain_update_chains (p=0x55a53413e850, free=free@entry=0x55a53413f7b8, busy=busy@entry=0x55a53413f7c0, out=out@entry=0x7f80f353fe50, tag=0x55a5326887a0 <ngx_http_lua_module>) at src/core/ngx_buf.c:187
187     {
$12 = 80400

Breakpoint 1, ngx_chain_update_chains (p=0x55a53413e850, free=free@entry=0x55a53413f7b8, busy=busy@entry=0x55a53413f7c0, out=out@entry=0x7f80f353fe50, tag=0x55a5326887a0 <ngx_http_lua_module>) at src/core/ngx_buf.c:187
187     {
$13 = 80401
```

With a simple script, the reason gets confirmd, and we do not touch any source codes!

## Magic3: gdb python

Besides basic scripting, if you want more magic, use python!

Python could be used to define customized `command`, `breakpoint` or `function`.

Here I just take a `function` example. Assume I need to ignore some breakpoint events if the backtrace contains some functions.

```
py
class should_skip_f(gdb.Function):
    def __init__ (self):
        super (should_skip_f, self).__init__("should_skip")

    def invoke(self):
        try:
            frame = gdb.selected_frame()
            while frame is not None:
                if "lj_BC_FUNCC" in frame.name():
                    return False
                frame = frame.older()
        except Exception as e:
            print(e)
            return True
        return True
end
py should_skip_f()

b lj_gc.c:875 if !$should_skip()
    command 1
    ...
end
```

If the breakpint event get skipped, the commands attached to the breakpint would not get executed, pefect!

## ⭐Magic4: set source path

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

## Conclusion

gdb is a powerful tool, when we encounter issues, just stay clarm and think about if we make a full use of gdb or not. Assembly codes, scripting and python extentions are your friends.