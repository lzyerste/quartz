---
title: INSTALLING_CEPH
---

# INSTALLING CEPH

成熟的使用package自动安装，也可以完全自己源码编译安装。

[INSTALLATION (MANUAL)](INSTALLING%20CEPH/INSTALLATION%20(MANUAL).md)

# INSTALLING CEPH

There are several different ways to install Ceph. Choose the method that best suites your needs.

## RECOMMENDED METHODS

[`Cephadm`](https://docs.ceph.com/docs/master/cephadm/#cephadm) installs and manages a Ceph cluster using containers and systemd, with tight integration with the CLI and dashboard GUI.

- `cephadm only supports Octopus and newer releases.`
- cephadm is fully integrated with the new orchestration API and fully supports the new CLI and dashboard features to manage cluster deployment.
- cephadm requires `container support` (podman or docker) and Python 3.

[`Rook`](https://rook.io/) deploys and manages Ceph clusters running in `Kubernetes`, while also enabling management of storage resources and provisioning via Kubernetes APIs. We recommend Rook as the way to run Ceph in Kubernetes or to connect an existing Ceph storage cluster to Kubernetes.

- `Rook only supports Nautilus and newer releases of Ceph.`
- Rook is the preferred method for running Ceph on Kubernetes, or for connecting a Kubernetes cluster to an existing (external) Ceph cluster.
- Rook supports the new orchestrator API. New management features in the CLI and dashboard are fully supported.

## OTHER METHODS

[`ceph-ansible`](https://docs.ceph.com/ceph-ansible/) deploys and manages Ceph clusters using Ansible.

- ceph-ansible is widely deployed.
- ceph-ansible is not integrated with the new orchestrator APIs, introduced in Nautlius and Octopus, which means that newer management features and dashboard integration are not available.

[`ceph-deploy`](https://docs.ceph.com/docs/master/install/ceph-deploy/#ceph-deploy-index) is a tool for quickly deploying clusters.

> Important: `**ceph-deploy is no longer actively maintained**`. It is not tested on versions of Ceph newer than Nautilus. It does not support RHEL8, CentOS 8, or newer operating systems.
> 

[DeepSea](https://github.com/SUSE/DeepSea) installs Ceph using Salt.

[jaas.ai/ceph-mon](https://jaas.ai/ceph-mon) installs Ceph using Juju.

[github.com/openstack/puppet-ceph](https://github.com/openstack/puppet-ceph) installs Ceph via Puppet.

Ceph can also be [**`installed manually`**](https://docs.ceph.com/docs/master/install/index_manual/#install-manual).