# CLHS Glossary

| Abbreviation | Meaning                                    |
| :----------- | :----------------------------------------- |
| adj.         | adjective                                  |
| adv.         | adverb                                     |
| ANSI         | compatible with one or more ANSI standards |
| Comp.        | computers                                  |
| Idiom.       | idiomatic                                  |
| IEEE         | compatible with one or more IEEE standards |
| ISO          | compatible with one or more ISO standards  |
| Math.        | mathematics                                |
| Trad.        | traditional                                |
| n.           | noun                                       |
| v.           | verb                                       |
| v.t.         | transitive verb                            |

() `()` n.

符号`nil`的另一个记法, 强调`nil`表示空列表.

# absolute 绝对的 adj.

1 特定的时间点, 见[time](#time).

2 目录层次中特定位置, 见[pathname](#pathname).

见[relative](#relative)

# access 访问 n., v.t.

- 1 读或写位置的值或数组中元素的值.
- 2 尝试访问位置的值.

见[place](#place), [value](#value), [array](#array)

# accessibility 可访问性 n.

- 可访问的状态.

# accessible 可访问的 adj.

1 (对象)被引用的能力.

2 (类的实现的共享或本地槽)已在实例的类或超类中定义.

3 (包中符号)在当前包中不使用包前缀可被引用的能力, 不管符号存在于包中还是继承获得的.

见[object](#object), [instance](#instance), [symbol](#symbol)

# accessor 访问器 n.

执行访问的操作符.

见[operator](#operator), [reader](#reader), [writer](#writer)

# active

"活跃的"

adj.

1 (处理器, 重启器或捕获标签)已被建立但还未被解除

2 (数组中元素)由大于等于0但小于填充指针的索引. 对没有填充指针的数组, 所有元素被认为是获取的.

见[handler](#handler), [restart](#restart), [catch tag](#catch tag), [fill pointer](#fill pointer)

# actual adjustability

"实际可调整性"

n.

数组相关的一个广义布尔值, 标识数组是否是实际可调整的.

见[actually adjustable](#actually adjustable), [expressed adjustability](#expressed adjustability), [adjustable-array-p](../Symbols#adjustable-array-p)

# actual argument

"实参"

n. Trad.

参数.

见[argument](#argument)

"实际数组元素类型"

n.

数组实际被特化后的类型, 是数组的被表达的数组元组类型的升级的数组元素类型.

见[array](#array), [array-element-type](../Symbols#array-element-type), [expressed array element type](#expressed array element type), [upgraded array element type](#upgraded array element type)

# actual complex part type

"实际复数部分类型"

n.

复数的实部和虚部的实际表示的类型, 是复数的被表达的复数部分类型的升级的复数部分类型.

见[complext](#complext), [expressed complex part type ](#expressed complex part type ), [upgraded complex part type](#upgraded complex part type)

# actual parameter

"实参"

n. Trad.

参数.

见[argument](#argument)

# actually adjustable

"实际可调整的"

adj.

可用函数`ADJUST-ARRAY`直接修改数组特性. 需要满足: 数组被表达为可调整的 或 显式用`ADJUSTABLE-ARRY-P`测试.

见[expressly adjustable](#expressly adjustable), [adjust-array](../Symbols#adjust-array), [adjustable-array-p](../Symbols#adjustable-array-p)

# adjustability

"可调整性"

n.

1 被表达的可调整性

2 实际可调整性

见[expressed adjustability](#expressed adjustability), [actual adjustability](#actual adjustability)

# adjustable

"可调整的"

adj.

1 表达的可调整性

2 实际可调整性

见[expressly adjustable](#expressly adjustable), [actually adjustable](#actually adjustable)

# after method

":after方法"

n.

由限定符`:after`的方法.

见[method](#method), [qualifier](#qualifier)

# alist

"关联列表"

n.

关联列表.

见[association list](#association list)

# alphabetic

"字母的"

n. adj.

1 字符: 标准字符, 实现定义的字符, 图形字符

2 字符的要素特质, 见2.1.4.1和2.2

3 当前`readtable`中有语法类型要素和有要素特质的字符, 见图2-8

见[character](#character)

# alphanumeric

"字母或数字的"

adj.

字母字符或数值字符.

见[alphabetic](#alphabetic), [numeric](#numeric)

# ampersand

"&"

n.

`&`的标准字符. 见图2-5.

见[standard character](#standard character)

# anonymous

"匿名的"

adj.

1 (类或函数)没有名字

2 (重启器)有名字nil

见[mame](#name)

# apparently uninterned

"明显未内部化的"

adj.

主包为`nil`.

见[home package](#home package)

# applicable

"可应用的"

adj.

1 处理器可应用

2 方法可应用

3 重启器可应用

见[applicable handler](#applicable handler), [applicable method](#applicable method), [applicable restart](#applicable restart)

# applicable handler

"可应用的处理器"

n.

活跃处理器关联的类型包含给定条件.

见[condition](#condition), [handler](#handler)

# applicable method

"可应用的方法"

n.

广义函数的方法, 其参数满足参数特化符, 见7.6.6.1.1

见[method](#method), [parameter specializers](#parameter specializers)

# applicable restart

"可应用的重启器"

n.

1 活跃处理器关联的测试在给定条件作为参数时返回真值

2 活跃处理器关联的测试在`nil`作为参数时返回真值

见[handler](#handler)

# apply

"APPLY函数"

v.t.

使用列表中元素作为参数调用函数

见[call](#call), [function](#function)

# argument

"参数"

n.

1 作为函数被调用时的数据

2 格式控制中的格式化参数

见[function](#function), [format argument](#format argument)

# argument evaluation order

"参数求值顺序"

n.

参数在函数调用中的被求值的顺序, 见3.1

# argument precedence order

"参数优先级顺序"

n.

广义函数排序可应用的方法时考虑的参数顺序

见[applicable method](#applicable method)

# around method `:around`方法/围绕方法 n.

有限定符`:around`的方法.

见[method](#method), [qualifier](#qualifier)

# array 数组 n.

有类型`ARRAY`的对象

# array element type 数组元素类型 n.

1 数组关联的类型

2 数组的实际数据元素类型

3 数组的被表达的数组元素类型

见[actual array element type](#actual array element type), [expressed array element type](#expressed array element type)

# array total size

"数组总大小"

n.

数组中元素总数量, 按数组维度之积计算.

见[dimension](#dimension)

# assign

"赋值"

v.t.

改变已建立的绑定中变量的值.

见[binding](#binding), [variable](#variable), [setq](../Symbols#setq)

# association list

"关联列表"

n.

表示关联的键值的cons列表, 每个cons的car是键, cdr是键对应的值.

见[cons](#cons)

# asterisk

"*"

n.

标准字符`*`, 见图2-5.

# at-sign

"@"

n.

标准字符`@`, 见图2-5.

# atom

"原子"

n.

不是cons的对象

见[](#)

# atomic

"原子的"

adj.

原子的.

见[atom](#atom)

# atomic type specifier

"原子类型描述符"

n.

对每个原子类型描述符`x`, 存在一个等价的的复合类型描述符`(x)`

见[compound type specifier](#compound type specifier)

# attribute

"属性"

n.

字符的程序可见的方面, 字符的标准属性是其编码, 见13.1.3

见[code](#code)

# aux variable

"辅助变量"

n.

在lambda列表中由`&aux`引入的变量, 辅助变量不是参数.

见[lambda list](#lambda list)

# auxiliary method

"辅助方法"

n.

构成方法对应的广义函数的完备方法集合中的一个方法.

见[primary methods](#primary methods), [method combination](#method combination)

"\\"

n.

`\`, 称为逆斜线(reverse solidus)或反斜线(backslash). 见图2-5.

# base character

# base string

# before method

# bidirectional

# binary

# bind

# binding

# bit

# bit array

# bit vector

# bit-wise logical operation specifier

# block

# block tag

# boa lambda list

# body parameter

# boolean

# boolean equivalent

# bound

# bound declaration

# bounded

# bounding index

# bounding index designator

# break loop

# broadcast stream

# built-in class

# built-in type

# byte

# byte specifier

# cadr

# call

# captured initialization form

# car

# case

# case sensitivity mode

# catch

# catch tag

# cddr

# cdr

# cell

# character

# character code

# character designator

# circular

# circular list

# class

# class designator

# class precedence list

# close

# closed

# closure

# coalesce

# code

# coerce

# colon

# comma

# compilation

# compilation environment

# compilation unit

# compile

# compile time

# compile-time definition

# compiled code

# compiled file

# compiled function

# compiler

# compiler macro

# compiler macro expansion

# compiler macro form

# compiler macro function

# complex

# complex float

# complex part type

# complex rational

# complex single float

# composite stream

# compound form

# compound type specifier

# concatenated stream

# condition

# condition designator

# condition handler

# condition reporter

# conditional newline

# conformance

# conforming code

# conforming implementation

# conforming processor

# conforming program

# congruent

# cons

# constant

# constant form

# constant object

# constant variable

# constituent

# constituent trait

# constructed stream

# contagion

# continuable

# control form

# copy

# correctable

# current input base

# current logical block

# current output base

# current package

# current pprint dispatch table

# current random state

# current readtable

# data type

# debug I/O

# debugger

# declaration

# declaration identifier

# declaration specifier

# declare

# decline

# decoded time

# default method

# defaulted initialization argument list

# define-method-combination arguments lambda list

# define-modify-macro lambda list

# defined name

# defining form

# defsetf lambda list

# deftype lambda list

# denormalized

# derived type

# derived type specifier

# designator 指示器 n.

一个表示另一个对象的对象.

在操作符的目录项中, 如果一个参数被描述为一个类型的指示器, 该操作符的描述中假设已经有到该类型的恰当的转型(coercion), 即该参数已有该类型. 更多信息见 1.4.1.5 指示器 .

# destructive

# destructuring lambda list

# different

# digit

# dimension

# direct instance

# direct subclass

# direct superclass

# disestablish

# disjoint

# dispatching macro character

# displaced array

# distinct

# documentation string

# dot

# dotted list

# dotted pair

# double float

# double-quote

# dynamic binding

# dynamic environment

# dynamic extent

# dynamic scope

# dynamic variable

# echo stream

# effective method

# element

# element type

# em

# empty list

# empty type

# end of file

# environment

# environment object

# environment parameter

# error

# error output

# escape

# establish

# evaluate

# evaluation

# evaluation environment

# execute

# execution time

# exhaustive partition

# exhaustive union

# exit point

# explicit return

# explicit use

# exponent marker

# Marker Meaning

# D or d double-float

# E or e float (see *read-default-float-format*)

# F or f single-float

# L or l long-float

# S or s short-float

# export

# exported

# expressed adjustability

# expressed array element type

# expressed complex part type

# expression

# expressly adjustable

# extended character

# extended function designator

# extended lambda list

# extension

# extent

# external file format

# external file format designator

# external symbol

# externalizable object

# false

# fbound

# feature

# feature expression

# features list

# file

# file compiler

# file position

# file position designator

# file stream

# file system

# filename

# fill pointer

# finite

# fixnum

# float

# for-value

# form

n.

1 要被求值的对象.

2 一个符号, 一个复合形式或一个自求值对象.

3 一个复合形式, 首元素是操作符, 例如`quote`形式是个常量形式.

见[symbol](#symbol), [compound form](#compound form), [self-evaluating object](#self-evaluating object), [operator](#operator).

# formal argument

# formal parameter

# format

# format argument

# format control

# format directive

# format string

# free declaration

# fresh

# freshline

# funbound

# function

# function block name

# function cell

# function designator

# function form

# function name

# functional evaluation

# functional value

# further compilation

# general

# generalized boolean

# generalized instance

# generalized reference

# generalized synonym stream

# generic function

# generic function lambda list

# gensym

# global declaration

# global environment

# global variable

# glyph

# go

# go point

# go tag

# graphic

# handle

# handler

# hash table

# home package

# I/O customization variable

```
*debug-io*        *error-io*         query-io*
*standard-input*  *standard-output*  *trace-output*
```

# identical

# identifier

# immutable

# implementation

# implementation limit

# implementation-defined

# implementation-dependent

# implementation-independent

# implicit block

# implicit compilation

# implicit progn

# implicit tagbody

# import

# improper list

# inaccessible

# indefinite extent

# indefinite scope

# indicator

# indirect instance

# inherit

# initial pprint dispatch table

# initial readtable

# initialization argument list

# initialization form

# input

# instance

# integer

# interactive stream

# intern

# internal symbol

# internal time

# internal time unit

# interned

# interpreted function

# interpreted implementation

# interval designator

# invalid

# iteration form

# iteration variable

# key

# keyword

# keyword parameter

# keyword/value pair

# lambda combination

# lambda expression

# lambda form

# lambda list

# lambda list keyword

# lambda variable

# leaf

# leap seconds

# left-parenthesis

# length

# lexical binding

# lexical closure

# lexical environment

# lexical scope

# lexical variable

# Lisp image Lisp镜像 n.

一个Common Lisp实现的运行实例. Lisp镜像时一个单一的地址空间, 其中每个对象可以通过单一的通用的全局环境, 直接引用符合该规范的其它对象.

外部操作系统称其为核心镜像(core image)、fork、化身(incarnation)、作业或进程. 注意操作系统中的进程与这里定义的Lisp镜像技术上是正交的. 在操作系统中, 单个进程可以有多个Lisp镜像, 多个进程也可以在单一Lisp镜像中. 因此, Lisp镜像的特征是一个完全共享的地址空间, 所有对象可以之间相互引用. 注意, 两个通过通信机制允许共享部分但不是全部对象的进程, 被视为不同的Lisp镜像.

# Lisp printer

# Lisp read-eval-print loop

# Lisp reader Lisp读取器 n. Trad.

从流中解析对象的字符表示, 生成对象的过程. 该过程由函数`read`实现.

# list

# list designator

# list structure

# literal

# load

# load time

# load time value

# loader

# local declaration

# local precedence order

# local slot

# logical block

# logical host

# logical host designator

# logical pathname

# long float

# loop keyword

# lowercase

# macro

n.

1 一个宏形式.

2 一个宏函数.

3 一个宏的名称.

见[macro form](#macro form), [macro function](#macro function), [macro name](#macro name).

# macro character

n.

一个字符, 当Lisp读取器在其主分发循环中遇到时, 引入读取器宏.

宏字符与宏没有关系.

见[](#)

# macro expansion

n.

1 将宏形式转换为另一个形式的过程.

2 作为该过程结果产生的宏.

见[reader macro](#reader macro).

# macro form

n.

代表另一个形式的形式(为了抽象、信息隐藏、语法遍历), 即或者是首元素为宏名称的复合形式, 或者是一个命名了符号宏的符号的形式.

见[compound form](#compound form), [macro name](#macro name), [symbol macro](#symbol macro).

# macro function

n.

一个有两个参数的函数: 形式和环境, 这个函数实现了宏扩展, 生成作为原始参数的形式求值后的形式.

见[form](#form), [environment](#environment), [macro expansion](#macro expansion).

# macro lambda list

n.

用在形式中以建立宏定义的扩展的lambda列表, 例如`defmacro`、`macrolet`.

见[3.4.4 宏lambda列表](../03-Evaluation-and-Compilation#3.4.4)

# macro name

n.

一个名称, 作为`macro-function`参数时返回true,

用在复合形式的首元素处, 标识该形式为宏形式.

见[macro-function](../Symbols#macro-function), [macro form](#macro form).

# macroexpand hook

n.

`*macroexpand-hook*`的值对应的函数.

见[`*macroexpand-hook*`](../Symbols#*macroexpand-hook*)

# mapping

# metaclass

# Metaobject Protocol

# method

# method combination

# method-defining form

# method-defining operator

# minimal compilation

# modified lambda list

# most recent

# multiple escape

# multiple values

# name

# named constant

# namespace

# namestring

# newline

# next method

# nickname

# nil

# non-atomic

# non-constant variable

# non-correctable

# non-empty

# non-generic function

# non-graphic

# non-list

# non-local exit

# non-nil

# non-null lexical environment

# non-simple

# non-terminating

# non-top-level form

# normal return

# normalized

# null

# null lexical environment

# number

# numeric

# object

# object-traversing

# open

# operator

# optimize quality

# optional parameter

# ordinary function

# ordinary lambda list

# otherwise inaccessible part

# output

# package

# package cell

# package designator

# package marker

# package prefix

# package registry

# pairwise

# parallel

# parameter

# parameter specializer

# parameter specializer name

# pathname

# pathname designator

# physical pathname

# place

# plist

# portable

# potential copy

# potential number

"可能的数值"

n.

在一些符合标准的实现中被Lisp读取器解析为数值的文本内容, 但不要求被解析为数值.

没有对象是可能的数值: 一个对象或者是数值, 或者不是, 见[2.3.1.1 可能的数值的记号](../02-Syntax#2.3.1.1).

见[number](#number)

# pprint dispatch table

# predicate

# present

# pretty print

# pretty printer

# pretty printing stream

# primary method

# primary value

# principal

# print name

# printer control variable

# printer escaping

# printing

# process

# processor

# proclaim

# proclamation

# prog tag

# program

# programmer

# programmer code

# proper list

# proper name

# proper sequence

# proper subtype

# property

# property indicator

# property list

# property value

# purports to conform

# qualified method

# qualifier

# query I/O

# quoted object

# radix

# random state

# rank

# ratio

# ratio marker

# rational

# read

# readably

# reader

# reader macro

# reader macro function

# readtable

# readtable case

# readtable designator

# recognizable subtype

# reference

# registered package

# relative

# repertoire

# report

# report message

# required parameter

# rest list

# rest parameter

# restart

# restart designator

# restart function

```
# abort     muffle-warning  use-value
# continue  store-value
```

# return

# return value

# right-parenthesis

# Rubout

n.

删除字符.

见[13.1.7 字符名称](../13-Characters#13.1.7)

# run time

# run-time compiler

# run-time definition

# run-time environment

# safe

# safe call

# same

# satisfy the test

# scope

# script

# secondary value

# section

# self-evaluating object

# semi-standard

# semicolon

# sequence

# sequence function

# sequential

# sequentially

# serious condition

# session

# set

# setf expander

# setf expansion

# setf function

# setf function name

# shadow

# shadowing symbol

# shadowing symbols list

# shared slot

# sharpsign

"#"

n.

井号符号. 见图2-5.

见[standard character](#standard character)

# short float

# sign

# signal

# signature

# similar

# similarity

# simple

# simple array

# simple bit array

# simple bit vector

# simple condition

# simple general vector

# simple string

# simple vector

# single escape

# single float

# single-quote

# singleton

# situation

# slash

# slot

# slot specifier

# source code

# source file

# space

# special form

# n

不是宏形式的一个列表, 是一个有特殊语法或特殊求值规则形式, 可能操作求值环境或控制流.

特殊形式的首个元素是特殊操作符.

见[form](#form), [macro form](#macro form), [evaluation](#evaluation), [special operator](#special operator).

# special operator

图3-2中列举的一组固定符号, 出现在形式的car中将该形式标识为特殊形式..

见[symbol](#symbol), [special form](#special form).

# special variable

# specialize

# specialized

# specialized lambda list

# spreadable argument list designator

# stack allocate

# stack-allocated

# standard character

# standard class

# standard generic function a function of type standard-generic-function.

# standard input

# standard method combination

# standard object

# standard output

# standard pprint dispatch table

# standard readtable

# standard syntax

# standardized

# startup environment

# step

# stream

# stream associated with a file

# stream designator

# stream element type

# stream variable

# stream variable designator

# string

# string designator

# string equal

# string stream

# structure

# structure class

# structure name

# style warning

# subclass

# subexpression

# subform

# subrepertoire

# subtype

# superclass

# supertype

# supplied-p parameter

# symbol

# symbol macro

# synonym stream

# synonym stream symbol

# syntax type

# system class

# system code

# t

# tag

# tail

# target

# terminal I/O

# terminating

# tertiary value

# throw

# tilde

# time

# time zone

# token

"记号"

数值或符号的文本表示. 见[2.3 解释记号](../02-Syntax#2.3)

见[number](#number), [symbol](#symbol)

# top level form

# trace output

# tree

# tree structure

# true

# truename

# two-way stream

# type

# type declaration

# type equivalent

# type expand

# type specifier

# unbound

# unbound variable

# undefined function

# unintern

# uninterned

# universal time

# unqualified method

# unregistered package

# unsafe

# unsafe call

# upgrade

# upgraded array element type

# upgraded complex part type

# uppercase

# use

# use list

# user

# valid array dimension

# valid array index

# valid array row-major index

# valid fill pointer

# valid logical pathname host

# valid pathname device

# valid pathname directory

# valid pathname host

# valid pathname name

# valid pathname type

# valid pathname version

# valid physical pathname host

# valid sequence index

# value

# value cell

# variable

# vector

# vertical-bar

"|"

n.

`|`, 称为竖线的标准字符.

见[](#)

# whitespace

# wild

# write

# writer

# yield