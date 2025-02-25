# Python & 代数

记录一些在python中实现张量代数运算的方法，
主要包括Numpy, Paddle, PyTorch, TensorFlow等包

## 张量的定义
在机器学习等领域，数据通常以张量的形式表现。
!!! quote "张量（Tensor）"
    In mathematics, a tensor is an algebraic object that describes a multilinear relationship between sets of algebraic objects related to a vector space. Tensors may map between different objects such as vectors, scalars, and even other tensors. There are many types of tensors, including scalars and vectors (which are the simplest tensors), dual vectors, multilinear maps between vector spaces, and even some operations such as the dot product. Tensors are defined independent of any basis, although they are often referred to by their components in a basis related to a particular coordinate system; those components form an array, which can be thought of as a high-dimensional matrix.  
    ---from [wiki](https://en.wikipedia.org/wiki/Tensor)

其实看了这么多也看不懂，看了知乎[关于张量和矩阵的区别的讨论](https://www.zhihu.com/question/29150964)，
其实也没能看懂多少，其中涉及到坐标基矢的表示和变换，看了很多也没看懂，如果后面能看懂，或者谁能告诉我，再重新记录一下吧。

我就取数学中的定义吧。张量是多维数组的推广，比如矩阵就是2阶张量，向量是1阶张量。

## 张量轴的定义
在上述平台进行张量运算时，涉及到轴。特别是在python中，使用代码实现矩阵运算，比如：
``` python
import numpy as np
x = np.array([[1,2,3]])
x_ex = np.array([[4,5,6]])
x_result = np.concatenate((x,x_ex),axis=0) # (1)
print(x_result)
```
{.annotate}

1. 试试-1，0，1

这里`np.concatenate()`的作用是将两个张量进行拼接，需要指定`axis`。  
轴的序号遵循从外到内，逐渐递增的规则，比如上面例子中的两个张量，

- `axis=0`就是最外层括号的维度。
- `axis=1`就是内层括号的维度。
- `axis=-1`是序号最大的维度，在上面的例子中等价于`axis=1`

## 乘积
主要有两种，`dot`和`multiply`，需要注意二者的区别。

- `dot`与矩阵点乘概念相同，遵从矩阵点乘基本size要求。
需要注意，对于高于2维的Tensor之间的点乘，需要使用`tensordot`指定维度，否则会产生意想不到的结果
- `muliply`并不是叉乘，而是逐元素相乘，对于shape不同的两个张量，
遵循[广播机制](https://numpy.org/doc/stable/user/basics.broadcasting.html)

=== "Numpy"
    ``` python
    import numpy as np
    x = np.array([[[1,2,3],
                [7,8,9],
                [10,11,12]],
                [[2,2,2],
                [3,3,3],
                [4,4,4]]])
    x_ex = np.array([[1,1,1]])
    print('multiply: ',np.multiply(x_ex,x))
    print('dot: ',np.dot(x_ex,x))
    print('sum along axis0: ',np.sum(np.multiply(x_ex,x),axis=0))
    print('sum along axis1: ',np.sum(np.multiply(x_ex,x),axis=1))
    ```

=== "Paddle"
    ``` python hl_lines="10 11"
    import paddle as pdl
    x = pdl.to_tensor([[[1,2,3],
                [7,8,9],
                [10,11,12]],
                [[2,2,2],
                [3,3,3],
                [4,4,4]]])
    x_ex = pdl.to_tensor([[1,1,1]])
    print('multiply: ',pdl.multiply(x_ex,x))
    print('dot: ',pdl.dot(x[0],x[0]))
    print('dot: ',pdl.tensordot(x[0],x[0],axes=1))
    print('sum along axis0: ',pdl.sum(pdl.multiply(x_ex,x),axis=0))
    print('sum along axis1: ',pdl.sum(pdl.multiply(x_ex,x),axis=1))
    ```
    
=== "Pytorch" 
    ``` python hl_lines="10"
    import torch as th
    x = th.tensor([[[1,2,3],
                [7,8,9],
                [10,11,12]],
                [[2,2,2],
                [3,3,3],
                [4,4,4]]])
    x_ex = th.tensor([[1,1,1]])
    print('multiply: ',th.multiply(x_ex,x))
    print('dot: ',th.tensordot(x[0],x[0],dims=1))
    print('sum along axis0: ',th.sum(th.multiply(x_ex,x),axis=0))
    print('sum along axis1: ',th.sum(th.multiply(x_ex,x),axis=1))
    ```

=== "Tensorflow" 
    ``` python hl_lines="10"
    import tensorflow as tf
    x = tf.convert_to_tensor([[[1,2,3],
                [7,8,9],
                [10,11,12]],
                [[2,2,2],
                [3,3,3],
                [4,4,4]]])
    x_ex = tf.convert_to_tensor([[1,1,1]])
    print('multiply: ',tf.multiply(x_ex,x))
    print('dot: ',tf.tensordot(x[0],x[0],axes=1))
    print('sum along axis0: ',tf.reduce_sum(tf.multiply(x_ex,x),axis=0))
    print('sum along axis1: ',tf.reduce_sum(tf.multiply(x_ex,x),axis=1))
    ```

!!! warning 
    机器学习框架中的张量处理与Numpy中的张量处理不同，
    `dot`在paddle等框架中并不是矩阵点乘。请使用`tensordot`，
    并指定坐标轴来进行点乘。

## 拼接
几个平台都差不多
=== "Numpy"
    ``` python
    import numpy as np
    A = np.array([[1, 2], [3, 4]])
    B = np.array([[5, 6], [7, 8]])

    ax0_concat = np.concatenate((A, B), axis=0)
    ax1_concat = np.concatenate((A, B), axis=1)
    print(ax0_concat)
    print(ax1_concat)
    ```
=== "Paddle"
    ``` python
    import paddle as pdl
    A = pdl.to_tensor([[1, 2], [3, 4]])
    B = pdl.to_tensor([[5, 6], [7, 8]])

    ax0_concat = pdl.concat((A, B), axis=0)
    ax1_concat = pdl.concat((A, B), axis=1)
    print(ax0_concat)
    print(ax1_concat)
    ```
=== "Pytorch"
    ``` python
    import torch as th
    A = th.tensor([[1, 2], [3, 4]])
    B = th.tensor([[5, 6], [7, 8]])

    ax0_concat = th.concat((A, B), axis=0)
    ax1_concat = th.concat((A, B), axis=1)
    print(ax0_concat)
    print(ax1_concat)
    ```
=== "Tensorflow"
    ``` python
    import tensorflow as tf
    A = tf.convert_to_tensor([[1, 2], [3, 4]])
    B = tf.convert_to_tensor([[5, 6], [7, 8]])

    ax0_concat = tf.concat((A, B), axis=0)
    ax1_concat = tf.concat((A, B), axis=1)
    print(ax0_concat)
    print(ax1_concat)
    ```