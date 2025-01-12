
#git

https://learngitbranching.js.org/

## git init

https://git-scm.com/docs/git-init

参数`--separate-git-dir <git dir>`可以把默认生成的`.git`目录放到别处。

比如：

```shell
cd ~/Nutstore Files/Nutstore/wiki
git init . --separate-git-dir=../../.git_wiki

# 使用的git目录实际为~/Nutstore Files/.git_wiki，与Nutstore同级，不会被坚果云同步。
```

它会在 wiki 当前目录生成.git 文件，指示了具体目录在哪里。默认使用的是绝对路径，手工修改为相对路径也可以。

```shell
$ vi .git
gitdir: ../../.git_wiki
```

使用相对路径的好处是便于坚果云同步。

## git clone

https://git-scm.com/docs/git-clone

参数`-b <name>`可以指定 branch，参数`--depth <depth>`可以设定只 clone 最近的若干个 commit（*shallow* clone）。

如果仓库很大，比如 Linux，可以只 clone 某个分支的最近几个 commit。

```shell
# 深度100，下载600多M，目录大小为1.9G
# 深度10，下载200多M，目录大小为1.4G
git clone https://github.com/torvalds/linux.git -b master --depth 10
```

这时候只能看到一个分支信息：

```shell
$ gb -avv
* master                3dbdb38e2 [origin/master] Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
  remotes/origin/HEAD   -> origin/master
  remotes/origin/master 3dbdb38e2 Merge branch 'for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
```

如果要多跟踪一个分支：

https://stackoverflow.com/questions/23708231/git-shallow-clone-clone-depth-misses-remote-branches

```shell
git remote set-branches origin '<branch>'
git fetch --depth <depth> origin <branch>
git checkout <branch>
```

---

直接 clone 本地的仓库：

https://stackoverflow.com/questions/10603671/how-to-add-a-local-repo-and-treat-it-as-a-remote-repo

```
git remote add <NAME> <PATH>
```

比如：

```shell
git remote add bak /home/sas/dev/apps/smx/repo/bak/ontologybackend/.git
```

另外，可通过 ssh 方式 clone 内网的仓库，比如：

```sh
git clone lzy@lzy:~/git/tacoma
```

## git hooks

设置全局 hooks：

https://coderwall.com/p/jp7d5q/create-a-global-git-commit-hook

commit-msg 文件：config/config-tacoma/commit-msg

```bash
git config --global init.templatedir '~/.git-templates'
mkdir -p ~/.git-templates/hooks
拷贝commit-msg文件
# 仓库重新init下
git init
```

## git log

显示 git log graph：

https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs

```c
alias lg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'"

lg 可查看当前分支情况
lg --all 可查看所有分支情况
```

![Pasted image 20220701144128](assets/Pasted%20image%2020220701144128.png)

---

查看已删除文件的历史信息：

https://stackoverflow.com/questions/7203515/how-to-find-a-deleted-file-in-the-project-commit-history

```
git log --all --full-history -- <path-to-file>
```

## git push

https://git-scm.com/docs/git-push

将本地分支推到远端：如果需要强行覆盖，加上参数`-f`。

```sh
git push -u origin branchname
```

如果 git push 默认使用当前分支名：

https://stackoverflow.com/a/57893280/1148981

```sh
git config --global push.default current
git push
```

如果要简单点，只是把本地新分支推到远端，写 branchname 太麻烦：

```sh
git push -u origin HEAD
```

如果仓库跟踪了 2 个 remote repo，然后想把其中一个 repo 的信息（branch，tag）同步到另一个：

```sh
git push ssh://zlu@10.20.0.16:29418/spdk 'refs/remotes/origin/*:refs/heads/*' --tags -f
```

---

git push 到 gerrit，还可以生成 review：

```sh
git push origin HEAD:refs/for/rainier_a0_zns
```

---

禁止本地仓库 push：修改成一个非法的 url 就行。fetch 还是正常的。

https://stackoverflow.com/questions/8375206/git-disable-pushing-from-local-repository

```sh
git config remote.origin.pushurl www.non-existing.com
```

```sh
$ git remote -vv
origin  lzy@lzy-pcu.local:~/git/tacoma (fetch)
origin  www.non-existing.com (push)
```

## git remote

https://git-scm.com/docs/git-remote

显示远程仓库信息：

```sh
$ git remote -v
github  https://github.com/spdk/spdk (fetch)
github  https://github.com/spdk/spdk (push)
origin  ssh://zlu@10.20.0.16:29418/spdk (fetch)
origin  ssh://zlu@10.20.0.16:29418/spdk (push)
```

添加远程仓库跟踪：

```sh
git remote add gitlab git@gitlab.innogrit.com:zhongyong.lu/dpdk.git
```

修改名字：

```sh
git remote rename [old-name] [new-name]
```

