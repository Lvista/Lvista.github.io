---
# draft: true 
comments: true
slug: np_bc
title: "Numpy中的广播机制"
date: 2025-01-19
categories: 
    - Python
tags:
    - Python
    - Numpy
    - 广播机制
    - 机器学习
---
# Numpy中的广播机制

使用Numpy进行机器学习时，向量之间的运算涉及到到广播机制(Broadcast)，
详细的广播机制是很长的，但是可通过一个简单的例子就能窥见其一二。

<!-- more -->

## 背景

在学习机器学习时，尝试使用Numpy构建一个简单的多输入特征的实验性代码时，
发现最后的结果出现了维度上升问题，如下，在这里使用了：

- 模型：简单线性模型
- 输入和输出：5维度的输入和1维度的输出
- 损失函数：平方损失函数
- 优化算法：随机梯度下降法

=== "生成数据点"
    ``` python
    import numpy as np

    n = 500
    m = 5
    w = np.array([[3,2,6,1,7]]).T
    b = 8
    np.random.seed(42)
    x = np.random.rand(m, n)
    x_aug = np.pad(x, ((0, 1), (0, 0)), 'constant', constant_values=1)
    w_aug = np.pad(w, ((0, 1), (0, 0)), 'constant', constant_values=b)
    y = np.dot(w_aug.T,x_aug)

    # 添加高斯噪声 
    mu, sigma = 0, 1 # 均值和标准差 
    noise = np.random.normal(mu, sigma, y.shape) 
    y_noisy = y + noise

    from sklearn.model_selection import train_test_split

    # 转置 x_aug 和 y_noisy 以进行打乱和分割
    x_aug = x_aug.T
    y_noisy = y_noisy.T

    # 将数据打乱并分成训练集和测试集
    x_train, x_test, y_train, y_test = train_test_split(x_aug, y_noisy, test_size=0.2, random_state=42)

    # 输出结果
    print("训练集 X 的形状:", x_train[:,:-1].shape)
    print("测试集 X 的形状:", x_test.shape)
    print("训练集 Y 的形状:", y_train.shape)
    print("测试集 Y 的形状:", y_test.shape)
    ```
=== "线性模型，损失函数和梯度"
    ``` python
    # 线性模型函数
    def line_fun(x, w, b):
        return np.dot(w.T, x)+b


    # 设定一个平方损失函数的梯度优化
    def gradient_optimization(x, y, w, b):
        y_pre = line_fun(x, w, b)
        grad_w = -(y - y_pre) * x
        grad_b = -(y - y_pre)
        return grad_w, grad_b
    # 损失函数 
    def loss_function(x, y, k, b): 
        y_pre = line_fun(x, k, b) 
        return np.mean((y - y_pre) ** 2)
    ```
=== "训练"
    ``` python
    # 设定学习变量w和b的初始值
    w = np.ones((5, 1))  # 初始权重向量，维度为5*1
    b = 0.0
    learning_rate = 0.001
    decay_rate = 0.5

    tolerance = 1e-6
    max_epochs = 1000
    min_improvement = 1e-6
    patience = 10

    # 训练过程
    previous_loss = float('inf')
    improvement_streak = 0

    # 训练集循环
    for i in range(max_epochs):
        learning_rate = 0.01 / (1 + decay_rate * i)
        current_loss = 0
        for n in range(x_train.shape[0]):
            x_n = x_train[n, :-1]  # 输入特征向量
            y_n = y_train[n]  # 目标值
            grad_w, grad_b = gradient_optimization(x_n, y_n, w, b)
            w = w - learning_rate * grad_w
            b = b - learning_rate * grad_b
            current_loss += loss_function(x_n, y_n, w, b)

        current_loss /= x_train.shape[0]
        if abs(previous_loss - current_loss) < min_improvement:
            improvement_streak += 1
        else:
            improvement_streak = 0

        if improvement_streak >= patience:
            print(f"Training stopped after {i} epochs due to no significant improvement.")
            break

        previous_loss = current_loss

    print(f"Final values: w={w.T},\n b={b}, loss={previous_loss}")

    ```
``` shell
output:
Final values: w=[[3.02622292 3.02622292 3.02622292 3.02622292 3.02622292]
 [2.44689788 2.44689788 2.44689788 2.44689788 2.44689788]
 [5.7501989  5.7501989  5.7501989  5.7501989  5.7501989 ]
 [1.51654221 1.51654221 1.51654221 1.51654221 1.51654221]
 [6.47852751 6.47852751 6.47852751 6.47852751 6.47852751]], 
 b=[ 6.95328209  8.38911179  0.17837436 10.70002468 -1.62483275], loss=4.85157491175411
```
可以发现，w和b均被广播机制扩充为(5,5)(1,5)的矩阵。各位可以思考一下为什么。

## 问题所在
经过繁琐的问题排查，做了以下测试代码：
=== "Test1.py"
    ``` python
    x = np.ones((5,)) # 相当于x_n = x_train[n, :-1] (1)
    w = np.ones((5,1))# 
    b = 1.0
    y = 1
    y_pre = np.dot(w.T, x)+b
    w =  w + (y - y_pre) * x
    print(f"shape of w: {w.shape}")

    y_pre = np.dot(w.T, x)+b
    print(f"shape of y_pre: {y_pre.shape}")
    ```

    1.  从(100, 6)的增广向量$\hat{x}$中取一行的1~5个元素（最后一个是常数项）

    ``` shell
    output: 
    shape of w: (5, 5)
    shape of y_pre: (5,)
    ```
=== "Test2.py"
    ``` python
    x = np.ones((5,1))
    w = np.ones((5,1))
    b = 1.0
    y = 1
    y_pre = np.dot(w.T, x)+b
    w =  w + (y - y_pre) * x
    print(f"shape of w: {w.shape}")

    y_pre = np.dot(w.T, x)+b
    print(f"shape of y_pre: {y_pre.shape}")
    ```
    ``` shell
    output: 
    shape of w: (5, 1)
    shape of y_pre: (1, 1)
    ```

左边是`x = np.ones((5,))`，相当于一个5个常数。
右边是`x = np.ones((5,1))`，是一个行向量

注意`w =  w + (y - y_pre) * x`这一步的运算：

=== "Test1.py"

    - `(y - y_pre) * x`-->(1,)乘以(5,)，得到的shape为(5,)
    - `w + (y - y_pre) * x`-->(5,1)加(5,)，得到的shape为(5,5)
=== "Test2.py"

    - `(y - y_pre) * x`-->(1,)乘以(5,1)，得到的shape为(5,1)
    - `w + (y - y_pre) * x`-->(5,1)加(5,1)，得到的shape为(5,1)

## 总结
在Numpy中，尤其需要注意(5,)这样shape的变量，它会被当作5个常量，即5个shape为(1,1)的向量，
与shape为(5,1)的向量作加算会得到shape为(5,5)的向量。

这也就是为什么在众多关于Numpy的书籍和教程中，优先使用行向量的表示方式的原因。

!!! example "试一试"

    试试下面代码看看结果，发现了什么？
    ``` python
    x = np.ones((5,)) # 输入特征向量
    w = np.ones((5,1))
    print(f"shape of the result: {(x - w)}")
    print(f"shape of the result: {(x * w)}")
    print(f"shape of the result: {np.subtract(x, w)}")
    print(f"shape of the result: {np.dot(x, w)}")
    ```
