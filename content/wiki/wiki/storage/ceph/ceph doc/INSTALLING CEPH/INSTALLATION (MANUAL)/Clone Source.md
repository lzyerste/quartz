---
title: Clone_Source
---

# Clone Source

# **CLONING THE CEPH SOURCE CODE REPOSITORY**

You may clone a Ceph branch of the Ceph source code by going to [github Ceph Repository](https://github.com/ceph/ceph), selecting a branch (`master` by default), and clicking the **Download ZIP** button.

To clone the entire git repository, install and configure `git`.

## **INSTALL GIT**

To install `git` on Debian/Ubuntu, execute:

```
sudo apt-get install git
```

To install `git` on CentOS/RHEL, execute:

```
sudo yum install git
```

You must also have a `github` account. If you do not have a `github` account, go to [github.com](https://github.com/) and register. Follow the directions for setting up git at [Set Up Git](https://help.github.com/linux-set-up-git).

## **ADD SSH KEYS (OPTIONAL)**

If you intend to commit code to Ceph or to clone using SSH (`git@github.com:ceph/ceph.git`), you must generate SSH keys for github.

Tip

If you only intend to clone the repository, you may use `git clone --recursive https://github.com/ceph/ceph.git` without generating SSH keys.

To generate SSH keys for `github`, execute:

```
ssh-keygen
```

Get the key to add to your `github` account (the following example assumes you used the default file path):

```
cat .ssh/id_rsa.pub
```

Copy the public key.

Go to your `github` account, click on “Account Settings” (i.e., the ‘tools’ icon); then, click “SSH Keys” on the left side navbar.

Click “Add SSH key” in the “SSH Keys” list, enter a name for the key, paste the key you generated, and press the “Add key” button.

## **CLONE THE SOURCE**

To clone the Ceph source code repository, execute:

```
git clone --recursive https://github.com/ceph/ceph.git
```

Once `git clone` executes, you should have a full copy of the Ceph repository.

Tip

Make sure you maintain the latest copies of the submodules included in the repository. Running `git status` will tell you if the submodules are out of date.

```
cd ceph
git status
```

If your submodules are out of date, run:

```
git submodule update --force --init --recursive
```

## **CHOOSE A BRANCH**

Once you clone the source code and submodules, your Ceph repository will be on the `master` branch by default, which is the unstable development branch. You may choose other branches too.

- `master`: The unstable development branch.
- `stable`: The bugfix branch.
- `next`: The release candidate branch.

```
git checkout master
```