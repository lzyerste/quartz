---
title: Install_Virtualization_for_Block
---

# Install Virtualization for Block

# **INSTALL VIRTUALIZATION FOR BLOCK DEVICE**

If you intend to use Ceph Block Devices and the Ceph Storage Cluster as a backend for Virtual Machines (VMs) or [Cloud Platforms](https://docs.ceph.com/docs/master/glossary/#term-cloud-platforms) the QEMU/KVM and `libvirt` packages are important for enabling VMs and cloud platforms. Examples of VMs include: QEMU/KVM, XEN, VMWare, LXC, VirtualBox, etc. Examples of Cloud Platforms include OpenStack, CloudStack, OpenNebula, etc.

![https://docs.ceph.com/docs/master/_images/ditaa-ae4116f02fb745f20ff5c4db0adef66fb7abe052.png](https://docs.ceph.com/docs/master/_images/ditaa-ae4116f02fb745f20ff5c4db0adef66fb7abe052.png)

## **INSTALL QEMU**

QEMU KVM can interact with Ceph Block Devices via `librbd`, which is an important feature for using Ceph with cloud platforms. Once you install QEMU, see [QEMU and Block Devices](https://docs.ceph.com/docs/master/rbd/qemu-rbd) for usage.

### **DEBIAN PACKAGES**

QEMU packages are incorporated into Ubuntu 12.04 Precise Pangolin and later versions. To install QEMU, execute the following:

```
sudo apt-get install qemu
```

### **RPM PACKAGES**

To install QEMU, execute the following:

1. Update your repositories.
    
    ```
    sudo yum update
    ```
    
2. Install QEMU for Ceph.
    
    ```
    sudo yum install qemu-kvm qemu-kvm-tools qemu-img
    ```
    
3. Install additional QEMU packages (optional):
    
    ```
    sudo yum install qemu-guest-agent qemu-guest-agent-win32
    ```
    

### **BUILDING QEMU**

To build QEMU from source, use the following procedure:

```
cd {your-development-directory}
git clone git://git.qemu.org/qemu.git
cd qemu
./configure --enable-rbd
make; make install
```

## **INSTALL LIBVIRT**

To use `libvirt` with Ceph, you must have a running Ceph Storage Cluster, and you must have installed and configured QEMU. See [Using libvirt with Ceph Block Device](https://docs.ceph.com/docs/master/rbd/libvirt) for usage.

### **DEBIAN PACKAGES**

`libvirt` packages are incorporated into Ubuntu 12.04 Precise Pangolin and later versions of Ubuntu. To install `libvirt` on these distributions, execute the following:

```
sudo apt-get update && sudo apt-get install libvirt-bin
```

### **RPM PACKAGES**

To use `libvirt` with a Ceph Storage Cluster, you must have a running Ceph Storage Cluster and you must also install a version of QEMU with `rbd` format support. See [Install QEMU](https://docs.ceph.com/docs/master/install/install-vm-cloud/#install-qemu) for details.

`libvirt` packages are incorporated into the recent CentOS/RHEL distributions. To install `libvirt`, execute the following:

```
sudo yum install libvirt
```

### **BUILDING `LIBVIRT`**

To build `libvirt` from source, clone the `libvirt` repository and use [AutoGen](http://www.gnu.org/software/autogen/) to generate the build. Then, execute `make` and `make install` to complete the installation. For example:

```
git clone git://libvirt.org/libvirt.git
cd libvirt
./autogen.sh
make
sudo make install
```

See [libvirt Installation](http://www.libvirt.org/compiling.html) for details.