---
title: "Understanding fio norandommap and randrepeat parameters"
---

#cut

https://www.n0derunner.com/understanding-fio-norandommap-and-randrepeat-parameters/

The parameters **norandommap** and **randrepeat** significantly change the way that repeated random IO workloads will be executed, and also can meaningfully change the results of an experiment due to the way that caching works on most storage system.

Files can be found on my [github](https://github.com/garyjlittle/fio-random-eaxperiments)

I used the fio logfile to record the offsets for all combinations of **norandommap** and **randrepeat**

```
fio workload.fio --write_iolog=iolog.out
```

### Default fio behavior

By default the **randommap** is **enabled** and **randrepeat** is set to **true**. In short these defaults ensure that (unless using a timed run) all offsets in the file/device will be accessed **exactly once** AND **each subsequent run will access the file/device in the same order.**

```
[global]ioengine=libaioiodepth=100direct=1bs=1024krw=randread[rr]filename=/dev/sdb
```

I run the same workload file three times in succession, then use vimdiff to look at the outputfile. The outputlog is identical for each invocation, showing that the ordering is identical each run

```
fio randomread-default.fio --write_iolog=iolog.outfio randomread-default.fio --write_iolog=iolog-2.outfio randomread-default.fio --write_iolog=iolog-3.outvimdiff iolog*
```

![](media/fio-default-randomread-vimdiff.png)

#### We can also see that each offset was read exactly once

```
$ sort iolog.out | uniq -c | sort -n| tail
       1 /dev/sdb read 9990832128 1048576
       1 /dev/sdb read 9991880704 1048576
       1 /dev/sdb read 9992929280 1048576
       1 /dev/sdb read 999292928 1048576
       1 /dev/sdb read 9993977856 1048576
       1 /dev/sdb read 9995026432 1048576
       1 /dev/sdb read 9996075008 1048576
       1 /dev/sdb read 9997123584 1048576
       1 /dev/sdb read 9998172160 1048576
       1 /dev/sdb read 9999220736 1048576

```

#### Plotting each access on a 2×2 grid shows the entire LBA range is covered

![](media/xy.png)

## Parameter 1 : norandommap

With randommap enabled (the default) fio ensures that every block in the LBA range is read, but in a random order. You can use the **norandommap** in the fio file to change that behavior to be truly random.

```
[global]ioengine=libaioiodepth=100direct=1bs=1024krw=randreadnorandommap[rr]filename=/dev/sdb
```

In a true random sequence there would be **some blocks that are read multiple times, and others that are never read**. By enabling norandommap in the fio file we get a more truly random pattern, at the expense of not touching every offset.

**norandommap does not change the seed, so repeated executions will generate the same order.**

![](media/fio-norandommap-randomread-vimdiff.png)

This time however there will be **some offsets that were read more than once, and some that were never read**.

```
$ sort iolog.out | uniq -c | sort -n| tail
       5 /dev/sdb read 9523167232 1048576
       5 /dev/sdb read 9918480384 1048576
       5 /dev/sdb read 9923723264 1048576
       5 /dev/sdb read 9961472000 1048576
       6 /dev/sdb read 2300575744 1048576
       6 /dev/sdb read 4282384384 1048576
       6 /dev/sdb read 6184501248 1048576
       6 /dev/sdb read 6667894784 1048576
       6 /dev/sdb read 9860808704 1048576
       7 /dev/sdb read 7990149120 1048576
```

#### Plotting on 2×2 Grid we see that the LBA range is not evenly covered. But each run is identical

![](media/gnuplotx3-norandommap.png)

## Parameter 2: randrepeat (bool)

By default randrepeat is set to true. This means that each time the fio is run, the order is the same each time as we saw above using the vimdiff output. If we set randrepeat to false (0) then the order is randomized afresh each time.

```
[global]
ioengine=libaio
iodepth=100
direct=1
bs=1024k
rw=randread
randrepeat=0
[rr]
filename=/dev/sdb
```

Run the above file three times.

```
fio rr-no_randrepeat.fio --write_iolog=iolog.out
fio rr-no_randrepeat.fio --write_iolog=iolog-2.out
fio rr-no_randrepeat.fio --write_iolog=iolog-3.out
vimdiff iolog*
```

With only randrepeat fio still covers every offset in the LBA space exactly once. vimdiff shows us that the iolog files show the offsets in a different order each time.

![](media/fio-norandrepeat-randomread-vimdiff.png)

Each offset is still read only once though

```
sort iolog.out | uniq -c | sort -n| tail1 /dev/sdb read 9991880704 10485761 /dev/sdb read 9992929280 10485761 /dev/sdb read 999292928 10485761 /dev/sdb read 9993977856 10485761 /dev/sdb read 9995026432 10485761 /dev/sdb read 9996075008 10485761 /dev/sdb read 9997123584 10485761 /dev/sdb read 9998172160 10485761 /dev/sdb read 9999220736 1048576
```

The plot for randrepeat=0 shows that every offset is read

![](media/gnuplotx3-randrepeat-0.png)

### Fully random and not repeated. randrepeat and norandommap

To get fully random, and different order each time, we need to use **randrepeat=0 and norandommap together**

```
[global]
ioengine=libaio
iodepth=100
direct=1
bs=1024k
rw=randread
norandommap
randrepeat=0
[rr]
filename=/dev/sdb
```

Run the above three times.

```
fio rr-no_randommap-no_randrepeat.fio --write_iolog=iolog.out
fio rr-no_randommap-no_randrepeat.fio --write_iolog=iolog-2.out
fio rr-no_randommap-no_randrepeat.fio --write_iolog=iolog-3.out
vimdiff iolog*
```

![](media/fio-norandrepeat-norandommap-randomread-vimdiff.png)

Now, not only is each invocation distinct (different order each time) but also some blocks are read more than others too.

```
gary@master:~/fio/no-randommap_no-randrepeat$ sort iolog.out | uniq -c | sort -n| tail6 /dev/sdb read 1512046592 10485766 /dev/sdb read 2563768320 10485766 /dev/sdb read 2564816896 10485766 /dev/sdb read 2815426560 10485766 /dev/sdb read 3044016128 10485766 /dev/sdb read 3215982592 10485766 /dev/sdb read 7801405440 10485766 /dev/sdb read 9365880832 10485767 /dev/sdb read 1628438528 10485767 /dev/sdb read 753926144 1048576gary@master:~/fio/no-randommap_no-randrepeat$ sort iolog-2.out | uniq -c | sort -n| tail5 /dev/sdb read 9873391616 10485765 /dev/sdb read 9888071680 10485765 /dev/sdb read 9958326272 10485766 /dev/sdb read 1326448640 10485766 /dev/sdb read 3595567104 10485766 /dev/sdb read 4062183424 10485766 /dev/sdb read 6518996992 10485766 /dev/sdb read 7237271552 10485766 /dev/sdb read 7974420480 10485766 /dev/sdb read 800063488 1048576gary@master:~/fio/no-randommap_no-randrepeat$ sort iolog-3.out | uniq -c | sort -n| tail5 /dev/sdb read 927989760 10485765 /dev/sdb read 9284091904 10485765 /dev/sdb read 9299820544 10485765 /dev/sdb read 9958326272 10485766 /dev/sdb read 2685403136 10485766 /dev/sdb read 5478809600 10485766 /dev/sdb read 6481248256 10485766 /dev/sdb read 9324986368 10485766 /dev/sdb read 9406775296 10485767 /dev/sdb read 6511656960 1048576
```

#### The plot for norandommap and randrepeat=0 show unique, non-uniform pattern

![](media/gnuplotx3-norandommap-randrepeat-0.png)
