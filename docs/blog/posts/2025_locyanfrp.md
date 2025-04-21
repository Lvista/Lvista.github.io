---
comments: true
title: "乐青Frp使用教程"
date: 2025-04-21
categories: 
    - 网络
tags:
    - Frp
    - 内网穿透
    - locyanfrp
    - 柚子厨
---

# 乐青Frp使用教程

乐青Frp对小白并不友好，在这里记录一下。

<!-- more -->

## （吐槽）乐青Frp，偶遇下头柚子厨，拼进全力无法战胜

在bash上进行验证时，发现源网页里藏了柚子厨

``` html
 <!doctype html>
<!--
⣹⡇⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⡇⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀ ⣀⡤⠴⣒⣺⣭⣭⣭⣭⣭⣭⣭⣭⣓⡲⠤⣀⠀⠀⣀⢴⣺⠭⠭⠭⠭⠭⠭⠯⢵⠲⠤⣀⠀⠀⠀⠀⠀
⣿⡇⠀⣧⣼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⣀⠔⣪⣵⣾⣿⣿⣿⣿⣿⠿⢿⣛⣛⣛⣛⡿⢿⣷⣶⣭⠚⢕⡉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠚⢕⡦⡀⠀⠀
⣿⡇⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢜⣵⣿⣿⣿⣿⣿⠿⣫⣵⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣍⣨⠆⣉⠲⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢪⣢⡀
⣿⡇⠀⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⣡⣿⣿⣿⣿⣿⢟⣵⣿⣿⣿⣿⣿⣿⡿⣿⣿⣭⣭⣽⣿⣻⣿⣿⣿⣶⣝⠶⣬⣓⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⡵
⠛⠃⠀⠛⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⣜⡛⣛⣛⣛⣿⣥⣿⣿⣿⣿⣿⡿⠛⢵⣛⢛⠉⣩⣽⣶⣿⣿⡿⣿⣭⣻⢿⣷⣌⠻⢷⣽⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⢰
⣶⡆⠀⣶⡶⠀⠀⠀⠀⠀⠀⠀⠀⠀⡜⣼⣿⣿⣷⣶⢂⣾⣿⣿⣿⣿⣿⢏⣶⠿⢛⣩⣶⣿⣿⣿⢿⣿⣿⢃⣿⣿⣿⣷⣽⣿⣷⡄⢝⢿⣝⢄⠀⠀⢀⢤⣒⡤⣄⡸
⣿⡇⠀⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⡜⣼⣟⣿⣿⣿⢧⣿⣿⣿⣿⣿⣟⣁⣥⢕⣴⣿⣿⣯⣟⢉⡴⠋⣿⡏⠡⣿⣿⣟⣿⣿⣮⣻⣿⣎⢷⡽⣯⣣⠀⢸⣧⡀⢈⣻⣹
⣿⡇⠀⣿⠏⠀⠀⠀⠀⠀⠀⠀⢰⣹⢯⣾⣿⣿⡏⣾⣿⣿⡿⣿⠏⠞⠉⠑⠻⠿⠿⣛⡭⡂⠛⢀⣸⡟⣼⣿⣿⣿⣿⣹⣿⡝⢷⣻⣿⡜⡌⢎⢷⣣⠀⠉⠛⠓⠉⠃
⣿⡇⠀⣷⣶⠀⠀⠀⠀⠀⠀⢠⢃⣵⣿⣿⣿⣿⢹⣿⣿⣿⣿⡆⢀⣤⠤⠤⠤⢀⠉⠻⣊⠷⡐⣷⢏⣾⣿⡏⣿⣿⣿⡟⣿⣷⠈⢷⢿⣿⢱⠈⢎⢯⠆⠀⠀⠀⢀⢧
⣿⡇⠀⣿⣿⠀⠀⠀⠀⣀⢔⣵⣿⣿⣿⣿⣿⡏⣾⣿⣿⣿⡿⢀⡟⠁⠐⠂⠀⠀⢰⣄⠙⣵⢝⣔⣿⣿⣿⢷⣿⣿⢧⡇⣿⣿⡆⠈⡞⣿⡏⡆⠈⡞⣾⠀⠀⠀⠓⠁
⣿⡇⠀⣿⣿⢀⡠⢔⣮⣾⣿⣿⣿⣿⣿⣿⡿⠄⣿⣿⣿⢿⣧⡸⢀⠀⠀⠀⠀⠀⢸⣋⣂⣷⣿⣿⣿⣿⠟⣞⣯⠗⣼⠁⣿⡏⡇⠙⡇⣿⡇⡇⠀⠸⠃⡄⠀⠀⠀⠀
⣿⣧⠐⣛⣯⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣟⣩⣟⠿⢿⡿⡼⣻⣷⣳⣦⣀⡀⣾⣿⣾⣿⣿⣿⣿⣿⣿⡟⣽⠿⣫⣰⠃⠀⣿⠇⠇⠀⡇⣿⡇⡇⠀⠀⡇⡇⠀⠀⠀⠀
⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⠿⠿⢟⣨⡁⡑⣛⠽⣾⡇⡙⣿⣿⣿⣿⣓⣬⣿⣿⣿⣿⣿⣿⣿⡭⠮⠑⠋⠁⠁⣤⣤⡟⠠⡸⠀⢳⣿⡇⠇⠀⠀⣇⠁⠀⠀⠀⠀
⣿⣿⣿⣿⣿⢟⣵⢫⣷⣯⣵⠿⣫⡾⣯⣟⠻⠃⠉⢭⣠⣷⢻⣽⣿⣿⣿⣿⣿⢟⣛⣛⢿⣿⣿⣅⠀⠴⣶⣾⢏⣾⣿⠟⣽⣲⢇⢢⣿⣿⢸⠀⠀⢠⡹⠀⠀⠀⠀⠀
⣿⣿⠿⣫⣿⣿⢟⣸⢟⣛⣃⢾⣭⣽⣯⣾⢸⣆⣀⢀⡳⡹⣎⢿⣿⣿⣿⣟⣽⣿⣿⣿⣿⡙⣿⣿⣿⣦⣌⠑⣻⣭⢗⢜⣱⢝⢴⣸⣿⡏⠆⠀⢠⡢⠁⠀⠀⠀⠀⠀
⡫⣡⣾⣿⣿⡧⣫⣿⢞⣛⣻⢯⣾⣿⣾⣿⣿⣻⣿⣧⡁⢀⠈⠂⠙⠻⣿⣽⣿⣿⣿⣿⡟⣱⣿⣿⣿⣿⣿⡰⣿⣥⣱⡳⠉⠁⣎⣿⡟⡜⢀⢴⠕⠁⠀⠀⠀⠀⠀⠀
⣵⣿⣿⣿⣿⠃⢉⣶⣿⣿⣿⣿⣿⣿⣿⢿⣷⣿⣿⣿⣷⡄⠂⠢⠱⡄⠀⠁⠛⠟⢛⣯⣾⣿⣿⣿⣿⠿⢛⣡⣿⡇⡳⠁⠀⣜⣾⢟⠜⠚⠓⠁⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⢟⣿⣿⣇⠀⡩⢭⠉⠉⠉⢭⣿⣾⣿⣿⣿⣿⣿⣿⣿⡴⣶⣧⡹⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣺⠸⣿⡿⡀⠁⢀⢮⡾⡫⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⢫⣿⣿⣿⢫⠊⢀⠃⣤⠀⠀⠀⠈⠉⠙⣋⣭⣽⣾⣿⣿⣿⣻⣿⣧⢻⡅⡀⡀⠄⣀⠀⠀⡀⢠⣿⣷⣥⢿⢣⡇⢷⣑⠝⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠏⣿⣿⡿⣱⠁⠀⡌⠀⠀⢠⡀⠀⠀⠀⠀⠈⠻⣯⣿⣿⣿⣿⣏⣿⣿⠨⣕⡍⠔⣿⢋⡕⣼⣿⣿⣿⣿⢸⢘⣸⣿⡼⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⡿⡕⠉⠀⠀⠇⠀⠀⠀⠀⠀⠀⠻⣄⠀⠀⠉⠻⡿⠿⣟⣻⣭⣶⣿⣿⡇⢅⢰⢟⣾⣿⣿⣿⣿⡟⢺⠘⣿⣿⣷⡵⡀
------------------------------------------------------------------------------
Ciallo～(∠・ω< )⌒★
-->
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
    <title>LoCyanFrp 2 Dashboard</title>
    <script defer src="https://analytics.locyan.cn/script.js" data-website-id="321f68d2-1667-450a-ac30-22166d693b6d"></script>
    <script type="module" crossorigin src="/assets/index-DFULV924.js"></script>
    <link rel="stylesheet" crossorigin href="/assets/index-D3iYbOST.css">
  </head>
  <body>
    <div id="app"></div>
  </body>
</html>
```

