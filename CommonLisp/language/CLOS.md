# CLOS: Common Lisp Object System

[CLOS: Common Lisp Object System](https://www.cliki.net/CLOS)

The Common Lisp Object System is based on generic functions, multiple inheritance, and declarative method combination. Many implementations also have a meta-object protocol, or MOP, often based on that described in AMOP

[MOP: Meta Object Protocol](https://www.cliki.net/mop)

Meta Object Protocol(MOP) is a protocol for describing CLOS itself as an extensible CLOS program. In this description, the fundamental elements of CLOS programs (classes, slot definitions, generic functions, methods, specializers and method combinations) are represented by first-class objects. The behavior of CLOS is provided by these objects, or, more precisely, by methods specialized to the classes of these objects.

Because these objects represent pieces of CLOS programs, and because their behavior provides the behavior of the CLOS language itself, they are considered meta-level objects or metaobjects. The protocol followed by the metaobjects to provide the behavior of CLOS is called the CLOS Metaobject Protocol (MOP).

# Terminology

- 面向对象编程(Object-Oriented Programming(OOP))
- 类(Class)和实例(Instance)
- 槽(Slot)
- 超类(Superclasses)
- 类优先级列表(Class Precedence List)
- 广义函数(Generic Function)
    - 方法(Method)
    - 方法特化(Method Specialization)
    - 可应用方法(Applicable Methods)
    - 主方法(Primary Method)
    - 辅助方法(Auxiliary Method): 之前(before), 之后(after), 围绕(around)
    - 方法组合(Method Combination)
        - 标准方法组合(Standard Method Combination)
        - 操作符方法组合(Operator Method Combination)
- 类型(Type)
- 类型声明(Type Declaration)
    - 类型描述符(Type Specifier)

# 类和实例

- 创建新类: defclass
- 创建类的实例: make-instance
- 访问实例的槽: slot-value, `(setf (slot-value <instance> '<slot-name>) <value>)`

槽的属性:

- 访问器: 读`:reader`, 写`:writer`, 访问`:accessor`.
- 初始化: 初始化参数名称`:initarg`, 初始值形式`:initform`.
- 存储分配: `:allocation`, 值有实例`:instance`和类`:class`.
- 文档字符串: `:documentation`.
- 值的类型: `:type`.

超类: 在`defclass`的第二个参数中指定超类的列表. 不指定时默认为`(standard-object t)`.

类的优先级列表: 从最特殊到最不特殊的顺序.

# 广义函数

广义函数由一个或多个方法组成.

- 定义方法: `defmethod`.
- 方法特化: 方法的特化指定它可以应用的参数的类别.
    - 特化于类
    - 特化于类型
    - 特化于独立对象
- 可应用方法: 调用广义函数时, 传入的参数确定了一个或多个可应用的方法.
    - 没有可应用方法: 抛出错误.
    - 只有一个可应用方法: 直接调用.
    - 有多个可应用方法: 调用最特殊的那个.

# 方法组合

- 主方法: 上面定义的方法.
- 辅助方法: `:before`, `:after`, `:around`.
    - around方法和主方法可以使用`call-next-method`调用主方法.
    - around方法和主方法可以使用`next-method-p`测试后续是否有方法可以调用.

**标准方法组合**, 调用广义函数时调用顺序:

1. 最特殊的around方法, 如果有的话.
2. 否则, 按如下顺序:
    1. 所有before方法, 从最特殊到最不特殊.
    2. 最特殊的主方法.
    3. 所有after方法, 从最不特殊到最特殊.

**操作符方法组合**:

- 免除了标准方法组合中只有最特殊的主方法可被调用的限制.
- 一旦指定了广义函数使用的方法组合, 该广义函数的所有方法只能使用同一类别的方法组合.

操作符方法组合调用顺序:

- 没有可应用的around方法时:

```
(<operator> (apply <最特殊的主方法> <args>)
            ...
            (apply <最不特殊的主方法> <args>))
```

- 有可应用的around方法时:
    - around方法可以使用`call-next-method`调用下一个方法.
    - 主方法中不能使用`call-next-method`.

可用于`defmethod`第二个参数或`defgeneric`的`:method-combination`选项的符号:

```
+ and append list max min nconc or progn
```

# 类型

Common Lisp使用了清单类型(manifest typing):

- 值有类型, 变量没有类型.
- 变量可以持有任意类型的对象.

清单类型(manifest typing)

类型信息被附加到数据对象上.

运行时类型(run-time typing)

类型信息在运行时使用.

两者表示同一个事情.

在Common Lisp中, 类型不是对象. 顶级类型: `t`.

定义类型: `deftype`.

## 类型声明

在Common Lisp中类型声明是可选的.

- 全局声明: `declaim`.
- 局部声明: `declare`.
- 声明表达式的值的类型: `the`.
- 指定数组的元素类型: `:element-type`.

## 类型描述符

- 类型描述符是类型的名称.
- `type-of`的返回值, `typep`的参数不是类型, 而是类型描述符.

类型描述符的种类: 参考 4.2.3 类型描述符 .

- 标准原子类型描述符
- 标准组合类型描述符
    - 未指定的次要项(subsidiary items)用`*`表明.
- 自定义类型描述符: 使用defclass, define-condition, defstruct, deftype.

# See Also
* Common Lisp: The Language > Chapter 28 Common Lisp Object System
* CLHS 4 Types and Classes, 7 Objects
* ANSI Common Lisp > Chapter 11 CLOS
* On Lisp > 25 Object-Oriented Lisp
* Object-Oriented Programming in Common Lisp: A Programmer's Guide to CLOS
* The Art of the Metaobject Protocol(AMOP)
* [Common Lisp Object System Metaobject Protocol](https://clos-mop.hexstreamsoft.com/)