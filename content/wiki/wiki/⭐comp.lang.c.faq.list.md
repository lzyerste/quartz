---
title: "comp.lang.c.faq.list"
---

https://c-faq.com/index.html

## 1. Declarations and Initializations

### 1.1 How should I decide which integer type to use?

**Q:** How should I decide which integer type to use?

---

**A:** If you might need large values (above 32,767 or below -32,767), use `long`. Otherwise, if space is very important (i.e. if there are large arrays or many structures), use `short`. ==Otherwise, use int.== If well-defined overflow characteristics are important and negative values are not, or if you want to steer clear of sign-extension problems when manipulating bits or bytes, use one of the corresponding `unsigned types`. (Beware when mixing signed and unsigned values in expressions, though; see question [3.19](https://c-faq.com/expr/preservingrules.html).)

Although `character types` (especially unsigned char) can be used as "tiny" integers, doing so is sometimes more trouble than it's worth. The compiler will have to emit extra code to convert between char and int (making the executable larger), and <mark style="background: #FF5582A6;">unexpected sign extension</mark> can be troublesome. (Using unsigned char can help; see question [12.1](https://c-faq.com/stdio/getcharc.html) for a related problem.)

A similar space/time tradeoff applies when deciding between <mark style="background: #FF5582A6;">float and double</mark>. (Many compilers still convert all float values to double during expression evaluation.) None of the above rules apply if pointers to the variable must have a particular type.

Variables referring to certain kinds of data, such as sizes of objects in memory, can and should use *predefined abstract types* such as `size_t`.

It's often incorrectly assumed that C's types are defined to have certain, exact sizes. In fact, what's guaranteed is that:

> 实际位宽是不确定的，跟机器、编译器有关。

-   type `char` can hold values up to 127;
-   types short int and `int` can hold values up to 32,767; and
-   type `long` int can hold values up to 2,147,483,647.
-   something like the relation

    ```c
    sizeof(char) <= sizeof(short) <= sizeof(int) <= sizeof(long) <= sizeof(long long)
    ```

    holds. [\[footnote\]](https://c-faq.com/decl/fn1.html)

From these values, it can be inferred that ==char is at least 8 bits, short int and int are at least 16 bits, and long int is at least 32 bits==. (The signed and unsigned versions of each type are guaranteed to have the same size.) Under ANSI C, the maximum and minimum values for a particular machine can be found in the header file `<limits.h>`; here is a summary:

| Base type | Minimum size (bits) | Minimum value (signed) | Maximum value (signed) | Maximum value (unsigned) |
| --------- | ------------------- | ---------------------- | ---------------------- | ------------------------ |
| `char`    | 8                   | -127                   | 127                    | 255                      |
| `short`   | 16                  | -32,767                | 32,767                 | 65,535                   |
| `int`     | 16                  | -32,767                | 32,767                 | 65,535                   |
| `long`    | 32                  | -2,147,483,647         | 2,147,483,647          | 4,294,967,295            |

(These values are the minimums guaranteed by the Standard. Many implementations allow larger values, but portable programs shouldn't depend on it.)

If for some reason you need to declare something with an `exact size` (usually the only good reason for doing so is when attempting to conform to some `externally-imposed storage layout`, but see question [20.5](https://c-faq.com/misc/binaryfiles.html)), be sure to `encapsulate` the choice behind an appropriate `typedef`, but see question [1.3](https://c-faq.com/decl/int16.html).

If you need to manipulate `huge` values, larger than the guaranteed range of C's built-in types, you need an arbitrary-precision (or "multiple precision") arithmetic library; see question [18.15d](https://c-faq.com/resources/mplib.html).

References: K&R1 Sec. 2.2 p. 34
K&R2 Sec. 2.2 p. 36, Sec. A4.2 pp. 195-6, Sec. B11 p. 257
ISO Sec. 5.2.4.2.1, Sec. 6.1.2.5
H&S Secs. 5.1,5.2 pp. 110-114

### 1.2 Why aren't the sizes of the standard types precisely defined?

**Q:** Why aren't the sizes of the standard types precisely defined?

---

**A:** Though C is considered relatively low-level as high-level languages go, it does take the position that the exact size of an object (i.e. in bits) is an <mark style="background: #FF5582A6;">implementation detail</mark>. (The only place where C lets you <mark style="background: #FF5582A6;">specify a size in bits is in bit-fields within structures</mark>; see questions [2.25](https://c-faq.com/struct/bitfield0.html) and [2.26](https://c-faq.com/struct/bitfields.html).) Most programs do not need precise control over these sizes; many programs that do try to achieve this control would be better off if they didn't.

==Type int is supposed to represent a machine's natural word size.== It's the right type to use for most integer variables; see question [1.1](https://c-faq.com/decl/inttypes.html) for other guidelines. See also questions [12.42](https://c-faq.com/stdio/extconform.html) and [20.5](https://c-faq.com/misc/binaryfiles.html).

### 1.3 typedef int16 and int32

**Q:** Since C doesn't define sizes exactly, I've been using typedefs like int16 and int32. I can then define these typedefs to be int, short, long, etc. depending on what machine I'm using. That should solve everything, right?

---

**A:** If you truly need control over exact type sizes, this is the right approach. There remain several things to be aware of:

-   There might not be an exact match on some machines. (There are, for example, 36-bit machines.)
-   A typedef like int16 or int32 accomplishes nothing if its intended meaning is "at least'' the specified size, because types int and long are _already_ essentially defined as being "at least 16 bits'' and "at least 32 bits,'' respectively.
-   <mark style="background: #FF5582A6;">Typedefs will never do anything about byte order problems</mark> (e.g. if you're trying to interchange data or conform to externally-imposed storage layouts).
-   You no longer have to define your own typedefs, because the Standard header `<inttypes.h>` contains a complete set.

See also questions [10.16](https://c-faq.com/cpp/ifendian.html) and [20.5](https://c-faq.com/misc/binaryfiles.html).

### 1.4 What should the 64-bit type be on a machine that can support it?

**Q:** What should the 64-bit type be on a machine that can support it?

---

**A:** The new `C99` Standard specifies type `long long` as effectively being `at least 64 bits`, and this type has been implemented by a number of compilers for some time. (Others have implemented extensions such as `__longlong`.) On the other hand, it's also appropriate to implement type short int as 16, int as 32, and long int as 64 bits, and some compilers do.

See also questions [1.3](https://c-faq.com/decl/int16.html) and [18.15d](https://c-faq.com/resources/mplib.html).

Additional links: Part of a [proposal for long long for C9X](https://c-faq.com/decl/longlong.awjd.html) by Alan Watson and Jutta Degener, succinctly outlining the arguments.

References: C9X Sec. 5.2.4.2.1, Sec. 6.1.2.5

### 1.5 char* p1, p2;

**Q:** What's wrong with this declaration?

char* p1, p2;

I get errors when I try to use p2.

---

> [!NOTE]+ \*是跟着 p1 走的，不是跟着 char 走的
> 最好一行一个声明。

**A:** Nothing is wrong with the declaration--except that it doesn't do what you probably want. The `*` in a pointer declaration is not part of the base type; it is part of the [declarator](https://c-faq.com/sx1/index.html#declarator) containing the name being declared (see question [1.21](https://c-faq.com/decl/cdecl1.html)). That is, in C, the syntax and interpretation of a declaration is not really

	type identifier ;

but rather

	base_type thing_that_gives_base_type ;

where "_thing_that_gives_base_type_''--the [declarator](https://c-faq.com/sx1/index.html#declarator)--is either a simple identifier, or a notation like \*p or a[10] or f() indicating that the variable being declared is a pointer to, array of, or function returning that _base_type_. (Of course, more complicated declarators are possible as well.)

In the declaration as written in the question, no matter what the whitespace suggests, <mark style="background: #FF5582A6;">the base type is char</mark> and the first declarator is "\*p1'', and since the declarator contains a \*, it declares p1 as a pointer-to-char. The declarator for p2, however, contains nothing but p2, so p2 is declared as a plain char, probably not what was intended. To declare two pointers within the same declaration, use

	char *p1, *p2;

Since the \* is part of the declarator, it's best to use whitespace as shown; writing char* invites mistakes and confusion.

See also question [1.13](https://c-faq.com/decl/typedefvsdefine.html).

Additional links: [Bjarne Stroustrup's opinion](http://www.research.att.com/~bs/bs_faq2.html#whitespace)

### 1.6 declare a pointer

**Q:** I'm trying to declare a pointer and allocate some space for it, but it's not working. What's wrong with this code?

```c
char *p;
*p = malloc(10);
```

---

**A:** The pointer you declared is p, not \*p. See question [4.2](https://c-faq.com/ptrs/mimic.html).

### 1.7 What's the best way to declare and define global variables and functions?

**Q:** What's the best way to declare and define global variables and functions?

---

**A:** First, though there can be many [declarations](https://c-faq.com/sx1/index.html#declarations) (and in many translation units) of a single global variable or function, there must be exactly one [definition](https://c-faq.com/sx1/index.html#definition). [\[footnote\]](https://c-faq.com/decl/unused.html) For global variables, the definition is the declaration that actually allocates space, and provides an initialization value, if any. For functions, the definition is the \`\`declaration'' that provides the function body. For example, these are declarations:

```c
extern int i;

extern int f();
```

and these are definitions:

```c
int i = 0;

int f()
{
	return 1;
}
```

(Actually, the keyword extern is optional in function declarations; see question [1.11](https://c-faq.com/decl/extern.html).)

When you need to share variables or functions across several source files, you will of course want to ensure that all definitions and declarations are consistent. ==The best arrangement is to place each definition in some relevant .c file. Then, put an external declaration in a header (.h'') file==, and #include it wherever the declaration is needed. The .c file containing the definition should also #include the same header file, so the compiler can check that the definition matches the declarations.

This rule promotes a high degree of portability: it is consistent with the requirements of the ANSI C Standard, and is also consistent with most pre-ANSI compilers and linkers. (Unix compilers and linkers typically use a \`\`common model'' which allows multiple definitions, as long as at most one is initialized; this behavior is mentioned as a \`\`common extension'' by the ANSI Standard, no [pun](https://c-faq.com/decl/common.html) intended. A few very old systems might once have required an explicit initializer to distinguish a definition from an external declaration.)

It is possible to use preprocessor tricks to arrange that a line like

```c
DEFINE(int, i);
```

need only be entered once in one header file, and turned into a definition or a declaration depending on the setting of some macro, but it's not clear if this is worth the trouble, especially since it's usually a better idea to keep global variables to a minimum.

It's not just a good idea to put global declarations in header files: if you want the compiler to be able to catch inconsistent declarations for you, you _must_ place them in header files. ==In particular, never place a prototype for an external function in a .c file==--if the definition of the function ever changes, it would be too easy to forget to change the prototype, and an incompatible prototype is worse than useless.

> [!NOTE]+ 实际写代码的时候，没太遵守，想到用哪个 function 直接 extern 了。

See also questions [1.24](https://c-faq.com/decl/extarraysize.html), [10.6](https://c-faq.com/cpp/hfiles.html), [17.2](https://c-faq.com/style/srcfiles.html), and [18.8](https://c-faq.com/resources/lintvsansi.html).

References: K&R1 Sec. 4.5 pp. 76-7
K&R2 Sec. 4.4 pp. 80-1
ISO Sec. 6.1.2.2, Sec. 6.7, Sec. 6.7.2, Sec. G.5.11
Rationale Sec. 3.1.2.2
H&S Sec. 4.8 pp. 101-104, Sec. 9.2.3 p. 267
CT&P Sec. 4.2 pp. 54-56

### 1.24 extern array size

https://c-faq.com/decl/extarraysize.html

> [!WARNING]+ 数组 external 要加`[]`，不要作为指针类型。

> [!WARNING]+ 数组作为函数参数不要声明大小
> 因为本质上会转为指针，sizeof 并不是数组大小，而是一个指针的大小，容易误导。

---

**Q:** I have an extern array which is defined in one file, and used in another:

```c
file1.c:                    file2.c:

int array[] = {1, 2, 3};    extern int array[];
```

Why doesn't sizeof work on array in file2.c?

---

**A:** An extern array of unspecified size is an incomplete type; ==you cannot apply sizeof to it==. sizeof operates at compile time, and there is no way for it to learn the size of an array which is defined in another file.

You have three options:

1.  Declare a companion variable, containing the size of the array, defined and initialized (with sizeof) in the same source file where the array is defined:

    ```c
    file1.c:                       file2.c:

    int array[] = {1, 2, 3};       extern int array[];
    int arraysz = sizeof(array);   extern int arraysz;
    ```

    (See also question [6.23](https://c-faq.com/aryptr/arraynels.html).)
2.  #define a manifest constant for the size so that it can be used consistently in the definition and the extern declaration:

    ```c
    file1.h:

    #define ARRAYSZ 3
    extern int array[ARRAYSZ];

    file1.c:                           file2.c:

    #include "file1.h"                 #include "file1.h"
    int array[ARRAYSZ];

    ```

3.  Use some sentinel value (typically 0, \-1, or NULL) in the array's last element, so that code can determine the end without an explicit size indication:

    ```c
    file1.c:                        file2.c:

    int array[] = {1, 2, 3, -1};    extern int array[];

    ```


(Obviously, the choice will depend to some extent on whether the array was already being initialized; if it was, option 2 is poor.)

See also question [6.21](https://c-faq.com/aryptr/aryparmsize.html).

References: H&S Sec. 7.5.2 p. 195

---
