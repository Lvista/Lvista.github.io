---
comments: true
slug: py_doc
title: "Python"
date: 2025-02-24
---
# Python

这里记录一些关于python的笔记

## Decorators
> See: https://book.pythontips.com/en/latest/decorators.html#decorators

### 基本知识
在python中，函数是可以被视为变量传递的

``` python
def hi(name="yasoob"):
    def greet():
        return "now you are in the greet() function"

    def welcome():
        return "now you are in the welcome() function"

    if name == "yasoob":
        return greet
    else:
        return welcome

a = hi()
print(a)
#outputs: <function greet at 0x7f2143c01500>

#This clearly shows that `a` now points to the greet() function in hi()
#Now try this

print(a())
#outputs: now you are in the greet() function
```

### Decorators

- Decorators类似于override，正如名字所示，主要作用是“包装”。
- 使用functools的`wraps`可以避免“签名”被覆盖的问题。

=== "不引入functools"
    ``` python
    def new_decorator(fun):
        def wrap(name):
            print("Before function call")
            fun(name)
            print("After function call")
        return wrap

    @new_decorator
    def func(name):
        print("Hello", name)

    func("Bob")
    print(func.__name__)
    ```
=== "引入functools"
    ``` python hl_lines="1 3"
    from functools import wraps
    def new_decorator(fun):
        @wraps(fun)
        def wrap(name):
            print("Before function call")
            fun(name)
            print("After function call")
        return wrap

    @new_decorator
    def func(name):
        print("Hello", name)

    func("Bob")
    print(func.__name__)
    ```

### 嵌套函数的Decorators

``` python hl_lines="14"
from functools import wraps
def new_decorator(log_file_name = "log2"):
    def logging(fun):
        @warps(fun)
        def wrap(name):
            with open(log_file_name, "a") as f:
                f.write("Before function call\n")
            fun(name)
            with open(log_file_name, "a") as f:
                f.write("After function call\n")
        return wrap
    return logging

@new_decorator("log1")
def func(name):
    print("Hello", name)
```

### Decorator Classes

因为decorator的本质其实是将函数以参数进行传递，所以用class也能构建一个decorator

``` python
class logit(object):

    _logfile = 'out.log'

    def __init__(self, func):
        self.func = func

    def __call__(self, *args):
        log_string = self.func.__name__ + " was called"
        print(log_string)
        # Open the logfile and append
        with open(self._logfile, 'a') as opened_file:
            # Now we log to the specified logfile
            opened_file.write(log_string + '\n')
        # Now, send a notification
        self.notify()

        # return base func
        return self.func(*args)

    def notify(self):
        # logit only logs, no more
        pass

class email_logit(logit):
    '''
    A logit implementation for sending emails to admins
    when the function is called.
    '''
    def __init__(self, func, email='admin@myproject.com'):
        self.email = email
        super(email_logit, self).__init__(func)

    def notify(self):
        # Send an email to self.email
        # Will not be implemented here
        pass

logit._logfile = 'out2.log' # if change log file
@logit
def myfunc1():
    pass

myfunc1()
# Output: myfunc1 was called

@email_logit
def myfunc1():
    pass

myfunc1()
```