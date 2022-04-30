---
title: Linux配置v2ray详细教程-Ubuntu为例_-_菠萝阁_7906293c9f274fe4a500f49f5b3c125f
---

# Linux配置v2ray详细教程-Ubuntu为例 - 菠萝阁

[https://www.boluo.in/1776.html](https://www.boluo.in/1776.html)

v2ray科学上网的话，windows平台我们可以使用clash，v2rayN等软件，mac的话可以使用clashX等，但是对于linux平台，我们的选择比较少了就，今天介绍一款linux上很好用的图形话界面科学上网工具-Qv2ray。

简介：🌟 Linux/Windows/macOS 跨平台 v2ray GUI 🔨 使用 c++ 编写，支持订阅，扫描二维码，支持自定义路由编辑 🌟。使用 Qt 框架的跨平台 v2ray 客户端。支持 Windows, Linux, macOS。

这是github页面的作者简介，下面来看下linux上面配置教程。-本教程基于Ubuntu哦。其他Linux平台类似。

1：下载`V2ray`客户端，这里以最简单的`AppImage`文件为例,下载链接：

[https://github.com/Qv2ray/Qv2ray/releases/download/v1.99.6/Qv2ray-refs.tags.v1.99.6-linux.AppImage](https://github.com/Qv2ray/Qv2ray/releases/download/v1.99.6/Qv2ray-refs.tags.v1.99.6-linux.AppImage)

或者打开网站：[https://github.com/Qv2ray/Qv2ray/releases/tag/v1.99.6](https://github.com/Qv2ray/Qv2ray/releases/tag/v1.99.6) 选择下图文件

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580651760-1.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580651760-1.png)

*注意：建议下载1.99.6及以上版本，其它版本可能出现找不到openssl库。*

2：下载核心文件，下载链接：

[https://github.com/v2ray/v2ray-core/releases/download/v4.22.1/v2ray-linux-64.zip](https://github.com/v2ray/v2ray-core/releases/download/v4.22.1/v2ray-linux-64.zip)

或者打开网站：[https://github.com/v2ray/v2ray-core/releases/](https://github.com/v2ray/v2ray-core/releases/) 选择下图文件

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580651801-2.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580651801-2.png)

3:进入v2ray下载的根目录，执行以下命令：

`sudo chmod +x ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`

4:仍然在v2ray根目录下打开终端，输入以下命令：

`sudo ./Qv2ray-refs.tags.v1.99.6-linux.AppImage`

执行4后会出现主界面，点击`首选项`

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652261-3-1580634671283.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652261-3-1580634671283.png)

在常规设置里面按照图示操作,最后点击ok保存：

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652339-4.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652339-4.png)

6：回到主界面，点击订阅：

然后按照下图要求填入相应内容,然后点击ok：

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580655824-6.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580655824-6.png)

进入网站->个人中心，按照下图说明复制链接到上图中：

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652405-7.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580652405-7.png)

将软件的代理模式打开，如下图所示；

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580653297-8.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580653297-8.png)

7:一切准备好后点击主界面的连接，开始科学上网

墙外的世界在欢迎你!

![Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580653648-tzyy_2020-02-02_22-27-02.png](Linux%E9%85%8D%E7%BD%AEv2ray%E8%AF%A6%E7%BB%86%E6%95%99%E7%A8%8B-Ubuntu%E4%B8%BA%E4%BE%8B%20-%20%E8%8F%A0%E8%90%9D%E9%98%81%207906293c9f274fe4a500f49f5b3c125f/1580653648-tzyy_2020-02-02_22-27-02.png)

特别感谢 ***hnsywangxin*** 在百忙之中抽空整理此篇文章。

如果您有好的想法和教程也可以联系网站管理员哦。

用户留言：

1. 我解决啦，我在windows上面用v2ray也配置了一下，然后对比了下Ubuntu上的那个，就是设置端口号的问题。那个Ubuntu版的v2ray的socks和http端口号默认是1080和8000，但是win上的是10808和10809我改了下就好了。和你说一声，免得又有像我这样的来找你哈哈哈哈。