---
# draft: true 
comments: true
slug: site_build
title: "自建主页：始"
date: 2025-01-08
categories: 
    - 建站
tags:
    - 建站
    - HTML
    - Material for MkDocs
    - Blog
    - 个人网站
---
# 自建主页：始

从萌生一个建站的想法，到成功构建一个基本框架的过程。具体做法官网给的很详细，这里只会指出一些特别的地方
<!-- more -->

!!! refer "参考"

    - :fontawesome-solid-handshake-simple:感谢：[Σ张杨][lab_1]激发了我建站的想法。
    - :material-book:主要遵循：[:simple-materialformkdocs:Material for MkDocs-getting-started](https://squidfunk.github.io/mkdocs-material/getting-started/#getting-started)

??? note "为何要费时费力建一个网站？"
    
    不为别的，就是“介绍自我”。如果是为了分享一些东西，大可去CSDN(1)之类的地方，
    不必在个人主页上分享经验，这有悖互联网的“分享”精神。
    {.annotate}

    1. 可以前往我的[CSDN](https://blog.csdn.net/Lvista?spm=1000.2115.3001.5343)看看分享过的文章

    [:simple-notion:Notion][lab_2]是一个很好的笔记记录平台，功能很强大，我把很多记录的东西都放在这里，
    但是并不能完全的自定义，并且更多是“私有”的，所以想将其移植到个人网站上。

    对于我这样喜欢混迹在互联网，视电子设备为“最佳玩具”的人来说，
    个人主页就是最好的名片。通过这样的“名片”我结实了“世另我”[Σ张杨][lab_1]

## Start your first homepage

只需要遵从[Getting-started][qs]
按照顺序一步步做下去即可搭建完成第一个HP，之后在[GitHub Pages][GP]上部署即可。动手完成至[Getting-started][qs]中的[Publishing your site](https://squidfunk.github.io/mkdocs-material/publishing-your-site/#publishing-your-site)
章节即可完成基本部署。


??? example annotate "快速实践"

    以下仅为“急急国王”或者需要尽快搭建的同学的参考，对于大多数人，
    依然建议按照[Getting-started][qs]提供的教程进行.

    - `pip install mkdocs-material`
    - 下载官方提供的标准例子
        [Blog][blog-template]
    - `mkdocs.yml`修改以下部分(1): 
        ```yaml
        plugins:
            - search
            - blog:
                blog_toc: true
                archive_date_format: MMMM yyyy
                categories_allowed:
                    - Holidays
                    - News
                authors_profiles: true
                pagination_per_page: 5
                archive_pagination_per_page: 10
                categories_pagination_per_page: 10
            - tags
        ```
    - 运行`mkdocs serve`即可在本地浏览效果
    - 运行`mkdocs build`创建包含`index.html`的网页文件
    - [GitHub Pages][GP]快速部署，推送到Github
    - 访问`user.github.io`即可看到结果
    !!! tip "更喜欢我的？"
        如果您更喜欢我的，可以看看[这篇](./build_simi.md)

1.  因为该例子只给[Insiders Edition](https://squidfunk.github.io/mkdocs-material/insiders/)，俗称高级用户使用
需要去掉部分功能才能运行。

[blog-template]: https://github.com/mkdocs-material/create-blog
[qs]: https://squidfunk.github.io/mkdocs-material/getting-started/#getting-started


??? note "你可能需要知道的"
    GitHub Pages是通过自动寻找当前Branch上的的`index.html`来发布网页的，
    所以需要注意repo中的setting→Pages→Build and deployment下的Source设置是否是Deploy from a branch，
    Branch是否设置为编译后的文件分支，这个设置在后面也会提到

## 使用GitHub Actions workflow

!!! quote "为何要使用 GAW "
    GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. You can create workflows that build and test every pull request to your repository, or deploy merged pull requests to production. 

    :material-arrow-right:from [Publishing your site - Material for MkDocs](https://squidfunk.github.io/mkdocs-material/publishing-your-site/)



!!! note "原理"
    使用 GAW 最大的好处在于将源文件和编译后的文件库分开。并且编译在 GAW 上完成，对本地编辑环境要求降低了很多，可以快速发布文章。

    原理就是将编译前的文件推送到Github，Github会根据`.github\workflows\ci.yml`运行命令，
    在这里就是将文件云编译至`gh-pages`分支，然后Github Page会展示`gh-pages`分支的网页仓库，
    而源文件则在`main`分支中。

1. 根据[Publishing your site - Material for MkDocs](https://squidfunk.github.io/mkdocs-material/publishing-your-site/)
完成`ci.yml`的创建
2. 将带有`mkdocs.yml`的源文件库推送至`main`分支
3. 转Github仓库页面，在`Setting`->`Pages`->`Build and deployment`中，将`Branch`设定为`gh-pages`


??? bug "ERROR - Config value 'plugins': The "git-revision-date-localized" plugin is not installed"
    当使用[git-revision-date-localized](https://squidfunk.github.io/mkdocs-material/setup/adding-a-git-repository/?h=git+date#document-dates)
    模块后，在 GAW 运行时会出现这样的错误。请修改`.github/workflows/ci.yml`内容如下，让 GAW 下载该模块：
    ```yaml linenums="1" hl_lines="29"
    name: ci
    on:
    push:
        branches:
        - main
    permissions:
    contents: write
    jobs:
    deploy:
        runs-on: ubuntu-latest
        steps:
        - uses: actions/checkout@v4
        - name: Configure Git Credentials
            run: |
            git config user.name github-actions[bot]
            git config user.email 41898282+github-actions[bot]@users.noreply.github.com
        - uses: actions/setup-python@v5
            with:
            python-version: 3.x
        - run: echo "cache_id=$(date --utc '+%V')" >> $GITHUB_ENV
        - uses: actions/cache@v4
            with:
            fetch-depth: 0
            key: mkdocs-material-${{ env.cache_id }}
            path: .cache
            restore-keys: |
                mkdocs-material-
        - run: pip install mkdocs-material
        - run: pip install mkdocs-git-revision-date-localized-plugin
        - run: mkdocs gh-deploy --force

    ```


## 国内访问

!!! note
    请确认已在[GitHub Pages][GP]上部署好网站并可以访问。
国内访问[GitHub Pages][GP]提供的`username.github.io`会出现加载慢的情况，[vercel](https://vercel.com/)
之类的平台也无法在国内进行访问，所以就需要另外一种方法来进行代理访问。这里我们使用域名+DNS解析的方法。

1. 首先购买域名，腾讯云，阿里云啥的都行。比如我这里使用的[腾讯云](https://buy.cloud.tencent.com/domain/price?type=overview)，
需要实名注册，审核通过很快，购买了1年的`.site`域名；
2. 之后带着注册号的域名，比如我的`lvista.site`，找到`云解析DNS`服务，选择`新手快速解析`
3. 选择将网站域名解析到另外的目标名，输入`username.github.io`，就能开启免费套餐版的云解析DNS服务
4. 转Github仓库，在`Setting`->`Pages`-> `Chustom domain`中输入域名，保存

*[GAW]: GitHub Actions Workflow
[GP]: https://pages.github.com/
[lab_1]: https://yangzhang.site/
[lab_2]: https://www.notion.com/

## END

到此为止，你已经成功完成以下功能：

- [x] 构建一个网站
- [x] 将其部署在服务器上（GitPage托管服务）
- [x] 中国大陆也能访问

:partying_face:恭喜你，你又进步了！！