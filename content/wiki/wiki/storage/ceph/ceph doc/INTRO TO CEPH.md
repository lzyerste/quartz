---
title: INTRO_TO_CEPH
---

# INTRO TO CEPH

[HARDWARE RECOMMENDATIONS](INTRO%20TO%20CEPH/HARDWARE%20RECOMMENDATIONS.md)

[OS RECOMMENDATIONS](INTRO%20TO%20CEPH/OS%20RECOMMENDATIONS.md)

[GET INVOLVED IN THE CEPH COMMUNITY!](INTRO%20TO%20CEPH/GET%20INVOLVED%20IN%20THE%20CEPH%20COMMUNITY!.md)

[DOCUMENTING CEPH](INTRO%20TO%20CEPH/DOCUMENTING%20CEPH.md)

# INTRO TO CEPH

Whether you want to provide [Ceph Object Storage](https://docs.ceph.com/docs/master/glossary/#term-ceph-object-storage) and/or [Ceph Block Device](https://docs.ceph.com/docs/master/glossary/#term-ceph-block-device) services to [Cloud Platforms](https://docs.ceph.com/docs/master/glossary/#term-cloud-platforms), deploy a [Ceph File System](https://docs.ceph.com/docs/master/glossary/#term-ceph-file-system) or use Ceph for another purpose, all [Ceph Storage Cluster](https://docs.ceph.com/docs/master/glossary/#term-ceph-storage-cluster) deployments begin with setting up each [Ceph Node](https://docs.ceph.com/docs/master/glossary/#term-ceph-node), your network, and the Ceph Storage Cluster. A Ceph Storage Cluster requires at least one Ceph Monitor, Ceph Manager, and Ceph OSD (Object Storage Daemon). The Ceph Metadata Server is also required when running Ceph File System clients.

![https://docs.ceph.com/docs/master/_images/ditaa-a05b27b38a4e3f935204a86447596829bf691c9e.png](https://docs.ceph.com/docs/master/_images/ditaa-a05b27b38a4e3f935204a86447596829bf691c9e.png)

- **Monitors**: A [Ceph Monitor](https://docs.ceph.com/docs/master/glossary/#term-ceph-monitor) (`ceph-mon`) maintains maps of the cluster state, including the monitor map, manager map, the OSD map, the MDS map, and the CRUSH map. These maps are critical cluster state required for Ceph daemons to coordinate with each other. Monitors are also responsible for managing authentication between daemons and clients. At least three monitors are normally required for redundancy and high availability.
- **Managers**: A [Ceph Manager](https://docs.ceph.com/docs/master/glossary/#term-ceph-manager) daemon (`ceph-mgr`) is responsible for keeping track of runtime metrics and the current state of the Ceph cluster, including storage utilization, current performance metrics, and system load. The Ceph Manager daemons also host python-based modules to manage and expose Ceph cluster information, including a web-based [Ceph Dashboard](https://docs.ceph.com/docs/master/mgr/dashboard/#mgr-dashboard) and [REST API](https://docs.ceph.com/docs/master/mgr/restful). At least two managers are normally required for high availability.
- **Ceph OSDs**: A [Ceph OSD](https://docs.ceph.com/docs/master/glossary/#term-ceph-osd) (object storage daemon, `ceph-osd`) stores data, handles data replication, recovery, rebalancing, and provides some monitoring information to Ceph Monitors and Managers by checking other Ceph OSD Daemons for a heartbeat. At least 3 Ceph OSDs are normally required for redundancy and high availability.
- **MDSs**: A [Ceph Metadata Server](https://docs.ceph.com/docs/master/glossary/#term-ceph-metadata-server) (MDS, `ceph-mds`) stores metadata on behalf of the [Ceph File System](https://docs.ceph.com/docs/master/glossary/#term-ceph-file-system) (i.e., Ceph Block Devices and Ceph Object Storage do not use MDS). Ceph Metadata Servers allow POSIX file system users to execute basic commands (like `ls`, `find`, etc.) without placing an enormous burden on the Ceph Storage Cluster.

Ceph stores data as objects within logical storage pools. Using the [CRUSH](https://docs.ceph.com/docs/master/glossary/#term-crush) algorithm, Ceph calculates which placement group should contain the object, and further calculates which Ceph OSD Daemon should store the placement group. The CRUSH algorithm enables the Ceph Storage Cluster to scale, rebalance, and recover dynamically.