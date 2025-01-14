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

可修改`docs/index.md`中的图片和文字

=== ":material-file-code:`docs/index.md`"

    ``` html
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

=== ":material-file-code:`docs/css/custom.css`"

    ``` css
    .flip-container {
        position: relative;
        width: 300px;
        height: 300px;
        margin: 10px auto;
        display: flex;
        align-items: flex-start;
        /* 对齐顶部 */
        justify-content: flex-end;
        /* 将文字放置右上角 */
    }

    /*more...*/

    ```

### 友情链接

可修改`overrides/main.html`中的图片和链接

=== ":material-file-code:`overrides/main.html`"

    ``` html hl_lines="27-42" 
    {% block site_nav %}
    <!-- Navigation -->
    {% if nav %}
    {% if page.meta and page.meta.hide %}
    {% set hidden = "hidden" if "navigation" in page.meta.hide %}
    {% endif %}
    <div class="md-sidebar md-sidebar--primary" data-md-component="sidebar" data-md-type="navigation" {{ hidden }}>
        <div class="md-sidebar__scrollwrap">
            <div class="md-sidebar__inner">
                {% include "partials/nav.html" %}
            </div>
        </div>
    </div>

    {% endif %}

    <!-- Table of contents -->
    {% if "toc.integrate" not in features %}
    {% if page.meta and page.meta.hide %}
    {% set hidden = "hidden" if "toc" in page.meta.hide %}
    {% endif %}
    <div class="md-sidebar md-sidebar--secondary" data-md-component="sidebar" data-md-type="toc" {{ hidden }}>
        <div class="md-sidebar__scrollwrap">
            <div class="md-sidebar__inner">
                {% include "partials/toc.html" %}
            </div>
            <div class="card-container">
                <h3>友情链接</h3>
                <div class="card">
                    <div class="img-container">
                        <a href="https://yangzhang.site/" target="_blank">
                            <img src="https://yangzhang.site/assets/images/summation.png"
                                style="width: 70%; height: 70%; object-fit: contain;">
                        </a>
                    </div>
                    <div class="content">
                        <a href="https://yangzhang.site/" target="_blank">
                            <h3>yangzhang's Site</h3>
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
    {% endif %}
    {% endblock %}
    ```
=== ":material-file-code:`css/float_cards.css`"

    ``` css
    .card-container {
    margin: 50px 0 0 0;
    display: flex;
    flex-flow: row wrap;
    flex-wrap: wrap;
    align-content: flex-start;
    text-align: center;
    }
    /*...see more */

    ```
=== ":material-file-code:`mkdocs.yml`"
    ``` html
    extra_css:
        - css/float_cards.css
    ```