---
# draft: true
comments: true
slug: win11_pro_up
title: "Win11 家庭版升级/专业版激活"
date: 2025-02-04
categories: 
    - 破解
tags:
    - 破解
    - win11
    - 激活
---
# Win11 家庭版升级/专业版激活

<!-- more -->
# 为什么要激活专业版

!!! quote "Features You Only Get in Windows 11 Pro"
    According to the Microsoft Store documentation, these features are exclusive to Windows 11 Pro:

    - BitLocker, which helps protect data with enhanced encryption and security management
    - Remote Desktop control
    - Hyper -V for creating and running virtual machines
    - Private Catalog to access your company's apps through your own section in the Microsoft Store
    - Ability to join Azure Active Directory and connect to your school, business, or corporate network via the cloud
    - Ability to join a domain and connect to your business or corporate network

其中，远程桌面控制和虚拟机功能是开发人员所需要的

# 引导

分两种情况，如果已经是专业版，但未激活，请跳转到[**专业版激活**](#_4)节，如果是家庭版升级为专业版，请继续看下去。

# 家庭版升级

只有首先升级为专业版才能激活。

正规升级有两种途径，一种是购买正版权限，一种是重装系统为专业版，在这里不涉及。

> 相信在座的各位一定是出于学习目的来看本文的吧
> 

下面是绕过检查直接升级的方法：

- 因为有重启操纵，请确认各项文件已保存
- 断网（务必确认）
- 进入**设置→系统→激活→更改产品密钥**
- 输入密钥：`J8WVF-9X3GM-4WVYC-VDHQG-42CXT` 并确认，进入升级，需要花费较长时间

> 密钥截止2024/12/18有效 from [Win11家庭版升级Win11专业版 - Invinc-Z - 博客园](https://www.cnblogs.com/Invinc-Z/p/18320144))
如果失效则可考虑网上其他人提供的密钥
> 

# 专业版激活
> 激活方法来自[Microsoft Activation Scripts (MAS) | MAS](https://massgrave.dev/)，可关注https://github.com/TGSAN/CMWTAT_Digital_Edition/issues/81

重启后可以在**设置→系统→激活→激活状态**中看到未激活。


- 联网
- 进入PowerShell（非cmd）输入以下命令：

```powershell
irm https://get.activated.win | iex
```

- 当加载出UI后，输入1来选择[1] HWID，进入激活
- 出现激活成功提示后，即激活成功

# 后话

该方法来自[Microsoft Activation Scripts (MAS) | MAS](https://massgrave.dev/)，是一个叫massgrave.dev团队开发的，从官网来看，这个项目居然维护的很好，很好奇为何一致没有被MS官方请喝茶🤔

也无所谓了，何必想那么多。