仪表盘也是：
![ 2025-04-21 105031.png](https://s2.loli.net/2025/04/21/GDVM2Nls9x3AOpo.png)

你们干的好啊！

## 关于乐青Frp

原本我一直在用SakuraFrp，但只能用两个通道，于是开始寻找另外一个frp。
总之就是找到了乐青Frp。
两个免费Frp服务其实是差不多的。二者对比如下：

|名称|流量|带宽|免费隧道数|易用性|
|---|---|---|---|---|
|SakuraFrp|每天约2G|10M|2|简单|
|乐青Frp|基本是无限|114,514M(ﾟД ﾟ; )|无限|较难|

- SakuraFrp

    ✅较为成熟，官方wiki内容充足，基本是小白级别。  
    ✅每天可领取一定流量，基本够用。  
    ❌唯一的不足是免费只有2个隧道。  

- 乐青Frp

    ✅很新的一个自发电Frp服务。带宽和流量完全不担心。  
    ✅隧道无限，服务器多  
    ❌官方wiki基本空白，小白勿碰  

## Linux端使用教程

!!! note

    如果是桌面用户，按照官方指引即可。
    如果使用[CLI](https://baike.baidu.com/item/%E5%91%BD%E4%BB%A4%E8%A1%8C%E7%95%8C%E9%9D%A2/9910197)
    则基本无指引。我在此记录一下。

### 注册和认证

认证一定要将实人认证（一级认证）下面的提交认证完成

### 准备

!!! failure

    官方提供了一个[Nya LoCyanFrp! 乐青映射启动器][1]，但怎么也无法运行
    ```bash
    ./nyalcf -a 
    # 以上认证完成后
    ./nyalcf -s xxxxxx # 某隧道
    ```
    返回语法错误。目前还没有向Github提出issue，懒了。
    
    因此，只能使用同一
    页面下的[纯净版客户端 (Frpc)][2]。

[1]: https://dashboard.locyanfrp.cn/other/software
[2]: https://github.com/LoCyan-Team/LoCyanFrpPureApp

``` bash
# 从mirror上下载Frpc
curl -O https://mirrors.locyan.cn/github-release/LoCyan-Team/LoCyanFrpPureApp/LatestRelease/frp_LoCyanFrp-0.51.3_linux_amd64.tar.gz
# 解压
tar -xzf frp_LoCyanFrp-0.51.3_linux_amd64.tar.gz
# 复制到目录
sudo cp -r frp_LoCyanFrp-0.51.3_linux_amd64 /lib/frp
cd /lib/frp
# 打开配置文件
sudo nano frpc.ini
```
然后找到[配置文件](https://dashboard.locyanfrp.cn/proxies/config)，按节点
找到你已经开启的隧道服务器对应的文件，覆写到该文件中。

### 简单开启

```bash
# 定位到根目录
cd /your/frpc/path
# 开启
./frpc -u {你的访问密钥} -p {隧道ID}
```

### 自启动

参考[官方][1]，这里作了一点修改。

[1]: https://docs.locyanfrp.cn/%E4%BD%BF%E7%94%A8-systemd-%E7%AE%A1%E7%90%86%E5%92%8C%E5%AE%88%E6%8A%A4%E8%BF%9B%E7%A8%8B.html

```
# lcf-frpc.service
[Unit]
Description=LoCyanFrp Client
After=network-online.target
Wants=network-online.target

[Service]
WorkingDirectory=/your/frpc/path
ExecStart=/your/frpc/path/frpc

# 开机无网会导致服务启动失败
# 加入下面以保证启动
Restart=always
RestartSec=5
StartLimitIntervalSec=0

[Install]
WantedBy=network.target
```
### 多服务器

如果你的隧道不是用的同一服务器，则需要创建多个实例。

这里以成都和香港为例。首先同样按节点，找到[配置文件][1]。
在根目录下分别写入两个`.ini`文件

.  
├ frpc  
├ frpc_cq.ini  
└ frpc_hk.ini  

[1]: https://dashboard.locyanfrp.cn/proxies/config

同时，如果启用自启动，也要创建两个`.service`文件

=== "lcf-frpc_cq.service"
    ```
    [Unit]
    Description=LoCyanFrp Client
    After=network-online.target
    Wants=network-online.target

    [Service]
    WorkingDirectory=/your/frpc/path
    # 修改下面
    ExecStart=/your/frpc/path/frpc -c /your/frpc/path/frpc_cq.ini

    Restart=always
    RestartSec=5
    StartLimitIntervalSec=0

    [Install]
    WantedBy=network.target
    ```
=== "lcf-frpc_hk.service"

    ```
    [Unit]
    Description=LoCyanFrp Client
    After=network-online.target
    Wants=network-online.target

    [Service]
    WorkingDirectory=/your/frpc/path
    # 修改下面
    ExecStart=/your/frpc/path/frpc -c /your/frpc/path/frpc_hk.ini

    Restart=always
    RestartSec=5
    StartLimitIntervalSec=0

    [Install]
    WantedBy=network.target
    ```