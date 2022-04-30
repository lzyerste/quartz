---
title: Install_Ceph_Storage_Cluster__package_
---

# Install Ceph Storage Cluster (package)

# **INSTALL CEPH STORAGE CLUSTER**

This guide describes installing Ceph packages manually. This procedure is only for users who are not installing with a deployment tool such as `ceph-deploy`, `chef`, `juju`, etc.

Tip

You can also use `ceph-deploy` to install Ceph packages, which may be more convenient since you can install `ceph` on multiple hosts with a single command.

## **INSTALLING WITH APT**

Once you have added either release or development packages to APT, you should update APT’s database and install Ceph:

```
sudo apt-get update && sudo apt-get install ceph ceph-mds
```

## **INSTALLING WITH RPM**

To install Ceph with RPMs, execute the following steps:

1. Install `yum-plugin-priorities`.
    
    ```
    sudo yum install yum-plugin-priorities
    ```
    
2. Ensure `/etc/yum/pluginconf.d/priorities.conf` exists.
3. Ensure `priorities.conf` enables the plugin.
    
    ```
    [main]
    enabled = 1
    ```
    
4. Ensure your YUM `ceph.repo` entry includes `priority=2`. See [Get Packages](https://docs.ceph.com/docs/master/install/get-packages) for details:
    
    ```
    [ceph]
    name=Ceph packages for $basearch
    baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/$basearch
    enabled=1
    priority=2
    gpgcheck=1
    gpgkey=https://download.ceph.com/keys/release.asc
    ​
    [ceph-noarch]
    name=Ceph noarch packages
    baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/noarch
    enabled=1
    priority=2
    gpgcheck=1
    gpgkey=https://download.ceph.com/keys/release.asc
    ​
    [ceph-source]
    name=Ceph source packages
    baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/SRPMS
    enabled=0
    priority=2
    gpgcheck=1
    gpgkey=https://download.ceph.com/keys/release.asc
    ```
    
5. Install pre-requisite packages:
    
    ```
    sudo yum install snappy leveldb gdisk python-argparse gperftools-libs
    ```
    

Once you have added either release or development packages, or added a `ceph.repo` file to `/etc/yum.repos.d`, you can install Ceph packages.

```
sudo yum install ceph
```

## **INSTALLING A BUILD**

If you build Ceph from source code, you may install Ceph in user space by executing the following:

```
sudo make install
```

If you install Ceph locally, `make` will place the executables in `usr/local/bin`. You may add the Ceph configuration file to the `usr/local/bin` directory to run Ceph from a single directory.