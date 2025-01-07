---
# draft: true
comments: true
slug: Vedio_processing_by_python
title: "基于Python的视频处理"
date: 2025-01-06
categories: 
    - Python
    - application
    - media process
tags:
    - Python
    - Vedio
    - Image
---

# 基于Python的视频处理

一开始我是为了做一个GIF图，然后进行一个压的缩，缩到8M以下，以便发到B站动态。但是网上的在线压缩工具都不太好用，于是想到了Python，一查果然有这样的媒体处理模块：`moviepy`

<!-- more -->

[一日一技：使用Python将视频转Gif-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/1975307)

[User Guide — MoviePy 1.0.2 documentation](https://zulko.github.io/moviepy/)

# MP4转GIF

首先用Win11自带的视频剪辑软件剪了一下，然后导入`moviepy` ，按照教程给的代码进行测试：

```python
from moviepy.editor import *

clip = VideoFileClip(r"C:\Users\czc_c\Downloads\Liar Dancer.mp4")
clip = clip.resize(0.4) # 压缩大小
clip.write_gif("movie-10f.gif",fps=15)  #设置为每秒15帧
```

这时候会出现一个error：**`module 'PIL.Image' has no attribute 'ANTIALIAS'`**

查了之后发现是Pillow 从10.0版本后就移除了**`ANTIALIAS`** ，解决方案就是导入9.5版本。

[AttributeError: module 'PIL.Image' has no attribute 'ANTIALIAS'](https://stackoverflow.com/questions/76616042/attributeerror-module-pil-image-has-no-attribute-antialias)

![](../../assets/images/5M.gif)

