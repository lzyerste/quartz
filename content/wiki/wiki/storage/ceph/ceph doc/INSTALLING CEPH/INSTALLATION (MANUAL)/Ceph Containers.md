---
title: Ceph_Containers
---

# Ceph Containers

# **CEPH CONTAINER IMAGES**

## **OFFICIAL RELEASES**

Ceph Container images are available from Docker Hub at:

```
https://hub.docker.com/r/ceph
```

### **CEPH/CEPH**

- General purpose Ceph container with all necessary daemons and dependencies installed.

[Untitled](Ceph%20Containers/Untitled%20Database%20716a66af09214dd78bbf0f9e9f41f8fb.csv)

### **CEPH/DAEMON-BASE**

- General purpose Ceph container with all necessary daemons and dependencies installed.
- Basically the same as *ceph/ceph*, but with different tags.
- Note that all of the *-devel* tags (and the *latest-master* tag) are based on unreleased and generally untested packages from [https://shaman.ceph.com](https://shaman.ceph.com/).
- note
    
    This image will soon become an alias to *ceph/ceph*.
    

[Untitled](Ceph%20Containers/Untitled%20Database%20f5c7bbc0ef484421a96e4de1e822aee9.csv)

### **CEPH/DAEMON**

- *ceph/daemon-base* plus a collection of BASH scripts that are used by ceph-nano and ceph-ansible to manage a Ceph cluster.

[Untitled](Ceph%20Containers/Untitled%20Database%2005fce4b2756242cab40345cc1025a2b7.csv)

## **DEVELOPMENT BUILDS**

We automatically build container images for development `wip-*` branches in the ceph-ci.git repositories and push them to Quay at:

```
https://quay.io/organization/ceph-ci
```

### **CEPH-CI/CEPH**

- This is analogous to the ceph/ceph image above
- TODO: remove the `wip-*` limitation and also build ceph.git branches.

[Untitled](Ceph%20Containers/Untitled%20Database%20d6706c0f7e594af593d56d54e6dd6872.csv)