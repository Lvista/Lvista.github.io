---
draft: true 
comments: true
slug: build_sim
title: "Build A Simular Site"
date: 2025-01-10
categories: 
    - HP
    - Blog
tags:
    - 建站
    - HTML
    - Material for MkDocs
    - Blog
    - 个人网站
---
# 给我也整一个！

整一个与本站类似的网站

<!-- more -->

:heart:首先谢谢频幕前的你对我的认同，话不多说，开整！

## 准备

- 从我的[release/latest](https://github.com/Lvista/Lvista.github.io/releases/latest)中下载最新版
- 下载包:
<!-- termynal -->

```
> pip install mkdocs-material
> pip install mkdocs-rss-plugin
> pip install mkdocs-git-revision-date-localized-plugin
```
之后运行以下命令即可预览
<!-- termynal -->
```
> mkdocs server
```
!!! tip 
    `mkdocs server`运行后不会自动中止进程，使用++ctrl+c++即可强行终止进程。
    进程开始后， 大部分 的网页的修改会同步跟新到网页，不需要重新启动。

*[大部分]: 后面就会懂哪些是大部分了
## 部署

1. 创建一个Github账号
2. 按照[GitHub Pages](https://pages.github.com/)创建仓库
3. 按照[使用GitHub Actions workflow](http://127.0.0.1:8000/blog/2025/01/08/site_build/#github-actions-workflow)
推送仓库
4. 按照[国内访问](http://127.0.0.1:8000/blog/2025/01/08/site_build/#_2)解析网页

## 自定义

大部分设置可参考[Customization](https://squidfunk.github.io/mkdocs-material/customization/)
这里对我加入的进行说明

### 首页头像

:material-file-code:`index.html`

=== "`index.html`"
    ```html
    <div class="flip-container">
        <div class="image-container">
            <!-- docs/assets/images/logo_noBG_circle.png -->
            <img src="https://s2.loli.net/2025/01/09/ve1piNRt6M5ycDQ.png" alt="Front Image">
            <a href="/template/" >
                <!-- docs/assets/images/self_shoot.png -->
                <img src="https://s2.loli.net/2025/01/09/wOzTR9Kyfq2jMHo.png" alt="Back Image">
            </a>
        </div>
        <div class="hover-block">
            点我看看!
        </div>
    </div>

    ```

:material-file-code:`overrides/main.html`


