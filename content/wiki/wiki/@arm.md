---
title: _arm
---

[arm-assembly-cheatsheet.pdf](assets/arm-assembly-cheatsheet.pdf)

## 资源

[INTRODUCTION TO ARM ASSEMBLY BASICS](https://azeria-labs.com/writing-arm-assembly-part-1/)

[Code in Assembly for Apple Silicon with the AsmAttic app](https://eclecticlight.co/2021/06/07/code-in-assembly-for-apple-silicon-with-the-asmattic-app/)

[Code in ARM Assembly: Registers explained](https://eclecticlight.co/2021/06/16/code-in-arm-assembly-registers-explained/)

[Apple Developer Documentation](https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms)

## 如何打印stack trace

[Debugging ARM without a Debugger 3: Printing Stack Trace - Woongbin's blog](https://wbk.one/article/6/debugging-arm-without-a-debugger-3-printing-stack-trace)

## 使用__FILE__

[https://mcuoneclipse.com/2021/01/23/assert-__file__-path-and-other-cool-gnu-gcc-tricks-to-be-aware-of/](https://mcuoneclipse.com/2021/01/23/assert-__file__-path-and-other-cool-gnu-gcc-tricks-to-be-aware-of/)

相对路径还是绝对路径？

## 64 位除法

https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/compiler-rt/builtins/udivmoddi4.c

udivmoddi4

https://stackoverflow.com/questions/51457851/building-coreboot-undefined-reference-udivmoddi4

```c
`__udivmoddi4` is a function in libgcc which is used to implement a combined unsigned division/modulo operation for what GCC calls DI mode (doubled-up integers, 64-bit on i686)
```

## 寄存器说明

https://developer.arm.com/documentation/dui0040/d/ch06s02s01

APCS register names and usage

[Table 6.1](chrome-extension://pcmpcfapbekmbjjkdalcgopdkipoggdi/documentation/dui0040/d/Using-the-Procedure-Call-Standards/Using-the-ARM-Procedure-Call-Standard/APCS-register-names-and-usage?lang=en#Chdbehfa "Table 6.1. APCS registers") and [Table 6.2](chrome-extension://pcmpcfapbekmbjjkdalcgopdkipoggdi/documentation/dui0040/d/Using-the-Procedure-Call-Standards/Using-the-ARM-Procedure-Call-Standard/APCS-register-names-and-usage?lang=en#CACBDCAD "Table 6.2. APCS floating-point registers") summarize the names and roles of integer and floating-point registers under the APCS.

> ### Note
>
> Not all ARM systems support floating-point. Refer to [_Floating-point Support_](chrome-extension://pcmpcfapbekmbjjkdalcgopdkipoggdi/documentation/dui0041/c/BIHBJIEA) in the _ARM Software Development Toolkit Reference Guide_ for more information.

| Register | APCS name | APCS role |
| --- | --- | --- |
| r0 | a1 | argument 1/scratch register/result |
| r1 | a2 | argument 2/scratch register/result |
| r2 | a3 | argument 3/scratch register/result |
| r3 | a4 | argument 4/scratch register/result |
| r4 | v1 | register variable |
| r5 | v2 | register variable |
| r6 | v3 | register variable |
| r7 | v4 | register variable |
| r8 | v5 | register variable |
| r9 | sb/v6 | static base/register variable |
| r10 | sl/v7 | stack limit/stack chunk handle/register variable |
| r11 | fp/v8 | frame pointer/register variable |
| r12 | ip | scratch register/new -sb in inter-link-unit calls |
| r13 | sp | lower end of the current stack frame |
| r14 | lr | link register/scratch register |
| r15 | pc | program counter |

| Name | Number | APCS Role |
| --- | --- | --- |
| f0 | 0 | FP argument 1/FP result/FP scratch register |
| f1 | 1 | FP argument 2/FP scratch register |
| f2 | 2 | FP argument 3/FP scratch register |
| f3 | 3 | FP argument 4/FP scratch register |
| f4 | 4 | floating-point register variable |
| f5 | 5 | floating-point register variable |
| f6 | 6 | floating-point register variable |
| f7 | 7 | floating-point register variable |

To summarize:

a1-a4, \[f0-f3\]

These are used to pass arguments to functions. a1 is also used to return integer results, and f0 to return FP results. These registers can be corrupted by a called function.

v1-v8, \[f4-f7\]

These are used as register variables. They must be preserved by called functions.

sb, sl, fp, ip, sp, lr, pc

These have a dedicated role in some APCS variants, though certain registers may be used for other purposes even when strictly conforming to the APCS. In some variants of the APCS some of these registers are available as additional variable registers. Refer to [_A more detailed look at APCS register usage_](chrome-extension://pcmpcfapbekmbjjkdalcgopdkipoggdi/documentation/dui0040/d/Using-the-Procedure-Call-Standards/Using-the-ARM-Procedure-Call-Standard/A-more-detailed-look-at-APCS-register-usage?lang=en "6.2.3. A more detailed look at APCS register usage") for more information.

Hand coded assembly language routines that interface with C or C++ must _conform_ to the APCS. They are not required to _conform strictly_. This means that any register that is not used in its APCS role by an assembly language routine (for example, fp) can be used as a working register, provided that its value on entry is restored before returning.