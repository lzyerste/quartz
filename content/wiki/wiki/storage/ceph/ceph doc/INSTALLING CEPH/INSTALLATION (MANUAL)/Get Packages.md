---
title: Get_Packages
---

# Get Packages

# **GET PACKAGES**

To install Ceph and other enabling software, you need to retrieve packages from the Ceph repository.

There are three ways to get packages:

- **Cephadm:** Cephadm can configure your Ceph repositories for you based on a release name or a specific Ceph version. Each [Ceph Node](https://docs.ceph.com/docs/master/glossary/#term-ceph-node) in your cluster must have internet access.
- **Configure Repositories Manually:** You can manually configure your package management tool to retrieve Ceph packages and all enabling software. Each [Ceph Node](https://docs.ceph.com/docs/master/glossary/#term-ceph-node) in your cluster must have internet access.
- **Download Packages Manually:** Downloading packages manually is a convenient way to install Ceph if your environment does not allow a [Ceph Node](https://docs.ceph.com/docs/master/glossary/#term-ceph-node) to access the internet.

## **INSTALL PACKAGES WITH CEPHADM**

1. Download the cephadm script:
    
    ```bash
    curl --silent --remote-name --location https://github.com/ceph/ceph/raw/octopus/src/cephadm/cephadm
    chmod +x cephadm
    ```
    
2. Configure the Ceph repository based on the release name:
    
    ```
    ./cephadm add-repo --release nautilus
    ```
    
    For Octopus (15.2.0) and later releases, you can also specify a specific version:
    
    ```
    ./cephadm add-repo --version 15.2.1
    ```
    
    For development packages, you can specify a specific branch name:
    
    ```
    ./cephadm add-repo --dev my-branch
    ```
    
3. Install the appropriate packages. You can install them using your package management tool (e.g., APT, Yum) directly, or you can also use the cephadm wrapper. For example:
    
    ```
    ./cephadm install ceph-common
    ```
    

## **CONFIGURE REPOSITORIES MANUALLY**

All Ceph deployments require Ceph packages (except for development). You should also add keys and recommended packages.

- **Keys: (Recommended)** Whether you add repositories or download packages manually, you should download keys to verify the packages. If you do not get the keys, you may encounter security warnings.
- **Ceph: (Required)** All Ceph deployments require Ceph release packages, except for deployments that use development packages (development, QA, and bleeding edge deployments only).
- **Ceph Development: (Optional)** If you are developing for Ceph, testing Ceph development builds, or if you want features from the bleeding edge of Ceph development, you may get Ceph development packages.

### **ADD KEYS**

Add a key to your system’s list of trusted keys to avoid a security warning. For major releases (e.g., `luminous`, `mimic`, `nautilus`) and development releases (`release-name-rc1`, `release-name-rc2`), use the `release.asc` key.

### **APT**

To install the `release.asc` key, execute the following:

```
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
```

### **RPM**

To install the `release.asc` key, execute the following:

```
sudo rpm --import 'https://download.ceph.com/keys/release.asc'
```

### **CEPH RELEASE PACKAGES**

Release repositories use the `release.asc` key to verify packages. To install Ceph packages with the Advanced Package Tool (APT) or Yellowdog Updater, Modified (YUM), you must add Ceph repositories.

You may find releases for Debian/Ubuntu (installed with APT) at:

```
https://download.ceph.com/debian-{release-name}
```

You may find releases for CentOS/RHEL and others (installed with YUM) at:

```
https://download.ceph.com/rpm-{release-name}

```

For Octopus and later releases, you can also configure a repository for a specific version `x.y.z`. For Debian/Ubuntu packages:

```
https://download.ceph.com/debian-{version}
```

For RPMs:

```
https://download.ceph.com/rpm-{version}
```

The major releases of Ceph are summarized at: [Ceph Releases (general)](https://docs.ceph.com/docs/master/releases/general/#ceph-releases-general)

Tip

For non-US users: There might be a mirror close to you where to download Ceph from. For more information see: [Ceph Mirrors](https://docs.ceph.com/docs/master/install/mirrors).

### **DEBIAN PACKAGES**

Add a Ceph package repository to your system’s list of APT sources. For newer versions of Debian/Ubuntu, call `lsb_release -sc` on the command line to get the short codename, and replace `{codename}` in the following command.

```
sudo apt-add-repository 'deb https://download.ceph.com/debian-luminous/ {codename} main'
```

For early Linux distributions, you may execute the following command:

```
echo deb https://download.ceph.com/debian-luminous/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
```

For earlier Ceph releases, replace `{release-name}` with the name with the name of the Ceph release. You may call `lsb_release -sc` on the command line to get the short codename, and replace `{codename}` in the following command.

```
sudo apt-add-repository 'deb https://download.ceph.com/debian-{release-name}/ {codename} main'
```

For older Linux distributions, replace `{release-name}` with the name of the release:

```
echo deb https://download.ceph.com/debian-{release-name}/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
```

For development release packages, add our package repository to your system’s list of APT sources. See [the testing Debian repository](https://download.ceph.com/debian-testing/dists) for a complete list of Debian and Ubuntu releases supported.

```
echo deb https://download.ceph.com/debian-testing/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
```

Tip

For non-US users: There might be a mirror close to you where to download Ceph from. For more information see: [Ceph Mirrors](https://docs.ceph.com/docs/master/install/mirrors).

### **RPM PACKAGES**

### **RHEL**

For major releases, you may add a Ceph entry to the `/etc/yum.repos.d` directory. Create a `ceph.repo` file. In the example below, replace `{ceph-release}` with a major release of Ceph (e.g., `luminous`, `mimic`, `nautilus`, etc.) and `{distro}` with your Linux distribution (e.g., `el7`, etc.). You may view [https://download.ceph.com/rpm](https://download.ceph.com/rpm)-{ceph-release}/ directory to see which distributions Ceph supports. Some Ceph packages (e.g., EPEL) must take priority over standard packages, so you must ensure that you set `priority=2`.

```
[ceph]
name=Ceph packages for $basearch
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/$basearch
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-noarch]
name=Ceph noarch packages
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/noarch
enabled=1
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

[ceph-source]
name=Ceph source packages
baseurl=https://download.ceph.com/rpm-{ceph-release}/{distro}/SRPMS
enabled=0
priority=2
gpgcheck=1
gpgkey=https://download.ceph.com/keys/release.asc

```

For specific packages, you may retrieve them by downloading the release package by name. Our development process generates a new release of Ceph every 3-4 weeks. These packages are faster-moving than the major releases. Development packages have new features integrated quickly, while still undergoing several weeks of QA prior to release.

The repository package installs the repository details on your local system for use with `yum`. Replace `{distro}` with your Linux distribution, and `{release}` with the specific release of Ceph:

```
su -c 'rpm -Uvh https://download.ceph.com/rpms/{distro}/x86_64/ceph-{release}.el7.noarch.rpm'

```

You can download the RPMs directly from:

```
https://download.ceph.com/rpm-testing

```

Tip

For non-US users: There might be a mirror close to you where to download Ceph from. For more information see: [Ceph Mirrors](https://docs.ceph.com/docs/master/install/mirrors).

### **OPENSUSE LEAP 15.1**

You need to add the Ceph package repository to your list of zypper sources. This can be done with the following command

```
zypper ar https://download.opensuse.org/repositories/filesystems:/ceph/openSUSE_Leap_15.1/filesystems:ceph.repo

```

### **OPENSUSE TUMBLEWEED**

The newest major release of Ceph is already available through the normal Tumbleweed repositories. There’s no need to add another package repository manually.

### **CEPH DEVELOPMENT PACKAGES**

If you are developing Ceph and need to deploy and test specific Ceph branches, ensure that you remove repository entries for major releases first.

### **DEB PACKAGES**

We automatically build Ubuntu packages for current development branches in the Ceph source code repository. These packages are intended for developers and QA only.

Add the package repository to your system’s list of APT sources, but replace `{BRANCH}` with the branch you’d like to use (e.g., wip-hack, master). See [the shaman page](https://shaman.ceph.com/) for a complete list of distributions we build.

```
curl -L https://shaman.ceph.com/api/repos/ceph/{BRANCH}/latest/ubuntu/$(lsb_release -sc)/repo/ | sudo tee /etc/apt/sources.list.d/shaman.list

```

Note

If the repository is not ready an HTTP 504 will be returned

The use of `latest` in the url, means it will figure out which is the last commit that has been built. Alternatively, a specific sha1 can be specified. For Ubuntu Xenial and the master branch of Ceph, it would look like:

```
curl -L https://shaman.ceph.com/api/repos/ceph/master/53e772a45fdf2d211c0c383106a66e1feedec8fd/ubuntu/xenial/repo/ | sudo tee /etc/apt/sources.list.d/shaman.list

```

Warning

Development repositories are no longer available after two weeks.

### **RPM PACKAGES**

For current development branches, you may add a Ceph entry to the `/etc/yum.repos.d` directory. The [the shaman page](https://shaman.ceph.com/) can be used to retrieve the full details of a repo file. It can be retrieved via an HTTP request, for example:

```
curl -L https://shaman.ceph.com/api/repos/ceph/{BRANCH}/latest/centos/7/repo/ | sudo tee /etc/yum.repos.d/shaman.repo

```

The use of `latest` in the url, means it will figure out which is the last commit that has been built. Alternatively, a specific sha1 can be specified. For CentOS 7 and the master branch of Ceph, it would look like:

```
curl -L https://shaman.ceph.com/api/repos/ceph/master/53e772a45fdf2d211c0c383106a66e1feedec8fd/centos/7/repo/ | sudo tee /etc/apt/sources.list.d/shaman.list

```

Warning

Development repositories are no longer available after two weeks.

Note

If the repository is not ready an HTTP 504 will be returned

### **DOWNLOAD PACKAGES MANUALLY**

If you are attempting to install behind a firewall in an environment without internet access, you must retrieve the packages (mirrored with all the necessary dependencies) before attempting an install.

### **DEBIAN PACKAGES**

Ceph requires additional third party libraries.

- libaio1
- libsnappy1
- libcurl3
- curl
- libgoogle-perftools4
- google-perftools
- libleveldb1

The repository package installs the repository details on your local system for use with `apt`. Replace `{release}` with the latest Ceph release. Replace `{version}` with the latest Ceph version number. Replace `{distro}` with your Linux distribution codename. Replace `{arch}` with the CPU architecture.

```
wget -q https://download.ceph.com/debian-{release}/pool/main/c/ceph/ceph_{version}{distro}_{arch}.deb
```

### **RPM PACKAGES**

Ceph requires additional additional third party libraries. To add the EPEL repository, execute the following:

```
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

Ceph requires the following packages:

- snappy
- leveldb
- gdisk
- python-argparse
- gperftools-libs

Packages are currently built for the RHEL/CentOS7 (`el7`) platforms. The repository package installs the repository details on your local system for use with `yum`. Replace `{distro}` with your distribution.

```
su -c 'rpm -Uvh https://download.ceph.com/rpm-luminous/{distro}/noarch/ceph-{version}.{distro}.noarch.rpm'
```

For example, for CentOS 7 (`el7`):

```
su -c 'rpm -Uvh https://download.ceph.com/rpm-luminous/el7/noarch/ceph-release-1-0.el7.noarch.rpm'
```

You can download the RPMs directly from:

```
https://download.ceph.com/rpm-luminous
```

For earlier Ceph releases, replace `{release-name}` with the name with the name of the Ceph release. You may call `lsb_release -sc` on the command line to get the short codename.

```
su -c 'rpm -Uvh https://download.ceph.com/rpm-{release-name}/{distro}/noarch/ceph-{version}.{distro}.noarch.rpm'
```