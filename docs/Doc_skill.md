---
draft: true 
comments: true
slug: test_page
title: "Test"
date: 2025-01-07
categories: 
    - Test
tags:
    - Test
---

# MkDocs撰写技巧

记录一些有用的MkDocs的撰写语法，技巧等，随时查阅。主要记录一些我用过或者觉得有用的一些语法，毕竟并不是越多越好。

<!-- more -->
!!! info

    本文所述语法并不是基本MarkDown语法，其依赖于各种扩展，请在加载对应扩展后再使用

## 警告(Admonitions)

详情请查阅[原文](https://squidfunk.github.io/mkdocs-material/reference/admonitions/#admonitions)。

!!! quote "引用"

    人生三问，我是谁，我从哪里来，我到哪里去。
    ——from 民间

??? example "动手做一做吧"

    比起“例子”这个解释，我觉“动手做一做”这个更适合，就像课后习题一样

!!! tip "提示"

    [原文](https://squidfunk.github.io/mkdocs-material/reference/admonitions/#supported-types)
    有很多可以表示提示的格式，暂时觉得这个更好一点。

## 表情(Emojis)和按钮(Buttons)

```
[前往搜索emoji :octicons-search-16:][tab_1]{ .md-button }

[tab_1]: https://squidfunk.github.io/mkdocs-material/reference/icons-emojis/#search

```

[前往搜索emoji :octicons-search-16:][tab_1]{ .md-button }

[tab_1]: https://squidfunk.github.io/mkdocs-material/reference/icons-emojis/#search

或者下面两个网站：

- [fontawesome](https://fontawesome.com/)
- [Bootstrap Icons](https://icons.getbootstrap.com/)

## 注释(Annotations)

See more (1)
{ .annotate }

1.  [Annotations :material-plus-circle:][tab_2]{ .md-button }

    [tab_2]: https://squidfunk.github.io/mkdocs-material/reference/annotations/#annotations

代码中的Annotations:
``` yaml
theme:
  features:
    - content.code.annotate # (1)!
```

1.  使用这个注释方法：`# (1)!`


## 代码块(Code blocks)

### 加标题

```` yaml title="test.md"
``` py title="bubble_sort.py"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```
````
### 加行号
```` yaml linenums="1"
``` py linenums="1"
def bubble_sort(items):
    for i in range(len(items)):
        for j in range(len(items) - 1 - i):
            if items[j] > items[j + 1]:
                items[j], items[j + 1] = items[j + 1], items[j]
```
````
### 行高亮

=== "Lines"

    ```` markdown title="Code block with highlighted lines"
    ``` py hl_lines="2 3"
    def bubble_sort(items):
        for i in range(len(items)):
            for j in range(len(items) - 1 - i):
                if items[j] > items[j + 1]:
                    items[j], items[j + 1] = items[j + 1], items[j]
    ```
    ````

    <div class="result" markdown>

    ``` py linenums="1" hl_lines="2 3"
    def bubble_sort(items):
        for i in range(len(items)):
            for j in range(len(items) - 1 - i):
                if items[j] > items[j + 1]:
                    items[j], items[j + 1] = items[j + 1], items[j]
    ```

    </div>

=== "Line ranges"

    ```` markdown title="Code block with highlighted line range"
    ``` py hl_lines="3-5"
    def bubble_sort(items):
        for i in range(len(items)):
            for j in range(len(items) - 1 - i):
                if items[j] > items[j + 1]:
                    items[j], items[j + 1] = items[j + 1], items[j]
    ```
    ````

    <div class="result" markdown>

    ``` py linenums="1" hl_lines="3-5"
    def bubble_sort(items):
        for i in range(len(items)):
            for j in range(len(items) - 1 - i):
                if items[j] > items[j + 1]:
                    items[j], items[j + 1] = items[j + 1], items[j]
    ```

    </div>

## 获取网页ICON的api

[:simple-github: favicone](https://github.com/fransallen/favicone)
``` html
<!-- example -->
https://favicone.com/google.com
```
![](https://0x3.com/icon?host=0x3.com){width=20} https://0x3.com/

``` html
<!-- example -->
https://0x3.com/icon?host=www.bilibili.com
```