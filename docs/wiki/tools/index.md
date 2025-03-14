---
comments: true
title: "工具、软件和资源"
date: 2025-03-14
categories: 
    - app
---

# 工具、软件和资源

## 字体

- [辰宇落雁體](https://github.com/Chenyu-otf/chenyuluoyan_thin.git):手写体
- [JetBrains Maple Mono](https://github.com/SpaceTimee/Fusion-JetBrainsMapleMono.git):一只基于 Github Workflows (Bash) 的 JetBrains Mono + Maple Mono 合成字体

## 内网穿透

### 游客访问

- SakuraFrp

### 个人设备访问

- Tailscale
- Zerotier

??? deepseek "Tailscale和Zerotier是不是类似的"
    是的，Tailscale 和 ZeroTier 非常类似，它们都是基于 软件定义网络（SDN） 的工具，用于创建安全的虚拟局域网（VPN），允许用户将不同设备连接到一个私有网络中。尽管它们的目标相似，但在实现细节、性能和使用体验上存在一些差异。  

    | 特性                         | Tailscale               | ZeroTier               |
    |------------|------------------|----------------|
    | 协议                         | 基于 WireGuard，性能高且现代     | 使用自研协议，性能稍逊于 WireGuard |
    | 配置复杂度                      | 更简单，自动化程度高              | 配置稍复杂，需要手动设置网络规则       |
    | 中继服务器                      | 提供全球中继服务器，性能较好          | 中继服务器性能一般，免费版可能较慢      |
    | 网络管理                       | 更注重团队协作，适合企业使用          | 更适合个人用户或小型团队           |
    | 开源程度                       | 部分开源（客户端开源，控制端闭源）       | 完全开源                   |
    | NAT 穿透能力                   | 基于 WireGuard，NAT 穿透能力较强 | NAT 穿透能力一般，依赖中继服务器     |
    | 性能                         | 通常性能更高，延迟更低             | 性能稍逊，尤其是免费版            |

    **总结**

    Tailscale 和 ZeroTier 都是优秀的虚拟局域网工具，Tailscale 在性能和易用性上略胜一筹，而 ZeroTier 则更适合需要完全开源解决方案的用户。选择哪个工具取决于你的具体需求和使用场景。
