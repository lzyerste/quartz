---
title: OS_RECOMMENDATIONS_72e2a23432904fd99e724a9c763e08fa
---

# OS RECOMMENDATIONS

# OS RECOMMENDATIONS

## CEPH DEPENDENCIES

As a general rule, we recommend deploying Ceph on newer releases of Linux. We also recommend deploying on releases with long-term support.

### LINUX KERNEL

- **Ceph Kernel Client**
    
    If you are using the kernel client to map RBD block devices or mount CephFS, the general advice is to use a “stable” or “longterm maintenance” kernel series provided by either [http://kernel.org](http://kernel.org/) or your Linux distribution on any client hosts.
    
    For `RBD`, if you choose to *track* long-term kernels, we currently recommend `4.x-based` “longterm maintenance” kernel series:
    
    - 4.19.z
    - 4.14.z
    
    For CephFS, see the section about [Mounting CephFS using Kernel Driver](https://docs.ceph.com/docs/master/cephfs/mount-using-kernel-driver#which-kernel-version) for kernel version guidance.
    
    Older kernel client versions may not support your [CRUSH tunables](https://docs.ceph.com/docs/master/rados/operations/crush-map#tunables) profile or other newer features of the Ceph cluster, requiring the storage cluster to be configured with those features disabled.
    

## PLATFORMS

The charts below show how Ceph’s requirements map onto various Linux platforms. Generally speaking, there is very little dependence on specific distributions aside from the kernel and system initialization package (i.e., sysvinit, upstart, systemd).

### NAUTILUS (14.2.Z)

[Untitled](OS%20RECOMMENDATIONS%2072e2a23432904fd99e724a9c763e08fa/Untitled%20Database%203fef79eae8ab403889f0cacb53c4b95d.csv)

### LUMINOUS (12.2.Z)

[Untitled](OS%20RECOMMENDATIONS%2072e2a23432904fd99e724a9c763e08fa/Untitled%20Database%20bebb0c6f15864190a132907683a05879.csv)

### NOTES

- **1**: The default kernel has an older version of `btrfs` that we do not recommend for `ceph-osd` storage nodes. We recommend using `bluestore` starting from Mimic, and `XFS` for previous releases with `filestore`.
- **2**: The default kernel has an old Ceph client that we do not recommend for kernel client (kernel RBD or the Ceph file system). Upgrade to a recommended kernel.
- **3**: The default kernel regularly fails in QA when the `btrfs` file system is used. We recommend using `bluestore` starting from Mimic, and `XFS` for previous releases with `filestore`.

### TESTING

- **B**: We build release packages for this platform. For some of these platforms, we may also continuously build all ceph branches and exercise basic unit tests.
- **I**: We do basic installation and functionality tests of releases on this platform.
- **C**: We run a comprehensive functional, regression, and stress test suite on this platform on a continuous basis. This includes development branches, pre-release, and released code.