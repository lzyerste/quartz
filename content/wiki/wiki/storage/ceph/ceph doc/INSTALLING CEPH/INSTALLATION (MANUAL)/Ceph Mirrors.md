---
title: Ceph_Mirrors
---

# Ceph Mirrors

# **CEPH MIRRORS**

For improved user experience multiple mirrors for Ceph are available around the world.

These mirrors are kindly sponsored by various companies who want to support the Ceph project.

## **LOCATIONS**

These mirrors are available on the following locations:

- **EU: Netherlands**: [http://eu.ceph.com/](http://eu.ceph.com/)
- **AU: Australia**: [http://au.ceph.com/](http://au.ceph.com/)
- **SE: Sweden**: [http://se.ceph.com/](http://se.ceph.com/)
- **DE: Germany**: [http://de.ceph.com/](http://de.ceph.com/)
- **HK: Hong Kong**: [http://hk.ceph.com/](http://hk.ceph.com/)
- **FR: France**: [http://fr.ceph.com/](http://fr.ceph.com/)
- **UK: UK**: [http://uk.ceph.com](http://uk.ceph.com/)
- **US-East: US East Coast**: [http://us-east.ceph.com/](http://us-east.ceph.com/)
- **US-Mid-West: Chicago**: [http://mirrors.gigenet.com/ceph/](http://mirrors.gigenet.com/ceph/)
- **US-West: US West Coast**: [http://us-west.ceph.com/](http://us-west.ceph.com/)
- **`CN: China**: [http://mirrors.ustc.edu.cn/ceph/](http://mirrors.ustc.edu.cn/ceph/)`

You can replace all download.ceph.com URLs with any of the mirrors, for example:

- [http://download.ceph.com/tarballs/](http://download.ceph.com/tarballs/)
- [http://download.ceph.com/debian-hammer/](http://download.ceph.com/debian-hammer/)
- [http://download.ceph.com/rpm-hammer/](http://download.ceph.com/rpm-hammer/)

Change this to:

- [http://eu.ceph.com/tarballs/](http://eu.ceph.com/tarballs/)
- [http://eu.ceph.com/debian-hammer/](http://eu.ceph.com/debian-hammer/)
- [http://eu.ceph.com/rpm-hammer/](http://eu.ceph.com/rpm-hammer/)

## **MIRRORING**

You can easily mirror Ceph yourself using a Bash script and rsync. A easy to use script can be found at [Github](https://github.com/ceph/ceph/tree/master/mirroring).

When mirroring Ceph, please keep the following guidelines in mind:

- Choose a mirror close to you
- Do not sync in a interval shorter than 3 hours
- Avoid syncing at minute 0 of the hour, use something between 0 and 59

## **BECOMING A MIRROR**

If you want to provide a public mirror for other users of Ceph you can opt to become a official mirror.

To make sure all mirrors meet the same standards some requirements have been set for all mirrors. These can be found on [Github](https://github.com/ceph/ceph/tree/master/mirroring).

If you want to apply for an official mirror, please contact the ceph-users mailinglist.