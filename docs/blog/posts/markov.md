---
comments: true
slug: Markov chains
title: "马尔可夫链计算暴击伤害"
date: 2025-02-27
categories: 
    - Math
tags:
    - Game
    - 统计
    - statistic
    - 概率递增
    - 马尔可夫链
    - Markov
---
# 随机过程和马尔可夫链

游戏中经常出现暴击率递增的实现方法，那么怎么计算它的期望呢？
<!-- more -->

!!! note

    - <https://en.wikipedia.org/wiki/Markov_chain>  
    - <https://www.bilibili.com/video/BV14y4y1S7ve?vd_source=796139b42b923237a89bd18f2217a4e7&spm_id_from=333.788.videopod.sections>  
    - (上面的视频用的PDF)<http://dl.nemoudar.com/Introduction-to-Stochastic-Processes-with-R.pdf>

## 背景

<iframe
  src="//player.bilibili.com/player.html?isOutside=true&aid=114065556903918&bvid=BV1mbPveyEe3&cid=28577368952&p=1&autoplay=false"
  scrolling="no"
  border="0"
  frameborder="no"
  framespacing="0"
  allowfullscreen="true"
  style="width: 100%; aspect-ratio: 16 / 9; border: none;"
></iframe>

视频简介里描述了一种“暴击率递增”的出伤方式，想起了游戏中经常出现的“暴击率递增”概率方案。突然就想计算一下数学期望。

## 马尔可夫链

马尔可夫过程可以用以下图来表示：
![](https://media.licdn.com/dms/image/v2/D4D12AQGYhQ7epZ1HVQ/article-cover_image-shrink_600_2000/article-cover_image-shrink_600_2000/0/1687842615765?e=2147483647&v=beta&t=oNve9sF1aDkp4ZkXz2JNMCZlvTMjICoNkNJXE5Vq2GQ)

用一种更为形象的方式来表现。在决定吃什么的时候：每次吃过一种之后，下次吃某一种的概率。有下图：
![](https://i.ytimg.com/vi/i3AkTO9HLXo/maxresdefault.jpg)

## 牙膏问题

大概理解了上面的图之后，接着我们用下面的例子来尝试求解。
!!! quote "[牙膏问题](<https://wiki.mbalib.com/wiki/%E8%BD%AC%E7%A7%BB%E6%A6%82%E7%8E%87%E7%9F%A9%E9%98%B5#_note-.E5.86.B3.E7.AD.96.E6.94.AF.E6.8C.81.E7.B3.BB.E7.BB.9F.E5.AF.BC.E8.AE.BA>)"
    　假定某大学有1万学生，每人每月用1支牙膏，并且只使用“中华”牙膏与“黑妹”牙膏两者之一。根据本月（12月）调查，有3000人使用黑妹牙膏，7000人使用中华牙膏。又据调查,使用黑妹牙膏的3000人中，有60％的人下月将继续使用黑妹牙膏，40％的人将改用中华牙膏； 使用中华牙膏的7000人中， 有70％的人下月将继续使用中华牙膏，30％的人将改用黑妹牙膏。据此，可以得到如表所示的统计表。

    | 拟用   | 黑妹牙膏 | 中华牙膏 |
    |------|------|------|
    | 现用   |      |      |
    | 黑妹牙膏 | 60%  | 40%  |
    | 中华牙育 | 30%  | 70%  |

    计算下个月的两种牙膏的使用情况

这个问题的解很快：

$$
\begin{align*}
(3000,7000)\cdot
\begin{pmatrix}
0.6 & 0.4 \\
0.3 & 0.7
\end{pmatrix}
 = (3900,6100)
 \end{align*}
$$

同样，我们可以求出$n$个月之后的用户分布情况：

$$
\begin{align*}
y = (3000,7000)\cdot
\begin{pmatrix}
0.6 & 0.4 \\
0.3 & 0.7
\end{pmatrix}
^n
\end{align*}
$$

借用[知乎](<https://www.zhihu.com/question/452918374>)上对于这个问题的相关讨论，
令P为上面的转移矩阵。根据一系列定理(1)，$\lim_{n \to \infty} P^n$存在。
因此，当$x$足够大时，$P^n=P^{n+1}$，此时，两边同时左乘向量$x$，同时令$\pi=xP^n$，
得到方程$\pi \cdot P = \pi$，因此解该方程即可得到稳态解。
{.annotate}

1. 关于这方面的讨论放在wiki里

注意这里，对方程$\pi \cdot P = \pi$两边同时转置，$\pi$变为列向量，整个方程正是求$P.T$的特征值为1的特征向量。
我们很快就能求得上面的方程解为$(3,4)$，归一化后得到$(0.43,0.57)$，也就是说两种牙膏的用户比例会趋近0.43:0.57

## 暴击伤害问题

我们回到上面视频里的伤害计算问题，这里取值与视频不同

假设起始概率为0.2，步长为0.2，则
转移概率矩阵$P$为:

$$
\begin{pmatrix}
 0.2 & 0.8 & 0   & 0   & 0  \\
 0.4 & 0   & 0.6 & 0   & 0  \\
 0.6 & 0   & 0   & 0.4 & 0  \\
 0.8 & 0   & 0   & 0   & 0.2\\
 1.0 & 0   & 0   & 0   & 0
\end{pmatrix}
$$

求解$\pi$,使得：

$$
\begin{align*}
\pi \cdot P = \pi \\
\sum_{i=0}^5 \pi _i = 1
\end{align*}
$$

这一次我们使用Python的`numpy`来计算：

```py
import numpy as np

y = np.array([[0.2, 0.8, 0,   0,   0  ],
              [0.4, 0,   0.6, 0,   0  ],
              [0.6, 0,   0,   0.4, 0  ],
              [0.8, 0,   0,   0,   0.2],
              [1,   0,   0,   0,   0  ]])

# 计算特征值和特征向量
eigenvalues, eigenvectors = np.linalg.eig(y.T)

# 找到特征值为 1 的特征向量
index = np.where(np.isclose(eigenvalues, 1))[0][0]

steady_state = eigenvectors[:, index]
print("稳态分布 L:", steady_state)

# 归一化
steady_state = steady_state / np.sum(steady_state)

print("稳态分布 L:", steady_state)
```

最后得到稳态分布 L:(0.39834289, 0.31867431, 0.19120459, 0.07648184, 0.01529637)

取$\pi_0$计算，得到$1\cdot (1-p)+p\cdot 2 = 1.273208$

!!! question
    这里想不通为什么取$\pi_0$
