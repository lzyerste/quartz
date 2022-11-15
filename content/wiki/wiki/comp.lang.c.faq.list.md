---
title: "comp.lang.c.faq.list"
---

https://c-faq.com/index.html

## Question 1.24

---

**Q:** I have an extern array which is defined in one file, and used in another:

```c
file1.c:                    file2.c:

int array[] = {1, 2, 3};    extern int array[];
```

Why doesn't sizeof work on array in file2.c?

---

**A:** An extern array of unspecified size is an incomplete type; you cannot apply sizeof to it. sizeof operates at compile time, and there is no way for it to learn the size of an array which is defined in another file.

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

    file1.c:file2.c:

    #include "file1.h"#include "file1.h"
    int array[ARRAYSZ];

    ```

3.  Use some sentinel value (typically 0, \-1, or NULL) in the array's last element, so that code can determine the end without an explicit size indication:

    ```c
    file1.c:file2.c:

    int array[] = {1, 2, 3, -1};extern int array[];

    ```


(Obviously, the choice will depend to some extent on whether the array was already being initialized; if it was, option 2 is poor.)

See also question [6.21](https://c-faq.com/aryptr/aryparmsize.html).

References: H&S Sec. 7.5.2 p. 195

---
