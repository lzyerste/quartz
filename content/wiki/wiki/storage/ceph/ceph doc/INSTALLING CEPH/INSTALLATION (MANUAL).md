---
title: INSTALLATION__MANUAL_
---

# INSTALLATION (MANUAL)

## GET SOFTWARE

There are several methods for getting Ceph software. The easiest and most common method is to [get packages](https://docs.ceph.com/docs/master/install/get-packages) by adding repositories for use with `package management tools` such as the Advanced Package Tool (APT) or Yellowdog Updater, Modified (YUM). You may also retrieve pre-compiled packages from the Ceph repository. Finally, you can retrieve tarballs or `clone the Ceph source code repository and build Ceph yourself`.

[Get Packages](INSTALLATION%20(MANUAL)/Get%20Packages.md)

[Get Tarballs](INSTALLATION%20(MANUAL)/Get%20Tarballs.md)

[Clone Source](INSTALLATION%20(MANUAL)/Clone%20Source.md)

[Build Ceph](INSTALLATION%20(MANUAL)/Build%20Ceph.md)

[Ceph Mirrors](INSTALLATION%20(MANUAL)/Ceph%20Mirrors.md)

[Ceph Containers](INSTALLATION%20(MANUAL)/Ceph%20Containers.md)

## INSTALL SOFTWARE

Once you have the Ceph software (or added repositories), installing the software is easy. To install packages on each [Ceph Node](https://docs.ceph.com/docs/master/glossary/#term-ceph-node) in your cluster. You may use `ceph-deploy` to install Ceph for your storage cluster, or use package management tools. You should install Yum Priorities for RHEL/CentOS and other distributions that use Yum if you intend to install the Ceph Object Gateway or QEMU.

[[Install ceph-deploy](https://docs.ceph.com/docs/master/install/install-ceph-deploy/)](INSTALLATION%20(MANUAL)/Install%20ceph-deploy.md)

[[Install Ceph Storage Cluster](https://docs.ceph.com/docs/master/install/install-storage-cluster/) (package)](INSTALLATION%20(MANUAL)/Install%20Ceph%20Storage%20Cluster%20(package).md)

[[Install Virtualization for Block](https://docs.ceph.com/docs/master/install/install-vm-cloud/)](INSTALLATION%20(MANUAL)/Install%20Virtualization%20for%20Block.md)

## DEPLOY A CLUSTER MANUALLY

Once you have Ceph installed on your nodes, you can deploy a cluster manually. The manual procedure is primarily for exemplary purposes for those developing deployment scripts with Chef, Juju, Puppet, etc.

- [Manual Deployment](https://docs.ceph.com/docs/master/install/manual-deployment/)
    - [Monitor Bootstrapping](https://docs.ceph.com/docs/master/install/manual-deployment/#monitor-bootstrapping)
    - [Manager daemon configuration](https://docs.ceph.com/docs/master/install/manual-deployment/#manager-daemon-configuration)
    - [Adding OSDs](https://docs.ceph.com/docs/master/install/manual-deployment/#adding-osds)
        - [Short Form](https://docs.ceph.com/docs/master/install/manual-deployment/#short-form)
            - [bluestore](https://docs.ceph.com/docs/master/install/manual-deployment/#bluestore)
            - [filestore](https://docs.ceph.com/docs/master/install/manual-deployment/#filestore)
        - [Long Form](https://docs.ceph.com/docs/master/install/manual-deployment/#long-form)
    - [Adding MDS](https://docs.ceph.com/docs/master/install/manual-deployment/#adding-mds)
    - [Summary](https://docs.ceph.com/docs/master/install/manual-deployment/#summary)

[Manual Deployment](INSTALLATION%20(MANUAL)/Manual%20Deployment.md)

- [Manual Deployment on FreeBSD](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/)
    - [Disklayout on FreeBSD](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#disklayout-on-freebsd)
        - [Configuration](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#configuration)
    - [Monitor Bootstrapping](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#monitor-bootstrapping)
    - [Adding OSDs](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#adding-osds)
        - [Long Form](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#long-form)
    - [Adding MDS](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#adding-mds)
    - [Summary](https://docs.ceph.com/docs/master/install/manual-freebsd-deployment/#summary)

## UPGRADE SOFTWARE

As new versions of Ceph become available, you may upgrade your cluster to take advantage of new functionality. Read the upgrade documentation before you upgrade your cluster. Sometimes upgrading Ceph requires you to follow an upgrade sequence.