修改 URL：

```sh
git remote set-url origin https://github.com/torvalds/linux.git
```

删除远程仓库跟踪：

```sh
git remote remove lzy
```

## .git/config

可以直接修改 remote 跟 submodule 跟踪信息。

比如：

```
[remote "origin"]
	url = /home/lzy/git/tacoma
	fetch = +refs/heads/*:refs/remotes/origin/*
[submodule "nvme"]
	active = true
	url = /home/lzy/git/tacoma/nvme
```

比如：

```
[submodule "dpdk"]
	path = dpdk
	url = http://gitlab.innogrit.com/spdk/dpdk.git
```

## git ignore

标准方式是使用`.gitignore`文件，这个文件可加入 git 管理。

另外的方式如果不想改动.gitignore 文件，则可以修改文件`.git/info/exclude`，写法与`.gitignore`相同。

https://stackoverflow.com/questions/1753070/how-do-i-configure-git-to-ignore-some-files-locally

---

如果文件已经在仓库中了，貌似不能直接 ignore，还会显示 modified。

可以使用 update-index

https://stackoverflow.com/questions/655243/ignore-modified-but-not-committed-files-in-git

```c
git update-index --assume-unchanged config/database.yml

git update-index --assume-unchanged scripts/gdb/rainier_hs/spc-dump.gdbinit
git update-index --assume-unchanged scripts/gdb/rainier_hs/spc-dump.sh
```

要恢复的话，使用：

```c
git update-index --no-assume-unchanged config/database.yml
```

## git sparse-checkout

[Git - git-sparse-checkout Documentation](https://git-scm.com/docs/git-sparse-checkout)

部分检出代码，隐藏一些目录。

编辑文件：`.git/info/sparse-checkout`

```c
# git config core.sparseCheckout true
/*
!nvme/inc/registers/rainier_3/
!nvme/inc/registers/rainier_q/
!nvme/inc/registers/rainier_qx/
!rtos/armv7r/rainier_3/
!rtos/armv7r/rainier_q/
!rtos/armv7r/rainier_qx/
```

之后把目录删了，再`git reset --hard HEAD`。

## git clean

可能会不小心误删，还是使用自定义的 git trash 安全。

https://git-scm.com/docs/git-clean

-n: dry-run，看下效果，并不真正执行。

保留 ignore 文件：

```shell
git clean -df .
```

连 ignore 文件一起删除：

```shell
git clean -dfx .
```

只删除 ignore 文件：

```sh
git clean -dfX .
```

## git trash

https://coderwall.com/p/g16jpq/keep-your-git-directory-clean-with-git-clean-and-git-trash

```c
git config --global alias.trash '!mkdir -p .trash && git ls-files --others --exclude-standard | xargs mv -f -t .trash'
```

相当于

## git branch

显示包含某 commit 的 branch：

```c
git branch --contains <sha1-commit-hash>
```

```c
$ git branch --contains eee5399eea833cefc1f853dec721fbaa43f8fe33
  alibaba_zns4_vzone
  review1
  tmp
```

---

按照 commit 时间排序：

https://stackoverflow.com/questions/5188320/how-can-i-get-a-list-of-git-branches-ordered-by-most-recent-commit

```shell
git branch --sort=-committerdate  # DESC
git branch --sort=committerdate  # ASC
```

```shell
alias gbs="git branch --sort=-committerdate"
```

## git status

https://stackoverflow.com/questions/466764/git-command-to-show-which-specific-files-are-ignored-by-gitignore

查看被 ignore 的文件：

```sh
$ git status --ignored
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   .gitignore

Ignored files:
  (use "git add -f <file>..." to include in what will be committed)
        unlinked_files_output.md
        unresolved_links_output.md
```

## git submodule

https://devconnected.com/how-to-add-and-update-git-submodules/

## patch

生成某 commit 到现在的所有 patch：先定位到前一个

```c
git fomat-patch a77094146d2b3b9d84550aa8509e4d7d96a62e84~1..HEAD
```

打 patch 时，不要忽略 commit message 中的中括号：使用参数`--keep-non-patch`。

https://stackoverflow.com/questions/13339027/git-am-should-ignore-something-in-commit-message-startswith

## git 其他操作

### 获取当前 commit 号。

> git rev-parse HEAD
>
> https://stackoverflow.com/questions/11168141/find-which-commit-is-currently-checked-out-in-git

### 忽略文件权限变动

https://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-file-mode-chmod-changes

```c
git config core.filemode false
```

### CA 证书错误

https://stackoverflow.com/questions/21181231/server-certificate-verification-failed-cafile-etc-ssl-certs-ca-certificates-c

```c
export GIT_SSL_NO_VERIFY=1
#or
git config --global http.sslverify false
```

再重新就可以了。

## git-old

[git-old](../personal/git-old.md)
