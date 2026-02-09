# CLHS: Common Lisp HyperSpec
* https://www.lispworks.com/documentation/common-lisp.html

> The specification set forth in this document is designed to promote the portability of Common Lisp programs among a variety of data processing systems. It is a language specification aimed at an audience of implementors and knowledgeable programmers. It is neither a tutorial nor an implementation guide.

# Contents

* 1 介绍 Introduction
* 2 语法 Syntax
* 3 求值和编译 Evaluation and Compilation
* 4 类型和类 Types and Classes
* 5 数据和控制流 Data and Control Flow
* 6 迭代 Iteration
* 7 对象 Objects
* 8 结构 Structures
* 9 状况 Conditions
* 10 符号 Symbols
* 11 包 Packages
* 12 数值 Numbers
* 13 字符 Characters
* 14 Conses
* 15 数组 Arrays
* 16 字符串 Strings
* 17 序列 Sequences
* 18 哈希表 Hash Tables
* 19 文件名 Filenames
* 20 文件 Files
* 21 流 Streams
* 22 打印器 Printer
* 23 读取器 Reader
* 24 系统构造 System Construction
* 25 环境 Environment
* [Glossary](./CLHS.Symbols.md)
* [Symbols](./CLHS.Symbols.md)

# 1 介绍

## 1.1 范围, 意图和历史

> TODO(zhoujiagen) 1.1 Scope, Purpose, and History

## 1.2 文档的组织

该文档使用的记号约定, 见**1.4 定义**.

标准符合性的信息, 见**1.5 标准符合性**.

语言扩展和子集的信息, 见**1.6 语言扩展**和**1.7 语言子集**.

关于程序如何被Lisp reader解析的信息, 见**2 语法**.

关于程序如何被编译和执行的信息, 见**3 求值和编译**.

关于数据类型的信息, 见**4 类型和类**; 这一章没有定义所有的类型和类, 例如**12 数值**中定义了数值类型. 图4-2给出了标准类型的完整列表.

关于通用的控制和数据流的信息, 见**5 数据和控制流**或**6 迭代**

## 1.3 引用的出版物

- The Anatomy of Lisp, John Allen, McGraw-Hill, Inc., 1978.
- The Art of Computer Programming, Volume 3, Donald E. Knuth, Addison-Wesley Company (Reading, MA), 1973.
- The Art of the Metaobject Protocol, Kiczales et al., MIT Press (Cambridge, MA), 1991.
- Common Lisp Object System Specification, D. Bobrow, L. DiMichiel, R.P. Gabriel, S. Keene, G. Kiczales, D. Moon, SIGPLAN Notices V23, September, 1988.
- Common Lisp: The Language, Guy L. Steele Jr., Digital Press (Burlington, MA), 1984.
- Common Lisp: The Language, Second Edition, Guy L. Steele Jr., Digital Press (Bedford, MA), 1990.
- Exceptional Situations in Lisp, Kent M. Pitman, Proceedings of the First European Conference on the Practical Application of LISP (EUROPAL '90), Churchill College, Cambridge, England, March 27-29, 1990.
- Flavors: A Non-Hierarchical Approach to Object-Oriented Programming, Howard I. Cannon, 1982.
- IEEE Standard for Binary Floating-Point Arithmetic, ANSI/IEEE Std 754-1985, Institute of Electrical and Electronics Engineers, Inc. (New York), 1985.
- IEEE Standard for the Scheme Programming Language, IEEE Std 1178-1990, Institute of Electrical and Electronic Engineers, Inc. (New York), 1991.
- Interlisp Reference Manual, Third Revision, Teitelman, Warren, et al, Xerox Palo Alto Research Center (Palo Alto, CA), 1978.
- ISO 6937/2, Information processing—Coded character sets for text communication—Part 2: Latin alphabetic and non-alphabetic graphic characters, ISO, 1983.
- Lisp 1.5 Programmer's Manual, John McCarthy, MIT Press (Cambridge, MA), August, 1962.
- Lisp Machine Manual, D.L. Weinreb and D.A. Moon, Artificial Intelligence Laboratory, MIT (Cambridge, MA), July, 1981.
- Maclisp Reference Manual, Revision 0, David A. Moon, Project MAC (Laboratory for Computer Science), MIT (Cambridge, MA), March, 1974.
- NIL—A Perspective, JonL White, Macsyma User's Conference, 1979.
- Performance and Evaluation of Lisp Programs, Richard P. Gabriel, MIT Press (Cambridge, MA), 1985.
- Principal Values and Branch Cuts in Complex APL, Paul Penfield Jr., APL 81 Conference Proceedings, ACM SIGAPL (San Francisco, September 1981), 248-256. Proceedings published as APL Quote Quad 12, 1 (September 1981).
- The Revised Maclisp Manual, Kent M. Pitman, Technical Report 295, Laboratory for Computer Science, MIT (Cambridge, MA), May 1983.
- Revised^3 Report on the Algorithmic Language Scheme, Jonathan Rees and William Clinger (editors), SIGPLAN Notices V21, #12, December, 1986.
- S-1 Common Lisp Implementation, R.A. Brooks, R.P. Gabriel, and G.L. Steele, Conference Record of the 1982 ACM Symposium on Lisp and Functional Programming, 108-113, 1982.
- Smalltalk-80: The Language and its Implementation, A. Goldberg and D. Robson, Addison-Wesley Company, 1983.
- Standard LISP Report, J.B. Marti, A.C. Hearn, M.L. Griss, and C. Griss, SIGPLAN Notices V14, #10, October, 1979.
- Webster's Third New International Dictionary the English Language, Unabridged, Merriam Webster (Springfield, MA), 1986.
- XP: A Common Lisp Pretty Printing System, R.C. Waters, Memo 1102a, Artificial Intelligence Laboratory, MIT (Cambridge, MA), September 1989.

## 1.4 定义

### 1.4.1 标记约定

#### 1.4.1.1 字体说明

| 符号   | 说明                              |
| ------ | --------------------------------- |
| name   | 术语                              |
| `name` | `COMMON-LISP`包中出现的符号, 代码 |

#### 1.4.1.2 修改的BNF语法

该规范使用扩展的BNF描述Common Lisp中宏形式和特殊形式的语法. 这一部分讨论BNF表达式的语法.

##### 1.4.1.2.1 粘接(Splicing)

最主要的扩展是: `[[O]]`. 这种形式的表达式在一组元素被粘接入一个较大结构时出现, 这些元素可以按任意顺序出现.

符号`O`表示一些数量的被粘接的句法元素的语法描述; 这一描述必须具有形式: `O1 | ... | Ol`, 其中每个`Oi`可以是形式`S`或`S*`或`{S}1`.

表达式`[[O]]`的含义是一组形式`Oi1...Oij`(`1 <= j`)被粘接入外围包裹的表达式, 使得如果`n /= m`, `1 <= n,m <= j`, 则`Oin /= Oim`或者`Oin = Oim = Qk`, 这里`1 <= k <= n`, `Ok`有形式`Qk*`. 此外, 对每个有形式`{Qk}1`的`Oin`, `Oin`必须出现在被粘接的列表中.

例如表达式`(x [[A | B* | C]] y)`的含义是最多一个`A`、任意数量的`B`和最多一个`C`可以按任意顺序出现. 是下列表达式的描述:

```
(x y)
(x B A C y)
(x A B B B B B C y)
(x C B A B B B y)
```

但不是这些表达式的描述:

```
(x B B A A C C y) ; A出现过多
(x C B C y)       ; C出现过多
```

记法`[[O1 | O2 | ...]]+`添加额外约束: 至少一项必须被使用. 例如: `(x [[A | B* | C]]+ y)`的含义是, 最多一个`A`、任意数量的`B`和最多一个`C`可以按任意顺序出现, 但至少选择其中一个选项. 是下列表达式的描述:

```
(x B y)
(x B A C y)
(x A B B B B B C y)
(x C B A B B B y)
```

但不是这些表达式的描述:

```
(x y)             ; 没有使用选项
(x B B A A C C y) ; A和C出现过多
(x C B C y)       ; C出现过多
```

表达式`(x [[{A}1 | {B}1 | C]] y)`只可以描述这些:

```
(x A B C y)
(x A C B y)
(x A B y)
(x B A C y)
(x B C A y)
(x B A y)
(x C A B y)
(x C B A y)
```

##### 1.4.1.2.2 间接(Indirection)

引入间接扩展是为了使得这种新语法更可读: `O`

如果`O`是非终结符, 其定义的右部分可以替换整个表达式`O`.

例如下面的BNF等价于前一个示例中的BNF

```
(x [[O]] y)
O ::= A | B* | C
```

##### 1.4.1.2.3 间接定义的额外使用

在一些案例中, BNF中的辅助定义可能在BNF中未被使用, 但在其他地方可能有用.

例如, 考虑如下定义:

case keyform {normal-clause}* [otherwise-calues] => result* ccase keyplace {normal-clause}* => result* ecase keyform {normal-clause}* => result* normal-caluse ::= (key form*) otherwise-caluse ::= ({otherwise | t} form*) clause ::= normal-cluase | otherwise-clause

这里`clause`项看上去并未在BNF中使用过, 但BNF的用途不仅仅是指导解析, 同时还定义了可在后续描述性文本中引用的项. 这样,`clause`项可以在后续文本中徐出现, 作为`normal-clause`或`otherwise-clause`的简写.

#### 1.4.1.3 特殊符号

这里描述的特殊符号在该文档中作为符号约定使用, 不是Common Lisp语言或其环境的一部分.

##### 1.4.1.3.1 `=>` 求值

例如:

(+ 4 5) => 9

表示求值形式`(+ 4 5)`的结果为`9`.

如果一个形式返回多值, 这些值可以按空格、行或逗号分隔. 例如:

(truncate 7 5) => 1 2 (truncate 7 5) => 1 2 (truncate 7 5) => 1, 2

上面的三个示例是等价的, 描述`(truncate 7 5)`返回两个值: `1`和`2`.

##### 1.4.1.3.2 `OR=>` 几个可选结果中的一个

示例:

(char-name #\a) => NIL OR=> "LOWERCASE-a" OR=> "Small-A" OR=> "LA01"

指出`nil`、`"LOWERCASE-a"`、`"Small-A"`、`"LA01"`是`(char-name #\a)`的可能结果. 除非特别指出, 否则不应该假设这些可能的结果是完备的. 形式的说, 上面的实例等价于

(char-name #\a) => implementation-depdendent

但其提供了展示被允许的实现差异的额外信息.

##### 1.4.1.3.3 `NOT=>` 不可能的结果

`NOT=>`可被用于强调预期的错误理解可以引导读者不会认同产生的结果的情况. 例如:

(function-lambda-expression (funcall #'(lambda (x) #'(lambda () x)) nil)) => NIL, true, NIL OR=> (LAMBDA () X), true, NIL NOT=> NIL, false, NIL NOT=> (LAMBDA () X), false, NIL

##### 1.4.1.3.4 `==` 代码等价

例如:

(gcd x (gcd y z)) == (gcd (gcd x y) z)

其含义是对任意的`x`、`y`、`z`, 求值形式`(gcd x (gcd y z))`的结果和可观察的副作用总是与`(gcd (gcd x y) z)`的结果和可观察的副作用相同.

##### 1.4.1.3.5 `>>` 指示输入和输出

Common Lisp按非交互式流模型描述输入和输出. 交互式输入输出如何映射到非交互式模型的特定细节是由实现定义的.

例如复合标准的实现被允许在交互输入如何结束这一问题上存在差异. 例如函数`read`在非交互式流中键入最终的定界符时终止. 在一些实现中, 交互式的调用`read`在最终定界符键入后立即返回, 甚至定界符不是新行符号时也是这样. 在其他实现中, 总是需要最终的新行符号. 在另外的一些实现中, 可能存在一个激活输入缓冲区已满的命令, 该命令在程序输入流中不可见.

在该文档的示例中, 在有交互式输入和输出出现时, 记号`>>`出现在行首.

例如:

```
(+ 1 (print (+ (sqrt (read)) (sqrt (read)))))
>>  9 16
>>  7
=>  8
```

展示了一个交互, 其中`(+ 1 (print (+ (sqrt (read)) (sqrt (read)))))`是被求值的形式, `9 16`是交互式输入, `7`是交互式输出, `8`是求值产生的值.

一些情况下, 非交互式流需要新行符号. 新行符号字符如何被交互式的键入是用户接口的实现定义的细节, 可以使用标记`<Newline>`或`<NEWLINE>`表示.

```
(progn (format t "~&Who? ") (read-line))
>>  Who? Fred, Mary, and Sally<NEWLINE>
=>  "Fred, Mary, and Sally", false
```

#### 1.4.1.4 有多个记法的对象

Common Lisp中一些对象可以用多于一种的方式标记. 在这样的情况中, 选用何种标记是技术自由的, 但可能存在观点或意图方面的约定.

##### 1.4.1.4.1 符号的大小写

Lisp读取器尽管在处理符号内部化(interning)时是却分大小写的, 但默认在内部化之前尝试规范化, 见**23.1.2 Lisp读取器中readtable大小写的作用**. 从而符号中大小写是默认不区分的. 在该文档中, 除非特别指出, 符号是不区分大小写的; 即`HELLO`、`Hello`、`HelLo`和`hello`均表示名称为`HELLO`的符号.

字符`\`和`|`用于显式的引述字符的大小写和其他解析相关方面. 记法`|hello|`和`\h\e\l\l\o`均表示名称为`hello`的符号, 这个符号与名称为`HELLO`的符号不同.

与Common Lisp已定义名称相关的符号有大写的名称, 但在该文档中以小写形式出现.

##### 1.4.1.4.2 数值

尽管Common Lisp提供了编程处理输入和输出有理数基数的多种方法, 除非特别说明, 该文档中的所有数值使用十进制记法.

##### 1.4.1.4.3 `.`的使用

`.`可以在表达式中出现, 例如:

(item1 item2 . tail)

其含义是`tail`表示一个列表尾部的对象的列表. 例如 `(A B C . (D E F))`与`(A B C D E F)`是记法上等价的.

尽管`.`是有效的符号中字符要素, 但不在标准符号中出现, 所以该文档的语句中如果在符号后出现`.`, 不将其作为符号名称的一部分解释. 例如 "这个示例语句引用了符号car.", 其中符号名称为`CAR`而不是`CAR.`.

##### 1.4.1.4.4 `NIL`

`nil`有多种含义. 它是在`COMMON-LISP`包中的一个名称为`NIL`的符号、布尔值(广义布尔值)false、空列表、空类型的名称.

在Common Lisp中, `nil`可以记为`NIL`或者`()`. 通常记法的选择提供了其扮演角色的暗示.

图 1-1. NIL的记法.

| 求值? | 记法   |   扮演的角色 |
| :---- | :----- | -----------: |
| Yes   | `nil`  |       布尔值 |
| Yes   | `'nil` |         符号 |
| Yes   | `'()`  |       空列表 |
| No    | `nil`  | 符号或布尔值 |
| No    | `()`   |       空列表 |

在该文档中, `nil`有时作为布尔值false. 例如:

```
(print ())                          ; 应该避免
(defun three nil 3)                 ; 应该避免
'(nil nil)                          ; 两个符号的列表
'(() ())                            ; 空列表的列表
(defun three () 3)                  ; 强调: 空参数列表.
(append '() '()) =>  ()             ; 强调: 使用空列表.
(not nil) =>  true                  ; 强调: 使用布尔值false.
(get 'nil 'color)                   ; 强调: 使用符号.
```

函数有时在特定环境中被称为false或true. 因没有函数对象与`nil`相同, 所有函数对象在布尔值视角表示true, 而在字面量视角称为true或false都是没有意义的. 作为替代, 传统上称函数返回false或返回true.

#### 1.4.1.5 指示器

指示器(Designators)是指示另一个对象的对象.

在操作符的参数被描述为指示器时, 操作符的描述中存在参数的值是被指示的对象的假设; 即参数已经有被指示的类型.(被指示为`<<type>> designator`或`<<type>>的disignator`的对象的性质见**指示器**)

例如: `nil`和`*standard-output*`的值可以作为流指示器, 类似的符号`foo`和字符串`"FOO"`可以作为字符串指示器.

除非特别指出, 被指示的对象在一些场景下可能被多次使用, 对象被求值(coerce)一次还是每次该对象出现时均求值是特定于实现的.

例如, `mapcar`接收函数指示器作为参数, 它的描述中假设这是个函数. 实际上, 这个函数指示器是被立即求值, 或者在内部以作为参数的形式携带, 并在每次没使用时求值, 是依赖于特定的实现的. 在大多数情况下, 符合标准的程序不能检测出这种差异性, 但是存在一些病态情况(包括自重定义或互相重定义函数), 在符合标准的同时可以检测出差异性. 下面的程序是符合标准的, 但依赖于其正确性是否依赖于哪一个结果, 可能或不可能有可移植的正确结果:

```
(defun add-some (x)
   (defun add-some (x) (+ x 2))
   (+ x 1)) =>  ADD-SOME
(mapcar 'add-some '(1 2 3 4))
=>  (2 3 4 5)
OR=>  (2 4 5 6)
```

在SBCL中执行的结果:

```
> > (defun add-some (x)
>    (defun add-some (x) (+ x 2))
>    (+ x 1))
> ADD-SOME
> (mapcar 'add-some '(1 2 3 4))
> WARNING: redefining COMMON-LISP-USER::ADD-SOME in DEFUN
> WARNING: redefining COMMON-LISP-USER::ADD-SOME in DEFUN
> WARNING: redefining COMMON-LISP-USER::ADD-SOME in DEFUN
> WARNING: redefining COMMON-LISP-USER::ADD-SOME in DEFUN
> (2 3 4 5)
```

在一些很少出现的情况中, 存在需要引用参数的原始指示器对象的字典项. 因为给参数命名可以引用被指示的对象, `the <<parameter-name>> designator`可被用于引用这个指示器, 它是用于计算`<<parameter-name>>`的值的参数.

#### 1.4.1.6 无含义单词

当一个单词不需要预先附加含义时, Lisp社区通常使用这些单词: `foo`, `bar`, `baz`, `quux`. 例如:

```
(defun foo (x) (+ x 1))
```

使用名称`foo`的含义是可以在这里将其替换为你喜欢的名称.

### 1.4.2 有关错误的术语

- 安全的代码(Safe code)

使用最高设置(3)的安全性优化处理的代码. 安全性是代码的词法属性. "函数`F`应该发出错误信息"的含义是, 如果`F`被经最高安全性优化处理的代码调用, 会发出一个错误信号. 是由`F`还是由调用代码发出错误信号, 是依赖于实现的.

- 不安全的代码(Unsafe code)

使用较低安全性优化等级处理的代码. 不安全的代码可能执行错误检测. 实现被允许将所有代码视为总是安全的代码.

- 发出错误信号(An error is signaled)

其含义是在安全和不安全代码中, 发布了一个错误信号. 符合标准的代码可以依赖于错误信号是在安全和不安全代码中发出的事实. 每个实现被要求检测安全和不安全代码重发出的错误信号. 例如: "如果给`unexport`传入当前包中不能访问的符号, 会发出一个错误信号".

如果没有显式指定错误类型, 默认为`error`.

- 应该发出错误信号(An error should be signaled)

其含义是安全代码中发出了错误信号, 不安全代码中可能发出了错误信号. 符合标准的代码可以依赖于错误信号是在安全代码中发出的事实. 每个实现被要求至少在安全代码中检测错误. 当无错误信号时, 后果是未定义的. 例如: "如果`+`的任意一个参数不是`number`类型的, 应该发出类型为`type-error`的错误信号".

- 应该准备发出错误信息(Should be prepared to signal an error)

与**应该发出错误信号**类似, 但其意味着, 使用懒检查, 如果操作符中的正常动作可以被正确的执行, 不需要操作符中额外的发现错误状况的工作. 实现总是被允许发出错误信号, 但是甚至在安全的代码中, 只需要在发出错误信号失败可能导致错误结果时发出错误信号. 在不安全的代码中, 其后果是未定义的.

例如, 定义"如果`find`的第二个参数不是合式列表时, 它应该准备发出类型为`type-error`的错误信号"并不表示总是抛出一个错误信息. 形式

```
(find 'a '(a b . c))
```

必须或者在安全代码中发出类型为`type-error`的错误信号, 或者返回`A`. 在不安全代码中后果未定义.

与之相反,

```
(find 'd '(a b . c))
```

必须按安全代码中发出类型为`type-error`的错误信号. 在不安全代码中后果未定义.

```
(find 'd '#1=(a b . #1#))
```

在安全代码中可能返回`nil`(作为实现定义的扩展), 也可能永不返回, 或发出类型为`type-error`的错误信号. 在不安全代码中后果未定义.

通常, 在类型检查场景中使用**应该该准备发出**, 这里有检测与操作符的正确操作不相关的错误是不实际的效率方面的考虑.

- 后果未描述(The consequences are unspecified)

其含义是后果不可预测但是有害的. 允许实现描述这种状况的后果. 不符合标准的代码可能依赖于结果或这种状况的作用, 所有复合标准的代码要求将这种状况的结果和作用视为不可预测的但有害的. 例如: "如果`shared-initialize`的第二个参数是一个与对象中任意可访问的槽不相关的名称, 结果未描述".

- 后果未定义(The consequences are undefined)

其含义是后果是不可预测的. 后果的范围可能是有害的到致命的(fatal). 不符合标准的代码可能依赖于结果或作用. 符合标准的代码必须将后果视为不可预测的. 在"必须"、"必须不"或"不能"出现的地方, 如果被陈述的需求无法满足, 并且没有陈述特定的后果, 后果是未定义的. 允许实现在这种情况下发出错误信号.

例如: "一旦一个名称被`defconstant`声明为常量, 后续的对该变量的赋值或绑定未定义".

- 可能发出错误信号(An error might be signaled)

其含义是这种状况的后果未定义, 然而, 如果发出了一个错误信号, 它的类型是被指定的类型. 例如: "`open`可能发出类型为`file-error`的错误信号".

- 返回值未描述(The return values are unspecified)

其含义是仅一个形式的返回值的数量和性质未描述. 然而, 是否有副作用或控制转义仍被描述.

甚至在使用了返回值未描述的函数时, 一个程序仍可被描述. 例如, 如果某个函数`F`的返回值未被描述, 像`(lenght (list (F)))`仍被恰当描述了, 这是因为它不依赖于`F`的返回值.

- 实现中可以涵盖这种状况(Implementations may be extended to cover this situation)

其含义是状况有未定义的后果, 然而, 允许符合标准的实现按更特定的方式处理这种状况. 例如, 一个实现可以定义发出错误信号、应该发出错误信号, 甚至详细定义的非错误行为.

不符合标准的代码可能依赖于这种状况的后果, 符合标准的代码必须将这种状况视为未定义的. 实现被要求记录状况如何被处理的.

例如: "实现可以扩展来定义其他由相关类的类型描述符".

- 实现可以自由扩展语法(Implementations are free to extend the syntax)

其含义是在这种状况下, 允许实现定义描述中形式的无歧义语法扩展. 不符合标准的代码可能依赖于这种扩展. 实现被要求记录每个扩展. 符合标准的代码被要求将这种语法视为无意义的. 标准科恩那个不允许一些扩展, 但允许另外一些扩展. 例如: "不允许实现扩展`defclass`的语法".

- 可能产生警告(A warning might be issued)

其含义是如果上下文不合适时(编译时)鼓励实现产生警告信息. 然而, 符合标准的实现不要求产生警告.

### 1.4.3 不属于标准的部分

目录、索引、图片、荣誉和附录, 不属于标准.

在各章节中, 以"备注"或"示例"未标题开头的子章节, 不属于标准.

字典项中的"备注"和"示例", 不属于标准.

### 1.4.4 解释字典项

#### 1.4.4.1 被影响(Affected By)

对操作符, 任何可以影响它的副作用或返回值的事物.

对变量, 任何可以影响它的值的事物, 包括绑定它或给它赋值的函数.

#### 1.4.4.2 参数(Arguments)

描述目录项的语法信息, 包括声明和特殊表达式(从不作为形式求值, 不返回值)等.

#### 1.4.4.3 参数和值(Arguments and Values)

操作符接受的参数和返回的值的描述, 包括参数默认值(可选参数和关键字参数).

对于特殊操作符和宏, 其参数不被求值, 除非在描述中被显式指出需要求值.

#### 1.4.4.4 影响的绑定类型(Binding Types Affected)

作为声明可能潜在影响的绑定的提醒. 特定绑定是否实际被影响可能依赖于其他因素.

#### 1.4.4.5 类优先级列表(Class Precedence List)

出现在类的目录字典中, 包含Common Lisp定义的在这个类的类优先级列表中出现的类的有序列表.

允许实现定义的类出现在实现的类优先级列表中.

允许`standard-object`或`struct-object`出现在实现的类优先级列表中, 详情见**4.2.2 类型关系**

除非特别指出, 不允许额外的标准类出现在实现的类优先级列表中.

通过定义类和类型之间的关系, 这里的类是被该类指示的类型的超类型.

#### 1.4.4.6 类型描述符的字典项

原子类型描述符是图4-2中列出的已定义名称. 这些目录项包括: 类、条件类型、系统类和类型. 如何将这些类型和类的符号解释为原子类型描述符的描述见描述一节.

复合类型描述符是图4-3中列出的已定义名称. 这些目录项包括: 类、系统类、类型和类型描述符. 如何将其`car`的符号解释为复合类型描述符的描述见类别、语法、参数和描述的章节.

##### 1.4.4.6.1 复合类型描述符类别

- 缩写(abbreviating)类型描述符 描述了这样的子类型: 原理上可能枚举元素的, 但实际上不可行.
- 特化(specilalizing)类型描述符 描述了这样的子类型: 约束类型的一个或多个成分的类型, 例如元组类型或复数部分类型
- 断言(predicating)类型描述符 描述了这样的子类型: 只包含满足给定谓词的对象
- 组合(combining)类型描述符 描述了这样的子类型: 使用组合的方式, 在其他类型上使用组合操作(`and`, `or`, `not`)

##### 1.4.4.6.2 复合类型描述符语法

这里的信息描述了类型的复合类型描述符的语法.

没有描述类型是否被认为是原子类型描述符.

##### 1.4.4.6.3 复合类型描述符参数

这里的信息描述了语法一节中定义的结构信息.

##### 1.4.4.6.4 复合类型描述符描述

这里的信息描述了语法一节中定义的结构的含义.

#### 1.4.4.7 常量值(Constant Value)

这里的信息描述了常值变量的不可变的类型和值.

#### 1.4.4.8 描述(Description)

操作符的总结和其他意图相关的方面, 但不一定需要包括下面的一些章节(副作用、异常状况等).

#### 1.4.4.9 示例(Examples)

操作符的使用示例. 这些示例不属于标准.

#### 1.4.4.10 异常状况(Exceptional Situations)

这里可以记录三种信息:

- 被函数检测到的状况
- 被函数处理的状况
- 可能被函数检测到的状况

这里的信息不包括这些被发出的条件:

- 作为参数或动态变量传递给操作符的函数
- 如果操作符是宏或特殊操作符, 执行操作符的子形式

#### 1.4.4.11 初始值(Initial Value)

这里的信息描述了动态变量的初始值. 因为这个变量可能被修改, 见值类型一节中类型约束部分.

#### 1.4.4.12 参数优先级顺序(Argument Precedence Order)

这里的信息描述了参数优先级顺序. 如果被省略掉了, 参数优先级顺序是默认的: 从左至右.

#### 1.4.4.13 方法签名(Method Signature)

广义函数的描述包括定义在广义函数上的方法的描述. 方法的签名用于描述方法的参数和参数特化符. 广义函数上定义的方法必须由这里描述的方法签名的形式.

F (x class)(y t) &optional z &key k

这个签名表明, 广义函数`F`上的这个方法需要两个必备参数: `x`和`y`, `x`必须是类`class`的泛化实例, `y`可以是任意对象(类`t`的泛化实例). 此外, 有可选参数`z`和关键字参数`k`. 这个签名还表明, 这个方法没有限定符, 是主方法.

对每个参数, 提供的参数必须在广义函数中描述的类型和方法签名中的类型的交中, 方法包括标准中定义的方法、实现定义或用户定义的方法.

#### 1.4.4.14 名称(Name)

这一节介绍目录项:

- 访问器(Accessor) 访问器
- 类(Class)
- 条件类型(Condition Type) 类型`condition`的子类型
- 常值变量(Constant Variable)
- 声明(Declaration) 声明描述符
- 函数(Function)
- 本地函数(Local Function) 只在其他宏形式词法作用域中定义的函数
- 本地宏(Local Macro) 只在其他宏形式词法作用域中定义的宏
- 宏(Macro)
- 重启器(Restart)
- 特殊操作符(Special Operator)
- 标准广义函数(Standard Generic Function)
- 符号(Symbol) 在特定场景中识别的符号, 例如宏语法中
- 系统类(System Class) 将类标记为内置类
- 类型(Type) 原子类型描述符
- 类型描述符(Type Specifier) 已定义的名称, 不是原子类型描述符, 但可用于构造有效的类型描述符
- 变量(Variable) 动态变量

#### 1.4.4.15 备注(Notes)

这里的信息作为操作符其他部分描述的补充. 可能包括交叉引用信息、代码等价性、风格建议、实现建议和典型使用方法的. 这里的信息不属于标准, 任何符合标准的实现和程序允许忽略这些信息.

#### 1.4.4.16 读法(Pronunciation)

提供了建议的已定义名称的读法. 不属于标准.

#### 1.4.4.17 参见(See Also)

标准中操作符相关的信息的连接. 不属于标准.

#### 1.4.4.18 副作用(Side Effects)

求值包含操作符的形式时, 任何被改变的事物.

#### 1.4.4.19 超类型(Supertypes)

出现在类型的目录项中, 包括这个类型的标准超类型的列表.

在有相关类的实现中, 类优先级列表的顺序与这里的一致.

#### 1.4.4.20 语法(Syntax)

这一部分描述如何在代码中使用已定义名称. 广义函数的语法部分描述其自身的lambda列表, 方法签名描述定义的方法的lambda列表. 常规函数、宏和特殊操作符的语法部分描述其参数。

例如: 一个操作符描述

F x y &optional z &key k

这个描述表明函数`F`有两个必备参数`x`和`y`, 一个可选参数`z`和一个关键字参数`k`.

对于宏和特殊操作符, 使用**1.4.1.2 修改的BNF语法**中定义的语法. 对于函数, 给出lambda列表. 省略了外围的括号和默认值信息.

##### 1.4.4.20.1 重载操作符的特护语法记法

如果相同操作由两个描述, 但由不同数量的参数, 则额外参数被视为可选参数.

例如:

file-position stream => position file-position stream position-spec => success-p

等价于:

file-position stream &optional position-spec => result

多行记法用于操作符重载中提供参数数量不同或返回值不同的情况.

##### 1.4.4.20.2 剩余参数的命名约定

剩余参数的名称选为复数名词, 使用单数名词引用其中一个元素.

例如:

F &rest arguments

通过`arguments`引用剩余参数列表, 通过`argument`引用其中一个元素.

##### 1.4.4.20.3 非空剩余参数

F &rest arguments+

等价于

F &rest argument

但引入了至少有一个参数的要求.

##### 1.4.4.20.4 返回值

在返回值前使用求值箭头`=>`. 例如:

F a b c => x

表明`F`是有三个必备参数(`a`, `b`, `c`)的操作符, 返回一个值(`x`).

如果操作符返回多个值, 按逗号分隔:

F a b c => x,y,z

###### 1.4.4.20.4.1 无参数或值

如果不允许有参数或没有返回值时, 使用特殊的记法:

F =>

表明`F`是无参数和返回值的操作符.

###### 1.4.4.20.4.2 无条件控制转移

一些操作符执行无条件控制转移, 所以永远不会由返回值. 使用如下记法:

F a b c =>|

#### 1.4.4.21 有效上下文(Valid Context)

被声明一节使用, 用于显示声明可以出现的上下文.

声明可以出现在`declare`表达式、`declaim`或`proclaim`形式中.

#### 1.4.4.22 值类型(Value Type)

这里的信息描述动态变量的类型约束.

除非特别说明, 违背这个类型约束的后果未定义.

## 1.5 标准符合性

标准给出了符合标准的实现中需要实现的语法和语义. 此外, 对符合标准的程序也提出要求.

### 1.5.1 符合标准的实现

符合标准的实现需要满足这里的需求.

#### 1.5.1.1 要求的语言特性

符合标准的实现需要具备标准中描述的所有特性(包括废弃的特性)和含义.

符合标准的实现不应该要求在代码中包含替换或额外语言元素以满足标准中描述的语言特性.

#### 1.5.1.2 记录实现相关的特性

符合标准的实现需要提供规范中定义的语言实现定义内容的文档.

此外, 鼓励(但不要求)符合标准的实现提供标准中标注为实现相关的内容.

#### 1.5.1.3 记录扩展

符合标准的实现应该提供标准中未描述的支持的特性的文档, 当添加到语言标准时不应该导致歧义和矛盾. 这些扩展应该描述为"ANSI 中描述的Common Lisp扩展".

#### 1.5.1.4 处理异常情况

符合标准的实现应该以与规范一致的方式处理异常情况.

##### 1.5.1.4.1 解决异常情况中明显的冲突

如果规范中有多处内容可用于同一情况但存在冲突, 则采用按最特殊方式(不要求是提供了最受限类别的异常检测)描述情况的内容.

###### 1.5.1.4.1.1 示例: 解决异常情况中明显的冲突

假设函数`foo`是操作数值的函数集合`S`中的一个. 一段描述指出如果没有给`S`中函数传递参数`17`则必须发出错误信号. 另一段明显冲突的描述指出如果给`foo`传递参数`17`后果未定义.

则采用第二段描述, 因为其描述的情况上下文更特殊. 不要求`foo`在收到参数`17`时发出错误信号, 尽管`S`中其他函数被要求这么做.

#### 1.5.1.5 符合性陈述

符合标准的实现应该生成符合性陈述作为使用实现的结果, 或者该陈述应该纳入相关文档中.

如果实现完全符合标准, 则符合性陈述应该是: "符合ANSI 的需求".

如果实现部分复合标准, 则符合性陈述应该是: "复合ANSI 的需求, 除了".

### 1.5.2 符合标准的程序

符合标准的程序应该满足:

1. 只使用标准或使用标准扩展机制描述的语言语法和语义中特性.
2. 可以使用实现线管的特性和值, 但不能依赖于这些特性和值的特定解释, 通过执行代码发现的解释除外.
3. 不应该依赖于未定义或未描述情况的后果.
4. 不可使用标准禁止使用的构造.
5. 不可依赖于实现中包括的扩展.

#### 1.5.2.1 使用实现定义的语言特性

注意符合标准的程序可以依赖于特定的实现定义的值或特性. 注意符合标准的程序和实现的需求, 不要求符合标准的程序产生的结果总是与符合标准的实现产生的结果相同.

符合标准的程序可以在所有符合标准的实现中运行, 但有允许的实现定义的行为使其不可一致. 例如, 下面的形式示例是符合标准的, 但在不同的实现中可能返回不同的值:

(evenp most-positive-fixnum) => implementation-dependent (random) => implementation-dependent (> lambda-parameters-limit 93) => implementation-dependent (char-name #\A) => implementation-dependent

##### 1.5.2.1.1 使用实时状况

使用`#+`和`#-`不自动将程序分类为不符合标准的. 如果不存在不符合标准的特性, 使用`#+`和`#-`的程序被认为是符合标准的. 当然, 符合标准的程序不一定是可用的程序. 下面的程序是符合标准的:

(defun foo () #+ACME (acme:initialize-something) (print 'hello-there))

然而, 这个程序可能工作也可能不工作, 依赖于特性`ACME`和函数`acme:initialize-something`是否存在.

实际上, 在符合标准的程序中使用`#+`和`#-`, 将变量`*feature*`作为额外的程序输入. 像其他程序输入一样, 程序员有责任确保程序没有对输入数据做无法保证的假设.

#### 1.5.2.2 可移植代码的字符集

可移植的代码只使用标准字符编写.

## 1.6 语言扩展

> TODO(zhoujiagen) 1.6 语言扩展

## 1.7 语言子集

> TODO(zhoujiagen) 1.7 语言子集

## 1.8 废弃的语言特性

> TODO(zhoujiagen) 1.8 废弃的语言特性

## 1.9 COMMON-LISP包中的符号

见**符号**.

# 2 语法

## 2.1 字符语法

Lisp读取器从流中接收字符串, 将它们解释为对象的打印表示, 构造对象并返回该对象.

这一章描述的语法称为标准语法(Standard Syntax). Common Lisp提供了操作, 因此通过`readtable`表示的语法信息可以在程序控制下修改, 见**23 读取器**. 除非特别说明, 文档中使用的语法是标准语法.

### 2.1.1 `readtable`

Lisp读取器使用的语法信息是被称为`readtable`的对象. `readtable`中包含字符和语法类型之间的关联.

下面是可用于`readtable`的已定义名称

图 2-1. `readtable`相关的已定义名称.

```
    *readtable*                    readtable-case
    copy-readtable                 readtablep
    get-dispatch-macro-character   set-dispatch-macro-character
    get-macro-character            set-macro-character
    make-dispatch-macro-character  set-syntax-from-char
```

#### 2.1.1.1 当前`readtable`

多个描述不同语法的`readtable`可以同时存在, 但在任意时刻只能有一个可以影响Lisp读取器解析表达式成对象的方式, 称为当前`readtable`. 给定动态环境中的当前`readtable`是该环境的`*readtable*`的值. 为将另一个`readtable`设置成当前`readtable`, `*readtable*`可以被赋值或绑定.

#### 2.1.1.2 标准`readtable`

标准`readtable`符合标准语法. 如果尝试修改标准`readtable`, 其后果是未定义的. 为达到修改或扩展标准语法的效果, 可以创建标准`readtable`的一个副本, 见函数`copy-readtable`.

在标准`readtable`上调用函数`readtable-case`的结果是`:upcase`.

#### 2.1.1.3 初始`readtable`

初始`readtable`是Lisp镜像启动时的当前`readtable`, 这时它符合标准语法. 初始`readtable`与标准`readtable`不同, 允许符合标准的程序修改初始`readtable`.

### 2.1.2 影响Lisp读取器的变量

Lisp读取器不仅受当前`readtable`的影响, 还受多个动态变量的影响. 下图列出了影响Lisp读取器行为的变量.

图 2-2. 影响Lisp读取器的变量.

```
    *package*    *read-default-float-format*  *readtable*
    *read-base*  *read-suppress*
```

### 2.1.3 标准字符

实现必须支持称为`standard-char`的字符表, 表中字符称为标准字符.

`standard-char`字符表由非图形字符**换行符**、图形字符**空白**和下面的92个**图形符号**或其等价物构成。

图 2-3. 标准字符子表(1/3 拉丁字符).

```
    Graphic ID  Glyph  Description  Graphic ID  Glyph  Description
    LA01        a      small a      LN01        n      small n
    LA02        A      capital A    LN02        N      capital N
    LB01        b      small b      LO01        o      small o
    LB02        B      capital B    LO02        O      capital O
    LC01        c      small c      LP01        p      small p
    LC02        C      capital C    LP02        P      capital P
    LD01        d      small d      LQ01        q      small q
    LD02        D      capital D    LQ02        Q      capital Q
    LE01        e      small e      LR01        r      small r
    LE02        E      capital E    LR02        R      capital R
    LF01        f      small f      LS01        s      small s
    LF02        F      capital F    LS02        S      capital S
    LG01        g      small g      LT01        t      small t
    LG02        G      capital G    LT02        T      capital T
    LH01        h      small h      LU01        u      small u
    LH02        H      capital H    LU02        U      capital U
    LI01        i      small i      LV01        v      small v
    LI02        I      capital I    LV02        V      capital V
    LJ01        j      small j      LW01        w      small w
    LJ02        J      capital J    LW02        W      capital W
    LK01        k      small k      LX01        x      small x
    LK02        K      capital K    LX02        X      capital X
    LL01        l      small l      LY01        y      small y
    LL02        L      capital L    LY02        Y      capital Y
    LM01        m      small m      LZ01        z      small z
    LM02        M      capital M    LZ02        Z      capital Z
```

图 2-4. 标准字符子表(2/3 数值字符).

```
    Graphic ID  Glyph  Description  Graphic ID  Glyph  Description
    ND01        1      digit 1      ND06        6      digit 6
    ND02        2      digit 2      ND07        7      digit 7
    ND03        3      digit 3      ND08        8      digit 8
    ND04        4      digit 4      ND09        9      digit 9
    ND05        5      digit 5      ND10        0      digit 0
```

图 2-5. 标准字符子表(3/3 特殊字符).

```
    Graphic ID  Glyph  Description
    SP02        !      exclamation mark
    SC03        $      dollar sign
    SP04        "      quotation mark, or double quote
    SP05        '      apostrophe, or [single] quote
    SP06        (      left parenthesis, or open parenthesis
    SP07        )      right parenthesis, or close parenthesis
    SP08        ,      comma
    SP09        _      low line, or underscore
    SP10        -      hyphen, or minus [sign]
    SP11        .      full stop, period, or dot
    SP12        /      solidus, or slash
    SP13        :      colon
    SP14        ;      semicolon
    SP15        ?      question mark
    SA01        +      plus [sign]
    SA03        <      less-than [sign]
    SA04        =      equals [sign]
    SA05        >      greater-than [sign]
    SM01        #      number sign, or sharp[sign]
    SM02        %      percent [sign]
    SM03        &      ampersand
    SM04        *      asterisk, or star
    SM05        @      commercial at, or at-sign
    SM06        [      left [square] bracket
    SM07        \      reverse solidus, or backslash
    SM08        ]      right [square] bracket
    SM11        {      left curly bracket, or left brace
    SM13        |      vertical bar
    SM14        }      right curly bracket, or right brace
    SD13        `      grave accent, or backquote
    SD15        ^      circumflex accent
    SD19        ~      tilde
```

**Graphic ID** 未在Common Lisp中未使用, 仅作为ISO 6937/2的引用参考. 注意其首字母的含义: L—Latin(拉丁), N—Numeric(数值), S—Special(特殊).

### 2.1.4 字符语法类型

Lisp读取器通过根据字符的语法类型解释每个字符, 从输入文本中构造对象. Lisp读取器不是接受所有由Lisp打印器产生的输入, Lisp读取器由未在Lisp打印器中使用的特性. Lisp读取器可以被用作更通用的解析器中的词法解析器.

当Lisp读取器被调用时, 它从输入流中读取单个字段, 根据该字符的语法类型执行分发(dispatch). 可以出现在输入流中的字符具备图2-6中的一个语法类型.

图 2-6. 可能的字符语法类型.

```
    constituent         ; 要素
    invalid             ; 无效的
    macro character     ; 宏字符
    multiple escape     ; 多转义
    single escape       ; 单转义
    whitespace          ; 空白
```

当前`readtable`中字符的语法类型, 决定了该字符如何被Lisp读取器解释. 在任意时刻, 每个字符有且只有一个语法类型.

图2-7列出了标准语法中每个字符的语法类型

图 2-7. 标准语法中字符的语法类型.

```
    character  syntax type                 character  syntax type
    Backspace  constituent                 0--9       constituent
    Tab        whitespace                  :          constituent
    Newline    whitespace                  ;          terminating macro char
    Linefeed   whitespace                  <          constituent
    Page       whitespace                  =          constituent
    Return     whitespace                  >          constituent
    Space      whitespace                  ?          constituent*
    !          constituent*                @          constituent
    "          terminating macro char      A--Z       constituent
    #          non-terminating macro char  [          constituent*
    $          constituent                 \          single escape
    %          constituent                 ]          constituent*
    &          constituent                 ^          constituent
    '          terminating macro char      _          constituent
    (          terminating macro char      `          terminating macro char
    )          terminating macro char      a--z       constituent
    *          constituent                 {          constituent*
    +          constituent                 |          multiple escape
    ,          terminating macro char      }          constituent*
    -          constituent                 ~          constituent
    .          constituent                 Rubout     constituent
    /          constituent
```

由`*`标注的字符初始时是要素, 但不在任何标准Common Lisp记法中使用. 这些字符显式的保留给程序员使用. `~`未在Common Lisp中使用, 保留给实现者. `$`和`%`是字母字符, 但不在任何标准Common Lisp已定义名称中使用.

空白字符作为分割符使用, 其他情况可以忽略. 要素和转义字符累积成记号(token), 接着被解释为数值或符号. 宏字符触发调用可以执行任意解析动作的函数(可能是用户提供的). 宏字符按是否终结一个记号, 分为两个类别: 终结、非终结.

下面描述每类语法类型.

#### 2.1.4.1 要素字符

要素字符在记号中使用. 记号是数值或符号的表示. 要素字符的示例是字母(letter)或数字(digit).

符号名称中字符在名称被读取时, 有时被转换大小写, 见**23.1.2 Lisp读取器中readtable大小写的作用**. 大小写转换可用通过使用单转义或多转义字符抑制.

#### 2.1.4.2 要素特质

当字符是要素字符时, 它有一个或多个要素特质, 定义了字符如何被Lisp读取器解释. 这些要素特质是字母、数字、包标记、加号、减号、点、小数点、比值标记、指数标记和无效的. 图2-8展示了标准字符和一些半标准字符的要素特质; 没有机制可以修改字符的要素特质. 图中任何有`alphadigit`的要素特质, 如果当前输入基大于该字符的数字值时, 是一个数字, 否则是字母. 单转义标注的任意字符被视为字母要素, 不管其常规语法.

图 2-8. 标准字符和半标准字符的要素特质.

```
    要素字符      特质             要素字符      特质
    ----------

    Backspace    invalid         {            alphabetic
    Tab          invalid*        }            alphabetic
    Newline      invalid*        +            alphabetic   , plus sign
    Linefeed     invalid*        -            alphabetic   , minus sign
    Page         invalid*        .            alphabetic   , dot, decimal point
    Return       invalid*        /            alphabetic   , ratio marker
    Space        invalid*        A, a         alphadigit
    !            alphabetic      B, b         alphadigit
    "            alphabetic*     C, c         alphadigit
    #            alphabetic*     D, d         alphadigit, double-float exponent marker
    $            alphabetic      E, e         alphadigit, float exponent marker
    %            alphabetic      F, f         alphadigit, single-float exponent marker
    &            alphabetic      G, g         alphadigit
    '            alphabetic*     H, h         alphadigit
    (            alphabetic*     I, i         alphadigit
    )            alphabetic*     J, j         alphadigit
    *            alphabetic      K, k         alphadigit
    ,            alphabetic*     L, l         alphadigit, long-float exponent marker
    0-9          alphadigit      M, m         alphadigit
    :            package marker  N, n         alphadigit
    ;            alphabetic*     O, o         alphadigit
    <            alphabetic      P, p         alphadigit
    =            alphabetic      Q, q         alphadigit
    >            alphabetic      R, r         alphadigit
    ?            alphabetic      S, s         alphadigit, short-float exponent marker
    @            alphabetic      T, t         alphadigit
    [            alphabetic      U, u         alphadigit
    \            alphabetic*     V, v         alphadigit
    ]            alphabetic      W, w         alphadigit
    ^            alphabetic      X, x         alphadigit
    _            alphabetic      Y, y         alphadigit
    `            alphabetic*     Z, z         alphadigit
    |            alphabetic*     Rubout       invalid
    ~            alphabetic
```

这个表的解释只适用与语法类型为要素的字符. 被`*`标注的项通常被遮盖, 因为被标注的字符的语法类型是空白、宏字符、单转义或多转义; 只有当其语法类型变为要素时这些要素特质才适用.

#### 2.1.4.3 无效的字符

要素特质是无效的字符不能在记号中出现, 除非在单转义字符的控制下. 如果在读取一个对象时遇到无效的字符, 发出类型为`reader-error`的错误信号. 如果无效的字符前有一个单转义字符, 它被视为字母的要素.

#### 2.1.4.4 宏字符

当Lisp读取器在输入流中遇到宏字符时, 会执行对输入流中后续字符的特殊解析操作.

宏字符有一个称为 **读取器宏函数** 的相关函数, 这个函数实现了特殊的解析行为. 在符合标准的程序中, 可以使用函数`set-macro-character`和`set-dispatch-macro-character`建立或修改这类相关.

Lisp读取器在遇到宏字符时, 调用其读取器宏函数, 该函数从输入流中解析特殊格式的对象. 这个函数或者返回解析出的对象, 或者不返回值以表明函数扫描过的字符被忽略. 宏字符的示例有反引号、单引号、左括号和右括号.

宏字符是终结的或非终结的, 其区别在于当这样的符号出现在记号的中间时会发生什么. 当非终结宏字符出现在记号中间时, 该符号相关的函数不被调用, 该符号不会终结记号的名称, 该符号像要素字符似的称为名称的一部分. 终结宏字符终结任意记号, 不管该字符在何处出现, 其相关的读取器宏函数总被调用. 标准语法中唯一的非终结宏字符是井号符号.

如果一个字符是分发宏字符`C1`, 其读取器函数是由实现提供的一个函数. 这个函数读取数字字符直到读到一个非数字字符`C2`. 如果读到任何数字, 这些数字被转换为一个对应的整数中缀参数`P`, 否则`P`是`nil`. 终结的非数字字符`C2`是个用于在与分发宏字符关联的分发表中进行查找的字符(有时称为子字符, 用以强调其在分发中的子角色). 读取器宏函数关联上子字符`C2`后, 调用时传入三个参数: 流、`C2`和中缀参数`P`. 关于分发符号的更新信息, 见函数`set-dispatch-macro-character`.

关于在标准语法中可用的宏字符, 见**2.4 标准宏字符**

#### 2.1.4.5 多转义字符

一对多转义字符用于将被其包裹的字符序列, 包括可能存在的宏字符和空白字符, 视为保留了大小写的字母字符.

这个序列中出现的任何单转义和多转义字符的前面必须由一个单转义字符.

##### 2.1.4.5.1 示例: 多转义字符

```
    ;; The following examples assume the readtable case of *readtable*
    ;; and *print-case* are both :upcase.
    (eq 'abc 'ABC) =>  true
    (eq 'abc '|ABC|) =>  true
    (eq 'abc 'a|B|c) =>  true
    (eq 'abc '|abc|) =>  false
```

#### 2.1.4.6 单转义字符

单转义字符用于将下一个字符视为保留了大小写的字母字符, 不管下一个字符是什么或它由什么要素特质.

反斜杠是标准语法中的单转义字符.

##### 2.1.4.6.1 示例: 单转义字符

```
    ;; The following examples assume the readtable case of *readtable*
    ;; and *print-case* are both :upcase.
    (eq 'abc '\A\B\C) =>  true
    (eq 'abc 'a\Bc) =>  true
    (eq 'abc '\ABC) =>  true
    (eq 'abc '\abc) =>  false
```

#### 2.1.4.7 空白字符

空白字符用于分隔记号.

空格符和换行符是标准语法中的空白字符.

##### 2.1.4.7.1 示例: 空白字符

```
    (length '(this-that)) =>  1
    (length '(this - that)) =>  3
    (length '(a
              b)) =>  2
    (+ 34) =>  34
    (+ 3 4) =>  7
```

## 2.2 读取器算法

这一部分描述Lisp读取器从输入自负留解析出对象时使用的算法, 包括Lisp读取器如何处理宏字符.

当处理记号时, 读取器的基本功能是区分符号和数值的表示. 当累积记号时, 如果它满足图2-9列出的数值的语法, 则被认为是表示一个数值. 如果它不表示一个数值, 如果它满足可能的数值的语法规则则被认为是可能的数值. 如果一个有效的不是数值和可能数值的标识, 则它表示一个符号.

Lisp读取器算法如下:

1. 如果在文件尾, 文件尾处理按`read`中描述的方式处理. 否则, 从输入流中读入一个字符`x`, 并根据其语法类型分发到 **步骤2-7** 中的一个.
2. 如果`x`是 **无效字符**, 发出类型为`reader-error`的错误信号.
3. 如果`x`是 **空白字符**, 忽略它, **转步骤1**.
4. 如果`x`是 **终结或非终结宏字符**, 则其相关的读取器宏函数以输入流和`x`这两个参数调用.
    1. 读取器宏函数可能从输入流中读取字符; 如果它不读取字符, 它会看到宏字符后面的字符. Lisp读取器可能在读取器宏函数中被递归调用.
    2. 读取器宏函数一定不能有除输入流外的任何副作用; 因为`read`操作的回溯和重启动, Lisp读取器的前端(编辑器等)可能导致在读取`x`只出现一次的单个表达式时, 读取器宏函数被重复调用.
    3. 读取器宏函数可能返回零个值或一个值. 如果返回了一个值, 则该值作为`read`操作的返回值, 算法结束. 如果没有返回值, **转步骤1**.
    4. 如果`x`是 **单转义字符**, 则读取下一个字符`y`, 如果到文件尾则发出类型为`end-of-file`的错误信号. `y`被视为要素特质为字母的要素. `y`用于开始记号, **转步骤8**.
5. 如果`x`是 **多转义字符**, 则开始一个记号(初始时不包含字符), **转步骤9**.
6. 如果`x`是 **要素字符**, 则开始一个记号. 在记号被读入后, 它将被解释为一个Lisp对象或无效的语法. 如果记号标识一个对象, 则该对象作为`read`操作的结果返回. 如果记号是无效语法, 发出错误信号. 如果`x`是有大小写的字符, 依赖于当前`readtable`中大小写设置可能被转换大小写, 见**23.1.2 Lisp读取器中readtable大小写的作用**. `X`用于开始记号, **转步骤8**.
7. 这时累积了一个记号, 遇到 **偶数数量的多转义字符**. 如果在文件尾, **转步骤10**. 否则读入一个字符`y`, 根据其语法类型执行下面的一个操作:
    1. 如果`y`是 **要素或非终结宏字符**:
        1. 如果`y`是有大小写的字符, 按23.1.2节中所述, 可能切换大小写
        2. 将`Y`追加到构建中的记号中
        3. **重复步骤8**.
    2. 如果`y`是 **单转义字符**, 读取下一个字符`z`, 如果在文件尾则发出类型为`end-of-file`的错误信号. `Z`视为要素特质是字母的要素, 追加到构建中的记号中, **重复步骤8**.
    3. 如果`y`是 **多转义字符**, **转步骤9**.
    4. 如果`y`是 **无效字符**, 发出类型为`read-error`的错误信号.
    5. 如果`y`是 **终结宏字符**, 则结束记号. 放回`y`(见`unread-char`), **转步骤10**.
    6. 如果`y`是 **空白字符**, 则结束记号. 必要时放回`y`(见`read-preserving-whitespace`),**转步骤10**.
8. 这时累积了一个记号, 遇到 **奇数数量的多转义字符**. 如果在文件尾, 发布类型为`end-of-file`的错误信号. 否则读入字符`y`, 根据其语法类型执行下面的一个操作:
    1. 如果`y`是 **要素字符、宏字符或空白字符**, `y`被视为要素特质为字母的要素. `Y`被追加到构建中的记号中, **重复步骤9**.
    2. 如果`y`是 **单转义字符**, 读取下一个字符`z`, 如果在文件尾则发出类型为`end-of-file`的错误信号. `Z`被视为要素特质为字母的要素, 被追加到构建中的记号中, **重复步骤9**.
    3. 如果`y`是 **多转义字符**, **转步骤8**.
    4. 如果`y`是 **无效字符**, 则发出类型为`reader-error`的错误信号.
9. 已累积了一个完整的记号. 记号标识的对象作为`read`操作的结果返回, 如果该记号不是有效语法则发出类型为`reader-error`的错误信号.

## 2.3 解释记号

### 2.3.1 数值记号

当读取一个记号时, 它被解释为一个数值或符号. 如果满足下述数值语法, 记号被解释为数值:

图 2-9. 数值记号的语法.

```
numeric-token  ::=  integer |
				   ratio   |
				   float
integer        ::=  [sign]
				   decimal-digit+
				   decimal-point |
				   [sign]
				   digit+
ratio          ::=  [sign]
				   {digit}+
				   slash
				   {digit}+
float          ::=  [sign]
				   {decimal-digit}*
				   decimal-point
				   {decimal-digit}+
				   [exponent]
                    |
				   [sign]
				   {decimal-digit}+
				   [decimal-point
					   {decimal-digit}*]
				   exponent
exponent       ::=  exponent-marker
				   [sign]
				   {digit}+

sign              ; + -
slash             ; /
decimal-point     ; .
exponent-marker   ; 指数标记: D E F L S
decimal-digit     ; 进制为10的数字
digit             ; 当前输入基数的数字
```

#### 2.3.1.1 可能的数值的记号

为允许实现者和将来的Common Lisp标准扩展数值的语法, 定义了比数值语法更通用的可能的数值的语法. 一个记号如果满足下述条件, 则是可能的数值:

1. 完全由数字、正负号、比值标记、小数点(`.`)、扩展字符(`^`或`_`)和数值标记构成. 数值标记是个字母. 一个字母是否被认为是数值标记是依赖于上下文的, 但不存在与字母相邻的字母是数值标记的情况. 指数标记是数值标记.
2. 包含至少一个数字. 依赖于当前输入基, 字母可以被视为数值, 但只在不包含小数点的记号中.
3. 以数字、正负号、小数点或扩展字符开始, 但不以包标记开始. 以包标记开始后跟可能的数值的语法不是良式定义的. 诸如`:1`、`:1/2`、`:2^3`在`read`需要读入表达式的位置出现时, 其后果未描述.
4. 不以正负号结束.

如果可能的数值有数值语法, 且数值在实现中可被表示, 则构造并返回恰当类型的数值. 如果数值超出了依赖于实现的数值常量的边界, 则数值在实现中不可表示. 例如给浮点数指定了太大或太小的指数, 使得数值在实现中不可表示. 分布为0的比值(例如`-35/000`)在任意实现中不可标识. 如果有数值语法的记号不能转换为内部数值, 则发出类型为`reader-error`的错误信号. 给浮点数指定了大量数字不可发出错误信号, 应该生成截断或舍入后的值.

如果存在一个字母被认为是数字或数值标记的歧义情况, 则该字母被认为是数字.

##### 2.3.1.1.1 转义字符与可能的数值

可能的数值中不能有任何转义字符. 转义字符强制将后面的字符解释为字母的, 因此不适合用于可能的数值. 下面的示例应该被解释为符号而不是数值:

```
    \256   25\64   1.0\E6   |100|   3\.14159   |3/4|   3\/4   5||
```

在每个情况中, 移除转义字符后可以生成可能的数值.

##### 2.3.1.1.2 示例: 可能的数值

下图中的记号是可能的数值, 但不是数值, 因此作为保留记号; 符合标准的实现允许但不要求定义它们的含义:

图 2-10. 保留记号示例.

```
    1b5000                       777777q                1.7J  -3/4+6.7J  12/25/83
    27^19                        3^4/5                  6//7  3.1.2.6    ^-43^
    3.141_592_653_589_793_238_4  -3.7+2.6i-6.17j+19.6k
```

下图中的记号不是可能的数字, 它们被认为是符号:

图 2-11. 符号示例.

```
    /     /5     +  1+  1-
    foo+  ab.cd  _  ^   ^/-
```

如果当前输入基是`16`时, 下图中记号是可能的数值, 如果当前输入基是`10`则这些是符号:

图 2-12. 符号或可能的数值的示例.

```
    bad-face  25-dec-83  a/b  fad_cafe  f^
```

### 2.3.2 从记号构造数值

实数直接从相关的数值记号构建, 见**图 2-9. 数值记号的语法.**.

复数记为`#C`或`#c`, 后跟两个实数的列表, 见**`#C`**.

读取器宏`#B`、`#O`、`#X`和`#R`可用于控制解析有理数时的输入基数, 见**`#B`**、**`#O`**、**`#X`**和**`#R`**.

这一部分汇总了数值的完整语法.

#### 2.3.2.1 有理数的语法

##### 2.3.2.1.1 整数的语法

整数可以写作数字的序列, 可选的在开始处放置正负号, 可选的后接小数点, 见**图 2-9. 数值记号的语法.**. 当使用小数点时, 数字的基数为`10`; 如果没有使用小数点, 则数字的基数为当前输入基.

关于整数如何打印的信息见**22 打印器**中相应部分.

##### 2.3.2.1.2 比值的语法

比值写作可选的正负号, 后接两个按`/`分隔的两个非空数字序列, 见**图 2-9. 数值记号的语法.**. 第二个数字序列不能都是0. 示例:

图 2-13. 比值示例.

```
2/3                 ;This is in canonical form
4/6                 ;A non-canonical form for 2/3
-17/23              ;A ratio preceded by a sign
-30517578125/32768  ;This is (-5/2)^15
10/5                ;The canonical form for this is 2
#o-101/75           ;Octal notation for -65/61
#3r120/21           ;Ternary notation for 15/7
#Xbc/ad             ;Hexadecimal notation for 188/173
#xFADED/FACADE      ;Hexadecimal notation for 1027565/16435934
```

关于比值如何打印的信息见**22 打印器**中相应部分.

#### 2.3.2.2 浮点数的语法

浮点数可以写作小数形式或科学记数法形式: 可选的正负号, 后接有内嵌小数点的非空数字序列, 后接可选的小数指数规格描述. 如果没有指数描述符, 则需要小数点, 且小数点后必须还有数字. 指数描述符由指数标记, 一个可选的正负号和一个非空的数字列表构成. 如果没有指数描述符, 或者使用了指数描述符`e`(或`E`), 则使用`*read-default-float-format*`指定的格式. 见**图 2-9 数值记号的语法.**.

实现可以提供构成类型`float`的一个或多个浮点数. 字母`s, f, d, l`(获取相应的大写形式)分别显式描述了使用类型`short-float`, `single-float`, `double-float`和`long-float`.

用于外部表示的内部格式仅依赖于指数标记, 不依赖于外部表示中数字的数量.

下图有浮点数记法的示例:

图 2-14. 浮点数的示例.

```
0.0       ;Floating-point zero in default format
0E0       ;As input, this is also floating-point zero in default format.
          ;As output, this would appear as 0.0.
0e0       ;As input, this is also floating-point zero in default format.
          ;As output, this would appear as 0.0.
-.0       ;As input, this might be a zero or a minus zero,
          ; depending on whether the implementation supports
          ; a distinct minus zero.
          ;As output, 0.0 is zero and -0.0 is minus zero.
0.        ;On input, the integer zero---not a floating-point number!
          ;Whether this appears as 0 or 0. on output depends
          ;on the value of *print-radix*.
0.0s0     ;A floating-point zero in short format
0s0       ;As input, this is a floating-point zero in short format.
          ;As output, such a zero would appear as 0.0s0
          ; (or as 0.0 if short-float was the default format).
6.02E+23  ;Avogadro's number, in default format
602E+21   ;Also Avogadro's number, in default format
```

关于浮点数如何打印的信息见**22 打印器**中相应部分.

#### 2.3.2.3 复数的语法

复数由笛卡尔结构, 一个实部和一个虚部, 每部分都是一个实数. 复数的各部分不一定要是浮点数, 但两部分必须是同类型的: 或者都是有理数, 或者是同一浮点数子类型. 构造复数时, 如果指定的两个部分不是同一类型, 则内部将其转换为同一类型(有理数部分转换为浮点数). 如果虚部是整数`0`, 有类型`(complex rational)`的对象内部作为有理数表示.

更多信息见**`#C`**和**22 打印器**中相应部分.

### 2.3.3 cons中的`.`

如果记号只由点号构成(没有转义符号), 则发出类型为`reader-error`的错误信号, 除了这种情况: 如果记号是单个点号, 且出现在点对单元中允许出现点号的位置, 则它被作为该语法的一部分被接受而不发出错误信号. 见**`(`**

### 2.3.4 符号记号

不是可能的数值、不包含包标记且不完全由点号构成的记号总是被解释为符号(Symbol). 是可能的数值但不满足数值语法的机号是保留记号, 有依赖于实现的解释. 在所有其他情况中, 记号构成符号的名称.

下图展示了符号的打印表示, 这里假设当前`readtable`的大小写是`:upcase`.

图 2-15. 符号的打印表示示例(1/2).

```
    FROBBOZ         The symbol whose name is FROBBOZ.
    frobboz         Another way to notate the same symbol.
    fRObBoz         Yet another way to notate it.
    unwind-protect  A symbol with a hyphen in its name.
    +$              The symbol named +$.
    1+              The symbol named 1+.
    +1              This is the integer 1, not a symbol.
    pascal_style    This symbol has an underscore in its name.
    file.rel.43     This symbol has periods in its name.
    \(              The symbol whose name is (.
    \+1             The symbol whose name is +1.
    +\1             Also the symbol whose name is +1.
    \frobboz        The symbol whose name is fROBBOZ.
    3.14159265\s0   The symbol whose name is 3.14159265s0.
    3.14159265\S0   A different symbol, whose name is 3.14159265S0.
    3.14159265s0    A possible short float approximation to <PI>.
```

图 2-16. 符号的打印表示示例(2/2).

```
    APL\\360            The symbol whose name is APL\360.
    apl\\360            Also the symbol whose name is APL\360.
    \(b^2\)\-\4*a*c     The name is (B^2) - 4*A*C. Parentheses and two spaces in it.
    \(\b^2\)\-\4*\a*\c  The name is (b^2) - 4*a*c. Letters explicitly lowercase.
    |"|                 The same as writing \".
    |(b^2) - 4*a*c|     The name is (b^2) - 4*a*c.
    |frobboz|           The name is frobboz, not FROBBOZ.
    |APL\360|           The name is APL360.
    |APL\\360|          The name is APL\360.
    |apl\\360|          The name is apl\360.
    |\|\||              Same as \|\| ---the name is ||.
    |(B^2) - 4*A*C|     The name is (B^2) - 4*A*C. Parentheses and two spaces in it.
    |(b^2) - 4*a*c|     The name is (b^2) - 4*a*c.
```

在处理解析符号时, 从构成表示符号的记号的字符中移除实现定义的属性是依赖于实现的.

当解析符号的语法时, Lisp读取器在当前包中查找符号的名字. 这个查找过程可能包括在另外一个包中查找, 当前包继承了这个保的外部符号. 如果找到了名称, 则返回相应的符号. 如果没有找到符号(即当前包中没有可访问的同名符号), 则创建一个新符号, 并作为内部符号放在当前包中.当前包称为符号的属主(主包), 这个符号在当前包中被内部化. 如果这个名称后续被读取且这个包仍是当前包, 则会找到相同的符号并返回.

### 2.3.5 记号的有效模式

记号的有效模式汇总在下图中:

图 2-17. 记号的有效模式.

```
    nnnnn              ; 数值
    xxxxx              ; 当前包中的符号
    :xxxxx             ; KEYWORD包中的符号
    ppppp:xxxxx        ; ppppp包中的外部符号
    ppppp::xxxxx       ; 可能是ppppp包中的内部符号
    :nnnnn             ; 未定义
    ppppp:nnnnn        ; 未定义
    ppppp::nnnnn       ; 未定义
    ::aaaaa            ; 未定义
    aaaaa:             ; 未定义
    aaaaa:aaaaa:aaaaa  ; 未定义
```

注意: `nnnnn`有数值语法, `xxxxx`和`ppppp`没有数值语法, `aaaaa`有任意语法.

关于包标记的规则汇总如下. 每种情况中均提供了示例, 这里假设当前`readtable`的大小写是`:upcase`.

1. 如果由单个包标记, 出现在记号的开始处, 则该记号解释为`KEYWORD`包中的符号. 同时将新创建符号的`symbol-value`设置为同一符号, 从而该符号可以自求值.  
    
2. 例如: 读取`:bar`时, 将`BAR`作为`KEYWORD`的外部符号.
3. 如果由单个包标记不在记号的开始或结尾处, 将记号分为两个部分. 第一部分描述包, 第二部分是该包中可用的外部符号的名称.  
    
4. 例如: 读取`foo:bar`, 在名为`FOO`的包中查找外部符号`BAR`.
5. 如果由两个相邻的包记号, 且不在记号的开始或结尾处, 将记号分为两个部分. 第一部分描述包, 第二部分是该包中的符号的名称(可能是内部符号).  
    
6. 例如: 读取`foo::bar`, 在名称`FOO`的包中查找符号`BAR`.
7. 如果记号中没有包标记, 且没有可能的数值语法, 则整个记号是符号的名称. 在当前包中查找该符号.  
    
8. 例如: 读取`bar`, 在当前包中查找符号`BAR`.
9. 如果在记号中使用了其他包标价, 则后果是未描述的. 符号名称中使用包标记的其他用法在标准中未定义, 但保留给依赖于实现使用.

例如, 当前`readtable`的大小写是`:upcase`, `editor:buffer`引用包`editor`中外部符号`BUFFER`, 而不管当前包中是否有名为`BUFFER`的符号. 如果没有包名称为`editor`, 或者包`editor`中没有名称为`BUFFER`的符号, 或者包`editor`未导出`BUFFER`, 则读取器发出可被修复的错误. 如果看到`editor:buffer`, 其效果与当前包是`EDITOR`读取符号`buffer`一致.

### 2.3.6 包系统一致性规则

下面的规则在`*package*`的值未改变时, 可用于包系统:

- 读-读一致性
- 读相同的符号名称, 总是返回同一符号.
- 打印-读一致性
- 内部符号总是打印为字符序列, 读回时产生同一符号.
- 打印-打印一致性
- 如果两个内部符号不相同, 则它们的打印表示也会是不同的字符序列.

不管任何隐式的内部化, 这些规则为真. 只要当前包为改变, 不管加载文件顺序或实际键入符号的历史, 结果总是可重现的. 如果`*package*`的值被修改, 之后再改为前一个值, 一致性被保持. 违背这些规则的方法有: 可以通过从一个错误开始修改`*package*`的值来强制修改符号或包、调用了这些函数: `unintern`、`unexport`、`shadow`、`shadowing-import`、`unuse-package`.

这些约束中的一个在两个命名的符号间被违背, 才产生不一致性. `shadow`、`unexport`、`unintern`和`shadowing-import`只会影响相同名称(在`string=`含义下相同)的符号的一致性.

## 2.4 标准宏字符

如果读取器遇到宏字符, 则调用宏字符相关的读取器宏函数, 可能生成对象并返回. 这个函数可能读取流中宏字符后后面的字符, 以任意语法解析出对象后返回该对象.

任意字符可以设置为宏字符. 复合标准的实现中初始定义的宏字符包括:

### 2.4.1 `(`(left-parenthesis)

`(`开始读取一个列表. `read`被递归调用读取输入流中后续的对象, 直到遇到`)`. 返回对象的列表. `(a b c)`被读取为一个三个对象(符号`a`,`b`,`c`)的列表. `)`不需要在列表中最后一对象的打印表示之后, 它的前面可以有空白字符和注释.

如果`)`之前没有对象, 则读取为零个对象的列表(空列表).

如果一个记号是不在转义字符后的点号, 并在其他对象之后被读取, 点号后有且只有一个对象: `(a b c . d)`. 这意味着列表中最后一个cons的cdr不是`nil`, 而是点号后的对象. 上面的示例等价于求值: `(cons 'a (cons 'b (cons 'c 'd)))`. 类似的:

```
    (cons 'this-one 'that-one) => (this-one . that-one)
```

允许点号之后的对象是一个列表:

```
    (a b c d . (e f .  (g))) == (a b c d e f g)
```

关于列表如何打印的信息见**22 打印器**中相应部分.

### 2.4.2 `)`(right-parenthesis)

`)`只有在与`(`联合使用时才有效.

### 2.4.3 `'`(single-quote)

**语法**: `'<<expr>>`

单引号引入了被引用的表达式. 被Lisp读取器解析为`(quote exp)`. 见特殊操作符**quote**.

#### 2.4.3.1 示例: 单引号

```
    'foo =>  FOO
    ''foo =>  (QUOTE FOO)
    (car ''foo) =>  QUOTE
```

### 2.4.4 `;`(semicolon)

**语法**: `;<<text>>`

分号引入可被忽略的字符, 例如注释. 分号和其后直到下一个换行符或文件结束符杜呗忽略.

#### 2.4.4.1 示例: 分号

```
    (+ 3 ; three
       4)
    =>  7
```

#### 2.4.4.2 备注: 分号的风格

一些文本编辑器有基于开始注释的分号数量的所需缩进的假设. 下面的风格约定是常见的, 但并不是普遍适用的.

##### 2.4.4.2.1 使用单个分号

以单个分号开始的注释在右端同一列对齐(有时称其为注释列). 这种注释通常只用于注释它出现的行的代码. 偶尔有两个或三个一起的行中均有这种注释, 除第一行外, 其他行前加一个空格字符(在分号之后).

##### 2.4.4.2.2 使用两个分号

以两个分号开始的注释与其注释的代码中形式的缩进层次相同. 这种注释通常描述程序在这里的状态.

##### 2.4.4.2.3 使用三个分号

以三个分号开始的注释居左对齐. 这种注释通常用于一个定义或一组定义, 而不是在定义中.

##### 2.4.4.2.4 使用四个分号

以四个分号开始的注释居左对齐. 这种注释通常包含作为代码标题的短文本, 也可以是用于生成文档形式的程序的头和脚注.

##### 2.4.4.2.5 示例: 分号的风格

```
;;;; Math Utilities

;;; FIB computes the the Fibonacci function in the traditional
;;; recursive way.

(defun fib (n)
  (check-type n integer)
  ;; At this point we're sure we have an integer argument.
  ;; Now we can get down to some serious computation.
  (cond ((< n 0)
         ;; Hey, this is just supposed to be a simple example.
         ;; Did you really expect me to handle the general case?
         (error "FIB got ~D as an argument." n))
        ((< n 2) n)             ;fib[0]=0 and fib[1]=1
        ;; The cheap cases didn't work.
        ;; Nothing more to do but recurse.
        (t (+ (fib (- n 1))     ;The traditional formula
              (fib (- n 2)))))) ; is fib[n-1]+fib[n-2].
```

### 2.4.5 `"`(double-quote)

**语法**: `"<<text>>"`

双引号用于开始和结束一个字符串. 当读取器遇到双引号时, 继续读取后续字符并累积直到遇到另一个双引号. 如果遇到单转义字符, 忽略该字符, 下一字符被累积. 累积的字符作为简单字符串返回. 在处理过程中移除哪些累积字符的属性是依赖于实现的.

示例:

图 2-18. 双引号使用示例.

```
    "Foo"                      ;A string with three characters in it
    ""                         ;An empty string
    "\"APL\\360?\" he cried."  ;A string with twenty characters
    "|x| = |-x|"               ;A ten-character string
```

注意: 在字符串中放置单转义字符或一个双引号时, 这些字符前需要有一个单转义字符. 多转义字符在字符串中不需要转义.

### 2.4.6  `` ` `` (backquote)

反引号引入了需要构建的数据结构的模板. 例如:

```
`(cond ((numberp ,x) ,@y) (t (print ,x) ,@y))
```

基本上等价于:

```
(list 'cond
      (cons (list 'numberp x) y)
      (list* 't (list 'print x) y))
```

当模板中出现`,`时, `,`后紧随的表达式需要被求值后插入在那一点. 例如, 假设`b`有值`3`, 求值形式 `` `(a b ,b ,(+ b 1) b) ``的结果为`(a b 3 4 b)`.

如果在模板中, `,`后紧随`@`, 则`@`后紧随的形式被求值为一个对象列表, 列表中对象插入那一点. 例如, 如果`x`有值`(a b c)`, 则

```
`(x ,x ,@x foo ,(cadr x) bar ,(cdr x) baz ,@(cdr x))
=>  (x (a b c) a b c foo b bar (b c) baz b c)
```

反引号的语法汇总如下:

- `` `basic `` 与`'basic`相同, 即`(quote basic)`, 这里表达式`basic`不是列表或向量.
- `` `,form `` 与`form`相同, 这里`form`的表示不以`@`或`.`开始.
- `` `,@form `` 有未定义的后果.
- `` `(x1 x2 x3 ... xn . atom) `` 被解释为`` `(append [x1] [x2] [x3] ... [xn] (quote atom)) ``, 这里的`[xj]`用于表示`xj`上的转换:  
    - `` `[form] `` 解释为``(list `form`)``, 有必须再次解释的反引用形式
    - `` `[,form] `` 解释为`(list form)`
    - `` `[,@form] `` 解释为`form`.
- `` `(x1 x2 x3 ... xn) `` 可被解释为`` `(x1 x2 x3 ... xn . nil) ``.
- `` `(x1 x2 x3 ... xn . ,form) `` 被解释为`(append [x1] [x2] [x3] ... [xn] form)`
- `` `(x1 x2 x3 ... xn . ,@form) `` 有未定义的后果.
- `` `#(x1 x2 x3 ... xn) `` 被解释为``(apply #'vector `(x1 x2 x3 ... xn)`)``.

任何使用`,@`的地方, 可以使用 `,.` 作为替代, 表示允许在其后的列表结构上执行破坏性操作(实际上是使用`nconc`替换`append`).

如果使用了**嵌套**的反引用语法, 则最内层的反引用形式应该首先被展开. 这意味着如果一行中出现多个`,`, 则最左边的属于最内层的`` ` ``.

实现可以自由的将反引用形式`F1`解释为任意形式`F2`, 只需要在应用上述定义求值时在`equal`语义下生成同样的结果, 替换形式`F2`的副作用行为也与上述定义一致. 构造出的模板副本可能也不可能与模板本身共享列表结果. 作为示例, 上面的定义将

```
`((,a b) ,c ,@d)
```

解释为

```
(append (list (append (list a) (list 'b) 'nil)) (list c) d 'nil)
```

但解释为下面的任何一个也是合法的:

```
(append (list (append (list a) (list 'b))) (list c) d)
(append (list (append (list a) '(b))) (list c) d)
(list* (cons a '(b)) c d)
(list* (cons a (list 'b)) c d)
(append (list (cons a '(b))) (list c) d)
(list* (cons a '(b)) c (copy-list d))
```

#### 2.4.6.1 备注: 反引用

因为Lisp读取器如何解析包含反引用读取器宏的表达式的精确行为未被描述, 允许实现自由的选择保留了已被描述的语义的表示.

通常实现会选择便于表达式美化打印的表示, 所以``(pprint `(a ,b))``会显示`(a, b)`, 而不是`(list 'a b)`. 但这不是必须的.

没有办法做出选择的实现者可以参考 **IEEE Standard for the Scheme Programming Language**, 这个标准中有对兼容一些用户社区有用的这类表达式的表示的常见选择. 但是不要求任何符合标准的实现使用这些表示.

### 2.4.7 `,`(comma)

逗号是反引用语法的一部分, 见**2.4.6 <code>&#x60;</code>(backquote)**. 在其他地方使用逗号是无效的.

### 2.4.8 `#`(sharpsign)

`#`是非终结的分发宏字符, 读取可选的数字序列, 再读取一个字符, 并使用这个字符选择一个读取器宏函数.

标准语法中包含`#`字符引入的构造. 这些构造的语法是: 一个表明构造的类型的字符, 后跟一些形式的参数. 如果这个字符是字符, 其大小写是不重要的, 例如`#O`和`#o`是等价的.

一些`#`构造允许在`#`和字符质检出现一个无符号的数值.

与分发宏字符`#`相关的读取器宏总结如下:

图 2-19. 标准`#`分发宏字符语法.

```
分发字符        意图                      分发字符        意图
Backspace      signals error            {              undefined*
Tab            signals error            }              undefined*
Newline        signals error            +              read-time conditional
Linefeed       signals error            -              read-time conditional
Page           signals error            .              read-time evaluation
Return         signals error            /              undefined
Space          signals error            A, a           array
!              undefined*               B, b           binary rational
"              undefined                C, c           complex number
#              reference to = label     D, d           undefined
$              undefined                E, e           undefined
%              undefined                F, f           undefined
&              undefined                G, g           undefined
'              function abbreviation    H, h           undefined
(              simple vector            I, i           undefined
)              signals error            J, j           undefined
*              bit vector               K, k           undefined
,              undefined                L, l           undefined
:              uninterned symbol        M, m           undefined
;              undefined                N, n           undefined
<              signals error            O, o           octal rational
=              labels following object  P, p           pathname
>              undefined                Q, q           undefined
?              undefined*               R, r           radix-n rational
@              undefined                S, s           structure
[              undefined*               T, t           undefined
\              character object         U, u           undefined
]              undefined*               V, v           undefined
^              undefined                W, w           undefined
_              undefined                X, x           hexadecimal rational
`              undefined                Y, y           undefined
|              balanced comment         Z, z           undefined
~              undefined                Rubout         undefined
```

标记了`*`的项是显式预留给用户的, 符合标准的实现不存在定义.

注意到上面的表中没有出现数字, 这是因为记法`#0`, `#1`, ... `#9`保留做其他用途. 当数字在`#`之后出现, 不作为分发字符, 累积一个无符号整数参数, 并作为参数传递给数字后面的字符的读取器宏. 例如`#2A((1 2) (3 4))`使用带有参数`2`的`#A`.

#### 2.4.8.1 `#\`(sharpsign backslash)

**语法**: `#\<<x>>`

当记号`x`是单一字符时, 被解析为字面量字符. `#\`后区分字符的大小写: `#\A`与`#\a`表示不同的字符对象. `#\`后可以使用任意单个字符, 甚至是`(`和`)`.

在单字符情况中, `x`必须后接非要素字符. 读取`#\`后, 读取器重读回`\`, 接着读取一个记号, 将初始的`\`视为单转义字符(不管它是否早当前`readtable`中).

当记号`x`多于一个字符时, `x`必须有不含包标记的符号语法. 在这种情况中, `#\`记法被解析为名称为`(string-upcase x)`的字符, 见**13.1.7 字符名称**.

关于字符对象如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.2 `#'`(sharpsign single-quote)

**语法**: `#'<<expr>>`

Lisp读取器将`#'expression`解析为`(function expression)`, 见**function**.

例如:

```
(apply #'+ l) ==  (apply (function +) l)
```

#### 2.4.8.3 `#(`(sharpsign left-parenthesis)

`#(`与`)`用于表示简单向量.

如果`#`与`(`之间出现了无符号整数, 它被解释为向量的长度. 如果在`)`之前的对象的数量超过这个无符号整数时, 后果未定义. 如果在`)`之前的对象的数量小于这个无符号整数但大于0时, 最后一个对象用于填充向量中的剩余元素. 如果无符号整数不是0, `)`之前的对象数量是0, 后果未定义.

```
#(a b c c c c)
#6(a b c c c c)
#6(a b c)
#6(a b c c)
```

均表示同一事物: 长度为6的想想两, 元素为`a b c c c c`.

```
#(a b c)               ;A vector of length 3
#(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47)
                       ;A vector containing the primes below 50
#()                    ;An empty vector
```

`#()`和`#0()`表示空向量.

关于向量如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.4 `#*`(sharpsign asterisk)

**语法**: `#*<<bits>>`

构造出包含`bits`(0或1构成)标识的简单位向量, 索引从0开始.

**语法**: `#<<n>>*<<bits>>`

构造出的位向量的长度为`n`, 如果`bits`的数量小于`n`但大于0, 则用最后一位填充位向量中剩余部分.

`#*`和`#0*`表示空的位向量.

不管是否提供了可选的数值参数`n`, `*`后面的记号按常见记号定界符定界. 除非`*read-suppress`的值为true, 否则, 在这些情况中将发出类型为`reader-error`的错误信号:

- 记号不完全由0和1组成
- 提供了`n`, 记号超过`n`位
- 提供了`n`, 且`n` > 0, 但记号长度为0

记号中不允许出现单转义字符或多转义字符.

关于位向量如何打印的信息见**22 打印器**中相应部分.

##### 2.4.8.4.1 示例: `#*`

```
#*101111
#6*101111
#6*101
#6*1011
```

均表示元素为`1 0 1 1 1 1`的向量.

```
#*         ;An empty bit-vector
```

#### 2.4.8.5 `#:`(sharpsign colon)

**语法**: `#:<<symbol-name>>`

`#:`引入了名称为`symbol-name`的未内部化符号(uninterned symbol). 每次遇到这个语法时, 都会创建一个不同的符号. `symbol-name`必须有无包前缀的符号的语法.

关于未内部化符号如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.6 `#.`(sharpsign dot)

`#.foo`被解释为对`foo`表示的对象的求值结果. 当遇到`#.`时, 求值在`read`处理中完成. `#.`语法执行`foo`的读时(read-time)求值.

当`*read-eval*`的值为false时, 禁用`#.`, 并抛出类型为`reader-error`的错误信号.

对没有合适的打印表示的对象, 可以使用`#.`记法给出计算该对象的一个形式.

#### 2.4.8.7 `#B`(sharpsign B)

`#B`按二进制读取有理数, 例如:

```
#B1101 ==  13 ;11012
#b101/11 ==  5/3
```

如果`#B`后面的记号没有二进制有理数的语法, 后果是未定义的.

#### 2.4.8.8 `#O`(sharpsign O)

`#O`按八进制读取有理数, 例如:

```
#o37/15 ==  31/13
#o777 ==  511
#o105 ==  69 ;1058
```

如果`#O`后面的记号没有八进制有理数的语法, 后果是未定义的.

#### 2.4.8.9 `#X`(sharpsign X)

`#X`按十六进制读取有理数. 9之上的数字是字母`A`-`F`(及其小写形式). 例如:

```
#xF00 ==  3840
#x105 ==  261 ;10516
```

如果`#X`后面的记号没有十六进制有理数的语法, 后果是未定义的.

#### 2.4.8.10 `#R`(sharpsign R)

`#nR`按`n`进制读取有理数, `n`必须是只有数字构成的整数, 其值范围为2-36. 只使用`n`中有效的数字.

例如, `#3r102`是十进制`11`的另一种写法, `#11R32`是十进制`35`的另一种写法. 对进制数大于10的情况, 使用字母表中的字母. 没有十进制的`#`语法, 因为使用小数点已可满足.

图 2-20. 进制指示器示例.

```
#2r11010101  ;Another way of writing 213 decimal
#b11010101   ;Ditto
#b+11010101  ;Ditto
#o325        ;Ditto, in octal radix
#xD5         ;Ditto, in hexadecimal radix
#16r+D5      ;Ditto
#o-300       ;Decimal -192, written in base 8
#3r-21010    ;Same thing in base 3
#25R-7H      ;Same thing in base 25
#xACCEDED    ;181202413, in hexadecimal radix
```

如果`#nR`后面的记号没有`n`进制有理数的语法, 后果是未定义的.

#### 2.4.8.11 `#C`(sharpsign C)

`#C`后面的对象必须是一个两个元素均为实数的列表. 这两个实数分别表示复数的实部和虚部. 如果这两个部分不是同一数据类型的, 将使用**12.1.1.2 数值操作中的传染**.

`#C(real imag)`等价于`#.(complex (quote real) (quote imag))`, 除了`#C`不受`*read-eval*`的影响. 见**complex**.

下面是`#C`的使用示例:

图 2-21. 复数示例.

```
#C(3.0s1 2.0s-1)  ;A complex with small float parts.
#C(5 -3)          ;A ``Gaussian integer''
#C(5/3 7.0)       ;Will be converted internally to #C(1.66666 7.0)
#C(0 1)           ;The imaginary unit; that is, i.
```

更多细节见**22 打印器**中相应部分和**2.3.2.3 复数的语法**.

#### 2.4.8.12 `#A`(sharpsign A)

`#nAobject`构造维度为`n`的数组, 使用`obect`作为`make-array`的参数`:inital-contents`的值.

例如, `#2A((0 1 5) (foo 2 (hot dog)))`表示2X3的矩阵:

0 1 5 foo 2 (hot dog)

与之相反, `#1A((0 1 5) (foo 2 (hot dog)))`表示长度为2的向量, 每个元素是个列表:

(0 1 5) (foo 2 (hot dog))

`#0A((0 1 5) (foo 2 (hot dog)))`表示0维数组, 其唯一的元素是个列表:

((0 1 5) (foo 2 (hot dog)))

`#0A foo`表示0维数组, 其唯一的元素的符号`foo`. `#1A foo`不是有效的, 因为`foo`不是个序列.

如果列表中一些维度的表示被解析为0, 则所有后续维度也被视为0.

关于数组如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.13 `#S`(sharpsign S)

`#s(name slot1 value1 slot2 value2 ...)`表示一个结构. 这只在`name`是已用`defstruct`定义的结构类型的名称, 且该结构类型有标准的构造器函数. `cm`为构造器函数的名称, 则这个语法等价于:

1. keyword1 'value1 keyword2 'value2 ...)

每个`keywordj`是计算这个的结果:

(intern (string slotj) (find-package 'keyword))

其效果是使用指定的槽和值调用构造器函数.

`#S`语法返回构造函数返回的对象.

关于结构如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.14 `#P`(sharpsign P)

`#P`后面的对象必须是个字符串.

`#P<<expression>>`等价于`#.(parse-namestring '<<expression>>')`, 除了`#P`不受`read-eval`的影响.

关于路径名如何打印的信息见**22 打印器**中相应部分.

#### 2.4.8.15 `#n=`(sharpsign equal-sign)

`#n=object`读取有打印表示`object`的对象. 这个对象被标记上`n`, 一个必备的无符号整数, 用于被语法`#n#`引用. 这个标记的作用域是最外层调用`read`的表达式, 在同一表达式中同一比较不可出现两次.

#### 2.4.8.16 `#n#`(sharpsign sharpsign)

`#n#`, `n`是个必须的无符号整数, 引用被`#n=`标记的相同对象. 例如下面代码中在变量`y`中创建的结构:

```
(setq x (list 'p 'q))
(setq y (list (list 'a 'b) x 'foo x))
(rplacd (last y) (cdr y))
```

可以使用这种方式表示:

```
((a b) . #1=(#2=(p q) foo #2# . #1#))
```

不使用这种标记, 将`print-length`设置为10, `print-circle`设置为`nil`时, 这个结构的打印输出为:

```
((a b) (p q) foo (p q) (p q) foo (p q) (p q) foo (p q) ...)
```

引用`#n#`只能出现在标签`#n=`之后, 不允许前向引用. 引用不允许出现在被标记的对象中(`#n=#n#`), 因为这种情况下被`#n=`标记的对象没有被很好的定义.

#### 2.4.8.17 `#+`(sharpsign plus)

**语法**: `#+test expression`

`#+`提供了读时条件化便利. 如果特性表达式`test`成功, 则这个文本记法表示打印形式为`expression`的对象. 如果特性表达式`test`失败, 则这个文本记法被视为空白.

关于特性表达式的成功和失败的详细描述, 见**24.1.2.1 特性表达式**.

`#+`首先读取特性表达式, 如果特性表达式失败, 则跳过后续的形式. 读取`test`时, 当前包是`KEYWORD`. 跳过形式由将`*read-suppress*`绑定为true后再调用`read`完成.

#### 2.4.8.18 `#-`(sharpsign minus)

`#-`类似于`#+`, 只不过他会在`test`成功时跳过`expression`, 即:

1. -test expression == #+(not test) expression

示例见**24.1.2.1.1 示例: 特性表达式**.

#### 2.4.8.19 `#|...|#`(sharpsign vertica-bar)

`#|...|#`被读取器视为注释. `#|`与`|#`必须成对出现, 此外可以包含任意字符.

##### 2.4.8.19.1 示例: `#|...|#`

下面的示例使用了`#|...|#`记法:

```
;;; In this example, some debugging code is commented out with #|...|#
;;; Note that this kind of comment can occur in the middle of a line
;;; (because a delimiter marks where the end of the comment occurs)
;;; where a semicolon comment can only occur at the end of a line
;;; (because it comments out the rest of the line).
 (defun add3 (n) #|(format t "~&Adding 3 to ~D." n)|# (+ n 3))

;;; The examples that follow show issues related to #| ... |# nesting.

;;; In this first example, #| and |# always occur properly paired,
;;; so nesting works naturally.
 (defun mention-fun-fact-1a ()
   (format t "CL uses ; and #|...|# in comments."))
=>  MENTION-FUN-FACT-1A
 (mention-fun-fact-1a)
>>  CL uses ; and #|...|# in comments.
=>  NIL
 #| (defun mention-fun-fact-1b ()
      (format t "CL uses ; and #|...|# in comments.")) |#
 (fboundp 'mention-fun-fact-1b) =>  NIL
```

```
;;; In this example, vertical-bar followed by sharpsign needed to appear
;;; in a string without any matching sharpsign followed by vertical-bar
;;; having preceded this.  To compensate, the programmer has included a
;;; slash separating the two characters.  In case 2a, the slash is
;;; unnecessary but harmless, but in case 2b, the slash is critical to
;;; allowing the outer #| ... |# pair match.  If the slash were not present,
;;; the outer comment would terminate prematurely.
 (defun mention-fun-fact-2a ()
   (format t "Don't use |\# unmatched or you'll get in trouble!"))
=>  MENTION-FUN-FACT-2A
 (mention-fun-fact-2a)
>>  Don't use |# unmatched or you'll get in trouble!
=>  NIL
 #| (defun mention-fun-fact-2b ()
      (format t "Don't use |\# unmatched or you'll get in trouble!") |#
 (fboundp 'mention-fun-fact-2b) =>  NIL
```

```
;;; In this example, the programmer attacks the mismatch problem in a
;;; different way.  The sharpsign vertical bar in the comment is not needed
;;; for the correct parsing of the program normally (as in case 3a), but
;;; becomes important to avoid premature termination of a comment when such
;;; a program is commented out (as in case 3b).
 (defun mention-fun-fact-3a () ; #|
   (format t "Don't use |# unmatched or you'll get in trouble!"))
=>  MENTION-FUN-FACT-3A
 (mention-fun-fact-3a)
>>  Don't use |# unmatched or you'll get in trouble!
=>  NIL
 #|
 (defun mention-fun-fact-3b () ; #|
   (format t "Don't use |# unmatched or you'll get in trouble!"))
 |#
 (fboundp 'mention-fun-fact-3b) =>  NIL
```

##### 2.4.8.19.2 备注: `#|...|#`

一些文本编辑器将`|...|`视为不能嵌套的平衡对. 为绕过这种限制, 一些程序员使用`#||...#||...||#...||#`, 而不是`#|...#|...|#...|#`. 注意到这种用法不是一个新的读取器宏, 有时可以看到这样的代码:

```
#|| (+ #|| 3 ||# 4 5) ||#
```

它等价于:

```
#| (+ #| 3 |# 4 5) |#
```

#### 2.4.8.20 `#<`(sharpsign less-than-sign)

`#<`不是有效的读取器语法. Lisp读取器在遇到`#<`时会发出类型为`reader-error`的错误信号.

这种语法通常用于打印不能读对的对象.

#### 2.4.8.21 `#` (sharpsign whitespace)

`#`后跟空白不是有效的读取器语法. Lisp读取器在遇到`#<Newline>`或`#<Space>`时会发出类型为`reader-error`的错误信号.

#### 2.4.8.22 `#)`(sharpsign right-parenthesis)

`#)`不是有效的读取器语法. Lisp读取器在遇到`#)`时会发出类型为`reader-error`的错误信号.

### 2.4.9 重读缩写表达式

注意到, Lisp读取器在读取到因长度或等级限制的缩写的表达式(见`*print-level*`, `*print-length*`, `*print-lines*`)、`#`后跟空白和`#)`时, 会发出类型为`reader-error`的错误信号.

# 3 求值和编译

## 3.1 求值(Evaluation)

代码的执行可以通过多种方式完成, 包括从解释表示程序的形式到调用编译器生成的已编译的代码.

求值(Evaluation)是表示在Common Lisp中程序执行的过程. 求值的机制包括隐式的使用Lisp REPL的作用, 显式的使用函数`eval`、`compile`, `compile-file`和`load`. 这些方法可能共享相同的执行策略, 或者每个有不同的策略.

由`eval`和`compile-file`处理的复合标准的程序的行为可能存在差异, 见**3.2.2.3 语义约束**.

求值可以被理解为是一个模型, 其中解释器递归的遍历一个形式, 在遍历过程中执行计算的每一步. 这个描述Common Lisp程序的语义的模型, 在**3.1.2 求值模型**中描述.

### 3.1.1 环境的介绍

**绑定** 是名称与其指示物之间的关联. 特定特殊操作符在词法环境或动态环境中建立绑定.

**环境** 是一组绑定和其他在求值期间使用的信息(例如: 关联名称和它的含义).

环境中的绑定按名称空间划分. 同一个名称可以在每个环境中同时有多于一个的绑定, 但在每个命名空间中只可以有一个绑定.

#### 3.1.1.1 全局环境

**全局环境**是包含无限期作用域和extent的绑定的环境. 包括:

- 动态变量和常值变量的绑定
- 函数、宏和特殊操作符的绑定
- 编译器宏的绑定
- 类型和类名称的绑定
- 公告(Proclamation)相关的信息.

#### 3.1.1.2 动态环境

求值的**动态环境**是包含这样的绑定的环境: 在建立绑定的形式的执行中, 绑定时间范围在建立时刻和解建立时刻中.

动态环境包括:

- 动态变量的绑定信息
- 活跃捕获标记的信息
- `unwind-protect`建立的退出点的信息
- 活跃处理器和重启器的信息

在程序执行的任一时间点, 活跃的动态环境被称为 **当前动态环境**.

在给定名称空间中, 称名称是已绑定的(bound), 如果:

- 当前动态环境中有该名称的绑定, 或者, 没有时,
- 在全局环境中有该名称的绑定.

#### 3.1.1.3 词法环境

在程序中某一位置求值的**词法环境**是这样的环境, 在包含这一位置的形式中有词法作用域的信息.

词法环境包括:

- 词法变量和符号宏的绑定
- 函数和宏的绑定(包括局部禁止的编译器宏)
- 块标记绑定
- 声明(Declaration)的信息

在程序中任一位置活跃的词法环境, 被称为当前词法环境.

在给定名称红键中, 称名称在词法环境中是已绑定的, 如果:

- 在当前词法环境中有该名称的绑定, 或者, 没有时,
- 在全局环境中有该名称的绑定.

##### 3.1.1.3.1 空词法环境

**空词法环境** 等价于全局环境.

尽管通常环境对象的表示是依赖于实现的, `nil`可用于需要环境对象的地方, 以表示空词法环境.

#### 3.1.1.4 环境对象

一些操作符使用称为**环境对象**的对象, 环境对象表示: 为在给定词法环境中的一个形式上执行语义分析所需的一组词法绑定. 环境对象中的一组绑定可能是实际执行求值所需的绑定集合的子集; 例如, 在相应词法环境中与变量名称和函数名称相关的值, 可能在环境对象中不可用.

环境对象的类型和本质是依赖于实现的. 宏函数的环境参数的值是环境对象的一个例子.

对象`nil`用于环境对象时, 表示空词法环境, 见**3.1.1.3.1 空词法环境**.

### 3.1.2 求值模型

Common Lisp系统求值形式时, 需要考虑词法、动态和全局环境. 下面的章节描述Common Lisp求值模型.

#### 3.1.2.1 形式求值

**形式** 分为三类: 符号, cons和自求值对象.

##### 3.1.2.1.1 符号作为形式

如果一个形式是**符号**, 则它是 **符号宏** 或者 **变量**.

如果符号命名了一个 **符号宏**, 则在当前词法环境中, 存在这个符号到符号宏的绑定(见`define-symbol-macro`和`symbol-macrolet`). 如果这个符号是个符号宏, 则获取它的展开函数. 展开函数是两个参数的函数, 并在调用 **宏展开钩子** 时被调用, 展开函数作为第一个参数, 符号作为第二个参数, 环境对象(当前词法环境)作为第三个参数. 宏展开钩子调用展开函数, 该形式作为第一个参数, 环境作为第二个参数. 由宏展开钩子返回的展开函数的值, 是个形式. 结果形式在原始符号的位置被处理.

如果形式是不是符号宏的符号, 则它是 **变量** 的名称, 返回该变量的值. 存在三种变量: **词法变量** 、**动态变量** 和 **常值变量**. 变量可以保存一个对象. 变量上的主要操作是读和写它的值.

如果引用一个 **未绑定变量**, 则发出类型为`unbound-variable`的错误信号.

非常值变量可以通过使用`setq`赋值或使用`let`绑定. 下图列出了一下可用于赋值、绑定和定义变量的已定义名称。

图 3-1. 一些可用于变量的已定义名称.

```
boundp
defconstant
defparameter
defvar
lambda
let
let*
makunbound
multiple-value-bind
multiple-value-setq
progv
psetq
set
setq
symbol-value
```

###### 3.1.2.1.1.1 词法变量

**词法变量**是只能在建立该变量的形式的词法作用域中引用的变量. 词法变量有词法作用域. 每当形式创建变量的词法绑定时, 建立一个新的绑定.

在一个词法变量名称绑定的作用域中, 将该名称作为变量使用视为对该绑定的引用, 除了被一个形式建立该变量名称的新绑定时该变量被遮盖, 或者一个形式中局部声明该变量为`special`.

一个词法变量总是有值. 不存在不带初始值引入词法变量绑定的操作符, 也不存在将词法变量置为未绑定的操作符.

词法变量的绑定可以在词法环境中找到.

###### 3.1.2.1.1.2 动态变量

如果下面的一个条件时, 一个变量被称为**动态变量**:

- 被局部或全局的公告为`special`
- 文本的出现在创建该名称的变量的动态绑定的形式中, 该绑定没有被一个创建相同变量名的词法绑定的形式遮盖.

在任意程序中, 可以在任意时刻引用动态变量, 不存在引用动态变量的文本限制. 在任意时刻, 给定名称的所有动态变量引用一个绑定, 在动态环境或全局环境中.

动态变量绑定的值部分可能为空, 在这种情况下, 动态变量被称为无值的或未绑定的. 使用`makeunbound`将一个动态变量置为未绑定的.

绑定动态变量的效果是, 为在求值创建该动态绑定的形式期间, 创建新的程序中所有对该动态变量引用的绑定.

动态变量可以在绑定它的形式的动态extent之外引用. 这种变量有时被称为 **全局变量**, 但它仍是一个动态变量, 它的绑定存在于全局环境而不是某个动态环境.

一个动态变量是未绑定的, 直到显式的给它赋值, 除了那些在该规范中或实现中定义了初始值的变量.

###### 3.1.2.1.1.3 常值变量

**常值变量**又称命名的常量. 尝试给它赋值或创建绑定的后果是未定义的, 除了使用`defconstant`兼容的重定义一个常值变量.

Common Lisp或实现中定义的关键字和符号是常量(例如: `nil`, `t`或`pi`), 使用`defconstant`声明的符号是常值变量.

###### 3.1.2.1.1.4 命名词法和动态变量的符号

同一符号可以同时命名词法变量和动态变量, 但不能在同一词法环境中.

在下面的示例中, 使用符号`x`, 作为词法变量的名称和作为动态变量的名称.

```
(let ((x 1))            ;Binds a special variable X
  (declare (special x)) ; 声明为特殊变量
  (let ((x 2))          ;Binds a lexical variable X
    (+ x                ;Reads a lexical variable X
       (locally (declare (special x)) ; 局部声明为特殊变量
                x))))   ;Reads a special variable X
=>  3
```

##### 3.1.2.1.2 cons作为形式

用作形式的cons被称为**复合形式**.

如果复合形式的car部分是一个符号, 该符号是一个操作符的名称, 依赖于在当前词法环境中操作符的函数绑定, 这个形式可以是 **特殊形式**、**宏形式** 或 **函数形式**. 如果该操作符不是特殊操作符或宏名称, 则被认为是函数名称(甚至不存在该函数定义时).

如果复合形式的car部分不是一个符号, 则该car必须是一个lambda表达式, 这时这个复合形式是 **lambda形式**.

复合形式是如何处理的, 依赖于它是特殊形式、宏形式、函数形式, 还是lambda形式.

###### 3.1.2.1.2.1 特殊形式(Special Forms)

**特殊形式**是有特殊语法或/和特殊求值规则的形式, 可能操作求值环境和/或控制流. 特殊操作符可以访问当前词法环境和当前动态环境. 每个特殊操作符定义了它的子表达式的行为, 哪些是形式, 哪些是特殊语法等等.

一些特殊操作符, 在求值特殊形式的子形式时, 创建新的词法或动态环境. 例如, `block`创建一个新的词法环境, 它与求值`block`形式时的词法环境相同, 此外创建了将块名称绑定到从该块中退出的退出点的绑定.

Common Lisp中特殊操作符的名称是固定的, 用户无法定义特殊操作符. 下图列出了Common Lisp中被定义为特殊操作符的符号.

图 3-2. Common Lisp特殊操作符.

```
block
catch
eval-when
flet
function
go
if
labels
let
let*
load-time-value
locally
macrolet
multiple-value-call
multiple-value-prog1
progn
progv
quote
return-from
setq
symbol-macrolet
tagbody
the
throw
unwind-protect
```

###### 3.1.2.1.2.2 宏形式(Macro Forms)

(复合形式中, )如果操作符是一个宏的名称, 其关联的宏函数被应用在整个形式上, 应用的结果用来替换原始的形式.

如果在给定词法环境中, 以一个符号和该环境作为参数调用`macro-function`结果为true, 则该符号是一个宏的名称. `macro-function`返回的函数是有两个参数的函数, 称为 **展开函数**. 宏展开钩子的第一个参数是展开函数, 第二个参数是整个宏形式, 第三个参数是(当前词法环境相关的)环境对象. 宏展开钩子接着调用展开函数, 使用形式作为第一个参数, 使用环境作为第二个参数. 展开函数的值是一个形式. 返回的形式在原始形式处被求值.

如果一个宏函数破坏性的修改了其宏参数的任意部分, 后果是未定义的.

宏名称不是函数指示器, 不能作为函数参数用于`apply`、`funcall`、`map`等.

实现可以自由的将Common Lisp特殊操作符作为宏实现. 实现可以自由的将宏操作符作为特殊操作符实现, 需要提供宏的等价定义.

下图列出了可用于宏的已定义名称:

图 3-3. 可用于宏的已定义名称.

```
*macroexpand-hook*
defmacro
macro-function
macroexpand
macroexpand-1
macrolet
```

###### 3.1.2.1.2.3 函数形式(Function Forms)

如果操作符是命名了函数的符号, 该形式表示**函数形式**, 包含该形式的列表的`cdr`将作为参数传递给该函数.

运行时, 当函数名称未定义时, 抛出一个类型为`undefined-function`的错误异常, 见**3.2.2.3 语义约束**.

函数形式按如下方式求值:

- 原始形式中的`cdr`中的子形式按从左至右的方式, 在当前词法和动态环境中求值. 这些求值的主值作为该命名的函数的参数, 子形式其他返回值被忽略
- 从词法环境中检索出操作符的函数值, 按上一步求值出的参数调用该函数

尽管参数子形式的求值顺序是严格从左至右的, 但未描述函数形式中操作符是在参数执行时求值之前、时或者之后查找. 例如, 下面可能返回23或24:

```
(defun foo (x) (+ x 3))
(defun bar () (setf (symbol-function 'foo) #'(lambda (x) (+ x 4))))
(foo (progn (bar) 20))
```

函数名称的绑定可以用一些方法建立. 全局环境中函数名称的绑定, 可以用`defun`、`dfefinition`上`setf`、`symbol-function`上`setf`、`ensure-generic-function`、`defmethod`(隐式的使用`ensure-generic-function`)、`defgeneric`. 词法环境中函数名称的绑定, 可以用`flet`和`labels`.

下图列出了一些函数相关的已定义名称:

图 3-4. 一些函数相关的已定义名称.

```
apply
call-arguments-limit
complement
constantly
defgeneric
defmethod
defun
fboundp
fdefinition
flet
fmakunbound
funcall
function
functionp
labels
map
mapcan
mapcar
mapcon
mapl
maplist
multiple-value-call
reduce
symbol-function
```

###### 3.1.2.1.2.4 lambda形式(Lambda Forms)

lambda形式与函数形式类似, 除了用lambda表达式替代了函数名称.

lambda形式等价于在给定参数上使用`funcall`调用lambda表达式的词法闭包.

更多信息, 见**3.1.3 lambda表达式**.

##### 3.1.2.1.3 自求值对象

不是符号或cons的形式被定义为**自求值对象**. 求值这里对象的结果是该对象自身.

一些特定的符号和cons可能恰好是自求值的, 但作为符号和cons求值规则的特例, 不被视为自求值对象.

破坏性修改字面量对象(包括自求值对象)的后果是未定义的.

###### 3.1.2.1.3.1 示例: 自求值对象

数值、路径名和数组是自求值对象:

```
3 =>  3
#c(2/3 5/8) =>  #C(2/3 5/8)

#p"S:[BILL]OTHELLO.TXT" =>  #P"S:[BILL]OTHELLO.TXT"

#(a b c) =>  #(A B C)
"fred smith" =>  "fred smith"
```

### 3.1.3 lambda表达式

在lambda表达式中, 表达式体在这样的词法环境中求值: 在当前词法环境中添加lambda列表中每个参数与实际参数值的绑定.

绑定是如何基于lambda列表建立的, 见**3.4 lambda列表**.

lambda表达式的体是一个隐式的`progn`, 它返回的值作为lambda表达式的返回值.

### 3.1.4 闭包(Closures)和词法绑定(Lexical Binding)

词法闭包是一个函数, 这个函数可以引用和修改, 文本包含函数定义的绑定形式建立的词法绑定的值.

考虑下面的代码, `x`未被声明为`special`:

```
(defun two-funs (x)
  (list (function (lambda () x))
        (function (lambda (y) (setq x y)))))

(setq funs (two-funs 6))
(funcall (car funs)) =>  6
(funcall (cadr funs) 43) =>  43
(funcall (car funs)) =>  43
```

`function`特殊形式将lambda表达式封入一个闭包中, 捕获lamabda表达式的同事, 也捕获特殊形式求值时的词法环境.

函数`two-funs`返回元素为两个函数的列表, 每个引用了调用`tow-funs`时创建的变量`x`的绑定. 这个变量初始值为6, `setq`可以修改这个绑定. 第一个lambda表达式创建的闭包, 在闭包创建时, 没有快照`x`的值6, 它捕获了`x`的绑定. 第二个函数可用于修改同一捕获的绑定中的值(修改为43), 接着, 这个被修改的变量绑定影响了第一个函数的返回值.

在同一组绑定上的lambda表达式的闭包可能产生多次的情况下, 这些闭包可能也可能不同一的, 这依赖于实现. 即, 两个行为上不可区分的函数可能也可能不是同一的. 两个行为上可区分的函数是不同的. 例如:

```
(let ((x 5) (funs '()))
  (dotimes (j 10)
    (push #'(lambda (z)
              (if (null z) (setq x 0) (+ x z)))
          funs))
  funs)
```

上面这个形式的结果是元素为10个闭包的列表. 每个闭包只需要`x`的绑定. 在各个闭包中, 这是同一个绑定, 但这10个比好对象可能也可能不是同一的. 另一方面,

```
(let ((funs '()))
  (dotimes (j 10)
    (let ((x 5))
      (push (function (lambda (z)
                       (if (null z) (setq x 0) (+ x z))))
            funs)))
 funs)
```

也是元素为10个闭包的列表. 然而, 这这种情况中, 任意两个闭包对象不可是同意的, 因为每个闭包在不同的`x`绑定下封闭, 因使用了`(setq x 0)`这些绑定行为上是可区分的.

```
(let ((funs '()))
  (dotimes (j 10)
    (let ((x 5))
      (push (function (lambda (z) (+ x z)))
           funs)))
  funs)
```

上面形式的结果是元素为10个闭包对象的列表, 这些闭包对象可以也可以不是同一的. 每个闭包中包含不同的`x`绑定, 但因为这些绑定的值相同且不可变的(没有出现`(setq x ...)`), 是不可区分. 编译器可以内部将其转换为:

```
(let ((funs '()))
  (dotimes (j 10)
    (push (function (lambda (z) (+ 5 z)))
          funs))
 funs)
```

这里的闭包可能是同一的.

闭包也可能没有在任何变量绑定上封闭. 在下面的代码片段中:

```
 (mapcar (function (lambda (x) (+ x 2))) y)
```

函数`(lambda (x) (+ x 2))`不包含外部对象的引用. 在这种情况中, `function`形式的所有求值可能返回同一闭包.

### 3.1.5 遮盖(Shadowing)

如果两个使用同一名称`N`建立词法绑定的形式是文本上嵌套的, 在内层形式上对`N`的引用是对在内层形式上建立的绑定的引用; 内层对`N`的绑定**遮盖**外层对`N`的绑定. 在内层形式之外外层形式之内, 对`N`的引用是对外层形式建立的绑定的引用. 例如:

```
(defun test (x z)
  (let ((z (* x 2)))
    (print z))
  z)
```

由`let`建立的变量`z`的绑定遮盖了函数`test`的参数绑定. `print`形式中引用的变量`z`是对`let`绑定的引用. 函数`test`末尾对`z`的引用是对参数`z`的引用.

词法作用域的构造, 表现为每次执行中为每个对象生成新的名称. 因此, 不会出现动态遮盖. 例如:

```
(defun contorted-example (f g x)
  (if (= x 0)
      (funcall f)
      (block here
         (+ 5 (contorted-example g
                                 #'(lambda () (return-from here 4))
                                 (- x 1))))))
```

考虑调用`(contorted-example nil nil 2)`, 结果为4. 在执行时, 有三次对`contorted-example`的调用, 有两个块:

```
(contorted-example nil nil 2)
  (block here1 ...)
    (contorted-example nil #'(lambda () (return-from here1 4)) 1)
      (block here2 ...)
        (contorted-example #'(lambda () (return-from here1 4))
                           #'(lambda () (return-from here2 4))
                           0)
            (funcall f)
                   where f =>  #'(lambda () (return-from here1 4))
                (return-from here1 4)
```

在`funcall`执行时, 有两个块退出点, 每个都有名称`here`. 作为`funcall`操作结果的`return-from`心事引用了外层的退出点`here1`, 而不是内层的`here2`. 它引用在执行函数时(这里的`#'`, 生成被`funcall`调用的函数对象)文本可见的退出点.

如果在这个例子中, 将`(funcall f)`修改为`(funcall g)`, 则`(contorted-example nil nil 2)`的结果为9. 这是因为`funcall`会执行`(return from here2 4)`, 从退出点`here2`返回. 值4从`contorted-example`中间返回, 加上5得到结果9, 这个值从外层块返回.

需要记住的是, 退出点的选择与初始时是最内层或最外层无关, 依赖于函数执行时lambda表达式包装的词法环境.

### 3.1.6 范围(Extent)

`contorted-example`可工作, 是因为在退出点范围内函数`f`被调用.**一旦执行流离开块, 退出点被解除**. 例如:

```
(defun invalid-example ()
  (let ((y (block here #'(lambda (z) (return-from here z)))))
    (if (numberp y) y (funcall y 5))))
```

认为`invalid-example`返回5的错误推理如下: `let`将`y`绑定到`block`的值, 这个值是lambda表达式产生的函数. 因为`y`不是一个数值, 用5作为参数调用. `return-from`从退出点`here`返回5, 因此退出块, 赋予`y`值5, `y`称为数值, 作为`invalid-example`的结果返回.

上面的陈述是错误的原因是退出点有**动态范围**. 关于`return-from`执行的描述是错误的. `return-from`应该发出类型为`control-error`的错误信号, 不是因为它不能引用退出点, 而是因为它正确的引用了一个退出点, 但那个退出点已被解除.

```
>(defun invalid-example ()
  (let ((y (block here #'(lambda (z) (return-from here z)))))
    (if (numberp y) y (funcall y 5))))
INVALID-EXAMPLE
> (invalid-example)

debugger invoked on a SB-INT:SIMPLE-CONTROL-ERROR in thread
#<THREAD "main thread" RUNNING {10004F84C3}>:
  attempt to RETURN-FROM a block or GO to a tag that no longer exists
```

名称对动态退出点绑定的引用, 例如捕获标签, 引用**最近建立的还未解除的**对改名称的绑定. 例如:

```
(defun fun1 (x)
  (catch 'trap (+ 3 (fun2 x))))

(defun fun2 (y)
  (catch 'trap (* 5 (fun3 y))))

(defun fun3 (z)
  (throw 'trap z))
```

考虑`(fun1 7)`, 结果为10. 在`throw`执行时, 有两个名为`trp`的捕获器: 一个在`fun1`中, 另一个在`fun2`中. 后者是最近的, 所以`fun2`中的`catch`返回7. 从`fun3`中看, `fun2`中的`catch`遮盖了`fun1`中的`catch`. 将`fun2`定义为:

```
(defun fun2 (y)
  (catch 'snare (* 5 (fun3 y))))
```

这样两个退出点有不同的名称, 从而`fun1`中的`catch`不会被遮盖, 结果为7.

### 3.1.7 返回值

通常调用一个函数的结果是一个对象. 有时, 函数计算并返回多个对象是很便利的.

为接收一个形式返回的多个值, 需要调用特殊形式或宏请求这些值. 如果一个形式产生多值, 但不用这种方式请求, 则返回给调用者第一个值, 忽略其他值; 如果一个形式产生零个值, 则返回给调用者`nil`.

下图列出了一些接收多值的操作符. 这些操作符可用于指定一个或多个需要求值的形式, 以及放置这些形式返回值的位置.

图 3-5. 一些可用于接收多值的操作符.

```
multiple-value-bind
multiple-value-call
multiple-value-list
multiple-value-prog1
multiple-value-setq
return
return-from
throw
```

函数`values`可产生多值:

- `(values)`返回零个值
- `(values form)`返回形式`form`返回的主值
- `(values form1 form2)`返回两个值, `form1`的主值和`form2`的主值
- 依次类推.

见**multiple-values-limit**和**values-list**.

## 3.2 编译(Compilation)

### 3.2.1 编译器术语

下面是这一节中使用的术语.

- compiler(编译器)

将代码转换为依赖于实现形式的工具, 该形式可被高效的表示或执行. 术语编译器包含函数`compile`和`compile-file`.

- compiled code(已编译的代码)

是表示已编译程序的对象, 例如由`compile`或通过`load`已编译文件构造的对象.

- implicit compilation(隐式编译)

表示在求值时执行的编译.

- literal object(字面量对象)

表示被引述的对象、自求值对象、或这种对象的子结构对象. 常值变量不是字面量对象.

- coalesce(合并)

假设`A`和`B`是源代码中连个字面常量, `A'`和`B'`是已编译代码中相应的对象. 如果`A'`和`B'`是`eql`的, 但`A`和`B`不是`eql`的, 则称`A`和`B`被编译器合并.

- minimal compilation(最小编译)

表示编译器在编译时必须执行的动作. 这些动作在**3.2.2 编译的语义**中描述.

- process(处理)

表示执行最小编译、确定形式的求值时间以及(如果需要的话)求值该形式.

- further compilation(进一步编译)

最小编译之外的依赖于实现的编译. 即, 处理并不意味着完全编译. 块编译和机器特定指令生成是进一步编译的例子. 进一步编译允许在运行时发生.

- environment(环境)

编译相关的环境包括: **启动环境**、**编译环境**、**求值环境** 和 **运行时环境**.

编译环境继承自求值环境, 编译环境和求值环境可能是同一个环境. 求值环境继承自启动环境, 启动环境和求值环境可能是同一个环境.

启动环境 ^ 求值环境 – 运行时环境 ^ 编译环境

- startup environment(启动环境)

Lisp镜像的环境, 在这里调用编译器.

- compilation environment(编译环境)

由编译器维护, 用于记录内部使用的定义和声明. 只保存正确编译需要的定义. 编译器环境用作编译器调用的宏扩展器的环境参数. 未描述: 编译环境中可用的定义是否在启动环境或求值环境中发起的求值中可用.

- evaluation environment(求值环境)

是运行时环境, 其中宏展开器和由`eval-when`指定的代码已被求值. 编译器发起的所有求值发生在求值环境.

- run-time environment(运行时环境)

已编译的程序可被执行的环境.

- compile time(编译时)

编译器处理源代码的一段时间. 在编译时, 只有 **编译环境** 和 **求值环境** 可用.

- compile-time definition(编译时定义)

表示编译环境中的定义. 例如, 编译文件时, 如果一个函数被声明为`inline`, 则它的定义可能被留存在编译环境中. 这个定义可能在求值环境中不可用.

- run time(运行时)

加载器在加载已编译代码或已编译代码在执行的一段时间. 运行时只有 **运行时环境** 可用.

- run-time definition(运行时定义)

表示运行时环境中的定义.

- run-time compiler(运行时编译器)

表示函数`compile`或隐式编译, 在同一个Lisp镜像中维护编译环境和运行时环境. 当使用运行时编译器时, 运行时环境和启动环境是同一个环境.

### 3.2.2 编译的语义

概念的讲, 编译是一个过程: 遍历代码、使用编译环境中的信息(例如公告和宏定义)执行各种语法和语义分析、生成等价可能更高效的代码.

#### 3.2.2.1 编译器宏

编译器宏的名称可以是函数或宏的名称. 即, 一个函数的名称可能命名了一个函数和一个编译器宏.

如果在函数名称出现的词法环境中对其调用`compiler-macro-function`结果为true时, 该函数名称命名了一个编译器宏. 创建函数名的词法绑定, 不仅创建了一个新的局部函数或宏定义, 也遮盖了编译器宏.

`compiler-macro-function`返回的函数是有两个参数的函数, 被称为展开函数. 为展开编译器宏, 通过调用宏展开钩子, 展开函数作为其第一个参数, 整个编译器宏形式作为第二个参数, 当前编译环境(如果这个形式被用`compile-file`之外的方式处理还需带上当前词法环境)作为第三个参数. 宏扩展钩子接着调用扩展函数, 形式作为第一个参数, 环境作为第二个参数. 扩展函数的返回值, 作为宏扩展钩子的返回值, 可能是同一个形式, 也可能是执行展开后的形式, 可用于替换原形式.

图 3-6. 可用于编译器宏的已定义名称.

```
*macroexpand-hook*
compiler-macro-function
define-compiler-macro
```

##### 3.2.2.1.1 编译器宏的目的

编译器宏的目的是允许有选择性的将代码转换作为对编译器的优化建议. 当编译器处理复合形式时, 如果操作符是编译器宏, 则在该形式和递归的在结果的展开上调用编译器宏函数, 而不是根据作为函数形式或宏形式执行原始形式中的常规处理.

编译器宏函数, 类似于宏函数, 是有两个桉树的函数: 整个形式和环境. 与常规的宏函数不同, 编译器宏函数可以衰退为返回与原始形式相同的值. 如果编译器宏函数破坏性的修改形式中的部分, 结果是未定义的.

作为参数传递给编译器宏函数的形式, 可以是一个car是函数名称的列表, 或者car是`funcall`、caddr是列表`(function name)`的列表; 注意这影响了编译器宏函数的形式参数的解构. `define-compiler-macro`为可能的参数格式提供了正确的解构.

当`compile-file`选择展开是编译器宏形式的顶级形式时, 这个展开被视为`eval-shen`处理的顶级形式, 见**3.2.3.1 顶级形式的处理**.

##### 3.2.2.1.2 编译器宏中名称

编译器宏的名称可以是命名宏和函数的名称.

编译器宏定义是严格的全局的. 不存在像`macrolet`定义局部宏的定义局部编译器宏的方法. 函数名称的词法绑定遮盖任意与该名称相同的全局函数定义、全局宏定义或编译器宏定义.

注意编译器宏定义的存在不影响访问函数定义或宏定义的函数的返回值(例如`fboundp`或`macroexpand`). 编译器宏是全局的, 函数`compiler-macro-function`可以解决与其他词法和全局定义的交互.

##### 3.2.2.1.3 何时使用编译器宏

存在函数或宏的编译器宏定义, 表明需要编译器使用编译器宏的展开, 而不是原始的函数形式或宏形式. 然而, 不需要语言处理器(编译器、求值器或其他代码遍历器)实际调用编译器宏函数, 或者如果确实调用了编译器宏函数时使用作为结果的展开.

当编译器处理过程中遇到一个表示调用编译器宏名称(未被声明为`notinline`)的形式时, 编译器可以展开编译器宏, 可以用该展开替换原始形式.

当`eval`处理过程中遇到表示调用编译器宏名称(未被声明为`notinline`)的形式时, `eval`可以展开编译器宏, 可以用该展开替换原始形式.

存在两种编译器宏定义不能用于语言处理器的情况:

- 编译器宏绑定的全局函数名称, 被该函数名称的词法绑定遮盖;
- 函数名称已被声明或公告为`notinline`, 调用形式在声明的作用域中.

其他情况下, 编译器宏是否被展开或使用, 未描述.

###### 3.2.2.1.3.1 备注: 编译器宏的实现

尽管技术上允许, `eval`处理编译器宏的方式与编译器相同, 但在解释实现中不是一个好方法.

编译器宏存在的目的是用编译时速度换取运行时速度. 编写编译器宏的程序员, 倾向于假设编译器宏比常规函数和宏花更长的时间, 以产生运行时优化的代码. 因为解释实现中`eval`可能多次执行同一形式的语义分析, 实现在每次这类求值时调用编译器宏是不高效的.

如何处理这种情况, 留给各实现决定.

#### 3.2.2.2 最小编译

**最小编译**定义如下:

- 在正编译的源代码中出现的 **编译器宏** 被展开, 或者在编译时全部展开, 不会在运行时展开;
- 在正编译的源代码中出现的 **宏** 和 **符号宏** 在编译时按不会在运行时再次展开的方式被展开. `macrolet`和`symbol-macrolet`被它们的体的形式替换, 体中对宏的调用被宏展开替换.
- `compile`处理的源代码中`load-time-value`形式的首个参数, 在编译时求值; `compile-file`处理的源代码中, 编译器安排它在加载时求值. 在两种情况中, 求值结果都被记住, 作为执行时`load-time-value`形式的值.

#### 3.2.2.3 语义约束

所有符合标准的程序必须遵循下面的约束, 这些约束被设计用于最小化已编译的程序与已解释的程序之间可观察出的区别:

- 所有引用的宏的定义必须在编译环境中出现. 任何以符号作为列表首元素的列表形式, 如果该符号不是在编译环境中定义的特殊操作符名称或宏名称, 则该形式被编译器视为函数调用.
- `special`公告的动态变量必须在编译环境中. 任何在编译环境中没有`special`声明或公告的绑定被编译器视为词法绑定.
- 在编译环境中定义且被声明为`inline`的函数定义, 必须与运行时为同一定义.
- 在函数`F`中, 编译器可以(但不要求)假设, 对名称为`F`的函数的递归调用会引用`F`的同一个定义, 除非该函数被声明为`notinline`. 在这中递归定义的函数`F`执行时进行重定义的后果是未定义的.
- 在一个文件中, 对在同一文件中定义的命名函数的调用, 会引用那个函数, 除非那个函数被省ing为`notinline`. 运行时函数单独重新定义函数或者在同一文件中多次定义一个函数, 其后果是未描述的.
- 所有函数在编译时声明的`ftype`中参数语法和返回值数量必须与运行时保持一致.
- 编译环境中定义的常值变量在运行时必须有相似的值. 源代码中对一个常值变量的引用, 等价于常值变量的值相应字面量对象的引用.
- 编译环境中使用`deftype`或`defstruct`指定的类型定义, 必须与运行时保持一致. 在编译环境中使用`defclass`定义的类, 必须在运行时定义为有相同超类和元类. 其含义是类型描述符的子类型/超类型关系在编译时和运行时一致.
- 编译环境中出现的类型声明, 必须在运行时精确的描述相应的值; 否则后果是为定义的. 允许编译时声明中出现未知的类型, 尽管这种情况下会产生警告.
- 除了上面显式列出的情况, 允许编译时定义的函数在运行时有不同的定义或不同的签名, 并且运行时的定义优先.

符合标准的程序不应该使用任意其他关于运行时环境与启动环境、求值环境和编译环境的一致性的假设.

除非特别说明, 当编译时和运行时定义不同时, 运行时会出现下述的某个情况:

- 发出类型为`error`的错误信号
- 编译时定义优先
- 运行时定义优先

如果编译器处理一个其操作符未在编译时未定义的函数形式, 编译时不会发出错误信号.

### 3.2.3 文件编译

函数`compile-file`按**3.2.2 编译的语义**中i奥数的规则编译文件中的形式, 生成可被`load`加载的输出文件.

通常, 用`compile-file`编译的文件中出现的顶级形式, 只在编译输出文件被加载时求值, 而不是编译文件时. 然而, 文件中的一些形式需要在编译时求值, 这样其他部分才可被读取并正确的编译.

特殊形式`eval-when`可用来控制顶级形式是否在编译时或/和加载时求值. 可以使用符号`:compile-toplevel`、`:load-toplevel`、`:execute`指定`eval-when`不同的处理方式. 对顶级的`eval-when`形式, `:compile-toplevel`表示编译器必须在编译时求值这个形式体, `:load-toplevel`表示编译器必须安排在加载时求值这个形式体. 对非顶级的`eval-when`形式, `:execute`表示这个形式体在运行时环境中执行.

这个形式(`eval-when`形式)在描述`compile-file`编译文件中形式的处理模型中更好理解. 有两个处理模式: not-compile-time和compile-time-too.

`compile-file`读取后续形式, 在not-compile-time模式中处理, 在这个模式中, `compile-file`安排在加载时而不是编译时求值形式. 当`compile-file`在compile-time-too模式中, 形式在编译时和加载时求值.

#### 3.2.3.1 顶级形式的处理

文件编译器中对顶级形式的处理定义如下:

- 1 如果形式是编译器宏(未使用`notinline`声明禁止), 实现可以选择或不选择计算形式的编译器宏扩展并执行展开, 选择或不选择在同一处理模式(compile-time-too或not-compile-time)中将结果作为顶级形式处理.
- 如果衰退为获取或使用扩展, 必须处理原始形式.
- 2 如果形式是宏形式, 计算其宏扩展, 在同一处理模式中按顶级形式处理.
- 3 如果形式是`progn`形式, 在同一处理模式中将其体形式作为顶级形式处理.
- 4 如果形式是`locally`、`macrolet`或`symbol-macrolet`, `compile-file`建立相应的绑定, 在同一处理模式中结合这些绑定将体形式作为顶级形式处理. (注意这意味着, 顶级形式被处理的词法环境不一定是空词法环境).
- 5 如果形式是`eval-when`形式, 按下图处理:

图 3-7. EVAL-WHEN处理.

```
CT   LT   E    Mode  Action    New Mode
----------

Yes  Yes  ---  ---   Process   compile-time-too
No   Yes  Yes  CTT   Process   compile-time-too
No   Yes  Yes  NCT   Process   not-compile-time
No   Yes  No   ---   Process   not-compile-time
Yes  No   ---  ---   Evaluate  ---
No   No   Yes  CTT   Evaluate  ---
No   No   Yes  NCT   Discard   ---
No   No   No   ---   Discard   ---
```

列`CT`表示是否使用`:cimpile-toplevel`.  
列`LT`表示是否使用`:load-time`.  
列`E`表示是否使用`:execute`.  
列`Mode`表示处理模型, `---`表示处理模式是不相关的.  
列`Action`表示这些动作:  
`Process`: 在指定模式中将体作为顶级形式处理  
`Evaluate`: 在编译器的动态执行上下文中求值体, 使用求值环境作为全局环境和`eval-when`出现的词法环境  
`Discard`: 忽略这个形式  
列`New Mode`表示新的处理模式, `---`表示编译器保留在当前模式.

- 6 否则, 这个形式是其他顶级形式.
- 在compile-time-too模式中, 编译器首先在求值环境中求值该形式, 然后执行最小化编译.
- 在not-compile-time模式中, 形式被最小化编译.
- 所有子形式被视为非顶级形式.  
      
    
- 注意顶级形式按在文件中出现的顺序处理, 在读取下一形式前处理当前的顶级形式.
- 然而, 不是顶级形式的形式的处理(包括宏展开)顺序, 以及进一步编译的顺序, 是未描述的.

`eval-when`形式只有在顶级时才会编译时求值. 在非顶级形式中, `:compile-toplevel`和`:load-toplevel`被忽略. 对非顶级形式, 指定为`:execute`的`eval-when`被视为包含`eval-when`形式的体的隐式的`progn`; 否则体中形式被忽略.

##### 3.2.3.1.1 定义宏的处理

在被`compile-file`处理的文件中出现的定义宏(例如`defmacro`或`defvar`), 通常有编译时副作用, 会影响被编译的同一文件中的后续形式. 解释这些副作用的一个便利模型是, 将宏展开定义为一个或多个`eval-when`形式, 产生编译时副作用的调用在形式`(eval-when (:compile-toplevel) ...)`的体中出现.

编译时副作用可能导致关于定义的信息, 与按正常处理定义宏的方式(解释的或加载已编译文件)的信息, 存储方式不同.

通常, 编译时存储的定义宏信息, 可能也可能不可用于解释器(编译前或编译后)或后续对编译器的调用中. 例如, 下面的代码是不可移植的, 因为它假设编译器存储对解释器可用的宏定义`foo`:

```
(defmacro foo (x) `(car ,x))
(eval-when (:execute :compile-toplevel :load-toplevel)
  (print (foo '(a b c))))
```

可移植的方式是将宏定义包含在`eval-when`形式中:

```
(eval-when (:execute :compile-toplevel :load-toplevel)
  (defmacro foo (x) `(car ,x))
  (print (foo '(a b c))))
```

下图列出了一些使得定义在编译时环境和运行时环境可用的宏. 在编译环境中可用的定义是否在求值环境中可用, 是未描述的, 编译环境中可用的定义是否在后续编译单元或后续对编译器的调用中可用, 是未描述的. 同`eval-when`一样, 这些编译时副作用只在定义宏出现在顶级形式时发生.

图 3-8. 影响编译时环境的定义宏.

```
declaim
defclass
defconstant
define-compiler-macro
define-condition
define-modify-macro
define-setf-expander
defmacro
defpackage
defparameter
defsetf
defstruct
deftype
defvar
```

##### 3.2.3.1.2 宏和编译器宏的约束

除非特殊说明, Common Lisp标准中没有定义这样的宏: 产生将宏形式中子形式作为顶级形式的展开. 如果一个实现提供了Common Lisp宏的特殊操作符, 则改特殊操作符定义必须在这个方语义等价.

编译器宏展开必须有与它们所替换的形式相同的顶级形式求值语义. 这是符合标准的实现和程序中都需要考虑的.

### 3.2.4 编译文件中的字面量对象

函数`eval`和`compile`需要保证在已解释的或已编译的代码对象中引用的字面量对象与源代码中相应的对象相同. `compile-file`必须生成已编译的文件, 当用`load`加载时, 构造源代码中定义的对象, 生成对它们的引用.

在`compile-file`中, 由`load`加载文件构造的对象, 不能说与编译时构造的对象相同, 因为已编译的文件可能被加载入与其被编译的Lisp镜像不同的镜像中. 这一节定义关联求值环境中对象到运行时环境中相应对象间相似性的概念.

这一节描述的字面量对象傻姑娘的约束只适用于`compile-file`, `eval`和`compile`不拷贝或合并常量.

#### 3.2.4.1 可外部化对象(Externalizable Objects)

文件编译器在已编译文件中表示字面量对象, 必须在该文件被加载时重新构造出合适的等价对象. 这一事实意味着, 需要在可被用作代码中字面量对象而被文件编译器处理的对象上添加约束.

可被用作代码中字面量对象而被文件编译器处理的对象, 称为**可外部化对象**.

两个对象是相似的, 如果它们满足两个位置概念等价谓词, 该谓词独立于Lisp镜像, 因此不同Lisp镜像中的两个对象可被理解为是在该谓词上等价. 通过考察这个概念性谓词的定义, 程序员可以预料到对象的哪些方面可以被文件编译保留.

文件编译器必须与加载器合作, 以确保在各种情况中, 一个可外部化对象作为一个字面量对象处理, 加载器会构造出一个相似的对象.

相似性是定义在可外部化对象上的, 当加载已编译文件, 可以构造出表现为与在文件编译器操作时存在的原始对象相似的对象.

#### 3.2.4.2 字面量对象的相似性(Similarity of Literal Objects)

##### 3.2.4.2.1 聚合对象的相似性(Similarity of Aggregate Objects)

在相似性定义的类型中, 一些对象被视为聚合对象. 对于这些类型, 相似性是递归定义的. 我们说隶属于这些类型的一个对象有一些基础品质; 为满足相似性关系, 两个对象中相应品质的值也必须是相似的.

##### 3.2.4.2.2 相似性定义(Definition of Similarity)

两个对象`S`(源代码中)与`C`(已编译代码中)是相似的, 当且仅当, 它们都隶属于下面列出的类型(或实现定义的)之一, 同时也满足所有该类型上所需的相似性需求.

- number(数值)

如果有相同的类型, 表示相同的数学值.

- character(字符)

如果有相似的编码属性.

实现定义的属性必须给出非简单字符如何视为相似的定义.

- symbol(符号)

明显未内部化的符号`S`和`C`是相似的, 如果它们的名称是相似的. 两个内部符号`S`和`C`是相似的, 如果它们的名称是相似的, 并且 (1) 编译时`S`在当前包可访问, 加载时`C`在当前包可访问, 或者 (2) `C`在与`S`的主包相似的包中可访问.

(注意, 符号间的相似性不依赖于当前`readtable`或函数`read`如何解析符号的名称中的字符的).

- package(包)

如果它们的名称是相似的.

注意, 尽管包对象是一个可外部化对象, 程序员有义务确保当加载将包视为字面量对象的代码时, 相关的包已存在. 加载器类似于用包的名称作为参数调用`find-package`, 查找相应的包对象. 加载时包不存在, 加载器将发出错误信号.

- random-state(随机状态)

如果`S`总是生成相同的伪随机数序列, 该序列与用`C`的副本作为参数`reandom-state`, 调用函数`random`时生成相同`limit`的序列相同.

(注意, `C`已被文件编译器处理, 它不能直接作为`random`的参数, 因为`random`会产生副作用).

- cons

如果`S`的car与`C`的car相似, 且`S`的cdr与`C`的cdr相似.

- array(数组)

两个一维数组`S`与`C`相似, 如果两者长度相似, 两者的实际数组元素类型相似, 并且`S`中活跃元素与`C`中相应元素相似.

两个高于一维的数组`S`与`C`相似, 如果两者维度数量相似, 每个维度相似, 两者的实际数组元素类型相似, 并且`S`中每个元素与`C`中相应元素类似.

- hash-table(哈希表)

两个哈希表`S`与`C`相似, 如果满足下面三个条件:  
(1) 使用了相同的测试: 例如都是`eql`  
(2) 两个哈希表中键之间存在唯一的一对一关系, 相应的键是相似的  
(3) 对所有的键, 与两个相应键对应的值是相似的.

- pathname(路径名)

如果所有相应的路径名组件是相似的.

- function(函数)

函数不是可外部化对象.

- `structure-object` 和 `standard-object`

不存在结构和标准对象之间的通用的相似性概念. 然而, 允许符合标准的程序, 为程序中定义的是`structure-object`或者是`standard-object`的子类的类`K`, 定义一个`make-load-form`方法. 这个方法的作用是定义: 源代码中类型`K`的对象`S`与已编译代码中类型`K`的对象`C`相似, 如果`C`是从通过在`S`上调用`make-load-form`产生的代码中构造出的.

#### 3.2.4.3 相似性规则的扩展(Extensions to Similarity Rules)

一些对象, 像流、`readtable`和方法等, 在上面定义的相似性意义下, 不是可外部化对象. 即, 这些对象不可作为字面量对象出现在可被文件编译器处理的代码中.

允许实现扩展相似性规则, 从而其它种类的对象可以是可外部化对象.

如果对一些种类的对象, 在本规范或实现中均未定义相似性, 则文件编译器在遇到这些字面量常值对象时必须发出错误信号.

#### 3.2.4.4 可外部化对象的额外约束

如果在被文件编译器处理的单个文件的源代码中出现的两个字面量对象是同一的(identical), 则在已编译代码中相应的对象也必须是同一的. 除了符号和包, 被文件编译器处理的代码中任意两个字面量对象可被合并, 当且仅当它们是相似的; 如果它们是符号或包, 则它们可被合并, 当且仅当它们是同一的.

包含循环引用的对象可以是可外部化对象. 要求文件编译器保留文件中子结构的`eql`语义. 保留`eql`语义的含义是, 源码中是同一的子对象必须在已编译代码中也是同一的.

此外, 下面是文件编译器处理字面量对象的额外约束:

- array(数组)

如果源码中的数组是简单数组, 则已编译代码中相应数组也是简单数组. 如果源代码中数组有填充指针或者是实际可调整的, 则已编译代码中相应数组可能缺少这些品质. 如果源代码中数组有填充指针, 则已编译代码中相应数组的大小可能是被填充指针指示的大小.

- packages(包)

要求加载器查找相应的包对象, 就像使用包名作为参数调用`find-package`. 如果加载时不存在这个名称的包, 则发出类型为`package-error`的错误信号.

- random-state(随机状态)

常值随机状态对象不能作为函数`random`的状态参数, 因为`random`会修改这个数据结构.

- structure(结构), `standard-object`

类型为`struct-object`和`standard-object`的对象可以出现在已编译常量中, 如果存在合适的为该类型定义的`make-load-form`方法.

如果对象是`standard-object`、`structure-object`、`condition`或依赖于实现的一组类的广义实例, 在该对象被文件编译器引用为字面量对象时, 文件编译器会在该对象上调用`make-load-form`. 文件编译器只可对单个文件中指定对象调用一次`make-load-form`.

- symbol(符号)

为确保已编译文件可被正确的加载, 用户需要保证这些文件中引用的包在编译时和加载时的定义是一致的. 符合标准的程序必须满足:  
  
1 文件中顶级形式被`compile-file`处理时的当前包, 必须与已编译文件中该顶级形式的代码被`load`执行时的当前包相同.  
1.1 文件中修改当前包的顶级形式, 必须在编译时和加载时将当前包修改为相同的名称  
1.2 如果文件中第一个非原子的顶级形式不是`in-package`形式, 则调用`load`时的当前包的名称, 必须与调用`compile-file`时当前包的名称相同.  

2 在顶级形式中词法的出现的符号, 在编译时处理该顶级形式的当前包的包中是可访问的, 但它的主包是另一个包; 在加载时, 则必须有相同的名称的符号, 同时在加载时的当前包和编译时的主包中是可访问的.  

3 在已编译文件中出现的符号, 这些符号在编译时主包中是外部符号, 则加载时, 必须有相同名称的符号, 在相同名称的包中也是外部符号.  

如果这些条件中的一个不满足, 则加载器在哪个包中查找受影响的符号是未描述的. 允许实现发出错误信号或定义这个行为.

### 3.2.5 编译器中异常情况

允许`compile`和`cimpile-file`发出错误或警告, 包括编译时处理`(eval-when (:compile-toplevel) ...)`形式、宏展开、编译器自身发出的状态错误。

在编译在没有外部介入无法继续处理的情况下, 编译器可以发出类型为`error`的状况信号.

在标准标注的类型为`warning`的状态必须或者可以被发出的情况之外, 在编译器检测到后果是未定义或将会发出运行时错误时, 也可以发出警告. 这种情况的示例包括: 违反了类型声明、修改或赋值用`defconstant`定义的常值的值、使用错误数量的参数或错误格式的关键字参数列表调用内置Lisp函数、使用不可识别的类型描述符.

允许编译器发出类型`style-warning`的程序风格警告. 这种情况的示例包括: 使用不同的参数列表重定义函数、使用错误数量的参数调用函数、没有为不被引用的局部参数声明`ignore`、引用声明为`ignore`的变量.

允许`compile`和`compile-file`建立类型为`error`的状况的处理器. 例如, 可以发出警告、从依赖于实现的位置重启编译使得编译在没有手工接入时继续进行.

`compile`和`compile-file`返回三个值: 其中两个指示被编译的源码中是否包含错误、是否有程序风格警告.

一些警告可以推迟到编译结束, 见`with-compilation-unit`.

## 3.3 声明(Declarations)

声明提供了描述供程序处理器(如求值器或编译器)使用的信息的方法.

可以使用`decalre`将**局部声明**嵌在可执行代码中. 使用`proclaim`或`declaim`建立**全局声明**或**公告**.

特殊形式`the`为给定形式的值的类型定义局部声明提供了简写记法.

如果程序违反了声明或公告, 后果是未定义的.

### 3.3.1 声明处理的最小需求

通常实现可以自由的忽略类型描述符, 除了`declaration`、`notinline`、`safety`和`special`类型描述符.

`declaration`声明必须抑制关于其声明的种类的未识别声明警告. 如果实现没有生成未识别声明的警告, 它可以安全的忽略该声明.

`notinline`声明必须被支持内联函数或编译器宏的实现识别, 以关闭这一功能. 没有使用内联函数或编译器宏的实现可以安全的忽略该声明.

增加当前安全等级的`safety`声明必须总被识别. 总是尽可能按高安全等级处理代码的实现可以安全的忽略该声明.

`special`声明必须被所有实现处理.

### 3.3.2 声明描述符(Declaration Specifiers)

声明描述符是一个表达式, 可以出现在`decalre`表达式或`declaim`形式的顶级, 或者作为`proclaim`的参数. 它是一个列表, 其car是声明标识符, 其cdr是根据特定于声明标识符的规则解释的数据.

### 3.3.3 声明标识符(Declaration Identifiers)

下图列出了标准中定义的所有声明标识符:

图 3-9. Common Lisp声明标识符.

```
declaration
dynamic-extent
ftype
ignorable
ignore
inline
notinline
optimize
special
type
```

实现可以自由的支持其他声明标识符. 如果声明标识符不在上面的定义中、未被实现定义、不是类型名称或未使用`declaration`公告声明, 需要发出警告.

#### 3.3.3.1 类型声明的短记法

类型描述符可被用作声明标识符.

`(type-specifier var*)`是`(type type-specier var*)`的短记法.

### 3.3.4 声明的作用域(Declaration Scope)

声明可被分为两种: 用于变量或函数绑定; 不用于绑定.

出现在绑定形式头部的声明, 且应用于该形式的变量或函数绑定, 则该声明被称为**绑定的声明**. 这种声明影响声明作用域的绑定和任意引用.

不是绑定的声明的声明, 被称为**自由的声明**.

形式`F1`中的自由的声明应用于由形式`F2`建立的名称`N`的绑定, `F1`是只影响在`F1`中对`N`的引用的子形式, 该声明不可应用与`F1`之外对`N`的引用, 或者它不影响`F2`建立的`N`的绑定的行为.

不应用于绑定过的声明只可以作为自由的声明出现.

绑定的声明的作用域与其应用的绑定的词法作用域相同. 对于特殊变量, 这意味着, 这个绑定的作用域有词法绑定.

除非特别说明, 自由的声明的作用域只包括它作为头部出现的形式的形式体子形式, 不包括其他子形式. 自由的声明的作用域不包括包含该声明的形式建立的绑定的初始化形式.

一些出现声明的迭代形式中, `step`、`end-test`或`result`子形式也被包含在声明的作用域中. 迭代形式和子形式包括:

- `do`, `do*`: `step-forms`, `end-test-forms`, `result-forms`
- `dolist`, `dotimes`: `result-form`
- `do-all-symbols`, `do-external-symbols`, `do-symbols`: `result-form`

#### 3.3.4.1 示例: 声明的作用域

这是一个展示绑定的声明的作用域的列子:

```
(let ((x 1))                ;[1] 1st occurrence of x - 动态绑定
  (declare (special x))     ;[2] 2nd occurrence of x
  (let ((x 2))              ;[3] 3rd occurrence of x - 词法绑定
    (let ((old-x x)         ;[4] 4th occurrence of x
          (x 3))            ;[5] 5th occurrence of x - 动态绑定
      (declare (special x)) ;[6] 6th occurrence of x
      (list old-x x))))     ;[7] 7th occurrence of x
=>  (2 3)
```

- `x`的第一次出现建立`x`的动态绑定, 因为第2行中`x`的`special`声明.
- `x`的第三次出现建立了`x`的词法绑定, 因为这个`let`形式中不存在`special`声明.
- `x`的第四次出现是对第三次出现的`x`的词法绑定的引用.
- `x`的第五次出现建立`x`的动态绑定, 因为第6行中出现`special`声明.
- 第4行对`x`的引用不受第6行中`special`声明的影响, 因为这个引用不在第5的变量`x`的可能的词法作用域中.
- 第7行对`x`的引用是对在第5行建立的`x`的动态绑定的引用.

下面是展示自由的省ing的例子:

```
(lambda (&optional (x (foo 1))) ;[1]
  (declare (notinline foo))     ;[2]
  (foo x))                      ;[3]
```

第1行对`foo`的调用可以内联编译, 第3行对`foo`的调用必须不能内联编译. 这只因为第2行中对`foo`的`notinline`声明, 只应用于第3行的体中. 为抑制两次调用的内联编译, 可以:

```
(locally (declare (notinline foo)) ;[1]
  (lambda (&optional (x (foo 1)))  ;[2]
    (foo x)))                      ;[3]
```

或者

```
(lambda (&optional                               ;[1]
           (x (locally (declare (notinline foo)) ;[2]
                (foo 1))))                       ;[3]
  (declare (notinline foo))                      ;[4]
  (foo x))                                       ;[5]
```

最后是展示迭代形式中声明的作用域的例子:

```
(let ((x  1))                     ;[1] - 动态绑定
  (declare (special x))           ;[2]
    (let ((x 2))                  ;[3] - 词法绑定
      (dotimes (i x x)            ;[4] - 词法绑定, 动态绑定
        (declare (special x)))))  ;[5]
=>  1
```

第4行中第一次对`x`的引用是对在第3行建立的`x`的词法绑定的引用. 第二次出现是在第5行的自由的声明的作用域中, 因为是`dotimes`的`result-form`, 因此引用`x`的动态绑定.

## 3.4 lambda列表

lambda列表是一个列表, 描述了一组参数(有时被称为lambda变量)和接受参数值的协议.

有几种lambda列表:

图 3-10. lambda列表的种类.

| 上下文                                          | lambda列表类别                                |
| :---------------------------------------------- | --------------------------------------------- |
| defun形式                                       | 常规lambda列表                                |
| defmacro形式                                    | 宏lambda列表                                  |
| lambda表达式                                    | 常规lambda列表                                |
| flet局部函数定义                                | 常规lambda列表                                |
| labels局部函数定义                              | 常规lambda列表                                |
| handler-case子句规范                            | 常规lambda列表                                |
| restart-case子句规范                            | 常规lambda列表                                |
| macrolet局部宏定义                              | 宏lambda列表                                  |
| define-method-combination                       | 常规lambda列表                                |
| define-method-combination  <br>的:arguments选项 | define-method-combination  <br>参数lambda列表 |
| defstruct的:constructor选项                     | 按参数顺序的(boa)lambda列表                   |
| defgeneric形式                                  | 广义函数lambda列表                            |
| defgeneric方法子句                              | 特化lambda列表                                |
| defmethod形式                                   | 特化lambda列表                                |
| defsetf形式                                     | defsetf lambda列表                            |
| define-setf-expander形式                        | 宏lambda列表                                  |
| deftype形式                                     | deftype lambda列表                            |
| destructuring-bind形式                          | destructuring lambda列表                      |
| define-compiler-macro形式                       | 宏lambda列表                                  |
| define-modify-macro形式                         | define-modify-macro lambda列表                |

下图列举了可用于lambda列表的已定义名称:

图 3-11. 可用于lambda列表的已定义名称.

```
lambda-list-keywords
lambda-parameters-limit
```

### 3.4.1 常规lambda列表

常规lambda列表用于描述常规函数如何接收一组参数. 下图是使用了常规lambda列表的已定义名称:

图 3-12. 使用常规lambda列表的标准操作符.

```
define-method-combination
defun
flet
handler-case
labels
lambda
restart-case
```

常规lambda列表中可以包含下图中的lambda列表关键字:

图 3-13. 常规lambda列表中使用的lambda列表关键字.

```
&allow-other-keys
&aux
&key
&optional
&rest
```

lambda列表中元素要么是参数描述符, 要么是lambda列表关键字. 允许实现提供额外的lambda列表关键字. 使用`lambda-list-keywords`查看实现中所有的lambda列表关键字.

常规lambda列表的语法如下:

```
lambda-list::= (var*
 [&optional { var | (var [init-form [supplied-p-parameter]]) }*]
 [&rest var]
 [&key { var | ({ var | (keyword-name var) } [init-form [supplied-p-parameter]]) }* [&allow-other-keys]]
 [&aux {var | (var [init-form])}*])
```

- `var`或`supplied-p-parameter`必须是一个符号, 该符号不是常值变量名称.
- `init-form`可以是任意形式. 每当对参数描述的`init-form`求值时, 这个形式可以引用该`init-form`出现的描述符左边的任意参数变量, 包括任意`supplied-p-paramenter`变量; 这个形式依赖于没有其他参数变量(包括它自己的参数变量)已被绑定的事实.
- `keyword-name`可以是任意符号, 但一般是关键字符号; 所有的标准函数遵循这一约定.

一个常规的lambda列表有5个部分, 都可以为空. 关于处理参数失配的信息见**3.5 函数调用中错误检测**.

#### 3.4.1.1 必备参数描述符

**必备参数描述符** 是直到首个lambda列表关键字的参数描述符. 如果没有lambda列表关键字, 则所有的描述符是必备参数描述符. 每个必备参数用参数变量`var`描述, `var`作为词法变量绑定, 除非被用`special`声明.

如果有`n`个必备参数(`n`可能为0), 则必须至少有`n`个传递的参数, 必备的参数绑定到前`n`个传递的参数; 见**3.5 函数调用中错误检测**. 其他参数使用剩余的传递参数处理.

#### 3.4.1.2 可选参数描述符

如果`&optional`存在,**可选参数描述符**是在`&optional`之后直到下一个lambda列表关键字或列表尾部的参数描述符.

如果指定了可选参数, 则按下述方式处理每个可选参数:

- 如果有未处理的传递参数剩下, 则参数变量`var`绑定到下一个传递参数, 就像必备参数那样.
- 如果没有传递参数剩下, 则求值`init-form`, 参数变量绑定到其结果值(如果不存在`init-form`则绑定到nil).
- 如果描述符中有变量名`supplied-p-parameter`, 如果传递参数可用则它被绑定到true; 如果没有传递参数剩下则它被绑定到false(因此需要求值`init-form`). `supplied-p-parameter`不是绑定到传递参数, 而是绑定到对应于`var`是否有提供专递参数的指示值.

#### 3.4.1.3 剩余参数描述符

如果`&rest`存在, 必须后接单个**剩余参数描述符**, 其后可以是lambda列表关键字或lambda尾.

- 在处理完所有可选参数描述符之后, 可以有或没有一个剩余参数.
- 如果有剩余参数, 它被绑定到至今未处理的传递参数的列表.
- 如果没有未处理的传递参数剩余, 剩余参数绑定到空列表.
- 如果没有剩余参数和关键字参数, 则如果存在未处理的传递参数时应该发出错误信号, 见**3.5 函数调用中错误检测**.

剩余参数的值, 允许但不要求, 与`apply`最后一个传递参数共享结构.

#### 3.4.1.4 关键字参数描述符

如果`&key`存在, 所有后续的直到lambda列表关键字或列表尾的描述符是**关键字参数描述符**. 当处理关键词参数时, 相应的传递参数被处理为剩余参数的列表. 允许同时使用`&rest`和`&key`, 这时, 剩余的传递参数用作这两个用途, 即所有的剩余传递参数处理为剩余参数的列表, 同时也作为`&key`参数处理. 如果指定了`&key`, 则必须有偶数个传递参数, 见**3.5.1.6 奇数个关键字传递参数**. 这些传递参数被视为一对, 第一个传递参数被解释为一个名称, 第二个传递参数被作为相应的值. 每对中第一个对象必须是一个符号, 见\[3.5.1.5 无效的关键字传递参数]. 关键字参数描述符后可选的可以后接lambda列表关键字`&allow-other-keys`.

在每个关键字参数描述符中, 必须有参数变量名称`var`. 如果`var`单独出现或者是`(var init-form)`格式, 则这个用于在传递参数匹配参数的关键字名称必须是包`KEYWORD`中的符号, 它的名称在`string=`语义下与`var`相同. 如果使用`((keyword-name var) init-form)`格式, 则用于传递参数匹配参数的关键字名称是`keyword-name`, 它是任意一个包中的符号.(当然, 如果它不是包`KEYWORD`中的符号, 它不需要是自求值的, 所以在调用函数是需要注意保证正常求值仍产生该关键字名称.)

因此

```
(defun foo (&key radix (type 'integer)) ...)
```

等价于

```
(defun foo (&key ((:radix radix)) ((:type type) 'integer)) ...)
```

关键字参数描述符, 与所有参数描述符一样, 从左至右处理. 对每个关键字参数描述符, 如果有传递参数对的名称匹配该描述符的名称(即名称在`eq`语义下相同), 则该描述符的参数变量被绑定到传递参数对的第二项上. 如果没有传递参数对存在, 则该描述符的`init-form`被求值, 参数变量被绑定到该值上(如果没有`init-form`, 则被绑定到nil). `supplied-p-paramenter`被视为`&optional`参数: 如果存在匹配的传递参数对则绑定为true, 否则绑定为false.

除非关键字参数检查被抑制, 传递参数对必须与参数描述符的名称匹配, 见**3.5.1.4 未识别的关键字参数**.

如果关键字参数检查被抑制, 则允许传递参数对不匹配参数描述符, 该传递参数对被忽略, 但如果提供了参数对, 则该参数对通过剩余参数可被访问. 这个机制的目的在于允许在多个lambda表达式间共享参数列表, 允许调用方或被调用的lambda表达式描述这种共享.

注意到, 如果`&key`存在, 总是允许`:allow-other-keys`关键在参数, 不管相应的值是true还是false. 如果值为false, 其他不匹配的关键字不被允许(除非使用了`&allow-other-keys`).

如果接收参数列表中指定了一个标记为`:allow-other-keys`的常规参数, 则`:allow-other-keys`同时有其特殊含义(指定是否可以有额外的关键字参数)和常规含义(流入函数的数据).

##### 3.4.1.4.1 抑制关键字参数检查

如果函数的lambda列表中指定了`&allow-other-keys`, 调用该函数时关键字传递参数检测被抑制.

如果调用函数时`:allow-other-keys`参数为true, 在该调用中关键字参数检查被抑制.

`:allow-other-keys`参数被允许的情况包括关键字参数, 甚至在相应的值是false时.

###### 3.4.1.4.1.1 示例: 抑制关键字参数检查

```
;;; The caller can supply :ALLOW-OTHER-KEYS T to suppress checking.
;;; 调用者可以提供抑制
 ((lambda (&key x) x) :x 1 :y 2 :allow-other-keys t) =>  1

;;; The callee can use &ALLOW-OTHER-KEYS to suppress checking.
;;; 被调用者可以抑制
 ((lambda (&key x &allow-other-keys) x) :x 1 :y 2) =>  1

;;; :ALLOW-OTHER-KEYS NIL is always permitted.
;;; :ALLOW-OTHER-KEYS NIL总是被允许
 ((lambda (&key) t) :allow-other-keys nil) =>  T

;;; As with other keyword arguments, only the left-most pair
;;; named :ALLOW-OTHER-KEYS has any effect.
;;; 存在多个时, 最左边的生效
 ((lambda (&key x) x)
  :x 1 :y 2 :allow-other-keys t :allow-other-keys nil)
=>  1

;;; Only the left-most pair named :ALLOW-OTHER-KEYS has any effect,
;;; so in safe code this signals a PROGRAM-ERROR (and might enter the
;;; debugger).  In unsafe code, the consequences are undefined.
;;; 存在多个时, :ALLOW-OTHER-KEYS NIL在安全代码中会产生错误
 ((lambda (&key x) x)                   ;This call is not valid
  :x 1 :y 2 :allow-other-keys nil :allow-other-keys t)
```

#### 3.4.1.5 `&aux`变量描述符

这些不是实际的参数. 如果lambda列表关键字`&aux`存在, 后面的所有描述符是辅助变量描述符. 在所有参数描述符被处理后, 辅助变量描述符按从左至右的方式处理. 对每个辅助参数描述符, `init-form`被求值, `var`被绑定到该值(没有`init-form`时绑定为`nil`). `&aut`变量的处理与`let*`的处理类似.

```
(lambda (x y &aux (a (car x)) (b 2) c) (list x y a b c))
   '' (lambda (x y) (let* ((a (car x)) (b 2) c) (list x y a b c)))
```

#### 3.4.1.6 示例: 一般lambda列表

包含可选参数和剩余参数的示例:

```
((lambda (a b) (+ a (* b 3))) 4 5) =>  19

((lambda (a &optional (b 2)) (+ a (* b 3))) 4 5) =>  19

((lambda (a &optional (b 2)) (+ a (* b 3))) 4) =>  10

((lambda (&optional (a 2 b) (c 3 d) &rest x) (list a b c d x)))
=>  (2 NIL 3 NIL NIL)

((lambda (&optional (a 2 b) (c 3 d) &rest x) (list a b c d x)) 6)
=>  (6 T 3 NIL NIL)

((lambda (&optional (a 2 b) (c 3 d) &rest x) (list a b c d x)) 6 3)
=>  (6 T 3 T NIL)

((lambda (&optional (a 2 b) (c 3 d) &rest x) (list a b c d x)) 6 3 8)
=>  (6 T 3 T (8))

((lambda (&optional (a 2 b) (c 3 d) &rest x) (list a b c d x))
 6 3 8 9 10 11)
=>  (6 t 3 t (8 9 10 11))
```

包含关键字参数的示例:

```
((lambda (a b &key c d) (list a b c d)) 1 2) =>  (1 2 NIL NIL)

((lambda (a b &key c d) (list a b c d)) 1 2 :c 6) =>  (1 2 6 NIL)

((lambda (a b &key c d) (list a b c d)) 1 2 :d 8) =>  (1 2 NIL 8)

((lambda (a b &key c d) (list a b c d)) 1 2 :c 6 :d 8) =>  (1 2 6 8)

((lambda (a b &key c d) (list a b c d)) 1 2 :d 8 :c 6) =>  (1 2 6 8)

((lambda (a b &key c d) (list a b c d)) :a 1 :d 8 :c 6) =>  (:a 1 6 8)

((lambda (a b &key c d) (list a b c d)) :a :b :c :d) =>  (:a :b :d NIL)

((lambda (a b &key ((:sea c)) d) (list a b c d)) 1 2 :sea 6) =>  (1 2 6 NIL)

((lambda (a b &key ((c c)) d) (list a b c d)) 1 2 'c 6) =>  (1 2 6 NIL)
```

包含可选参数、剩余参数和关键字参数的示例:

```
((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) 1)
=>  (1 3 NIL 1 ())

((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) 1 2)
=>  (1 2 NIL 1 ())

((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) :c 7)
=>  (:c 7 NIL :c ())

((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) 1 6 :c 7)
=>  (1 6 7 1 (:c 7))

((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) 1 6 :d 8)
=>  (1 6 NIL 8 (:d 8))

((lambda (a &optional (b 3) &rest x &key c (d a))
   (list a b c d x)) 1 6 :d 8 :c 9 :d 10)
=>  (1 6 9 8 (:d 8 :c 9 :d 10))
```

作为使用`&allow-other-keys`和`:allow-other-keys`的示例, 考虑一个接收两个命名参数和额外传递给`make-array`的命名参数的函数:

```
(defun array-of-strings (str dims &rest named-pairs
                         &key (start 0) end &allow-other-keys)
  (apply #'make-array dims
         :initial-element (subseq str start end)
         :allow-other-keys t
         named-pairs))
```

这个函数接收一个字符串和维度信息, 返回指定维度的元素为指定字符串的数字. `:start`和`:end`命名的参数用于指定应该使用的字符串的子串. 此外, lambda列表中的`&allow-other-keys`表明, 调用方可以提供额外的命名参数, 通过剩余参数可以访问它们. 这些额外命名的参数被传递给`make-array`. 函数`make-array`通常不允许使用命名参数`:start`和`:end`, 如果调用时使用这些参数将发出错误信号. 然而, 如果调用`make-array`时传入值为true的`:allow-other-keys`参数, 额外提供的参数, 包括`:start`和`:end`可被接收并被忽略.

### 3.4.2 广义函数lambda列表

广义函数lambda列表被用于描述: 可被冠以函数接受的传递参数列表的整体样式. 独立的方法签名可以为有效方法的lambda列表提供额外的关键字参数.

使用`defgeneric`定义广义函数lambda列表, 该lambda列表有语法:

```
lambda-list::= (var*
 [&optional { var | (var) }*]
 [&rest var]
 [&key { var | ({ var | (keyword-name var) }) }* [&allow-other-keys]])
```

广义函数lambda列表中可以使用的lambda列表关键字见下图:

图 3-14. 广义函数lambda列表中可以使用的lambda列表关键字.

```
&allow-other-keys
&key
&optional
&rest
```

广义函数lambda列表与常规lambda列表的不同之处有:

- 必备参数: 必须指定零个或多个必备参数
- 可选和关键字参数: 可选参数和关键字参数不可使用默认初始值形式或使用`supplied-p`参数
- 使用`&aux`: 不允许使用辅助参数

### 3.4.3 特化的lambda列表

特化的lambda列表用于特化特定签名的方法, 描述传递参数如何匹配方法接收的签名. 下面的已定义名称使用了特化的lambda列表, 详细信息见节尾的字典项部分.

图 3-15. 使用特化的lambda列表的标准操作符.

```
defmethod
defgeneric
```

特化的lambda列表可以使用下图中的lambda列表关键字:

图 3-16. 特化的lambda列表使用的lambda列表关键字.

```
&allow-other-keys
&aux
&key
&optional
&rest
```

特化的lambda列表语法上与常规lambda列表一样, 除了每个必备参数可选的与该参数特化的类或对象关联:

```
lambda-list::= ({ var | (var [specializer]) }*
  [&optional { var | (var [init-form [supplied-p-parameter]]) }*]
  [&rest var]
  [&key { var | ({ var | (keyword-name var) } [init-form [supplied-p-parameter]]) }* [&allow-other-keys]]
  [&aux { var | (var [init-form]) }*])
```

### 3.4.4 宏lambda列表

宏lambda列表用于描述下图中操作符定义的宏:

图 3-17. 使用宏lambda列表的操作符.

```
define-compiler-macro
define-setf-expander
defmacro
macrolet
```

在环境参数只可出现一次的约束下, 宏lambda列表的语法是:

```
reqvars::= var*
optvars::= [&optional { var | (var [init-form [supplied-p-parameter]]) }*]
restvar::= [{ &rest | &body } var]
keyvars::= [&key { var | ({ var | (keyword-name var) } [init-form [supplied-p-parameter]]) }*
            [&allow-other-keys]]
auxvars::= [&aux { var | (var [init-form]) }*]
envvar::= [&environment var]
wholevar::= [&whole var]
lambda-list::= (wholevar envvar  reqvars envvar  optvars envvar
                restvar envvar  keyvars envvar  auxvars envvar) |
               (wholevar envvar  reqvars envvar  optvars envvar .  var)
pattern::= (wholevar reqvars optvars restvar keyvars auxvars) |
           (wholevar reqvars optvars . var)
```

宏lambda列表可以使用下图中的lambda列表关键字:

图 3-18. 宏lambda列表使用的lambda列表关键字.

```
&allow-other-keys
&aux
&body
&environment
&key
&optional
&rest
&whole
```

像常规lambda列表一样, 由`&optional`引入的可选参数和由`&key`引入的关键参数可以用于宏lambda列表. 每个可以有默认的初值形式和`suppiled-p`参数.

`&body`与`&rest`功能一致, 但可用于表示一些输出格式和编辑函数, 将形式中剩余部分作为体, 应该有恰当的缩进. 在特定层级中, 只可以有一个`&body`或`&rest`, 见**3.4.4.1 lambda列表引入的解构(Destructuring by Lambda Lists)**. `&body`可以在宏lambda列表的任意层次中使用, 详情见**3.4.4.1 lambda列表引入的解构(Destructuring by Lambda Lists)**.

`&whole`后接单个绑定到整个宏调用形式的变量, 这个宏函数作为第一个传递参数的值. 如果`&whole`和后继的变量出现, 必须在lambda列表中首先出现, 在其他参数或lambda列表关键字之前. `&whole`可以在宏lambda列表的任意层次中出现. 在内层中, 像`&rest`一样, `&whole`变量绑定到传递参数的相应部分, 但与`&rest`不同的是允许其他参数. `&whole`的使用不影响指定的传递参数的模式.

`&environment`后接单个绑定到表示宏调用被解释的词法环境的参数. 在计算宏的展开时, 这个环境应该被`macro-function`、`get-setf-expansion`、`compiler-macro-function`和`macroexapnd`等使用, 以保证使用编译环境中建立的任意词法绑定或定义. `&environment`只可以在宏lambda列表的顶级出现, 只可出现一次, 但可以在该列表中任意位置出现; `&environment`参数与`&whole`在列表中其他参数之前绑定, 不管`&environment`在列表中出现的位置. `&environment`参数绑定到有动态extent的环境参数.

允许宏lambda列表使用解构表达宏调用语法的结构. 如果没有lambda列表关键字出现, 则宏lambda列表是一个叶子为参数名称的树. 模式和宏形式必须有兼容的树结构, 即它们的树结构必须是等价的, 或者必须只在匹配宏形式的非原子对象的一些叶子上存在差异. 这种情况中的错误检测见**3.5.1.7 解构失配**.

解构lambda列表(在顶级或内嵌层次中)可以包含`.`, 以参数名称结束. 这种情况被视为与结束列表的参数名称在`&rest`之后出现一致.

允许宏形式(或宏形式的子表达式)是包含`.`的列表, 仅当使用`(... &rest var)`或`(... . var)`匹配它时. 需要宏识别和处理这种情况.

#### 3.4.4.1 lambda列表引入的解构(Destructuring by Lambda Lists)

宏lambda列表中参数名称可以出现但常规lambda列表语法不允许一个列表的任意位置, 解构lambda列表可以作为替代参数名称而出现. 在这种情况下, 匹配参数的传递参数被视为一个列表(可能是包含`.`的列表), 被用作满足内嵌lambda列表的参数的传递参数猎豹. 这被称为**解构**.

解构是将复合对象分解为其组件部分的过程, 使用缩写的声明式语法, 而不是使用原始组件访问函数手动写出的. 每个组件部分被绑定到一个变量.

解构操作需要对象是可被分解的, 使用模式描述组件是如何被提取的, 以及其值是这些组件的变量的名称.

##### 3.4.4.1.1 lambda列表引入的数据解构

在数据解构中, 模式是需被分解的类型的一个样例对象. 每当组件被提取时, 模式中出现一个符号, 这个符号是其值是这个组件的变量的名称.

##### 3.4.4.1.2 示例: lambda列表引入的数据解构

示例模式`(a b c)`解构一个有三个元素的列表. 变量`a`被指派给第一个元素, 变量`b`被指派给第二个元素, 依次类推. `((first . rest) . more)`是另一个复杂的示例.

数据解构的重要特性是它的语法简单性和可被扩展用于lambda列表解构.

#### 3.4.4.2 lambda列表引入的lambda列表解构

lambda列表解构扩展了数据解构用于树对象. 这利用了树元素解构模式`(first second third)`与三个参数的lambda列表`(first second third)`之间的相似性.

如果模式中没有lambda列表关键字, lambda列表解构与数据结构完全一致. 模式中任意包含lambda列表关键字的列表(子列表或整个模式本身)被特殊解释. 这个列表中从左直到首个lambda列表关键字的元素被视为通常的解构模式, 然剩余的元素被视为函数的lambda列表, 除了通常需要一个变量, 允许使用任意解构模式. 注意到存在歧义性时, lambda列表语法是优先于解构语法的. 因此, 在`&optional`之后的元素列表是解构模式列表和一个默认值形式.

lambda列表解构模式中每个lambda列表关键字的详细行为如下:

- `&optional`

后继的元素是一个变量或一个解构模式的列表, 一个默认值形式, 一个`supplied-p`变量. 默认值形式和`supplied-p`变量可被省略. 如果被解构的列表过早结束, 使得没有元素用于匹配这个解构(子)模式, 默认值形式被求值和被用于解构. 如果默认形式被使用`supplied-p`变量的值为`nil`, 否则为`t`.

- `&rest`, `&body`

下一个元素是解构模式, 匹配列表的剩余部分. `&body`与`&rest`一致, 但`&body`声明了被匹配的是构成形式体的形式列表. 除非后面有lambda列表关键字, 下一个元素是最后一个元素.

- `&aux`

剩余的元素不是解构模式, 而是辅助变量绑定.

- `&whole`

下一个元素是解构模式, 匹配整个宏形式或宏内层的整个子表达式.

- `&key`

后续的元素是一个:  
变量  
变量的列表, 一个可选的初始化形式, 一个可选的`supplied-p`变量  
关键字和解构模式的列表的列表, 可选的初始化形式, 可选的`supplied-p`变量  
被解构的列表的剩余部分被视为关键字和值.

- `&allow-other-keys`

与常规含义一致.

### 3.4.5 解构lambda列表

`destructuring-bind`使用解构lambda列表.

解构lambda列表与宏lambda列表紧密相关, 见**3.4.4 宏lambda列表**. 解构lambda列表可以包含宏lambda列表中除了`&environment`之外的所有lambda列表关键字, 以同样的方式支持解构. 宏lambda列表中内嵌的内层lambda列表有解构lambda列表的语法.

解构lambda列表的语法:

```
reqvars::= var*
optvars::= [&optional { var | (var [init-form [supplied-p-parameter]]) }*]
restvar::= [{ &rest | &body } var]
keyvars::= [&key { var | ({ var | (keyword-name var) } [init-form [supplied-p-parameter]]) }*
            [&allow-other-keys]]
auxvars::= [&aux { var | (var [init-form]) }*]
envvar::= [&environment var]
wholevar::= [&whole var]
lambda-list::= (wholevar reqvars optvars restvar keyvars auxvars) |
               (wholevar reqvars optvars . var)
```

### 3.4.6 按参数顺序(Boa, by order of argument) lambda列表

按参数顺序lambda列表是与常规lambda列表语法相似的lambda列表, 但以按参数顺序风格处理.

按参数顺序lambda列表只在`defstruct`形式中使用, 用于显式的描述构造器函数的lambda列表(有时被称为按参数顺序构造器).

按参数顺序lambda列表中可以使用`&optional`、`&rest`、`&aux`、`&key`和`&allow-other-keys`lambda列表关键字. 但它们的使用方式与常规lambda列表不同.

下面的示例中描述了`defstruct`如何处理`:constructor`选项的:

```
(:constructor create-foo
        (a &optional b (c 'sea) &rest d &aux e (f 'eff)))
```

将`create-foo`定义为一个或多个传递参数的构造器.  
第一个传递参数用于初始化槽`a`.  
第二个传递参数用于初始化槽`b`. 如果没有第二个传递参数, 则使用`defstruct`体中给出的默认值.  
第三个传递参数用于初始化槽`c`. 如果没有第三个传递参数, 则使用符号`sea`.  
第三个传递参数后的所有参数被收集到一个列表中, 用于初始化槽`c`. 如果有三个或更少的传递参数, 则给槽`d`赋予`nil`.  
槽`e`未被初始化, 它的初始值是依赖于实现的.  
槽`f`被初始化为符号`eff`.  

`&key`和`&allow-other-keys`传递参数的默认行为与`&optional`传递参数相似: 如果lambda列表中没有提供默认值, 则使用`defstruct`体中给出的默认值. 例如:

```
(defstruct (foo (:constructor CREATE-FOO (a &optional b (c 'sea)
                                            &key (d 2)
                                            &aux e (f 'eff))))
  (a 1) (b 2) (c 3) (d 4) (e 5) (f 6))

(create-foo 10) =>  #S(FOO A 10 B 2 C SEA D 2 E implemention-dependent F EFF)

(create-foo 10 'bee 'see :d 'dee)
=>  #S(FOO A 10 B BEE C SEE D DEE E implemention-dependent F EFF)
```

如果使用了形式为`((key var) [default [svar]])`的关键字参数, 则使用`var`匹配槽名称.

`b`和`e`的情况允许用户指定所有可能的行为. `&aux`变量可用于完全覆盖体中的默认初始化.

如果没有给辅助变量提供默认值, 在显式赋予相应槽值之前尝试读取槽值的后果是未定义的. 如果这样的槽有指定的`:type`选项, 这个被抑制的初始化并不意味着类型失配检查, 只要求这个声明的类型在槽最终被赋值时应用.

使用这个定义, 可以使用`(create-foo 1 2)`替代`(make-foo :a 1 :b 2)`, `create-foo`提供了与`make-foo`不同的默认值.

允许其它不与槽名称对应的仅被用于后续初始化计算的传递参数. 例如:

```
(defstruct (frob (:constructor create-frob
                 (a &key (b 3 have-b) (c-token 'c)
                         (c (list c-token (if have-b 7 2))))))
        a b c)
```

`c-token`传递参数仅用于为初始化槽`c`提供一个值. 与可选参数和关键字参数关联的`supplied-p`参数也可这样使用.

### 3.4.7 `defsetf` lambda列表

`defsetf`使用`defsetf` lambda列表, 该lambda列表有语法:

```
lambda-list::= (var*
  [&optional { var | (var [init-form [supplied-p-parameter]]) }*]
  [&rest var]
  [&key { var | ({ var | (keyword-name var) } [init-form [supplied-p-parameter]]) }* [&allow-other-keys]]
  [&environment var]
```

`defsetf` lambda列表可以使用这些lambda列表关键字:

图 3-19. `defsetf` lambda列表使用的lambda列表关键字.

```
&allow-other-keys
&environment
&key
&optional
&rest
```

`defsetf` lambda列表与常规lambda列表的不同点是: 不允许使用`&aux`, 允许使用`&environment`引入一个环境参数.

### 3.4.8 `deftype` lambda列表

`deftype`使用`deftype` lambda列表.

`deftype` lambda列表的语法与宏lambda列表的语法一致, 从而可以包含lambda列表关键字作为宏lambda列表.

`deftype` lambda列表与宏lambda列表的不同点是: 如果没有给可选参数或关键字参数提供`init-form`, 则该参数的默认值是符号`*`而不是`nil`.

### 3.4.9 `define-modify-macro` lambda列表

`define-modify-macro`使用`define-modify-macro` lambda列表.

`define-modify-macro` lambda列表可以使用的lambda列表关键字见下图:

图 3-20. `define-modify-macro` lambda列表可以使用的lambda列表关键字.

```
&optional
&rest
```

`define-modify-macro` lambda列表与常规lambda列表类似, 但不支持关键字参数. `define-modify-macro`不需要匹配关键字参数, 剩余参数已足够使用. 也不支持辅助变量, 因为`define-modify-macro`没有引用这种绑定的体形式. 见宏`define-modify-macro`.

### 3.4.10 `define-method-combination` 传递参数lambda列表

`define-method-combination`的`:arguments`选项中使用`define-method-combination` 传递参数lambda列表.

`define-method-combination` 传递参数lambda列表可以使用的lambda列表关键字见下图:

图 3-21. `define-method-combination` 传递参数lambda列表可以使用的lambda列表关键字.

```
&allow-other-keys
&aux
&key
&optional
&rest
&whole
```

`define-method-combination` 传递参数lambda列表与常规lambda列表相似, 但允许使用`&whole`.

### 3.4.11 文档字符串和声明的语法交互

在一些情况下, 文档字符串可以出现在在一组形式前的一组`declare`表达式中.

如果字符串`S`出现在文档字符串允许出现的位置, 后续没有`decalre`表达式或形式, 则将`S`为形式; 否则`S`为文档字符串. 如果有多个这样的文档字符串存在, 后果是未定义的.

## 3.5 函数调用中错误检测

### 3.5.1 参数失配检测(Argument Mismatch Detection)

#### 3.5.1.1 安全和不安全调用

调用是**安全调用**, 如果下面的是安全代码或系统代码(不是程序员代码的宏展开后的系统代码):

- 这个调用
- 被调用的函数的定义
- 函数求值点

下面的特殊情况需要特别注意:

- 如果被调用的函数是广义函数, 它是安全的如果下面的是安全代码或系统代码:  
    
- 被显式定义的定义  
    
- 所有可应用方法的方法定义  
    
- 方法组合的定义  
    
- 对于形式`coerce X 'function`, `X`是一个lamda表达式,`coerce`被执行时全局环境中优化的安全性的值应用在结果函数上.
- 对于对函数`ensure-generic-function`的调用, 在作为`:environment`传递参数的环境对象中优化的安全性的值应用在结果广义函数上.
- 对于以lambda表达式作为传递参数对`compile`的调用, 在`compile`被调用时的全局环境中优化的安全性的值应用在结果已编译函数上.
- 对于以一个传递参数对`compile`的调用, 如果函数的原始定义是安全的, 则结果已编译函数必须也是安全的.
- 通过`call-next-method`对方法的调用必须被认为是安全的, 如果下面的是安全代码或系统代码:  
    
- 显式定义的广义函数的定义  
    
- 所有可应用方法的方法定义  
    
- 方法组合的定义  
    
- `call-next-method`建立绑定时, 方法定义形式体的进入点  
    
- 名称`call-next-method`的函数求值点  
    

**不去安全调用**是 不是安全调用的调用.

如果采用了合理的株洲确保调用是安全的, 程序员可以依赖于安全的调用, 甚至有系统代码时. 例如, 如果程序员从安全代码调用`mapcar`, 提供了一个被编译为安全的函数, 实现需要保证`mapcar`也是安全调用.

##### 3.5.1.1.1 安全调用中错误检测时间

如果安全调用中发出错误信号, 信号的具体发出点是依赖于实现的. 通常, 错误信号在编译时或运行时发出, 可以在执行调用前、时和后发出. 但总是在执行被调用的函数的体之前发出.

##### 3.5.1.1.2 过少传递参数

不允许给函数提供过少传递参数. 过少传递参数的含义是函数的传递参数数量比必备参数数量少.

如果在安全调用中出现这种情况, 必须发出类型为`program-error`的错误信号; 在不安全调用中这种情况的后果未定义.

#### 3.5.1.2 过多传递参数

不允许给函数提供过多传递参数. 过多传递参数的含义是函数的传递参数数量比必备参数和可选参数数量多; 如果函数使用了`&rest`或`&key`, 可以接收过多参数.

如果这种情况出现在安全调用中, 必须发出类型为`program-error`的错误信号; 在不安全调用中这种情况的后果未定义.

#### 3.5.1.3 未识别的关键字参数

不允许使用不能被函数识别的名称给函数提供关键字参数, 除非关键字检查被抑制(见**3.4.1.4.1 抑制关键字参数检查**).

如果这种情况出现在安全调用中, 必须发出类型为`program-error`的错误信号; 在不安全调用中这种情况的后果未定义.

#### 3.5.1.4 无效的关键字传递参数

不允许使用不是符号的名称给函数提供关键字参数.

如果这种情况出现在安全调用中, 必须发出类型为`program-error`的错误信号, 除非关键字检查被抑制(见**3.4.1.4.1 抑制关键字参数检查**); 在不安全调用中这种情况的后果未定义.

#### 3.5.1.5 奇数个关键字传递参数

不允许给关键词参数提供奇数个传递参数.

如果这种情况出现在安全调用中, 必须发出类型为`program-error`的错误信号, 除非关键字检查被抑制(见**3.4.1.4.1 抑制关键字参数检查**); 在不安全调用中这种情况的后果未定义.

#### 3.5.1.6 解构失配

当使用解构lambda列表匹配一个形式时, 模式与形式必须有兼容的树结构, 见**3.4.4 宏lambda列表**.

否则在安全调用中, 必须发出类型为`program-error`的错误信号; 在不安全调用中这种情况的后果未定义.

#### 3.5.1.7 调用下一方法时的错误

如果使用传递参数调用`call-next-method`, `call-next-method`的已改变传递参数集的可应用方法有序集, 必须与广义函数的原始传递参数的可应用方法有序集一样, 否则发出错误信号.

对新传递参数可应用的方法集 与 对原始传递参数可应用的方法集之前的比较, 对有相同描述符的方法中顺序是不敏感的.

如果用描述了不同可应用方法的有序集的传递参数调用`call-next-method`, 且没有下一个方法可用, 对不同方法的测试和相关错误的发出(如果有)在调用`no-next-method`之前执行.

## 3.6 遍历规则和副作用

在执行对象遍历操作的代码中, 以可能影响后续遍历操作的方式破坏性的修改对象时, 后果是未定义的. 特别的, 有下述规则:

- 列表遍历

对列表遍历操作, 列表中的cdr链不允许被破坏性修改.

- 数组遍历

对数组遍历操作, 数组不允许被调整, 如果存在填充指针, 则填充指针也不允许修改.

- 哈希表遍历

对哈希表遍历操作, 新元素不允许添加或移除, 除了当前哈希键对应的元素被修改或移除.

- 包遍历

对包遍历操作(例如`do-symbols`), 新符号不允许在被遍历的包或它使用的包中内部化或非内部化, 除了当前符号可以从被遍历的包中非内部化.

## 3.7 破坏性操作(Destructive Operations)

### 3.7.1 修改字面量对象

如果字面量对象被破坏性修改, 后果是未定义的. 下面的操作是破坏性的:

- `random-state`

用作函数`random`的传递参数.

- cons

修改cons的car或cdr, 或者在cons的car或cdr的对象上执行破坏性操作.

- 数组

给数组中某个元素存储新值, 或者在已是元素的对象上执行破坏性操作. 修改数组的填充指针、维度或displacement(不管数组是否是实际可调整的). 在displace到这个数组或者与其共享内容的另一个数组上, 执行破坏性操作.

- 哈希表

在键上执行破坏性操作. 给值存储新值, 或者在值的对象上执行破坏性操作. 从哈希表中添加或者移除项.

- `struct-object`

在槽中存储新值, 或者在一些槽的值对象上执行破坏性操作.

- `standard-object`

在槽中存储新值, 或者在一些槽的值对象上执行破坏性操作. 修改对象的类(例如使用函数`change-class`).

- `readtable`

修改`readtable`大小写设置. 修改`readtable`中任意字符的语法类型. 修改`readtable`中任意字符关联的读取器宏函数, 或者修改其中定义为分发宏字符的字符关联的读取器宏函数.

- 流

在流上执行IO操作, 或者关闭流.

- 所有其他标准类型

这个类别包括诸如: 字符串、状况、函数、方法组合、方法、数值、包、路径名、重启器和符号.

没有在这些类型的对象上定义标准的破坏性操作.

### 3.7.2 破坏性操作中控制转移

破坏性操作中是否可以发生控制转移, 是依赖于实现的.

#### 3.7.2.1 示例: 破坏性操作中控制转移

下面的示例展示了修改的依赖于实现的特性:

```
(let ((a (list 2 1 4 3 7 6 'five)))
  (ignore-errors (sort a #'<))
  a)
=>  (1 2 3 4 6 7 FIVE)
OR=>  (2 1 4 3 7 6 FIVE)
OR=>  (2)

(prog foo ((a (list 1 2 3 4 5 6 7 8 9 10)))
  (sort a #'(lambda (x y) (if (zerop (random 5)) (return-from foo a) (> x y)))))
=>  (1 2 3 4 5 6 7 8 9 10)
OR=>  (3 4 5 6 2 7 8 9 10 1)
OR=>  (1 2 4 3)
```

## 3.8 求值和编译的字典

- symbol `lambda`
- macro `lambda`
- function `compile`
- function `eval`
- special operator `eval-when`
- special operator `load-time-value`
- special operator `quote`
- accessor `compiler-macro-function`
- macro `define-compiler-macro`
- macro `defmacro`
- accessor `macro-function`
- function `macroexpand`
- macro `define-symbol-macro`
- special operator `symbol-macrolet`
- variable `*macroexpand-hook*`
- function `proclaim`
- macro `declaim`
- symbol `declare`
- declaration `ignore`
- declaration `dynamic-extent`
- declaration `type`
- declaration `inline`
- declaration `ftype`
- declaration `declaration`
- declaration `optimize`
- declaration `special`
- special operator `locally`
- special operator `the`
- function `special-operator-p`
- function `constantp`

# 4 类型和类

## 4.1 介绍

**类型**(type)是一组(可能无限数量的)对象. 一个对象(object)可以属于多个类型. Common Lisp从不将类型显式表示为对象, 而是通过使用**类型描述符**(type specifier)间接引用, 类型描述符是指代类型的对象.

可以通过**deftype**、**defstruct**、**defclass**和**define-condition**定义新的类型.

函数**typep**是集合成员测试, 用于确定给定对象是否属于给定类型. 函数**subtypep**是子集测试, 用于确定给定类型是否是另一个给定类型的子类型. 函数**type-of**返回给定对象所属的一个特定类型, 尽管对象可以属于多个类型.(例如, 每个对象属于类型**t**, 但**type-of**总是返回比**t**特殊的类型描述符.)

对象(object)是有类型的, 而变量(variable)是没有类型的. 通常变量的值可以是任意对象. 可以通过显式类型声明(type declaration), 声明一个变量的值只能是属于给定类型的对象. 除了类型等价外, 类型被组织成有向无环图.

可以使用**declare**、**proclaim**、**declaim**或**the**做类型声明. 有关声明的更多信息见 3.3 声明(Declarations) .

对象系统的基础对象中有**类(class)**. 类确定了一组其他对象的结构和行为, 这些对象称作它的**实例(instance)**. 每个对象是一个类的直接实例. 对象所属的类确定了可以在该对象上执行的操作集合- 更多信息见 4.3 类(Classes) .

可以编写对作为其参数的对象的类上有特化行为的函数- 更多信息见 7.6 广义函数和方法 .

对象的类的类称为它的**元类(metaclass)**- 关于元类的更多信息见 7.4 元对象 .

## 4.2 类型(Types)

### 4.2.1 数据类型定义

类型的使用信息在下图中给出. **图 4-7. 对象系统类.**列举了一些与对象系统相关的类. **图 9-1. 标准状况类型.**列出了已定义的状况类型.

Figure4-1. 数据类型信息的引用.

| 章节                   |               数据类型 |
| :--------------------- | ---------------------: |
| **4.3 类(Classes)**    |           对象系统类型 |
| **7.5 槽(Slots)**      |           对象系统类型 |
| **7 对象**             |           对象系统类型 |
| **7.6 广义函数和方法** |           对象系统类型 |
| **9.1 状况系统概念**   |           状况系统类型 |
| **4 类型和类**         |               多种类型 |
| **2 语法**             | 所有类型: 读和打印语法 |
| **22.1 Lisp打印器**    |     所有类型: 打印语法 |
| **3.2 编译**           |     所有类型: 编译问题 |

### 4.2.2 类型关系

- 类型`cons`、`symbol`、`array`、`number`、`character`、`hash-table`、`function`、`readtable`、`package`、`pathname`、`stream`、`random-state`、`condition`、`restart`和通过`defstruct`、`define-condition`或`defclass`定义的单个类型, 相互之间是隔离的, 除非在`declass`或`define-condition`中或者`defstruct`的`:include`选项中指定超类, 显式的建立了类型关系.
- 使用`defstruct`创建的两个类型是隔离的, 除非使用了`:include`选项将其中一个类型设置为另一个类型的超类型.
- 使用`defclass`或`define-condition`创建的两个不同类是隔离的, 除非它们有共同的超类, 或者一个类是另一个类的子类.
- 实现可以扩展添加类型之间的子类型关系, 只要它们没有违背这里描述的类型关系和不相交要求. 实现可以定义任意类型的超类型或子类型, 只要每个有超类型`t`和子类型`nil`, 且没有违背不相交要求.

在实现中, `standard-object`或`structure-object`可以在没有描述`standard-object`或`structure-object`的系统类的类优先级列表中出现. 如果出现了, 必须在类`t`之前和其他标准类之后出现.

### 4.2.3 类型描述符

**类型描述符** 可以是符号、类或列表. **图 4-2. 标准原子类型描述符.**列出了是标准原子类型描述符的符号, **图 4-3. 标准复合类型描述符名称.**列出了标准复合类型描述符的名称. 类型描述符的语法参见字典一节. 可以使用`defclass`、`define-condition`、`defstruct`或`deftype`定义新的类型描述符.

Figure4-2. 标准原子类型描述符.

```
arithmetic-error
array
atom
base-char
base-string
bignum
bit
bit-vector
broadcast-stream
built-in-class
cell-error
character
class
compiled-function
complex
concatenated-stream
condition
cons
control-error
division-by-zero
double-float
echo-stream
end-of-file
error
extended-char
file-error
file-stream
fixnum
float
floating-point-inexact
floating-point-invalid-operation
floating-point-overflow
floating-point-underflow
function
generic-function
hash-table
integer
keyword
list
logical-pathname
long-float
method
method-combination
nil
null
number
package
package-error
parse-error
pathname
print-not-readable
program-error
random-state
ratio
rational
reader-error
readtable
real
restart
sequence
serious-condition
short-float
signed-byte
simple-array
simple-base-string
simple-bit-vector
simple-condition
simple-error
simple-string
simple-type-error
simple-vector
simple-warning
single-float
standard-char
standard-class
standard-generic-function
standard-method
standard-object
storage-condition
stream
stream-error
string
string-stream
structure-class
structure-object
style-warning
symbol
synonym-stream
t
two-way-stream
type-error
unbound-slot
unbound-variable
undefined-function
unsigned-byte
vector
warning
```

如果类型描述符是一个列表, 该列表的car是一个符号, 列表的剩余部分是附属类型信息. 这样的类型描述符被称为**复合类型描述符**. 除非特别支持, 可以不指定附属项. 未指定的附属项通过`*`标识. 例如, 为完整的描述一个向量, 必须指定元素的类型和向量的长度.

```
(vector double-float 100)
```

下面没有指定长度:

```
(vector double-float *)
```

下面没有指定元素类型:

```
(vector * 100)
```

假设两个类型描述符除了第一个有个`*`而第二个有显式的描述之外均相同. 则第二个表示第一个表示的类型的子类型.

如果列表尾有未指定项, 这些项被移出. 如果移除所有`*`的结果为单个元素的列表, 则括号页可以被移除(这个列表可以被其car的符号替代). 例如, `(vector double-float *)`可以简写为`(vector double-float)`, `(vector * *)`可以简写为`(vector)`或`vector`.

Figure4-3. 标准复合类型描述符名称.

```
and
array
base-string
bit-vector
complex
cons
double-float
eql
float
function
integer
long-float
member
mod
not
or
rational
real
satisfies
short-float
signed-byte
simple-array
simple-base-string
simple-bit-vector
simple-string
simple-vector
single-float
string
unsigned-byte
values
vector
```

下图展示了可用作复合类型描述符名称、但不可以用作原子类型描述符的已定义名称。

Figure4-4. 标准的只用于复合类型描述符的名称.

```
and
eql
member
mod
not
or
satisfies
values
```

可以使用两种方式定义类型描述符:

- 使用不带`:type`描述符的`defstruct`定义结构, 或者使用`defclass`或`define-conditon`定义类, 自动将结构或类的名称转变为新的类型描述符的符号.
- 使用`deftype`定义导出的类型描述符, 它是其他类型描述符的简写.

类对象可被用作类型描述符, 它表示这个类的所有成员的集合.

下图展示了与类型和类型相关的一些已定义名称.

Figure4-5. 与类型和声明相关的已定义名称.

```
coerce
declaim
declare
defclass
define-condition
defstruct
deftype
ftype
locally
proclaim
subtypep
the
type
type-of
typep
```

下图展示了所有是类型描述符的已定义名称, 或者是原子类型描述符或者是复合类型描述符, 这个列表是**图 4-2. 标准原子类型描述符.|../04-Types-and-Classes#Figure4-2]]和[[图 4-3. 标准复合类型描述符名称.**的并.

Figure4-6. 标准类型描述符名称.

```
and
arithmetic-error
array
atom
base-char
base-string
bignum
bit
bit-vector
broadcast-stream
built-in-class
cell-error
character
class
compiled-function
complex
concatenated-stream
condition
cons
control-error
division-by-zero
double-float
echo-stream
end-of-file
eql
error
extended-char
file-error
file-stream
fixnum
float
floating-point-inexact
floating-point-invalid-operation
floating-point-overflow
floating-point-underflow
function
generic-function
hash-table
integer
keyword
list
logical-pathname
long-float
member
method
method-combination
mod
nil
not
null
number
or
package
package-error
parse-error
pathname
print-not-readable
program-error
random-state
ratio
rational
reader-error
readtable
real
restart
satisfies
sequence
serious-condition
short-float
signed-byte
simple-array
simple-base-string
simple-bit-vector
simple-condition
simple-error
simple-string
simple-type-error
simple-vector
simple-warning
single-float
standard-char
standard-class
standard-generic-function
standard-method
standard-object
storage-condition
stream
stream-error
string
string-stream
structure-class
structure-object
style-warning
symbol
synonym-stream
t
two-way-stream
type-error
unbound-slot
unbound-variable
undefined-function
unsigned-byte
values
vector
warning
```

## 4.3 类(Classes)

对象系统通常可以描述所有标准类(例如包括`number`、`hash-table`和`symbol`), 下图中有一组与理解对象系统相关的类.

Figure4-7. 对象系统类.

```
built-in-class
class
generic-function
method
method-combination
standard-class
standard-generic-function
standard-method
standard-object
structure-class
structure-object
```

### 4.3.1 类的介绍

**类**是一个确定一组其他独享的结构和行为的对象, 这一组对象称为它的实例.

类可以继承其它类的结构和行为. 一个类的定义中出于继承目的而引用其它类, 称这个类是其它类的子类. 设计用于被继承目的的类, 称为是继承类的超类.

类有一个名称. 函数`class-name`以类对象为传递参数, 返回它的名称. 匿名类的名称是`nil`. 符号可以命名类. 函数`find-class`已符号为传递参数, 返回该符号名称的类. 如果类的名称是一个符号, 类的名称命名了该类, 则称**类有合适的名称**. 即, 类`C`有合适的名称`S`, 如果`S=(class-name C)`且`C=(find-class S)`. 注意可能有`(find-class S1) = (find-class S2)`但`S1 /= S2`的情况. 如果`C=(find-class S)`, 称`C`是命名为`S`的类.

类`C1`是类`C2`的直接超类, 如果`C2`显式的在定义中指定`C1`作为超类. 在这种情况下, `C2`是`C1`的直接子类. 类`Cn`是类`C1`的超类, 如果存在一组类`C2,...,Cn-1`, 其中对`1 <= i < n`, `Ci+1`是`Ci`的直接超类. 在这种情况下, `C1`是`Cn`的子类. 类不是自身的超类或子类. 即, 如果`C1`是`C2`的超类, 则`C1 /= C2`. 给定类`C`和它的所有超类的集合, 称为`C`和它的超类.

每个类有一个类优先级列表, 它是在给定类和它的超类上的全序. 全序被表述为按从最特殊到最不特殊排列的列表. 类优先级列表被多种方式使用. 通常, 较特殊的类可以遮盖从较不特殊的类继承的特性. 方法选择和组合处理, 使用类优先级列表将方法按最特殊到最不特殊排序.

当定义类时, 在定义形式中的直接超类的顺序很重要. 每个类有一个**本地优先级顺序**, 是一个该类和按在其定义形式中直接超类顺序排列的直接超类.

类的优先级列表总是与列表中每个类的本地优先级顺序一致. 每个本地优先级顺序中类在类优先级列表中按相同的顺序出现. 如果本地优先级顺序与其他的不一致, 构造不出类优先级列表, 发出错误信号. 类优先级列表和它的计算在**4.3.5 确定类优先级列表**中讨论.

类被组织成一个有向无环图. 有两个特别的类: `t`和`standard-object`. 名称为`t`的类没有超类, 它是除自身之外的所有类的超类. 名称为`standard-object`的类是类`standard-class`的一个实例, 是出自身外其它是类`standard-class`的实例的所有类的超类.

存在从对象系统类空间到类型空间的映射. 该文档中描述的许多标准类型有响应的同名的类. 一些类型没有相应的类. 集成类和类系统, 在**4.3.7 集成类型和类**中讨论.

类被表示成自身是类的实例的对象. 对象的类的类是该对象的元类. 不存在歧义时, 术语元类用于引用一个自身实例也是类的类. 元类确定了被类使用的继承形式, 这些类是其实例和属于这些类的示例的表示. 对象系统提供了一个默认元类: `standard-class`, 对大多数程序适用.

除非特别说明, 该标准中提到的所有类是类`standard-class`的实例, 所有广义函数是类`standard-generic-function`的实例, 所有方法是类`standard-method`的实例.

#### 4.3.1.1 标准元类

对象系统提供了一组预定义的元类. 包括: 类`standard-class`、`built-in-class`和`structure-class`:

- 类`standard-class`是用`defclass`定义的类的类.
- 类`built-in-class`是其实例是有受限能力的特殊实现的类的类. 与标准类型对应的类可以是`built-in-class`的实例. **图 4-8. 与预定义的类型描述对应的类.**中列出了要求有对应的类的预定义的类型描述符. 是否将这些类实现为内置类是依赖于实现的.
- 用`defstruct`定义的类是类`structure-class`的实例.

### 4.3.2 定义类

用宏`defclass`定义新命名的类.

类的定义包括:

- 新类的名称. 对新定义的类, 这个名称是合适的名称.
- 新类的直接超类的列表.
- 一组槽描述符. 每个槽描述符包括槽的名称和槽选项. 槽选项只属于一个槽. 如果一个类定义中有两个相同的名称的槽描述符, 发出错误信号.
- 一组类选项. 每个类选项属于类.

`defclass`中槽选项和类选项提供了机制:

- 为给定槽提供默认初始值形式
- 要求自动生成读写槽的广义函数的方法
- 控制给定槽是否被类的所有实例共享, 还是每个实例有自己的槽
- 为实例创建提供一组初始化传递参数和初始化传递参数默认值
- 指示元类不是默认的. `:metaclass`选项被保留给未来使用, 实现可以扩展利用`:metaclass`选项
- 指示在槽中存储预期类型的值
- 指示槽的文档字符串

### 4.3.3 创建类的实例

广义函数`make-instance`创建和返回类的新实例. 对象系统提供了描述如何初始化新实例的机制. 例如, 可以通过给`make-instance`提供传递参数或提供默认初始值, 指定新建对象的槽的初始值. 进一步的初始化活动可以用作为初始化协议一部分的广义函数的方法来执行. 完整的初始化协议在**7.1 对象创建和初始化**中描述.

### 4.3.4 继承(Inheritance)

类可以从超类中继承方法、槽和一些`defclass`选项. 其他章节描述方法继承、槽和槽选项继承、类选项继承.

#### 4.3.4.1 示例: 继承

```
(defclass C1 ()
    ((S1 :initform 5.4 :type number)
     (S2 :allocation :class)))

(defclass C2 (C1)
    ((S1 :initform 5 :type integer)
     (S2 :allocation :instance)
     (S3 :accessor C2-S3)))
```

类`C1`的实例有一个本地槽`S1`, 它的默认初始值是5.4, 它的值总是一个数值. 类`C1`也有一个共享槽`S2`.

类`C2`的实例有一个本地槽`S1`, 它的默认初始值是5, 它的值的类型是`(and integer number)`. 类`C2`的实例也有本地槽`S2`和`S3`, 类`C2`有一个方法`C2-S3`读取槽`S3`的值, 有一个`(setf C2-S3)`方法写槽`S3`的值.

#### 4.3.4.2 类的选项继承

类选项`:default-initargs`被继承. 类的默认初始化传递参数是该类和其超类中`:default-initargs`中提供的初始化传递参数的并集. 当对给定的初始化传递参数有多个默认初始值形式时, 使用根据类优先级列表中最特殊的类提供的默认初始值形式.

如果一个给定的`:default-initargs`选项就同一名称指定了多个初始化传递参数, 发出类型为`program-error`的错误信号.

### 4.3.5 确定类优先级列表

> 参考 [https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node274.html](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node274.html)

类的`defclass`形式提供了该类和其直接超类的全序, 这个顺序被称为**本地优先级顺序**. 它是类和其直接超类的有序列表. 类 𝐶C 的类优先级列表是 𝐶C 和它的超类的全序, 由 𝐶C 和它的超类的本地优先级顺序构成.

(在优先级列表中)类出现在它的直接超类之前, 一个直接超类出现在`defclass`形式的超类列表中后面的超类之前.

对每个类 𝐶C 定义:

𝑅𝐶=(𝐶,𝐶1),(𝐶1,𝐶2),...,(𝐶𝑛−1,𝐶𝑛)RC​=(C,C1​),(C1​,C2​),...,(Cn−1​,Cn​)

其中, 𝐶1,...𝐶𝑛C1​,...Cn​ 在 𝐶C 的`defclass`形式中出现, 且保持(本地优先级顺序中的)顺序. 这些有序对生成了类 𝐶C 和它的直接超类的全序.

记 𝑆𝐶SC​ 为类 𝐶C 和它的超类构成的集合, 定义 𝑅R 为:

𝑅=⋃𝑐∈𝑆𝐶𝑅𝑐R=c∈SC​⋃​Rc​

𝑅R 可能会或不会生成一个偏序, 依赖于 𝑅𝑐,𝑐∈𝑆𝐶Rc​,c∈SC​ 是否是一致的; 当 𝑅R 生成偏序时, 认为它们是一致的. 如果 𝑅𝑐Rc​ 不是一致的, 称 𝑅R不是一致的.

计算类 𝐶C 的类优先级列表时, 将 𝑆𝐶SC​ 中元素按 𝑅R 生成的顺序拓扑排序. 当拓扑排序必须从一组类中选择一个类时, 这组类在 𝑅R 意义下没有顺序, 则按后面描述的方式选择.

如果 𝑅R 不是一致的, 则发出错误信号.

#### 4.3.5.1 拓扑排序

拓扑排序在 𝑆𝐶SC​ 中找一个类, 在 𝑅R 中没有其它类在该类之前. 类 𝐶C 作为结果列表中第一个元素, 将 𝐶C 从 𝑆𝐶SC​ 中移除, 同时从 𝑅R中移除所有 (𝐶,𝐷),𝐷∈𝑆𝐶(C,D),D∈SC​. 重复上述动作, 将没有前继的类添加到结果列表中. 在没有无前继元素时停止.

如果 𝑆𝐶SC​ 不空, 但处理过程已结束, 则 𝑅R 不是一致的. 如果在一个有限数量的类的集合中, 每个类在其它类之前出现, 则 𝑅R 包含一个 **环**. 即, 有一个类的链 𝐶1,...,𝐶𝑛C1​,...,Cn​, 对 1<=𝑖<𝑛1<=i<n, 𝐶𝑖Ci​ 在 𝐶𝑖+1Ci+1​ 之前出现, 且 𝐶𝑛Cn​ 在 𝐶1C1​ 之前出现.

有时 𝑆𝐶SC​ 中有些类没有前继. 这种情况下, 从有直接子类在当前计算出的类优先级列表中的类集合中, 选择有最右边的直接子类对应的类.

如果没有这种候选类, 𝑅R 不能生成一个偏序, 𝑅𝑐,𝑐∈𝑆𝐶Rc​,c∈SC​ 是不一致的.

如果有多个候选类, 𝑁1,...,𝑁𝑚,𝑚>=2N1​,...,Nm​,m>=2 是 𝑆𝐶SC​ 中没有前继的类集合, (𝐶1,...,𝐶𝑛),𝑛>=1(C1​,...,Cn​),n>=1 是当前构造出的类优先级列表, 𝐶1C1​ 是最特殊的类, 𝐶𝑛Cn​ 是最不特殊的类. 对 1<=𝑗<=𝑛1<=j<=n, 有 𝑁𝑖,1<=𝑖<=𝑚Ni​,1<=i<=m 是 𝐶𝑗Cj​ 的直接超类, 取对应于最大的 𝑗j 的 𝑁𝑖Ni​ 作为结果列表的下一个元素.

这个从一组没有前继的类中选择的规则的效果是, 简单超类链中的类在类优先级列表中是邻近的, 在每个相对隔离的子图中的类在类优先级列表中是邻近的. 例如, 𝑇1T1​ 和 𝑇2T2​ 是只共有类 𝐽J 的两个子图, 假设 𝐽J 的超类不出现在 𝑇1T1​ 或 𝑇2T2​ 中, 𝐶1C1​ 是 𝑇1T1​ 的底, 𝐶2C2​ 是 𝑇2T2​ 的底, 类𝐶C 的直接超类是 𝐶1,𝐶2C1​,C2​, 则 𝐶C 的类优先级列表以 𝐶C 开始, 后接 𝑇1T1​ 中除了 𝐽J 的所有类, 再后接 𝑇2T2​ 中所有类, 类 𝐽J 和它的超类最后出现.

#### 4.3.5.2 示例: 确定类优先级列表

下面的示例确定类pie的优先级列表, 类定义如下:

```
(defclass pie (apple cinnamon) ())
(defclass apple (fruit) ())
(defclass cinnamon (spice) ())
(defclass fruit (food) ())
(defclass spice (food) ())
(defclass food () ())
```

𝑆𝑝𝑖𝑒Spie​ = {pie, apple, cinnamon, fruit, spice, food, standard-object, t},

𝑅R = {(pie, apple), (apple, cinnamon), (apple, fruit), (cinnamon, spice), (fruit, food), (spice, food), (food, standard-object), (standard-object, t)}.

类pie没有前继, 作为结果列表的第一个元素, 当前结果列表为(pie). 将pie从 𝑆S 移除, 将pie作为对中第一个元素出现的对从 𝑅R 中移除, 则 𝑆S = {apple, cinnamon, fruit, spice, food, standard-object, t}, 𝑅R = {(apple, cinnamon), (apple, fruit), (cinnamon, spice), (fruit, food), (spice, food), (food, standard-object), (standard-object, t)}.

类apple没有前继, 作为结果列表中下一个元素, 当前结果列表为(pie apple), 移除apple及其相关对后, 𝑆S = {cinnamon, fruit, spice, food, standard-object, t}, 𝑅R = {(cinnamon, spice), (fruit, food), (spice, food), (food, standard-object), (standard-object, t)}.

类cinnamon和fruit没有前继, 选择有直接子类在当前计算出的类优先级列表中, 最右的直接子类对应的类. 类apple是fruit的直接子类, pie是cinnamon的直接子类, 但在当前优先级列表中apple出现在pie右边, 所以选择fruit作为结果列表下一元素, 当前结果列表为(pie apple fruit), 𝑆S = {cinnamon, spice, food, standard-object, t}, 𝑅R = {(cinnamon, spice), (spice, food), (food, standard-object), (standard-object, t)}.

类cinnamon是下一个元素, 当前结果列表为(pie apple fruit cinnamon), 𝑆S = {spice, food, standard-object, t}, 𝑅R = {(spice, food), (food, standard-object), (standard-object, t)}.

按顺序添加spice、food、standard-object和t, 类优先级列表为(pie apple fruit cinnamon spic food standard-object t).

也可能写出一组不能排序的类, 例如:

```
(defclass new-class (fruit apple) ())
(defclass apple (fruit) ())
```

类fruit必须在apple之前出现, 因为必须保留本地超类的顺序. 类apple必须在fruit之前出现, 因为类总是再它的超类前出现. 当发生这种情况时, 发出错误信号, 当系统尝试计算出new-class的类优先级列表时.

下面是可能表现出冲突的定义:

```
(defclass pie (apple cinnamon) ())
(defclass pastry (cinnamon apple) ())
(defclass apple () ())
(defclass cinnamon () ())
```

类pie的优先级列表是(pie apple cinnamon standard-object t), 类pastry的优先级列表是(pastry cinnamon apple standard-object t),

在类pie的优先级列表中, apple出现在cinnamon之前是没有问题的, 但在类pastry的优先级列表中, apple出现在cinnamon之前是是有问题的. 然而, 无法创建一个有超类pie和pastry的新类.

### 4.3.6 重定义类

`standard-class`的直接实例的类, 可被重定义, 如果新的类也是`standard-class`的直接实例. 重定义一个类会修改现有的类对象, 以反映新的类定义; 并不为该类创建一个新的类对象. 所有通过在旧的`defclass`形式中指定`:reader`、`:writer`、`:accessor`选项创建方法对象, 被从相应的广义函数中移除. 用新的`defclass`形式指定的方法被添加.

当类`C`被重定义, 修改会传播到它的实例和它的子类的实例中. 这种对实例的修改发生在依赖于实现的时刻, 但不晚于下一次该实例的槽被读取或写入. 这种对实例的修改并不改变它的标识(函数`eq`含义下). 这个修改过程可能修改特定实例的槽, 但不创建新的实例. 修改实例是否消耗存储空间是依赖于是实现的.

注意重定义类可能导致添加槽或移除槽. 如果以修改实例的本地槽可访问性的方式重定义类, 这些实例被修改. 如果重定义类没有修改实例的本地槽可访问性, 则这些实例是否被修改是依赖于实现的.

被指定为再旧类和新类中共享的槽值被保留. 如果这种共享的槽在旧类中是未绑定的, 则在新类中也是未绑定的. 在旧类中是本地的、在新类中是共享的槽, 被初始化. 新加的共享槽被初始化.

如果重定义类修改了类的实例中本地槽可访问性, 使用两个步骤的过程修改类的实例. 这个过程可以显式的调用广义函数`make-instances-obsolete`开始. 这个两个步骤的过程可以在一些实现中在其它场景下发生. 例如, 在一些实现中, 如果存储空间中槽的顺序被修改, 会触发这个两个步骤的过程.

过程中第一个步骤, 通过添加新的本地槽, 移除未在新类中定义的本次槽, 来修改实例的解构. 第二个步骤, 初始化新加的本地槽, 执行其它用户定义的动作. 详情见**4.3.6.1 修改实例的结构|#4.3.6.1]]和[[4.3.6.2 初始化新加的本地槽**.

#### 4.3.6.1 修改实例的结构

第一个步骤修改被重定义类的实例的结构, 以遵循新的类定义. 被新类定义的、未在旧类中指定为本地或共享的本地槽, 被添加; 在旧类中指定为本地的、未被新类定义为本地或共享的槽被移除. 这些被添加和移除的槽的名称, 作为`update-instance-for-redefined-class`的传递参数.

同时被新类和旧类指定的本地槽值被保留. 如果这样的本地槽是未绑定的, 则保持为未绑定.

在旧类中指定为共享、在新类中指定为本地的槽值被保留. 如果这样的共享槽是未绑定的, 则对应的本地槽未绑定.

#### 4.3.6.2 初始化新加的本地槽

第二个步骤初始化新加的本地槽, 指定其它用户定义的动作. 这个步骤用广义函数`update-instance-for-redefined-class`实现, 在修改实例结构的第一个步骤完成之后被调用.

广义函数`update-instance-for-redefined-class`有4个必备参数: 已经过第一个步骤处理的需修改实例、被添加的本地槽名称的列表、被移除的本地槽名称列表、包含被移除的槽的名称和值的关联列表. 被移出的槽中包含在旧类中指定为本地的、在新类中指定为共享的槽.

广义函数`update-instance-for-redefined-class`也接受一些初始化传递参数. 当被系统调用更新被重定义的类的实例时, 不会提供初始化传递参数.

广义函数`update-instance-for-redefined-class`有一个系统提供的主方法, 实例传递参数的参数特化符是类`standard-object`. 这个方法首先检查初始化传递参数的有效性, 无效时发出错误信号(更多信息见**7.1.2 声明初始化传递参数的有效性**). 然后, 调用广义函数`shared-initialize`, 传递参数: 该实例、新加槽的名称的列表、接收到的初始化传递参数.

#### 4.3.6.3 定制类重定义

广义函数`update-instance-for-redefined-class`的方法定义中可以指定实例被更新时执行的动作. 如果只定义了after方法, 它们会在系统提供的用于初始化的主方法之后运行, 因此不会影响`update-instance-for-redefined-class`的默认行为. 因为`update-instance-for-redefined-class`被系统调用时不会传递初始化参数, 被`update-instance-for-redefined-class`的before方法填充的槽的初始化形式不会被`shared-initialize`求值.

`shared-initialize`的方法可以定制类重定义. 更多信息见**7.1.5 共享的可初始化**.

### 4.3.7 集成类型和类

对象系统将类空间映射到类型的空间, 每个有合适名称的类有对应的同名的类型.

每个类的合适名称是有效的类型描述符. 此外, 每个类对象是有效的类型描述符. 所以表达式`(typep object class)`在`object`的类是`class`或`class`的子类时求值为true. 表达式`(subtypep class1 class2)`, 在`class1`是`class2`的子类或同一个类时, 求值为ture, true; 否则求值为false, true. 如果`I`是命名为`S`的类`C`的实例, `C`是`standard-class`的实例, 表达式`(type-of I)`, 在`S`是`C`的合适名称时返回`S`; 否则返回`C`.

因为类的名称和类对象的名称是类型描述符, 它们可被用于特殊形式`the`和类型声明中.

大量但不是所有的预定义的类型描述符有类型相应的有相同合适名称的类, 这些类型描述符见**图 4-8. 与预定义的类型描述对应的类.**. 例如, 类型`array`有相应命名为`array`的类. 是列表的类型描述符, 例如`(vector double-float 100)`, 没有相应的类. 操作符`deftype`不会创建类.

与预定义类型描述符对应的类, 实现可用三种方式实现. 它们可以是标准类、结构类或系统类.

内建类是其通用实例有受限能力或特殊表示的类. 尝试使用`defclass`定义内建类的子类, 会发出错误信号. 调用`make-instance`创建内建类的通用实例, 会发出错误信号. 在内建类的通用实例上调用`slot-value`, 会发出错误信号. 重定义内建类或使用`change-class`修改内建类实例的类或将其它类的实例的类修改为内建类, 会发出错误信号. 然而, 内建类可用作方法中参数特化符.

可以通过检查元类, 确定一个类是否是内建类. 标准类是类`standard-class`的实例, 内建类是类`built-in-class`的实例, 结构类是类`structure-class`的实例.

通过`defstruct`不带`:type`选项创建的结构类型有相应的类. 这个类是类`structure-class`的通用实例. `defstruct`的`:include`选项创建与被包含的结构类型对应的类的子类.

除了该规范中显示定义槽, 槽是否被包含到该规范定义的类的实例上函数的操作中, 是依赖于实现的.

如果在特定实现中, 该规范定义的类有该规范未定义的槽, 这些槽的名称必须不是该规范中定义的包的外部符号, 在`CL-USER`包中不可访问.

指定标准类型描述符有相应的类的意图是, 方便用户编写不区分这些类型的方法. 方法选择要求对每个类确定类优先级列表.

类型描述符的层次关系, 反应在与这些类型对应的类的层次关系中.

**图 4-8. 与预定义的类型描述对应的类.**列出了与预定义类型描述符对应的类.

Figure4-8. 与预定义的类型描述对应的类.

```
arithmetic-error
array
bit-vector
broadcast-stream
built-in-class
cell-error
character
class
complex
concatenated-stream
condition
cons
control-error
division-by-zero
echo-stream
end-of-file
error
file-error
file-stream
float
floating-point-inexact
floating-point-invalid-operation
floating-point-overflow
floating-point-underflow
function
generic-function
hash-table
integer
list
logical-pathname
method
method-combination
null
number
package
package-error
parse-error
pathname
print-not-readable
program-error
random-state
ratio
rational
reader-error
readtable
real
restart
sequence
serious-condition
simple-condition
simple-error
simple-type-error
simple-warning
standard-class
standard-generic-function
standard-method
standard-object
storage-condition
stream
stream-error
string
string-stream
structure-class
structure-object
style-warning
symbol
synonym-stream
t
two-way-stream
type-error
unbound-slot
unbound-variable
undefined-function
vector
warning
```

这些类定义中描述的类优先级列表信息, 是对象系统需要的.

实现可以扩展定义其它有对应类的类型描述符. 实现可以扩展添加其他子类关系, 在类优先级列表中添加其它元素, 只要没有违背该规范中类型关系和隔离性要求. 保证未指定直接超类的标准类与上图中所有类是不相交的, 除了类`t`.

## 4.4 类型和类的字典

- type **nil**
- type **boolean**
- system class **function**
- type **compiled-function**
- system class **generic-function**
- system class **standard-generic-function**
- system class **class**
- system class **built-in-class**
- system class **structure-class**
- system class **standard-class**
- system class **method**
- system class **standard-method**
- class **structure-object**
- class **standard-object**
- system class **method-combination**
- system class **t**
- type specifier **satisfies**
- type specifier **member**
- type specifier **not**
- type specifier **and**
- type specifier **or**
- type specifier **values**
- type specifier **eql**
- function **coerce**
- macro **deftype**
- function **subtypep**
- function **type-of**
- function **typep**
- condition type **type-error**
- function **type-error-datum**
- condition type **simple-type-error**


# 5 数据和控制流

## 5.1 通用的引用

### 5.1.1 位置和通用的引用概述

**通用的引用** 是对形式的使用, 有时称为 ==位置==, 就像是一个可以读取和写入的变量. 位置的值是位置形式求值结果的对象. 位置的值可以使用`setf`修改. Common lisp中未定义绑定一个位置的概念, 但实现允许扩展语言支持定义这个概念.

下图包含了使用`setf`的示例. 注意求值第二列中形式的返回值不一定与求值第三列的结果相同. 通常, `setf`形式的精确宏展开是没有保证的, 甚至可以是依赖于实现的; 可以保证的是展开是一个特定实现中可用的更新形式, 保留从左至右求值子形式, 求值`setf`的最终结果是被存储的值或一组值.

图 5-1. setf的示例.

```
访问函数            更新函数           使用setf更新
x                 (setq x datum)    (setf x datum)
(car x)           (rplaca x datum)  (setf (car x) datum)
(symbol-value x)  (set x datum)     (setf (symbol-value x) datum)
```

下图展示了与位置和通用的引用相关的操作符:

图 5-2. 与位置和通用的引用相关的操作符.

```
assert
ccase
ctypecase
decf
define-modify-macro
define-setf-expander
defsetf
get-setf-expansion
getf
incf
pop
psetf
push
remf
rotatef
setf
shiftf
```

上面的操作符中一部分操作位置, 一些操作setf展开器. setf展开可以从任意位置导出. 使用`defsetf`和`define-setf-expander`定义性的setf展开器.

#### 5.1.1.1 子形式到位置的求值

下面的规则应用在一个位置上的子形式的求值:

1. 在一个位置中的子形式的求值顺序, 是由`get-setf-expansion`返回的第一个值描述的顺序确定的. 对于该规范定义的所有位置(例如: `getf`, `ldb`...), 求值顺序是自左向右的. 当位置是由宏展开导出时, 这个规则在宏被展开以找到恰当的位置之后应用.  
      
    
2. 用`defmacro`或`define-setf-expander`定义的位置, 使用这个定义定义的求值顺序. 例如, 考虑``(defmacro wrong-order (x y) `(getf ,y ,x))``, 后面这个形式首先求值`place2`再求值`place1`, 因为这是它们在这个宏展开中求值顺序: `(push value (wrong-order place1 place2))`.  
    
3. 对操作位置的宏(`push`、`pushnew`、`remf`、`incf`、`decf`、`shiftf`、`rotatef`、`psetf`、`setf`、`pop`和用`define-modify-macro`定义的宏), 宏调用的子形式按从左至右的顺序求值一次, 位置的子形式按(1)中描述的顺序求值.  
      
    
4. `push`、`pushnew`、`remf`、`incf`、`decf`、`shiftf`、`rotatef`、`psetf`、`pop`在修改任何位置之前求值所有子形式. `setf`(有多于两个传递参数)按顺序在每对上执行操作. 例如: `(setf place1 value1 place2 value2 ...)`, 子形式`place1`和`value1`被求值, `place1`指定的位置被修改以包含`value1`返回的值, 然后以类似的方式处理`setf`形式中剩余部分.  
    
5. 对`check-type`、`ctypecase`和`ccase`, 位置上子形式按(1)中描述方式求值一次, 但如果`check-type`中类型检查失败, 或`ctypecase`和`ccase`中没有分支, 则可能被再次求值.
6. 对`assert`, 通用的引用的求值顺序未描述.

规则2、3和4包括错有操作位置的标准宏.

##### 5.1.1.1.1 示例: 子形式到位置的求值

```
(let ((ref2 (list '())))
  (push (progn (princ "1") 'ref-1)
        (car (progn (princ "2") ref2))))
>>  12
=>  (REF1)
```

```
(let (x)
   (push (setq x (list 'a))
         (car (setq x (list 'b))))
    x)
=>  (((A) . B))
```

`push`首先求值`(setq x (list 'a)) => (a)`, 然后求值`(setq x (list 'b)) => (b)`, 之后修改最后一个值的car为`((a) . b)`

#### 5.1.1.2 SETF展开

有时可以避免对位置上子形式求值多次或按错误的顺序求值. 对给定访问形式的setf展看可以表示为5个对象的有序集合:

- 临时变量的列表

- 命名了临时变量的符号的列表, 这些临时变量被顺序绑定, 就像`let*`, 被绑定到值形式产生的值.
- 值形式的列表

- 形式的列表(位置的子形式), 当这些形式被求值时, 产生对应的临时变量应该绑定到的值.
- 存储变量的列表

- 命名了临时存储变量的符号的列表, 这些存储变量用于持有将被指派到位置的新值.
- 存储形式

- 可以引用临时和存储变量的形式, 修改位置的值, 保证返回时它的值是存储变量的值, 这些值是正确的`setf`返回值.
- 访问形式

- 可以引用临时变量的形式, 返回位置的值.

访问形式返回的值, 受存储形式执行的影响, 但这两个形式可能被多次求值.

可以通过`psetf`、`shitf`和`rotatef`并行的做多个`setf`. 因此, setf展开器必须每次生成新的临时和存储变量名称. 如何生成新名词见`gensym`.

对每个标准的访问器函数`F`, 除非在其它地方说明, 使用`F`形式作为`setf`位置是通过setf展开器或setf函数实现的是依赖于实现的. 同时, 名称`(setf F)`是否是found的, 是依赖于实现的.

##### 5.1.1.2.1 实例: SETF展开

下面是setf展开的构成内容的示例.

对变量`x`:

图 5-3. 变量的setf展开的示例.

```
()              ;list of temporary variables
()              ;list of value forms
(g0001)         ;list of store variables
(setq x g0001)  ;storing form
x               ;accessing form
```

对`(car exp)`:

图 5-4. CAR形式的setf展开的示例.

```
(g0002)                             ;list of temporary variables
(exp)                               ;list of value forms
(g0003)                             ;list of store variables
(progn (rplaca g0002 g0003) g0003)  ;storing form
(car g0002)                         ;accessing form
```

对`(subseq seq s e)`:

图 5-5. SUBSEQ形式的setf展开的示例.

```
(g0004 g0005 g0006)         ;list of temporary variables
(seq s e)                   ;list of value forms
(g0007)                     ;list of store variables
(progn (replace g0004 g0007 :start1 g0005 :end1 g0006) g0007)
                            ;storing form
(subseq g0004 g0005 g0006)  ; accessing form
```

在一些情况中, 如果位置的子形式本身也是一个位置, 需要展开这个子形式以计算出外部位置中展开中的值. 例如, `(ldb bs (car exp))`:

图 5-6. LDB形式的setf展开的示例.

```
(g0001 g0002)            ;list of temporary variables
(bs exp)                 ;list of value forms
(g0003)                  ;list of store variables
(progn (rplaca g0002 (dpb g0003 g0001 (car g0002))) g0003)
                         ;storing form
(ldb g0001 (car g0002))  ; accessing form
```

### 5.1.2 位置的种类

Common Lisp定义了一些位置的种类, 这一部分列举出它们. 实现和程序员可以扩展位置的种类.

#### 5.1.2.1 变量名称作为位置

词法变量或动态变量的名称, 可被用作位置.

#### 5.1.2.2 函数调用形式作为位置

函数形式可被用作位置, 如果它是下面类别中的一个:

- 函数调用形式的首元素是下图中任一函数的名称:

图 5-7. 可以与setf一起使用的函数—1.

```
aref
bit
caaaar
caaadr
caaar
caadar
caaddr
caadr
caar
cadaar
cadadr
cadar
caddar
cadddr
caddr
cadr
car
cdaaar
cdaadr
cdaar
cdadar
cdaddr
cdadr
cdar
cddaar
cddadr
cddar
cdddar
cddddr
cdddr
cddr
cdr
char
class-name
compiler-macro-function
documentation
eighth
elt
fdefinition
fifth
fill-pointer
find-class
first
fourth
get
gethash
logical-pathname-translations
macro-function
ninth
nth
readtable-case
rest
row-major-aref
sbit
schar
second
seventh
sixth
slot-value
subseq
svref
symbol-function
symbol-plist
symbol-value
tenth
third
```

在`subseq`情况中, 替换值必须是一个元素可能包含在`subseq`的序列传递参数中的序列, 但不一定要是与指定子序列的序列的类型相同. 如果替换值的长度不等于被替换的子序列的长度, 则较短的长度确定了被存储的元素的数量, 就像`replace`.

- 函数调用形式的首元素是由`defstruct`构造的选择器函数的名称. 这个函数名称必须引用全局函数定义, 而不是本地定义的函数.
- 函数调用形式的首元素是下图中的一个函数的名称, 传递给函数的参数是位置形式; 这种情况下, 新位置的值是应用提供的更新函数后的结果.

图 5-8. 可以与setf一起使用的函数—2.

```
函数名称        是位置的传递参数             使用的更新函数
ldb            second                    dpb
mask-field     second                    deposit-field
getf           first                     依赖于实现
```

当这些形式的setf展开时, 需要调用`get-setf-expansion`, 以确定内层嵌套的通用变量如何处理.

`get-setf-expansion`中的信息按下述方式使用:

`ldb`

在形式`(setf (ldb byte-spec place-form) value-form)`中, `place-form`引用的位置必须总是被读写; 注意更新的是`place-form`指定的通用变量, 而不是类型`integer`的对象.

因此, 这个setf应该生成执行这些步骤的代码:

1. 求值`byte-spec`(将它绑定到一个临时变量)
2. 绑定`place-form`到临时变量
3. 求值`value-form`(绑定它的值到存储变量)
4. 读取`place-form`
5. 写入`place-form`, 用步骤4中读到的值, 用步骤3中值替换后的值.

如果步骤3中求值`value-form`修改了`place-form`中发现的对象, 例如设置整数的不同比特位, 则由`byte-spec`表达的比特位修改是应用在该修改后的对象上的, 因为步骤4是在求值`value-form`之后执行的. 绑定临时变量所需的求值是在步骤1和2中完成的, 因此可以看到预期的自左向右求值顺序. 例如:

```
(setq integer #x69) =>  #x69
(rotatef (ldb (byte 4 4) integer)
         (ldb (byte 4 0) integer))
integer =>  #x96
;;; This example is trying to swap two independent bit fields
;;; in an integer.  Note that the generalized variable of
;;; interest here is just the (possibly local) program variable
;;; integer.
```

`mask-field`

与`ldb`本质上相同.

`getf`

在形式`(setf (getf place-form ind-form) value-form)`中, `place-form`引用的形式必须总是被读写; 注意到更新是应用在`place-form`指定的通用变量上的, 不一定是特定的属性列表.

因此, 这个setf应该生成执行这些步骤的代码:

1. 绑定`place-form`到临时变量
2. 求值`ind-form`(绑定到临时变量)
3. 求值`value-form`(绑定值到存储变量)
4. 读取`palce-form`
5. 写入`place-form`, 使用通过步骤2-4组合后的可能为新的属性列表值.(注意这个可能为新的属性列表的含义是, 之前的属性列表被破坏性重用, 或部分或全拷贝. 对这个可能为新的属性列表的处理必须像需要一个不同的副本存入通用变量中).

如果步骤3中求值`value-form`修改了`place-form`中发现的对象, 例如在列表中设置不同名称属性, 则由`ind-form`表达的对属性的修改是应用在该修改后的列表上, 因为步骤4是在求值`value-form`后执行的. 绑定临时变量所需的求值是在步骤1和2中完成的, 因此可以看到预期的自左向右求值顺序. 例如:

例如:

```
(setq s (setq r (list (list 'a 1 'b 2 'c 3)))) =>  ((a 1 b 2 c 3))
(setf (getf (car r) 'b)
      (progn (setq r nil) 6)) =>  6
r =>  NIL
s =>  ((A 1 B 6 C 3))
;;; Note that the (setq r nil) does not affect the actions of
;;; the SETF because the value of R had already been saved in
;;; a temporary variable as part of the step 1. Only the CAR
;;; of this value will be retrieved, and subsequently modified
;;; after the value computation.
```

#### 5.1.2.3 VALUES形式作为位置

`values`形式可被用作位置, 它的每个子形式也是一个位置形式.

按下面的方式处理形式:

```
(setf (values place-1 ...place-n) values-form)
```

1. 每个内嵌位置的子形式按从左至右的顺序求值.
2. 求值`values-form`, 像使用`multiple-value-bind`一样将每个位置的首个存储变量绑定到它的返回值.
3. 如果任意位置的setf展开包含多个存储变量, 则额外的存储变量绑定到`nil`.
4. 每个位置的存储形式按从左至右的顺序求值.

`values`的setf展开中存储形式返回多值, 步骤2中存储变量的值. 即, 返回的值的数量与位置形式的数量相同. 返回值的数量可能比`values-form`生成的值多或少.

#### 5.1.2.4 THE形式作为位置

`the`形式可被用作位置, 声明被转换为新值的形式, 作为结果的setf被分析. 例如:

```
(setf (the integer (cadr x)) (+ y 3))
```

的处理方式与下面的相同:

```
(setf (cadr x) (the integer (+ y 3)))
```

#### 5.1.2.5 APPLY形式作为位置

必须支持这些包含`setf`的`apply`的使用:

- `(setf (apply #'aref array subscript* more-subscripts) new-element)`
- `(setf (apply #'bit array subscript* more-subscripts) new-element)`
- `(setf (apply #'sbit array subscript* more-subscripts) new-element)`

在三种情况中, 数组中由`subsripts`和`more-subscripts`指定的元素(如果不是`setf`形式的以部分则被读取)被修改为有`new-element`给定的值. 函数名称(`aref`、`bit`或`sbit`)必须引用全局函数定义, 而不是本地定义的函数.

不需要支持其他标准函数, 但实现可以支持. 实现页可以支持实现定义的操作符.

如果在这里使用用户定义的函数, 下面的等价为真, 除了注意保持传递参数子形式从左至右求值:

```
(setf (apply #'name arg*) val)
==  (apply #'(setf name) val arg*)
```

#### 5.1.2.6 SETF展开与位置

操作符有定义的setf展开器的复合形式可被用作位置. 这个操作符必须引用全局函数定义, 而不是本地定义的函数或宏.

#### 5.1.2.7 宏形式作为位置

宏形式可被用作位置, Common Lisp用`macroexpand-1`展开宏形式, 在原始位置处使用宏展开. 只在尝试了除将其展开为对`(setf reader)`函数调用的所有情况外, 尝试使用宏展开.

#### 5.1.2.8 符号宏作为位置

对已被建立为符号宏的符号的引用可被张用作位置. 在这种情况中, `setf`展开该引用, 然后分析作为结果的形式.

#### 5.1.2.9 其它复合形式作为位置

对任意操作符是符号`f`的复合形式, `setf`形式将其展开为对函数`(setf f)`的调用. 新构造的函数形式的第一个传递参数是新值, 剩余的传递参数是位置的剩余元素. 不管`f`或`(setf f)`被定义为本地函数、全局函数或不是函数, 总是执行这个展开. 例如:

```
(setf (f arg1 arg2 ...) new-value)
```

展开为与下面的形式效果和值向量:

```
(let ((#:temp-1 arg1)          ;强制正确的求值顺序
      (#:temp-2 arg2)
      ...
      (#:temp-0 new-value))
  (funcall (function (setf f)) #:temp-0 #:temp-1 #:temp-2...))
```

函数`(setf f)`必须返回它的第一个传递参数作为唯一的返回结果, 以保持`setf`的语义.

### 5.1.3 处理其它基于SETF的宏

对下图中的 **读-修改-写** 操作符, 和程序员用`define-modity-macro`定义的宏, 常规的按从左至右对传递参数进行求值的规则有一个例外. 按从左至右对传递参数形式求值, 对位置参数的处理是个例外, 在所有传递参数形式求值后、新值被计算出且被写入位置之前， 读取位置的旧值.

更具体的说, 这些操作符可被视为包含下述语法的形式:

```
(operator preceding-form* place following-form*)
```

对这个形式的求值处理如下:

1. 从左至右, 求值`preceding-forms`.
2. 求值`place`子形式, 按该位置的`setf`展开的第二个返回值指定的顺序.
3. 从左至右, 求值`following-form`.
4. 读`place`的旧值.
5. 计算新值.
6. 存储新值到`place`.

图 5-9. 读-修改-写宏.

```
decf
incf
pop
push
pushnew
remf
```

## 5.2 转移控制到退出点

当使用`go`、`return-from`或`throw`发起控制转移时, 为完成控制转移发生下面的事件. 注意, 对`go`, 退出点是`go`执行时运行的`tagbody`中的形式; 对`return-from`, 退出点是对应的`block`形式; 对`throw`, 退出点是相应的`catch`形式.

1. 其间的退出点之间被放弃(即它们的extent已结束, 通过它们尝试转移控制不再有效).
2. 其间的`unwind-protect`子句的清理子句被求值.
3. 其间的`special`变量的动态绑定、捕获标签、状况处理器和重启器被撤销.
4. 被调用的退出点的extend结束, 控制被传递给目标.

退出的extent被放弃, 是因为发出控制转移时立刻被结束. 即事件1在发起控制转移开始时发生. 如果尝试转移控制到动态extent已结束的退出点, 后果是未定义的.

事件2和3实际上是交叉执行的, 按与建立的顺序相反的顺序执行. 效果是, `unwind-protect`的清理子句看到相同的变量动态绑定, 进入`unwind-protect`时捕获标签可见.

事件4在转移控制结束时发生.

## 5.3 数据和控制流的字典

- function `apply`
- macro `defun`
- accessor `fdefinition`
- function `fboundp`
- function `fmakunbound`
- special operator `flet`
- function `funcall`
- special operator `function`
- function `function-lambda-expression`
- function `functionp`
- function `compiled-function-p`
- constant variable `call-arguments-limit`
- constant variable `lambda-list-keywords`
- constant variable `lambda-parameters-limit`
- macro `defconstant`
- macro `defparameter`
- macro `defvar`
- macro `destructuring-bind`
- special operator `let`
- special operator `progv`
- specialform `setq`
- macro `psetq`
- special operator `block`
- special operator `catch`
- special operator `go`
- special operator `return-from`
- macro `return`
- special operator `tagbody`
- special operator `throw`
- special operator `unwind-protect`
- constant variable `nil`
- function `not`
- constant variable `t`
- function `eq`
- function `eql`
- function `equal`
- function `equalp`
- function `identity`
- function `complement`
- function `constantly`
- function `every`
- macro `and`
- macro `cond`
- special operator `if`
- macro `or`
- macro `when`
- macro `unless`
- macro `case`
- macro `typecase`
- macro `multiple-value-bind`
- special operator `multiple-value-call`
- macro `multiple-value-list`
- special operator `multiple-value-prog1`
- macro `multiple-value-setq`
- accessor `values`
- function `values-list`
- constant variable `multiple-values-limit`
- macro `nth-value`
- macro `prog`
- macro `prog1`
- special operator `progn`
- macro `define-modify-macro`
- macro `defsetf`
- macro `define-setf-expander`
- function `get-setf-expansion`
- macro `setf`
- macro `shiftf`
- macro `rotatef`
- condition type `control-error`
- condition type `program-error`
- condition type `undefined-function`

# 6 迭代

## 6.1 循环功能

### 6.1.1 循环功能的概览

宏`loop`执行迭代.

#### 6.1.1.1 简单的循环与扩展的循环

`loop`行为被分为两类: 简单的`loop`形式和扩展的`loop`形式.

##### 6.1.1.1.1 简单的循环

简单的`loop`形式有一个只包含复合形式的体. 体中形式按从左至右的顺序依次求值. 在不结束的环内, 当求值完最后一个形式后, 第一个形式被再次求值, 等等. 简单的`loop`形式建立名称为`nil`的隐式块. 可以通过显式的转移控制到隐式块(使用`return`或`return-from`)或到块外的退出点(使用`throw`、`go`或`return-from`), 终止简单的`loop`的执行.

##### 6.1.1.1.2 扩展的循环

扩展的`loop`形式有包含原子表达式的体. 宏`loop`处理这种形式时, 调用称为循环功能的功能.

循环功能提供了对通过循环方案实现的迭代中使用的机制的标准访问, 这些机制由循环关键字引入.

扩展的`loop`形式的体被拆分为`loop`从句, 每个由循环关键字和形式构成.

#### 6.1.1.2 循环关键字

循环关键字不是真正的关键字, 它们是特殊的符号, 按名称而不是对象标识识别, 只在循环功能中有意义. 循环关键字是一个符号, 不管它在哪个表中被访问, 按名称(不是其标识)识别.

通常, 循环关键字不是COMMON-LISP包的外部符号, 除非在Common Lisp中恰好有与其同名的符号用于其它用户. 例如, COMMON-LISP包中有名称为`UNLESS`的符号, 但没有名称为`UNTIL`的符号.

如果`loop`形式中没有提供循环关键字, 循环功能重复的执行循环体; 见**6.1.1.1.1 简单的循环**.

#### 6.1.1.3 解析循环从句

扩展的`loop`形式的句法部分称为从句; 解析的规则是由从句的关键字确定的. 下面的示例展示了一个有6个从句的`loop`形式:

```
(loop for i from 1 to (compute-top-value)       ; first clause
      while (not (unacceptable i))              ; second clause
      collect (square i)                        ; third clause
      do (format t "Working on ~D now" i)       ; fourth clause
      when (evenp i)                            ; fifth clause
        do (format t "~D is a non-odd number" i)
      finally (format t "About to exit!"))      ; sixth clause
```

每个循环关键字引入了一个复合循环从句或一个简单的循环从句(由一个循环关键字后接一个简单形式构成). 从句中形式的数量是由从句开始处的循环关键字和从句中的辅助关键字确定的. 关键字`do`、`doing`、`initially`和`finally`是仅有的可以有任意数量形式的关键字, 这些形式被分组在一个隐式progn中.

循环从句可以包含辅助关键字, 它们有时被称为 ==介词==. 例如, 上面的示例中包含介词`from`和`to`, 标记了步进的起止值.

关于`loop`语法的详细信息见宏`loop`.

#### 6.1.1.4 展开循环形式

宏形式`loop`被展开为一个包含一个或多个 **绑定形式** (建立循环变量的绑定)、一个 **块** 和一个 **标签体** (表达循环控制结构)的形式. `loop`中建立的变量像`let`或`lambda`中那样被绑定.

实现可以交错的用绑定设置初始值. 然而, 初始值的赋值总是按用户指定的顺序计算. 因此, 一个变量可能绑定到对其类型无意义的值上, 然后在循环序言部分使用`setq`设置为正确的初始值. 这种交错设置的一个含义是, 在除了for-as-equals-then之外的for-as子句中的初始值形式(称为`form1`、`form1`、`form3`、`setp-fun`、`vector`、`hash-table`和`package`)中的词法环境, 在形式求值时, 是否只包含在该形式之前的循环变量或者包括更多的或所有循环变量, 是依赖于实现的; for-as-equals-then形式中`form1`和`form2`包含有所有循环变量的词法环境.

在形式被展开后, 它由标签体中三个基本部分构成: 循环序言、循环体和循环后记.

- 循环序言(prologue)  
    
- 循环序言中包含在迭代开始之前执行的形式, 例如变量从句中描述的自动变量初始化, 和出现在源码中的`initially`从句.
- 循环体  
    
- 循环体包含迭代执行中执行的形式, 包括应用特定的计算、终止测试和变量步进.
- 循环后记(epilogue)  
    
- 循环后记包含在迭代终止后执行的形式(如果有的话), 例如`finally`从句, 和累积从句或终止测试从句的隐式返回值.

源码形式中一些从句只为循环序言提供代码, 这些从句必须在`loop`形式主体中从句之前出现. 另外的一些源码形式为循环后记提供代码. 所有其它的源码形式按在`loop`源码形式中的顺序为最终翻译后的形式提供代码.

除非显式提供了`named`, 宏`loop`的展开生成名称为`nil`的隐式块. 因此, `return-from`(有时`return`也可以)被用于从`loop`中返回值或退出`loop`.

#### 6.1.1.5 循环从句汇总

循环从句分为如下6个种类:

##### 6.1.1.5.1 变量初始化和步长从句汇总

`for`和`as`构造提供了建立要被初始化的变量的迭代控制从句. `for`和`as`从句可以与循环关键字`and`一起使用, 以支持并行初始化和步进. 否则初始化和步进是顺序的.

`with`构造与单个`let`子句类似. `with`从句可以与循环关键字`and`一起使用, 以支持并行初始化.

更多信息见**6.1.2 变量初始化和步长从句**.

##### 6.1.1.5.2 值累积从句汇总

`collect`(或`collection`)构造在其从句中接受一个形式, 并将该形式的值添加到一个值列表的末尾. `loop`结束时默认返回这个值列表.

`append`(或`appending`)构造在其从句中接受一个形式, 将该形式的值追加到一个值列表的末尾. `loop`结束时默认返回这个值列表.

`nconc`(或`nconcing`)构造与`append`构造类似, 但列表的值是使用`nconc`连接的. `loop`结束时默认返回这个值列表.

`sum`(或`summming`)构造在其从句中接受一个形式, 这个形式必须求值为一个数值, 累积这些数值的和. `loop`结束时默认返回这个累积和.

`count`(或`counting`)构造在其从句中接受一个形式, 计数该形式求值为true的次数. `loop`结束时默认返回这个计数.

`minimize`(或`minimizing`)构造在其从句中接受一个形式, 确定求值该形式的最小值. `loop`结束时默认返回这个最小值.

`maximize`(或`maximizing`)构造在其从句中接受一个形式, 确定求值该形式的最大值. `loop`结束时默认返回这个最大值.

更多信息见**6.1.3 值累积从句**.

##### 6.1.1.5.3 终止测试字符汇总

`for`和`as`构造提供了由迭代控制从句确定的终止测试.

`repeat`构造导致在指定次数的迭代后终止.(使用内部变量跟踪迭代的次数)

`while`构造接受一个形式和一个测试, 在测试求值为false时终止. `while`从句等价于表达式`(if (not test) (loop-finish))`.

`until`构造是`while`的逆; 在测试求值为非`nil`值时终止. `until`从句等价于表达式`(it test (loop-finish))`.

`always`构造接受一个形式, 在该形式一旦求值为false时终止`loop`; 在这种情况下, `loop`形式返回`nil`. 否则提供了默认返回值`t`.

`never`构造接受一个形式, 在该形式一旦求值为true时终止`loop`; 这这种情况下, `loop`形式返回`nil`. 否则提供了默认返回值`t`.

`thereis`构造接受一个行his, 在该形式一旦求值为非`nil`对象时终止`loop`; 在这种情况下, `loop`形式返回该对象. 否则提供了默认返回值`nil`.

如果指定了多个终止测试从句, 在任意从句被满足时, 终止`loop`形式.

更多信息见**6.1.4 终止测试从句**.

##### 6.1.1.5.4 无条件执行从句汇总

`do`(或`doing`)构造求值其从句中的所有形式.

`return`构造接受一个形式. 这个形式返回的值立即从`loop`形式返回. 等价于从句`do (return-from block-name value)`, 这里`block-name`是由`named`从句指定的名称, 或者没有`named`从句时为`nil`.

更多信息见**6.1.5 无条件执行从句**.

##### 6.1.1.5.5 条件执行从句汇总

`if`和`when`构造接受一个作为测试的形式和一个在该测试返回true时指定的从句. 这个从句可以是值累积从句、无条件执行从句或另一个条件执行从句; 也可以是这些从句与循环关键字`and`的组合.

`unless`构造与`when`构造类似, 除非取相反的测试结果.

`else`构造为`if`、`when`和`unless`从句提供了可选的部分, 在`if`或`when`的测试返回false或者`unless`的测试返回true时, 执行这个部分. 这个部分是在`if`中描述的从句中的一个.

`end`构造提供了标记条件从句结束的可选部分.

更多信息见**6.1.6 条件执行从句**.

##### 6.1.1.5.6 杂项从句汇总

`named`构造给`loop`的块指定了一个名称.

`initially`构造导致它的形式在循环序言中被求值, 在除了`with`、`for`或`as`提供的初始值设置的所有`loop`代码之前执行.

`finally`构造导致它的形式在常规迭代终止后的循环后记中求值.

更多信息见**6.1.7 杂项从句**.

#### 6.1.1.6 执行的顺序

除了下面列出的例外情况之外, 从句在循环体中按它们在源码中出现的顺序指定. 重复执行, 直到一个从句终止循环、或遇到将控制转移到循环外一点的`return`、`go`或`throw`形式. 下面的动作是顺序指定的例外:

- 所有变量被首先初始化, 不管建立变量的从句在源码中出现的位置. 初始化的顺序遵循这些从句的顺序.
- 所有`initially`从句的代码, 按从句在源码中的顺序, 被收集到一个progn中. 在隐式变量初始化之后, 这些收集的代码在循环的序言中执行一次.
- 所有`finally`从句的代码, 按从句在源码中的顺序, 被收集到一个progn中. 在返回累积从句的任何隐式值之前, 这些收集的代码在循环后记中执行一次. 然而, 在源码中显式的返回, 不会执行循环后中代码, 而是退出循环.
- `with`从句引入了一个变量绑定和一个可选的初始值. 初始值按`with`从句出现的顺序计算.
- 迭代控制从句隐式的执行这些工作:  
    
- \– 初始化变量;  
    
- \– 步进变量, 通常在循环体的两次执行之间;  
    
- \– 执行终止测试, 通常在循环体执行之后立即执行.

#### 6.1.1.7 解构

`d-type-spec`传递参数被用于解构. 如果`d-type-spec`传递参数只由类型`fixnum`、`float`、`t`或`nil`构成, 关键字`of-type`是可选的. `of-type`构造在这些情况中是可选的, 是为保持前向兼容; 因此下面的两个表达式是等价的:

```
;;; This expression uses the old syntax for type specifiers.
 (loop for i fixnum upfrom 3 ...)

;;; This expression uses the new syntax for type specifiers.
 (loop for i of-type fixnum upfrom 3 ...)
```

```
;; Declare X and Y to be of type VECTOR and FIXNUM respectively.
 (loop for (x y) of-type (vector fixnum)
       in l do ...)
```

解构模式的类型描述符一个类型描述符树, 形状与变量名称树相同, 有如下例外:

- 对齐树时, 类型描述符树中的原子与变量名称树中的一个cons匹配, 变量名称树中以该cons为根的子树中每个变量的类型被声明为同一个类型.
- 匹配变量名称树中原子的类型描述符树中一个cons, 是复合类型描述符.

解构允许将一组变量绑定到相应的一组值, 每个值可以绑定到一个变量. 在循环展开中, 变量列表中的每个变量与值列表中的值匹配. 如果变量列表中变量数量比值列表中值的数量多, 剩余的变量被赋予值`nil`. 如果值的数量比变量的数量多, 多余的值被忽略.

为从一个列表给变量`a`、`b`和`c`赋值, 可以使用`for`从句绑定变量`numlist`到提供的(列表)形式的car, 然后使用另一个`for`从句顺序的绑定变量`a`、`b`和`c`.

```
;; Collect values by using FOR constructs.
 (loop for numlist in '((1 2 4.0) (5 6 8.3) (8 9 10.4))
       for a of-type integer = (first numlist)
       and b of-type integer = (second numlist)
       and c of-type float = (third numlist)
       collect (list c b a))
=>  ((4.0 2 1) (8.3 6 5) (10.4 9 8))
```

允许变量在每个循环迭代中绑定的解构更容易处理这种情况. 使用一个`type-spec`传递参数列表声明类型. 如果所有类型相同, 可以使用便捷解构语法, 如下所示:

```
;; Destructuring simplifies the process.
 (loop for (a b c) of-type (integer integer float) in
       '((1 2 4.0) (5 6 8.3) (8 9 10.4))
       collect (list c b a))
=>  ((4.0 2 1) (8.3 6 5) (10.4 9 8))
```

```
;; If all the types are the same, this way is even simpler.
 (loop for (a b c) of-type float in
       '((1.0 2.0 4.0) (5.0 6.0 8.3) (8.0 9.0 10.4))
       collect (list c b a))
=>  ((4.0 2.0 1.0) (8.3 6.0 5.0) (10.4 9.0 8.0))
```

如果使用解构声明或初始化多组变量, 可以使用循环关键字`and`进一步简化:

```
;; Initialize and declare variables in parallel by using the AND construct.
 (loop with (a b) of-type float = '(1.0 2.0)
       and (c d) of-type integer = '(3 4)
       and (e f)
       return (list a b c d e f))
=>  (1.0 2.0 3 4 NIL NIL)
```

如果在解构列表中使用了`nil`, 它的位置上没有变量.

```
(loop for (a nil b) = '(1 2 3)
      do (return (list a b)))
=>  (1 3)
```

注意点列表可以用于解构:

```
(loop for (x . y) = '(1 . 2)
      do (return y))
=>  2
(loop for ((a . b) (c . d)) of-type ((float . float) (integer . integer)) in
      '(((1.2 . 2.4) (3 . 4)) ((3.4 . 4.6) (5 . 6)))
      collect (list a b c d))
=>  ((1.2 2.4 3 4) (3.4 4.6 5 6))
```

如果在单个循环表达式的任意变量绑定从句中同一个变量被两次绑定, 则(在宏展开时)发出类型为`program-error`的错误信号. 这些变量包括本地变量、迭代控制变量和解构使用的变量.

#### 6.1.1.8 副作用的限制

见**3.6 遍历规则和副作用**.

### 6.1.2 变量初始化和步长从句

#### 6.1.2.1 迭代控制

迭代控制从句允许指定循环迭代的方向. 循环关键字`for`和`as`指示出迭代控制从句. 迭代控制子句之间在终止测试的描述和循环变量的初始化和步进方面存在差异. 迭代子句自身不会导致循环功能返回值, 但可以与值累积从句一起使用返回值.

所有变量在循环序言中被初始化. 一个变量绑定有词法作用域, 除非它被声明`special`; 因此默认情况下, 这些变量只可被文本上在循环内部的形式访问. 步进赋值在循环体中在体中其它形式求值之前执行.

迭代控制从句的变量传递参数可以是一个解构列表. 解构列表是其非`nil`原子为变量名称的树. 见**6.1.1.7 解构**.

迭代控制从句`for`、`as`和`repeat`必须在其它循环从句之前出现, 除了建立变量绑定的`initially`、`with`和`named`从句. 当循环中使用了迭代控制从句时, 循环体中相应的终止测试在体中其它代码执行之前求值.

如果使用多个迭代从句控制迭代, 变量初始化和步进默认按顺序执行. 当不需要顺序的绑定和步进时, `and`构造可用于连接两个或多个迭代子句. 用`and`连接从句的迭代行为的区别与宏`do`和`do*`之间的区别类似.

`for`和`as`从句通过使用一个或多个本地循环变量进行迭代, 这些变量被初始化为某些值, 在每次迭代之后被修改或步进. 对于这些从句, 在本地变量达到给定的值或其他循环从句终止迭代时, 迭代终止. 在每个迭代中, 可以使用递增、递减或通过求值形式赋予新值的方式步进变量. 在迭代时, 可以使用解构赋值变量.

关键字`for`和`as`是同义的; 可被互换使用. 这些构造有7个语法格式. 在每个语法格式中, `var`类型可以用可选的`type-spec`传递参数指定. 如果`var`是一个解构列表, 由`type-spec`传递参数指定的类型必须匹配列表元素. **通常, `for`引入新的迭代, `as`引入依赖于之前的迭代描述的迭代**.

##### 6.1.2.1.1 for-as-arithmetic子句

在for-as-arithmetic子句中, `for`和`as`构造从`form1`提供的值到`form2`提供的值, 按`form3`提供的值步进迭代. 每个表达式只被求值一次, 必须求值为一个数值. 变量`var`在第一个迭代中绑定到`form1`的值, 在每个后续迭代中按`form3`的值步进, 或者在没有提供`form3`时按1步进. 下面的循环关键字在这个语法中被视为有效的介词. 至少使用一个介词, 在单个子句中最多使用一行中的一个.

```
from | downfrom | upfrom
to | downto | upto | below | above
by
```

每个子句的介词短语可以按任意顺序出现. 例如, `from x by y`和`by y from x`都是允许的. 然而, 因为需要保留从左向右的求值顺序, 有副作用时效果可能不同. 考虑:

```
(let ((x 1)) (loop for i from x by (incf x) to 10 collect i))
=>  (1 3 5 7 9)
; 先求值(incf x)
(let ((x 1)) (loop for i by (incf x) from x to 10 collect i))
=>  (2 4 6 8 10)
```

这些介词的描述如下:

- from  
    
- 循环关键字`from`指定了步进值的开始值, 由`form1`提供. 步进默认为递增. 如果需要递减步进, 必须将`downto`或`above`与`form2`一起使用. 对递增步进, `from`的默认值为0.
- downfrom, upfrom  
    
- 循环关键字`downfrom`表明变量`var`按`form3`提供的步长减少; 循环关键字`upfrom`表示变量`var`按`form3`提供的步长增加.
- to  
    
- 循环关键字`to`标记由`form2`提供的步进结束值. 步进默认为递增. 如果需要递减步进, 必须将`downfrom`与`form1`一起使用, 或者用`downto`或`above`替代`to`与`form2`一起使用.
- downto, upto  
    
- 循环关键字`downto`指定了递减步进; 循环关键字`upto`指定了增量步进. 在这两种情况中, 每步修改的值由`form3`指定, 当变量`var`越过`form2`的值时终止循环. 因为在递减步进中没有`form1`的默认值, 使用`downto`时必须提供`form1`的值(使用`from`或`downfrom`).
- below, above  
    
- 循环关键字`below`和`above`分别与`upto`和`downto`等价. 这些关键字在变量`var`的值达到`form2`的值时, 结束迭代; 不包含`form2`的结束值. 因为在递减步进中没有`form1`的默认值, 使用`above`时必须提供`form1`值(使用`from`或`downfrom`).
- by  
    
- 循环关键字标记由`form3`提供的增量或减量. `form3`的值可以是任意正数. 默认值为1.

在一个迭代控制从句中, `for`或`as`构造在达到指定的界限时终止迭代. 即在变量`var`的值步进到由`form2`提供的界限值(包含或不包含)之前, 迭代继续执行. 如果使用使用`form3`增加或减少变量`var`的值到`form2`的值, 但没有达到该值, 这个范围是不包含的; 循环关键字`below`和`above`提供了不包含的界限. 包含的界限允许变量`var`达到`form2`的值; 循环关键字`to`、`downto`和`upto`提供了包含的界限.

###### 6.1.2.1.1.1 示例: for-as-arithmetic子句

```
;; Print some numbers.
 (loop for i from 1 to 3
       do (print i))
>>  1
>>  2
>>  3
=>  NIL

;; Print every third number.
 (loop for i from 10 downto 1 by 3
       do (print i))
>>  10
>>  7
>>  4
>>  1
=>  NIL

;; Step incrementally from the default starting value.
 (loop for i below 3
       do (print i))
>>  0
>>  1
>>  2
=>  NIL
```

##### 6.1.2.1.2 for-as-in-list子句

在for-as-in-list子句中, `for`或`as`构造迭代一个列表中的内容. 会检查是否到达列表尾, 就像使用`endp`那样. 变量`var`在每次迭代之前绑定到列表中的后继元素. 在每次迭代结束时, 在这个列表上使用函数`step-fun`; `step-fun`的默认值是`cdr`. 循环关键字`in`和`by`在这个语法中被视为有效的介词. `for`或`as`构造导致当达到列表尾部时终止循环.

###### 6.1.2.1.2.1 示例: for-as-in-list子句

```
;; Print every item in a list.
 (loop for item in '(1 2 3) do (print item))
>>  1
>>  2
>>  3
=>  NIL

;; Print every other item in a list.
 (loop for item in '(1 2 3 4 5) by #'cddr
       do (print item))
>>  1
>>  3
>>  5
=>  NIL

;; Destructure a list, and sum the x values using fixnum arithmetic.
 (loop for (item . x) of-type (t . fixnum) in '((A . 1) (B . 2) (C . 3))
       unless (eq item 'B) sum x)
=>  4
```

##### 6.1.2.1.3 for-as-on-list子句

在for-as-on-list子句中, `for`或`as`构造在一个列表上迭代. 检查是否到达列表尾, 就像使用`atom`那样. 变量`var`绑定到`form1`提供的列表的后继尾. 在每次迭代结束时, 在这个列表上应用函数`step-fun`; `step-fun`的默认值是`cdr`. 循环关键字`on`和`by`在这个语法中被视为有效介词. `for`或`as`构造导致在达到列表尾时结束循环.

###### 6.1.2.1.3.1 示例: for-as-on-list子句

```
;; Collect successive tails of a list.
 (loop for sublist on '(a b c d)
       collect sublist)
=>  ((A B C D) (B C D) (C D) (D))

;; Print a list by using destructuring with the loop keyword ON.
 (loop for (item) on '(1 2 3)
       do (print item))
>>  1
>>  2
>>  3
=>  NIL
```

##### 6.1.2.1.4 for-as-equals-then子句

在for-as-equals-then子句中, `for`或`as`构造在第一个迭代中初始化变量`var`, 将它设置为求值`form1`的结果值, 然后在第二个和后续的迭代中, 将其设置为求值`form2`的结果值. 如果省略了`form2`, 这个构造在第二个和后续的迭代中使用`form1`. 循环关键字`=`和`then`在这个语法中是有效的介词. 这个构造没有提供任何终止测试.

###### 6.1.2.1.4.1 示例: for-as-equals-then子句

```
;; Collect some numbers.
 (loop for item = 1 then (+ item 10)
       for iteration from 1 to 5
       collect item)
=>  (1 11 21 31 41)
```

##### 6.1.2.1.5 for-as-across子句

在for-as-across子句中, `for`或`as`构造(分别)绑定变量`var`到数组`vector`中的每个元素. 循环关键字`across`标记数组`vector`; 在这个语法中`across`被用作介词. 在提供的数组中没有更多元素可被引用时, 迭代停止. 一些实现可以识别`vector`形式中的`the`特殊形式, 以生成更高效的代码.

###### 6.1.2.1.5.1 示例: for-as-across子句

```
(loop for char across (the simple-string (find-message channel))
      do (write-char char stream))
```

##### 6.1.2.1.6 for-as-hash子句

在for-as-hash子句中, `for`或`as`构造在一个哈希表的元素、键和值上迭代. 在这个语法中, 使用复合介词设计对哈希表的访问. 变量`var`取提供的哈希表中的每个哈希键或者哈希值. 下面的循环关键字是这个语法中有效的介词:

- being  
    
- 循环关键字引入循环方案`hash-key`或`hash-value`
- each, the  
    
- 当使用`hash-key`或`hash-value`时, 循环关键字`each`在`being`之后出现. 循环关键字`the`与`hash-keys`和`hash-values`一起使用, 只是为了便于读取. 这个约定不是必要的.
- hash-key, hash-keys  
    
- 这些循环关键字访问哈希表中的每个键. 如果在`using`构造中使用了`hash-value`, 迭代可以可选的访问键的值. 值被访问的顺序是未定义的; 哈希表中的空槽被忽略.
- hash-value, hash-values  
    
- 这些循环关键字访问哈希表中的每个值. 如果在`using`构造中使用了`hash-key`, 迭代可以可选的访问与值对应的键. 键被访问的顺序是未定义的; 哈希表中的空槽被忽略.
- using  
    
- 循环关键字`using`引入可选的被访问的键或键的值. 如果迭代是在哈希值上的允许访问哈希键, 如果迭代是在哈希键上的允许访问哈希值.
- in, of  
    
- 这些循环介词引入哈希表.

实际上

```
being { each | the } { hash-value | hash-values | hash-key | hash-keys } { in | of }
```

是一个复合介词.

当提供的哈希表中没有更多哈希键或哈希值时, 迭代停止.

##### 6.1.2.1.7 for-as-package子句

在for-as-package子句中, `for`或`as`构造在包中符号上迭代. 在这个语法中, 使用复合介词设计对包的访问. 变量`var`取提供的包中每个符号的值. 下面的循环关键字在这个语法中是有效的介词:

- being  
    
- 循环关键字`being`引入循环方案`symbol`、`present-symbol`或`external-symbol`.
- each, the  
    
- 当使用`symbol`、`present-symbol`或`external-symbol`时, 循环关键字`each`在`being`之后出现. 循环关键字`the`与`symbol`、`present-symbol`和`external-symbol`一起使用, 只是为了便于读取. 这个约定不是必要的.
- present-symbol, present-symbols  
    
- 这些循环方案在包中出现的符号上迭代. 按`find-package`中包传递参数一样的方法给迭代提供包. 如果没有给迭代提供包, 则使用当前包. 如果提供的包不存在, 则发出类型为`package-error`的错误信号.
- symbol, symbols  
    
- 这些循环方案在包中可访问的符号上迭代. 按`find-package`中包传递参数一样的方法给迭代提供包. 如果没有给迭代提供包, 则使用当前包. 如果提供的包不存在, 则发出类型为`package-error`的错误信号.
- external-symbol, external-symbols  
    
- 这些循环方案在包中外部符号上迭代. 按`find-package`中包传递参数一样的方法给迭代提供包. 如果没有给迭代提供包, 则使用当前包. 如果提供的包不存在, 则发出类型为`package-error`的错误信号.
- in, of  
    
- 这些循环介词引入包.

实际上

```
being { each | the } { symbol | symbols | present-symbol | present-symbols | external-symbol | external-symbols } { in | of }
```

是一个复合介词.

当在提供的包中没有更多可被引用的符号时, 迭代停止.

###### 6.1.2.1.7.1 示例: for-as-package子句

```
(let ((*package* (make-package "TEST-PACKAGE-1")))
  ;; For effect, intern some symbols
  (read-from-string "(THIS IS A TEST)")
  (export (intern "THIS"))
  (loop for x being each present-symbol of *package*
         do (print x)))
>>  A
>>  TEST
>>  THIS
>>  IS
=>  NIL
```

#### 6.1.2.2 本地变量初始化

执行`loop`形式时, 本地变量被绑定并初始化. 这些本地变量一直存在直到迭代终止, 这时它们不再存在. 迭代控制从句和累积从句的`into`介词也会建立隐式变量.

`with`构造初始化循环中本地变量. 这些变量只被初始化一次. 如果为变量`var`提供了可选的`type-spec`传递参数, 但没有相关的需被求值的表达式, `var`被初始化为其类型的恰当的默认值. 例如, 对类型`t`、`number`和`float`, 默认是分别是`nil`、`0`和`0.0`. 如果指定了`type-spec`传递参数, 但提供的表达式求值结果值不是该类型, 其后果是未定义的. `with`构造默认顺序的初始化变量; 即赋值一个变量在求值下一个表达式之前发生. 然而, 使用循环关键字`and`连接多个`with`从句时, 初始化可以并行执行; 即求值所有提供的形式, 求值结果同时赋予相应的变量.

当一些变量的初始化需要依赖与之前绑定的变量时, 使用顺序绑定. 例如, 变量`a`、`b`和`c`按顺序绑定:

```
(loop with a = 1
      with b = (+ a 2)
      with c = (+ b 3)
      return (list a b c))
=>  (1 3 6)
```

上面的循环的执行效果等价与执行下面的代码:

```
(block nil
  (let* ((a 1)
         (b (+ a 2))
         (c (+ b 3)))
    (tagbody
        (next-loop (return (list a b c))
                   (go next-loop)
                   end-loop))))
```

如果之前绑定的变量值不需要用于其它本地变量, 可以使用`and`从句指定并行绑定:

```
(loop with a = 1
      and b = 2
      and c = 3
      return (list a b c))
=>  (1 2 3)
```

上面的循环的执行效果等价与执行下面的代码:

```
(block nil
  (let ((a 1)
        (b 2)
        (c 3))
    (tagbody
        (next-loop (return (list a b c))
                   (go next-loop)
                   end-loop))))
```

##### 6.1.2.2.1 示例: WITH从句

```
;; 顺序的绑定
 (loop with a = 1
       with b = (+ a 2)
       with c = (+ b 3)
       return (list a b c))
=>  (1 3 6)

;; 并行的绑定
 (setq a 5 b 10)
=>  10
 (loop with a = 1
       and b = (+ a 2)
       and c = (+ b 3)
       return (list a b c))
=>  (1 7 13)

;; 声明多个类型本地变量的便捷方式
 (loop with (a b c) of-type (float integer float)
       return (format nil "~A ~A ~A" a b c))
=>  "0.0 0 0.0"

;; 声明多个同类型本地变量的便捷方式
 (loop with (a b c) of-type float
       return (format nil "~A ~A ~A" a b c))
=>  "0.0 0.0 0.0"
```

### 6.1.3 值累积从句

构造`collect`、`collecting`、`append`、`appending`、`nconc`、`nconcing`、`count`、`counting`、`maximize`、`maximizing`、`minimize`、`minimizing`、`sum`、`summing`, 允许在循环中累积值.

构造`collect`、`collecting`、`append`、`appending`、`nconc`、`nconcing`, 指定在列表中累积值并返回该列表的从句. 构造`count`、`counting`、`maximize`、`maximizing`、`minimize`、`minimizing`、`sum`、`summing`, 指定累积并返回数值值的从句.

在每个迭代中, 构造`collect`和`collecting`收集提供的形式的值到列表中. 迭代终止时返回该列表. 传递参数`var`被设置为收集的值的列表; 如果提供了`var`, 循环不会自动返回最终的列表. 如果没有提供`var`, 等价于为`var`指定了一个内部名称并在`finally`从句中返回它的值. 就像使用`with`构造一样绑定传递参数`var`. 没有声明`var`的类型的机制, `var`的类型必须是类型`list`.

构造`append`、`appending`、`nconc`、`nconcing`与`collect`类似, 除了提供的形式的值必须是列表.

- 关键字`append`导致它的列表值串接到单个列表中, 就像使用函数`apppend`.
- 关键字`nconc`导致它的列表值串接到单个列表中, 就像使用函数`nconc`.

传递参数`var`被设置为串接值后的列表; 如果提供了`var`, 循环不会自动返回最终的列表. 就像使用`with`构造一样绑定传递参数`var`. 不能指定`var`的类型, `var`的类型必须是类型`list`. 构造`nconc`破坏性的修改它的传递参数.

构造`count`计数提供的形式返回true的次数. 传递参数累积出现的次数; 如果提供了`var`, 循环不会自动返回最终的计数值. 就像使用`with`构造绑定到恰当类型的零值一样, 绑定传递参数`var`. 后续的值(包括必要的转换)用函数`1+`计算. 如果使用了`into var`, 可以用传递参数`type-spec`指定`var`的类型; 提供了一个非数值类型的后果是未定义的. 如果没有`into`变量, 可选的传递参数`type-spec`应用在内部计数的变量上. 默认类型是依赖于实现的, 但必须是类型`fixnum`的超类型.

构造`maximize`和`minimize`比较提供的形式在第一次迭代和后续迭代中的值. 遇到的最大值(使用函数`max`)或最小值(使用函数`min`)被确定并返回. 如果`maximize`和`minimize`从句未被执行过, 累积值是未描述的. 传递参数`var`累积最大或最小值; 如果提供了`var`, 循环不会自动返回最大值或最小值. 就像使用`with`构造一样绑定传递参数`var`. 如果使用了`into var`, 可以用传递参数`type-spec`指定`var`的类型; 提供了一个非数值类型的后果是未定义的. 如果没有`into`变量, 可选的传递参数`type-spec`应用在内部记录最大值或最小值的变量上. 默认类型是依赖于实现的, 但必须是类型`real`的超类型.

构造`sum`生成提供的形式在每次迭代中求值的主值的累加和. 传递参数`var`用于累加和; 如果提供了`var`, 循环不会自动返回最终的和. 就像使用`with`构造绑定到恰当类型的零值一样, 绑定传递参数`var`. 后续的值(包括必要的转换)用函数`1`计算. 如果使用了`into var`, 可以用传递参数`type-spec`指定`var`的类型; 提供了一个非数值类型的后果是未定义的. 如果没有`into`变量, 可选的传递参数`type-spec`应用在内部记录和的变量上. 默认类型是依赖于实现的, 但必须是类型`number`的超类型.

如果使用了`into`, 构造不会提供一个默认返回值; 然而这个变量在任何`finally`从句中可用.

如果特定种类的累积从句的目标(循环的结果或者`into var`)是一致的, 这些从句可以在循环中组合, 引入它们可视为累积概念上兼容的量. 通常下面的组中元素可以在循环形式的同样的目标中与同组中其它元素混用:

- `collect`、`append`、`nconc`
- `sum`、`count`
- `maximize`、`minimize`

```
;; Collect every name and the kids in one list by using COLLECT and APPEND.
 (loop for name in '(fred sue alice joe june)
       for kids in '((bob ken) () () (kris sunshine) ())
       collect name
       append kids)
=>  (FRED BOB KEN SUE ALICE JOE KRIS SUNSHINE JUNE)
```

任何两个累积结果对象类型不同的从句可以在一个循环中同时出现, 仅当每个从句累积到不同的变量.

#### 6.1.3.1 示例: COLLECT从句

```
;; 收集列表中所有符号
 (loop for i in '(bird 3 4 turtle (1 . 4) horse cat)
       when (symbolp i) collect i)
=>  (BIRD TURTLE HORSE CAT)

;; 收集所有奇数
 (loop for i from 1 to 10
       if (oddp i) collect i)
=>  (1 3 5 7 9)

;; 收集项到本地变量, 但不返回
 (loop for i in '(a b c d) by #'cddr
       collect i into my-list
       finally (print my-list))
>>  (A C)
=>  NIL
```

#### 6.1.3.2 示例: APPEND和NCONC从句

```
;; APPEND串接子列表
  (loop for x in '((a) (b) ((c)))
        append x)
=>  (A B (C))

;; NCONC字列表. 只有用LIST构造的列表被修改.
  (loop for i upfrom 0
        as x in '(a b (c))
        nconc (if (evenp i) (list x) nil))
=>  (A (C))
```

#### 6.1.3.3 示例: COUNT从句

```
(loop for i in '(a b nil c nil d e)
      count i)
=>  5
```

#### 6.1.3.4 示例: MAXIMIZE和MINIMIZE从句

```
(loop for i in '(2 1 5 3 4)
      maximize i)
=>  5
(loop for i in '(2 1 5 3 4)
      minimize i)
=>  1

;; FIXNUM应用在持有最大值的内部变量上
(setq series '(1.2 4.3 5.7))
=>  (1.2 4.3 5.7)
(loop for v in series
      maximize (round v) of-type fixnum)
=>  6

;; FIXNUM应用在变量RESULT上.
(loop for v of-type float in series
      minimize (round v) into result of-type fixnum
      finally (return result))
=>  1
```

#### 6.1.3.5 示例: SUM从句

```
(loop for i of-type fixnum in '(1 2 3 4 5)
      sum i)
=>  15

(setq series '(1.2 4.3 5.7))
=>  (1.2 4.3 5.7)
(loop for v in series
      sum (* 2.0 v))
=>  22.4
```

### 6.1.4 终止测试从句

构造`repeat`导致迭代在指定次数后终止. 循环体执行n次, n是表达式`form`的值. 传递参数`form`在循环序言中求值一次. 如果这个逼到大师求值结果为0或一个负数, 循环体不被求值.

构造`always`、`never`、`thereis`、`while`、`until`和宏`loop-finish`允许在循环中迭代的条件终止.

构造`always`、`never`和`thereis`提供了循环终止时返回的特定值. 在循环中与不是`into`从句的值累积从句一起使用`always`、`never`或`thereis`, 发出类型为`program-error`的错误信号(在宏展开时). 因为`always`、`never`和`thereis`使用特殊操作符`return-from`终止迭代, 当这些迭代导致退出时, 提供的`finally`从句不被求值. 在其它方面, 这些构造与构造`while`和`until`相同.

构造`always`接受一个形式, 在形式一旦求值为`nil`是终止循环; 在这种情况下, 循环形式返回`nil`. 否则返回`t`. 如果提供的形式的值从不是`nil`, 其它构造可以终止迭代.

构造`never`在提供的形式首次求值为非`nil`时终止迭代; 循环形式返回`nil`. 如果提供的形式的值总是`nil`, 其它构造可以终止迭代. 除非其它从句贡献了返回值, 默认返回`t`.

构造`thereis`在提供的形式首次求值为非`nil`时终止迭代; 循环形式返回提供的形式的值. 如果提供的形式的值总是`nil`, 其它构造可以终止迭代. 除非其它从句贡献了返回值, 默认返回`nil`.

构造`thereis`与`until`之间有两个差异:

- 构造`unti`不会基于提供的形式的值返回一个值或`nil`.
- 构造`until`执行任意`finally`从句. 因为`thereis`使用特殊操作符`return-from`终止节点, 由于`thereis`导致退出时, 提供的任意`finally`从句不被求值.

构造`while`允许迭代一直执行直到提供的`form`求值为false. 提供的形式在`while`从句的位置被重复求值.

构造`until`等价于`while (not form)...`. 如果提供的形式的值是非`nil`, 迭代终止.

终止测试控制解构可以在循环体中任何位置出现. 按它们出现的顺序依次使用. 如果`until`或`while`导致终止, 源码中在它之前出现的任意从句仍被求值. 如果`until`和`while`导致终止, 控制被转移到循环后记, 任意`finally`从句被执行.

构造`never`与`until`质检有两个差异:

- 构造`unti`不会基于提供的形式的值返回`t`或`nil`.
- 构造`until`不会跳过任何`finally`从句. 因为`never`使用特殊操作符`return-from`终止迭代, 由于`never`导致退出时, 提供的任意`finally`从句不被求值.

因为其它循环控制从句可以结束循环, 大多数情况下不需要使用`loop-finish`. 宏`loop-finish`用于从循环中的内嵌条件中常规退出. 因为`loop-finish`将控制转移到循环后记, 在`finally`表达式中使用`loop-finish`会导致无限循环.

#### 6.1.4.1 示例: REPEAT从句

```
(loop repeat 3
      do (format t "~&What I say three times is true.~%"))
>>  What I say three times is true.
>>  What I say three times is true.
>>  What I say three times is true.
=>  NIL

(loop repeat -15
  do (format t "What you see is what you expect~%"))
=>  NIL
```

#### 6.1.4.2 示例: ALWAYS、NEVER和THEREIS从句

```
;; 确保I总是小于11(两种方式).
;; FOR构造终止循环.
 (loop for i from 0 to 10
       always (< i 11))
=>  T
 (loop for i from 0 to 10
       never (> i 11))
=>  T

;; If I exceeds 10 return I; otherwise, return NIL.
;; THEREIS构造终止循环
 (loop for i from 0
       thereis (when (> i 10) i) )
=>  11

;;; 在这些示例中, FINALLY从句不被求值.
 (loop for i from 0 to 10
       always (< i 9)
       finally (print "you won't see this"))
=>  NIL
 (loop never t
       finally (print "you won't see this"))
=>  NIL
 (loop thereis "Here is my value"
       finally (print "you won't see this"))
=>  "Here is my value"

;; FOR构造终止循环, 因此FINALLY从句被求值.
 (loop for i from 1 to 10
       thereis (> i 11)
       finally (prin1 'got-here))
>>  GOT-HERE
=>  NIL

;; If this code could be used to find a counterexample to Fermat's
;; last theorem, it would still not return the value of the
;; counterexample because all of the THEREIS clauses in this example
;; only return T.  But if Fermat is right, that won't matter
;; because this won't terminate.

 (loop for z upfrom 2
       thereis
         (loop for n upfrom 3 below (log z 2)
               thereis
                 (loop for x below z
                       thereis
                         (loop for y below z
                               thereis (= (+ (expt x n) (expt y n))
                                          (expt z n)))))) (loop while (hungry-p) do (eat))

;; UNTIL NOT is equivalent to WHILE.
 (loop until (not (hungry-p)) do (eat))

;; Collect the length and the items of STACK.
 (let ((stack '(a b c d e f)))
   (loop for item = (length stack) then (pop stack)
         collect item
         while stack))
=>  (6 A B C D E F)

;; Use WHILE to terminate a loop that otherwise wouldn't terminate.
;; Note that WHILE occurs after the WHEN.
 (loop for i fixnum from 3
       when (oddp i) collect i
       while (< i 5))
=>  (3 5)
```

#### 6.1.4.3 示例: WHILE和UNTIL从句

```
(loop while (hungry-p) do (eat))

;; UNTIL NOT is equivalent to WHILE.
(loop until (not (hungry-p)) do (eat))

;; Collect the length and the items of STACK.
(let ((stack '(a b c d e f)))
  (loop for item = (length stack) then (pop stack)
        collect item
        while stack))
=>  (6 A B C D E F)

;; Use WHILE to terminate a loop that otherwise wouldn't terminate.
;; Note that WHILE occurs after the WHEN.
(loop for i fixnum from 3
      when (oddp i) collect i
      while (< i 5))
=>  (3 5)
```

### 6.1.5 无条件执行从句

构造`do`和`doing`对循环的展开形式中提供的形式执行求值. 传递参数`form`可以是任何复合形式. 在每个迭代中求值每个形式. 因为每个循环从句必须以循环关键字开始, 当不需要除了执行之外的控制动作时, 使用关键字`do`.

构造`return`接受一个形式. 该形式返回的值立即被循环形式返回. 它等价于从句`do (return-from block-name value)`, 这里的`block-name`是在`named`从句中指定的名称或者`nil`(没有指定`named`从句时).

#### 6.1.5.1 示例: 无条件执行

```
;; 打印数和数平方
;; DO构造用于多个形式
 (loop for i from 1 to 3
       do (print i)
          (print (* i i)))
>>  1
>>  1
>>  2
>>  4
>>  3
>>  9
=>  NIL
```

### 6.1.6 条件执行从句

构造`if`、`when`和`unless`建立循环中的条件控制. 如果测试通过, 执行后续的循环从句. 如果测试不通过, 跳过后续的循环从句, 程序控制转移到循环关键字`else`之后的从句. 如果测试不通过且没有提供`else`从句, 控制转移到整个条件从句之后的从句或构造.

如果条件从句是嵌套的, 每个`else`与其前面最近的没有关联`else`或`end`的条件从句适配.

在`if`和`when`从句中, 它们是等价的, 如果提供的形式的值为true, 测试通过.

在`unless`从句中, 如果提供的形式的值为false, 测试通过.

可以使用循环关键字, 将在测试表达式之后的从句组在一起, 生成由复合从句构成的条件块.

使用循环关键字`it`引用从句中测试表达式的结果. 在条件执行从句中的`return`从句或累积从句的形式的位置处使用`it`. 如果用`and`连接了多个从句, 构造`it`必须在块中第一个从句中.

可选的循环关键字`end`标记从句的结束. 如果没有提供这个关键字, 下一个循环关键字标记结束. 构造`end`可用于区分复合从句的作用域.

#### 6.1.6.1 示例: WHEN从句

```
;; Signal an exceptional condition.
 (loop for item in '(1 2 3 a 4 5)
       when (not (numberp item))
        return (cerror "enter new value" "non-numeric value: ~s" item))
Error: non-numeric value: A

;; The previous example is equivalent to the following one.
 (loop for item in '(1 2 3 a 4 5)
       when (not (numberp item))
        do (return
            (cerror "Enter new value" "non-numeric value: ~s" item)))
Error: non-numeric value: A
;; This example parses a simple printed string representation from
;; BUFFER (which is itself a string) and returns the index of the
;; closing double-quote character.
 (let ((buffer "\"a\" \"b\""))
   (loop initially (unless (char= (char buffer 0) #\")
                     (loop-finish))
         for i of-type fixnum from 1 below (length (the string buffer))
         when (char= (char buffer i) #\")
          return i))
=>  2

;; The collected value is returned.
 (loop for i from 1 to 10
       when (> i 5)
         collect i
       finally (prin1 'got-here))
>>  GOT-HERE
=>  (6 7 8 9 10)

;; Return both the count of collected numbers and the numbers.
 (loop for i from 1 to 10
       when (> i 5)
         collect i into number-list
         and count i into number-count
       finally (return (values number-count number-list)))
=>  5, (6 7 8 9 10)
```

### 6.1.7 杂项从句

#### 6.1.7.1 控制转移从句

构造`named`建立包含整个循环的一个隐式块的名称, 从而可以使用特殊操作符`return-from`从循环返回值或退出. 每个循环形式只可以有一个名称. 如果被使用, 构造`named`必须是循环表达式的第一个从句.

构造`return`接受一个形式. 这个形式返回的值立即被循环形式返回. 这个构造类似于特殊操作符`return-from`和宏`return`. 构造`return`不执行循环形式中给定的`finally`从句.

##### 6.1.7.1.1 示例: NAMED从句

```
;; 只是命名并返回.
 (loop named max
       for i from 1 to 10
       do (print i)
       do (return-from max 'done))
>>  1
=>  DONE
```

#### 6.1.7.2 初值和最后的执行

构造`initially`和`finally`求值出现在循环体之前和之后的形式.

构造`initially`导致提供的`compound-forms`在循环序言中求值, 它在除了构造`with`、`for`或`as`提供的初始化设置外的循环代码之前出现. 任何`initially`从句的代码按它们在循环中出现的顺序执行.

构造`finally`导致提供的`compound-forms`在常规迭代终止之后在循环后记中求值. 任何`finally`从句的代码按它们在循环中出现的顺序执行. 收集的代码在循环后记中被执行一次, 在任何隐式值从累积从句返回之前执行. 然而, 循环体中显式的控制转移(例如`return`、`go`或`throw`), 会不执行循环后记代码而退出循环.

诸如`return`、`always`、`never`和`thereis`从句可以跳过`finally`从句. 在`finally`从句之后可以使用`return`(或提供`named`时使用`return-from`)从循环中返回值. 这种在`finally`从句中的显式返回比从诸如`collect`、`nconc`、`append`、`sum`、`count`、`maximize`和`minimize`累积从句返回, 有更高的优先级; 如果使用了`return`或`return-from`, 前述累积从句的累积值不会从循环中返回.

### 6.1.8 示例: 杂项循环特性

```
(let ((i 0))                     ; 没有使用循环关键字
   (loop (incf i) (if (= i 3) (return i)))) =>  3

(let ((i 0)(j 0))
   (tagbody
     (loop (incf j 3) (incf i) (if (= i 3) (go exit)))
     exit)
   j) =>  9
```

在下面的示例中, 变量`x`在`y`之前步进, 因此`y`的值反映了`x`更新后的的值.

```
(loop for x from 1 to 10
      for y = nil then x
      collect (list x y))
=>  ((1 NIL) (2 2) (3 3) (4 4) (5 5) (6 6) (7 7) (8 8) (9 9) (10 10))
```

在这个示例中, `x`与`y`并行步进:

```
(loop for x from 1 to 10
      and y = nil then x
      collect (list x y))
=>  ((1 NIL) (2 1) (3 2) (4 3) (5 4) (6 5) (7 6) (8 7) (9 8) (10 9))
```

#### 6.1.8.1 示例: 从句分组

```
;; 分组条件从句
 (loop for i in '(1 324 2345 323 2 4 235 252)
       when (oddp i)
         do (print i)
         and collect i into odd-numbers
         and do (terpri)
       else                              ; I is even.
         collect i into even-numbers
       finally
         (return (values odd-numbers even-numbers)))
>>  1
>>
>>  2345
>>
>>  323
>>
>>  235
=>  (1 2345 323 235), (324 2 4 252)
```

```
;; 收集大于3的数
 (loop for i in '(1 2 3 4 5 6)
       when (and (> i 3) i)
       collect it)                      ; IT引用(and (> i 3) i).
=>  (4 5 6)
```

```
;; 在列表中查找数
 (loop for i in '(1 2 3 4 5 6)
       when (and (> i 3) i)
       return it)
=>  4

;; 上面的示例与下面的类似.
 (loop for i in '(1 2 3 4 5 6)
       thereis (and (> i 3) i))
=>  4
```

```
;; 嵌套的条件从句.
 (let ((list '(0 3.0 apple 4 5 9.8 orange banana)))
   (loop for i in list
         when (numberp i)
           when (floatp i)
             collect i into float-numbers
           else                                  ; Not (floatp i)
             collect i into other-numbers
         else                                    ; Not (numberp i)
           when (symbolp i)
             collect i into symbol-list
           else                                  ; Not (symbolp i)
             do (error "found a funny value in list ~S, value ~S~%" list i)
         finally (return (values float-numbers other-numbers symbol-list))))
=>  (3.0 9.8), (0 4 5), (APPLE ORANGE BANANA)
```

```
;; 如果没有end介词, 最后一个and将用在内层的if中而不是外层的if.
;; Without the END preposition, the last AND would apply to the
;; inner IF rather than the outer one.
 (loop for x from 0 to 3
       do (print x)
       if (zerop (mod x 2))
         do (princ " a")
          and if (zerop (floor x 2))
                do (princ " b")
                end
          and do (princ " c"))
>>  0  a b c
>>  1
>>  2  a c
>>  3
=>  NIL
```

### 6.1.9 备注: 循环

可以指定循环变量的类型. 不需要给每个变量提供类型, 但提供了类型可以保证变量有正确类型的初始值, 同时有助于编译器优化(依赖于实现).

在一些实现中, 从句`repeat n ...`基本上等价于下面的从句:

```
(loop for internal-variable downfrom (- n 1) to 0 ...)
```

但构造`repeat`可能更高效.

在循环从句内部的可执行部分和整个循环形式周围, 可以使用`let`绑定变量.

因为`it`是一个循环关键字, 可以在特定上下文中的形式中出现, 在循环中使用名称为`IT`的变量时需要特别注意.

没有给用户添加循环扩展的标准机制.

## 6.2 迭代的字典

- macro `do, do*`
- macro `dotimes`
- macro `dolist`
- macro `loop`
- local macro `loop-finish`

# 7 对象

## 7.1 对象创建和初始化

广义函数`make-instance`创建并返回类的一个新实例. 第一个传递参数是类或类的名称, 剩余的传递参数是 **初始化传递参数列表**.

一个新实例的初始化由几个步骤构成, 包括: 组合显式提供的初始化传递参数和未提供的初始化传递参数的默认值、 检查初始化传递参数的有效性、 为实例分配存储空间、 用值填充槽、 执行用户提供的额外初始化的方法. `make-instance`中每一个步骤是由广义函数实现的, 提供了定制步骤的机制. 此外, `make-instance`本身是一个广义函数, 也可被定制.

对象系统为每个步骤指定了系统提供的主方法, 从而指定了整个初始化过程的良好定义的标准行为. 标准行为提供了控制初始化的4个简单机制:

1. **声明一个符号作为槽的初始化传递参数**. 初始化传递参数是使用`defclass`中槽选项`:initarg`声明的. 这个声明为在调用`make-instance`时提供槽值提供了一个机制.
2. **为初始化传递参数提供默认值**. 初始化传递参数的默认值形式是使用`defclass`的类选项`:default-initargs`定义的. 如果没有提供初始化传递参数作为`make-instance`的传递参数, 这个默认值形式在定义它的`defclass`形式的词法环境中求值, 结果值用作初始值传递参数的值.
3. **为槽提供了默认初始值形式**. 槽的默认初始值形式是使用`defclass`的槽选项`:initform`定义的. 如果没有槽相应的初始化传递参数作为`make-instance`的传递参数, 或者没有使用`:defualt-initargs`, 这个默认初始值形式在定义它的`defclass`形式的词法环境中求值, 结果值存储在槽中. 本地槽的`:initform`形式可在创建实例、重定义类时更新实例或者更新实例以复合另一个类的定义时使用. 共享槽的`:initform`可在定义或重定义类时使用.
4. **为`initialize-instance`和`shared-initialize`定义方法**. 上面描述的槽填充行为是使用系统提供的`initialize-instance`的主方法实现的, 该主方法会调用`shared-initialize`. 广义函数`shared-initialize`实现这四种情况中的初始化: 创建实例、重新初始化实例、重定义类时更新实例、更新实例以复合另一个类的定义. 提供提供的`shared-initialize`的主方法直接实现上述的槽填充行为, `initialize-instance`简单的调用`shared-initialize`.

### 7.1.1 初始化传递参数

**初始化传递参数** 控制对象的创建和初始化. 通常使用关键字符号命名初始化传递参数, 但初始化传递参数的名称可以是任意符号, 包括`nil`. 有两种使用初始化传递参数的方式: 填充槽值, 或为初始化方法提供传递参数. 一个简单的初始化参数参数可以用于这两个用途.

**初始化传递参数列表** 是初始化传递参数名称和值的关联列表. 它的结构与关联列表等同, 也与传递参数列表中`&key`参数部分等同. 在这些列表中, 如果一个初始化传递参数名称出现 **多次**, **最左** 的出现提供值, 剩余的被忽略. `make-instance`的第一个传递参数后的传递参数构成初始化传递参数列表.

**初始化传递参数可以与槽关联**. 如果初始化传递参数在初始化传递参数列表中有值, 这个值存储在新创建的对象的槽中, 覆盖与这个槽相关的`:initform`形式. 一个初始化传递参数可以初始化多个槽. 初始化共享槽的初始化传递参数将值存储到这个共享槽中, 替换之前的值.

**初始化传递参数可以与方法关联**. 当创建对象时, 提供了一个初始化传递参数, 广义函数`initialize-instance`、`shared-initialize`和`allocate-instance`会被调用, 将这个初始化传递参数的名称和值作为关键字传递参数对. 如果在初始化传递参数列表中没有提供初始化传递参数的值, 方法的lambda列表提供一个默认值.

初始化传递参数用于四种情况: **创建实例**、**重新初始化实例**、**重定义类时更新实例**、**更新实例以复合另一个类的定义**.

因为初始化参数参数被用于控制特定类的实例的创建和初始化, 称初始化传递参数是 **类的初始化参数**.

### 7.1.2 声明初始化传递参数的有效性

初始化传递参数在被使用的四种情况中被检查有效性. 一个初始化传递参数可能在一个情况中是有效的, 但在另一个情况中是无效的. 例如, 系统提供的为类`standard-class`定义的`make-instance`的主方法, 检查它的初始化传递参数的有效性, 在提供的初始化传递参数在一个情况中未被声明为有效时, 发出错误信号.

有两种将初始化传递参数声明为有效的方法:

1. 用`defclass`的`:initarg`槽选项将填充槽的初始化传递参数声明为有效的. 槽选项`:initarg`可从超类中继承的. 因此, 有效的填充槽的初始化传递参数集合是在类和它的超类中声明为有效的填充槽的初始化传递参数的并集. 填充槽的初始化传递参数在四种上下文中是有效的.
2. 为方法提供传递参数的初始化传递参数, 在定义这些方法时被声明为有效的. 方法的lambda列表中指定的关键字传递参数的关键字名称, 称为该方法可引用的所有类的初始化传递参数. 可应用方法的lambda列表中出现`&allow-other-keys`时, 会关闭初始化传递参数的检查. 因此, 方法继承控制了给方法提供传递参数的有效初始化传递参数集合. 用于支持在方法定义中将初始化传递参数声明为有效的广义函数有:  
      
    
3. \– 创建类的实例: `allocate-instance`、`initialize-instance`和`shared-initialize`. 在这些方法中声明为有效的初始化传递参数在创建类的实例是是有效的.  
    
4. \– 重新初始化实例: `reinitialize-instance`和`shared-initialize`. 在这些方法中声明为有效的初始化传递参数在重新初始化实例时是有效的.  
    
5. \– 重定义类时更新实例: `update-instance-for-redefined-class`和`shared-initialize`. 在这些方法中声明为有效的初始化传递参数在重定义类时更新实例是有效的.  
    
6. \– 更新实例以复合另一个类的定义: `update-instance-for-different-class`和`shared-initialize`. 在这些方法中声明为有效的初始化传递参数在更新实例以复合另一个类的定义更新实例是有效的.

一个类的有效初始化传递参数的集合是, 填充槽的或为方法提供传递参数的有效初始化传递参数, 和预定义的初始化传递参数`:allow-other-keys`. `:allow-other-keys`的默认值是`nil`. 如果初始化传递参数`:allow-other-keys`是true, 关闭初始化传递参数的有效性检查.

### 7.1.3 初始化传递参数的默认值

使用类选项`:default-initargs`可以为初始化传递参数提供一个默认值形式. 如果在特定类中初始化传递参数被声明为有效的, 可以在另一个类中指定它的默认值形式. 在这种情况下, `:default-initargs`用于为继承来的初始化参数提供默认值.

选项`:default-initargs`只用于为初始化传递参数提供默认值, 它并不将一个符号声明为有效的初始化传递参数的名称. 此外, 选项`:default-initargs`只用于在创建实例时为初始化传递参数提供默认值.

类选项`:default-initargs`的传递参数是交错排列的初始化传递参数的名称和形式的一个列表. 每个形式是相应的初始化传递参数的默认值. **一个初始化传递参数的默认值形式只在这些情况下被使用和求值** : 这个初始化传递参数没有在`make-instance`的传递参数中出现, 且没有被更特殊的类做默认处理. 默认值形式在提供它的`defclass`形式的词法环境中求值, 结果值用作初始化传递参数的值.

提供给`make-instance`的初始化传递参数与被默认处理的初始化传递参数组合, 生成 **默认的初始化传递参数列表**. 默认的初始化传递参数列表是一个交错排列的初始化传递参数的名称和值的列表, 其中, 未提供的初始化传递参数被默认处理, 在默认的初始化传递参数列表中, **显式提供的初始化传递参数出现在被默认处理的初始化传递参数之前**. 默认的初始化传递参数列表根据提供了默认值的类的类优先级列表排序.

在初始化槽时, 选项`:default-initargs`与`:initform`存在区别. 类选项`:default-initargs`为用户提供了一个机制, 在不清楚初始化传递参数是初始化一个槽, 还是被传递给方法时, 给这个初始化传递参数指定一个默认值形式. 如果在调用`make-instance`时没有显式提供该初始化传递参数, 使用这个默认值形式, 就像在调用中提供了一样. 与之相反, 槽选项`:initform`为用户提供了一个机制, 给一个槽指定一个默认初始值形式. 只有在这些情况下, `:initform`形式用于初始化一个槽: 调用`make-instance`时每个指定与该槽相关的初始化传递参数, 或者没有使用`:default-initargs`默认处理.

对初始化传递参数的默认值形式求值的顺序和`:initform`形式的求值顺序是未描述的. 如果求值顺序是重要的, 应该使用`initialize-instance`或`shared-initialize`方法.

### 7.1.4 初始化传递参数的规则

在给定槽上可以指定多次槽选项`:initarg`.

下面的规则描述初始化传递参数何时可以被多次定义:

- 如果同一个初始化传递参数的名称在多个槽选项`:initarg`中出现, 这个初始化传递参数可以用于初始化多个槽.
- 特定初始化传递参数的名称可以在多个初始化方法的lambda列表中出现.
- 特定初始化传递参数的名称可以同时出现在槽选项`:initarg`和初始化方法的lambda列表中.

如果在`make-instance`的传递参数中, **给定了两个或多个初始化同一个槽的初始化传递参数**, 这些在初始化传递参数列表中 **最左** 出现的初始化传递参数提供值, 甚至在这些初始化传递参数有不同的名称时也是如此.**[1]**

^1: 注释: 使用两个初始化传递参数命名作为同一个槽的初始化传递参数, 在`make-instance`的传递参数中只指定了一个, 则该参数提供值.

如果初始化同一个槽的两个或多个不同的初始化传递参数有默认值, 且均未在`make-instance`的传递参数中显式指定, 在最特殊的类中类选项`:default-initargs`中出现的初始化传递参数提供值. 如果单个类选项`:default-initargs`指定了两个或多个初始化传递参数来初始化同一个槽, 且均未在`make-instance`的传递参数中显式指定, 则最左的类选项`:default-initargs`提供值, 剩余的默认值形式的值被忽略.

在`make-instance`的传递参数中 **显式指定的初始化传递参数**, 出现在默认的初始化传递参数的左边. 假设类C1和C2为不同的槽提供了默认初始化传递参数的值, C1比C2更特殊, 则在默认的初始化传递参数列表中, 由C1提供值的默认初始化传递参数, 出现在由C2提供值的默认初始化传递参数的左边. 如果单个类选项`:default-initargs`为两个不同的槽提供了初始化传递参数的值, 则在类选项`:default-initargs`中较左出现值的初始化传递参数, 在默认初始化传递参数列表中也是较左出现.

如果一个槽同时有`:initform`形式和槽选项`:initarg`, 初始化传递参数默认用`:default-initargs`处理或提供给`make-instance`, 则 **从不使用或求值捕获的`:initform`形式**.

下面是上述规则的一个示例:

```
(defclass q () ((x :initarg a)))
(defclass r (q) ((x :initarg b))
  (:default-initargs a 1 b 2))
```

```
形式                           默认初始化传递参数列表           槽X的内容
----------
; 未指定初始化传递参数, 使用:default-initargs
(make-instance 'r)            (a 1 b 2)                     1
; 显式指定的初始化传递参数, 出现在默认的初始化传递参数的左边
; 见脚注1
(make-instance 'r 'a 3)       (a 3 b 2)                     3
; 显式指定的初始化传递参数, 出现在默认的初始化传递参数的左边
(make-instance 'r 'b 4)       (b 4 a 1)                     4
; 如果一个初始化传递参数名称出现 多次, 最左 的出现提供值, 剩余的被忽略
(make-instance 'r 'a 1 'a 2)  (a 1 a 2 b 2)                 1
```

### 7.1.5 shared-initialize

当创建实例、重新初始化实例、重定义类时更新实例、更新实例以复合不同类时, 广义函数`shared-initialize`使用初始化传递参数填充实例的槽. 它使用标准方法组合. 接受参数: 被初始化的实例、实例中可访问的槽名称集合的规范、任意数量的初始化传递参数. 头两个之后的传递参数构成初始化传递参数列表.

`shared-initialize`的第二个传递参数可以是以下的任意一个:

- 槽名称的一个(可能为空的)列表, 指定了这些槽名称的集合
- 符号`t`, 指定所有槽集合

有一个系统提供的`shared-initialize`主方法, 其第一个参数特化符是类`standard-object`. 这个方法在每个槽上的行为如下, 不管是共享槽还是本地槽:

- 如果初始化传递参数列表中的一个初始化传递参数指定了这个槽的值, 值被存储在槽中, 甚至在这个方法运行前槽中已有值. 被影响的槽与`shared-initialize`的第二个传递参数中指定的槽是不相关的.
- 在第二个传递参数中指定的此时仍是未绑定的槽, 根据它们的`:initform`形式初始化. 对任意这样的有`:initform`形式的槽, 这个形式在其被定义的`defclass`形式中的词法环境中求值, 结果作为槽值. 例如, 如果一个before方法在槽中存储值, 不会使用`:initform`形式给槽提供值. 如果第二个传递参数描述了不与实例中可访问的槽相关的名称, 后果是未定义的.
- 遵循**7.1.4 初始化传递参数的规则**中的规则.

`reinitialize-instance`、`update-instance-for-different-class`、`update-instance-for-redefined-class`和`initialize-instance`的系统提供的主方法中调用广义函数`shared-initialize`. 因此, 可以编写`shared-initialize`的方法, 指定应该在所有这些上下文中应该采取的动作.

### 7.1.6 initialize-instance

`make-instance`调用广义函数`initialize-instance`以初始化新建实例. 它使用标准方法组合. `initialize-instance`的方法可用于在不能简单的提供槽的初始值时执行任意初始化.

在初始化过程中, `initialize-instance`在下述动作发生后被调用:

- 默认初始化传递参数已通过组合提供的初始化传递参数列表和类的任意默认初始化传递参数.
- 默认初始值传递参数列表的有效性已检查. 如果有初始化传递参数未被声明为有效的, 发出错误信号.
- 已创建新的槽未绑定的实例.

使用新实例和默认初始化传递参数调用冠以函数`initialize-instance`. 有系统系统的`initialize-instance`主方法, 它的参数特化符是类`standard-object`. 这个方法调用广义函数`shared-initialize`根据初始化传递参数和槽的`:initform`形式填充槽; 调用广义函数`shared-initialize`时传递参数是: 这个实例、`t`、默认初始化传递参数.

注意`initialize-instance`在它对`shared-initialize`的调用中提供了默认初始化传递参数列表, 因此系统提供的`shared-initialize`主方法中的第一个步骤需要考虑调用`make-instance`时提供的吹刷传递参数和默认初始化传递参数列表.

可以定义`initialize-instance`的方法, 指定初始化实例时采取的动作. 如果只定义了`initialize-instance`的after方法, 它们在系统提供的初始化主方法之后运行, 因此不会影响`initialize-instance`的默认行为.

对象系统提供了两个在`initialize-instance`方法体中有用的函数. 函数`slot-boundp`返回广义布尔值, 表明给定的槽是否有值; 这为编写只在槽未被初始化时执行初始化的`initialize-instance` after方法提供了机制. 函数`slot-makeunbound`将槽置为无值.

### 7.1.7 make-instance和initialize-instance的定义

广义函数`make-instance`的行为就像如下定义的那样, 除了允许一些特定的优化:

```
(defmethod make-instance ((class standard-class) &rest initargs)
  ...
  (let ((instance (apply #'allocate-instance class initargs)))
    (apply #'initialize-instance instance initargs)
    instance))

(defmethod make-instance ((class-name symbol) &rest initargs)
  (apply #'make-instance (find-class class-name) initargs))
```

`make-instance`定义中省略的代码, 在`initargs`中加入默认初始化传递参数, 检查最终的初始化传递参数, 以确定一个提供的初始化传递参数是否填充槽或者作为可应用方法的传递参数.

广义函数`initialize-instance`的行为就像如下定义的那样, 除了允许一些特定的优化:

```
(defmethod initialize-instance ((instance standard-object) &rest initargs)
  (apply #'shared-initialize instance t initargs)))
```

这些过程可以被定制.

在程序员接口层次的定制包括: 使用`defclass`的选项`:initform`、`:initarg`和`:default-initargs`, 定义`make-instance`、`allocate-instance`和`initialize-instance`的方法. 也可以定义`shared-initialize`的方法, 它会被广义函数`reinitialize-instance`、`update-instance-for-redefined-class`、`update-instance-for-different-class`和`initialize-instance`调用. 元对象层次提供了额外的定制机制.

允许实现优化`initialize-instance`和`shared-initialize`. 本章中论述的`shared-initialize`提到了可能的优化.

## 7.2 修改实例的类

函数`change-class`可用于修改实例的类: 从当前类Cfrom修改为Cto; 它修改实例的解构以复合类Cto的定义.

注意到修改实例的类可能导致添加或移除槽. 修改实例的类不会修改实例在函数`eq`语义下的标识.

当在实例上调用`change-class`时, 会发生两个步骤的更新过程. 第一个步骤修改实例的结构: 添加新的本地槽, 移除未在实例的新版本中未指定的本地槽. 第二个步骤初始化新加的本地槽, 执行任何其它用户定义的动作. 后续章节进一步阐述这两个步骤.

### 7.2.1 修改实例的解构

为确保实例复合类Cto, 在类Cto中指定、未在类Cfrom中指定的本地槽需要被添加, 未在类Cto中指定、在类Cfrom指定的本地槽需要被移除.

同时在类Cto和Cfrom中指定的本地槽的值被保留. 如果这样的一个本地槽是未绑定的, 保持为未绑定.

在类Cfrom中指定为共享的、在类Cto中指定为本地的槽的值被保留.

更新过程的第一个步骤不会影响任何共享槽的值.

### 7.2.2 初始化新增的本地槽

更新过程的第二个步骤初始化新加的槽, 并执行任何其它用户定义的动作. 这个步骤是由广义函数`update-instance-for-different-class`实现的. 在更新过程的第一个步骤完成之后, `change-class`调用广义函数`update-instance-for-different-class`.

广义函数`update-instance-for-different-class`在由`change-class`计算出的传递参数上调用. 第一个传递参数是被更新的实例的一个副本, 这个实例属于类Cfrom; 这个副本在广义函数`change-class`中有动态extent. 第二个传递参数是到目前位置`change-class`已修改的实例, 这个实例属于类Cto. 剩余的传递参数是初始化传递参数列表.

系统提供的`update-instance-for-different-class`主方法有两个参数特化符, 每个都是类`standard-object`. 这个方法首先检查初始化传递参数的有效性, 在提供的初始化传递参数未被声明为有效时发出错误信号.(更多信息见**7.1.2 声明初始化传递参数的有效性**). 然后调用广义函数`shared-initialize`, 使用传递参数: 新实例、新添加的槽的名称的一个列表、接收到的初始化传递参数.

### 7.2.3 定制实例的类的修改

可以定义`update-instance-for-different-class`的方法, 指定在更新实例时采取的动作. 如果只定义的`update-instance-for-different-class`的after方法, 它们在系统提供的初始化主方法之后调用, 不会影响`update-instance-for-different-class`的默认行为.

可以定义`shared-initialize`的方法, 定制类的重定义. 更多信息见**7.1.5 shared-initialize**.

## 7.3 重新初始化实例

广义函数`reinitialize-instance`用于根据初始化传递参数修改槽的值.

重新初始化过程修改一些槽的值, 并指定任何用户定义的动作. 它不修改实例的结构以添加或移除槽, 不使用`:initform`形式初始化槽.

可以直接调用广义函数`reinitialize-instance`. 它有一个必备请求参数: 这个实例. 它也接受任意数量的用于`reinitialize-instance`或`shared-initialize`方法的初始化传递参数. 在必备实例传递参数之后的传递参数必须构成一个初始化传递参数列表.

系统提供的`reinitialize-instance`主方法的参数特化符是类`standard-object`. 这个方法首先检查初始化传递参数的有效性, 在提供的初始化传递参数未被声明为有效的时发出错误信号(更多信息见**7.1.2 声明初始化传递参数的有效性**). 然后调用广义函数`shared-initialize`, 使用的传递参数: 这个实例、`nil`、接受到的初始化传递参数.

### 7.3.1 定制重新初始化

`reinitialize-instance`的方法可以指定更新实例时采取的动作. 如果只定义了`reinitialize-instance` after方法, 它们会在系统提供的初始化主方法之后调用, 不会影响`reinitialize-instance`的默认行为.

`shared-initialize`的方法可用于定制类重定义. 更多信息见**7.1.5 shared-initialize**.

## 7.4 元对象(Meta-objects)

对象系统的实现操作类、方法和广义函数. 对象系统中有一组通过类中方法定义的广义函数; 这些广义函数的行为定义了对象系统的行为. 这些方法定义所在的类的实例被称为 **元对象**.

### 7.4.1 标准元对象

对象系统提供了一组元对象, 称为 **标准元对象**. 包括: 类`standard-object`, 类`standard-method`、`standard-generic-function`、`method-combination`的实例.

- 类`standard-method`是用`defmethod`和`defgeneric`形式定义的方法的默认类.
- 类`standard-generic-function`是用`defmethod`、`defgeneric`和`defclass`形式兴义的广义函数的默认类.
- 类`standard-object`是类`standard-class`的实例, 是`standard-class`的实例中除自身和`structure-class`的所有其它实例的超类.
- 每个方法组合对象是类`method-combination`的子类的实例.

## 7.5 槽(Slots)

### 7.5.1 槽的介绍

元类`standard-class`的对象有0个或几个命名的槽. 对象的槽是由对象的类所确定的. 每个槽可以持有一个值. 槽的名称是一个符号, 这个符号用作变量名称时是语法有效的.

当槽没有值时, 称这个槽是未绑定的. 当读取未绑定的槽时, 调用广义函数`slot-unbound`. 系统提供的类`t`上的`slot-unbound`主方法发出错误信号. 如果`slot-unbound`返回, 那时它的主值被用作槽的值.

槽的默认初始值形式是用槽选项`:initform`定义的. 当用`:initform`形式提供值时, 它在`defclass`形式被求值时的词法环境中求值. `:initform`连同`defclass`形式被求值的词法环境, 被称为 **捕获的初始化形式**. 更多信息见**7.1 对象创建和初始化**.

本地槽被定义为只在一个实例中可访问的槽, 这个实例是槽被分配时所在的实例. 共享槽被定义为在给定类和它的子类的多个实例中可见的槽.

当一个类的`defclass`形式中包含一个名称的槽描述符, 称 **这个类使用这个名称定义了一个槽**. 定义一个本地槽并不立即创建一个槽, 它导致每次类的实例被创建是该槽被创建. 定义一个共享槽立即创建一个槽.

`defclass`的槽选项`:allocation`控制所定义的槽的种类. 如果槽选项`:allocation`的值是`:instance`时, 创建本地槽; 如果是`:class`, 创建共享槽.

如果槽是用实例的类定义的, 或者从该类的超类中继承的, 称 **槽在类的实例中可访问**. 在一个实例中, 最多只有一个给定槽名称的槽可访问. 类中定义的共享槽在该类的所有实例中均可访问. 槽继承的详细解释在**7.5.3 槽和槽选项的继承**.

### 7.5.2 访问槽

有两种方式访问槽: 使用原生函数`slot-value`, 或使用`defclass`形式生成的广义函数.

函数`slot-value`可以与`defclass`形式中指定的槽名称一起使用, 以访问给定类的实例中可访问的槽.

宏`defclass`提供了生成读写槽方法的语法. 如果要求创建一个读方法, 会自动生成一个读取槽值的方法, 但不会生成存储槽值的方法. 如果要求创建一个写方法, 会自动生成一个存储槽值的方法, 但不会生成读取槽值的方法. 如果要求创建一个访问器方法, 会自动生成读取槽值和存储槽值两个方法. 读方法和写方法的方式是用`slot-value`实现的.

如果在一个槽上指定了读方法或写方法, 生成的方法所属的广义函数的名称是直接指定的. 如果写方法指定的名称是符号`name`, 则写入槽的广义函数的名称是符号`name`, 这个广义函数有两个传递参数: 新值和实例. 如果访问器方法指定的名称是符号`name`, 读取槽的广义函数的名称是符号`name`, 写入槽的广义函数的名称是列表`(setf name)`.

通过槽选项`:reader`、`:writer`或`:accessor`创建或修改的广义函数, 可被视为常规的广义函数.

注意`slot-value`可用于读写槽值, 不管槽上是否有读写方法. 当使用`slot-value`时, 不会调用读写方法.

宏`with-slots`可用于建立一个词法环境, 其中指定的槽是词法可用的, 就像是变量一样. 宏`with-slots`调用函数`slot-value`访问指定的槽.

宏`with-accessors`可用于建立一个词法环境, 其中指定的槽通过它们的访问器是词法可用的, 就像是变量一样. 宏`with-accessors`调用相应的访问器访问指定的槽.

### 7.5.3 槽和槽选项的继承

类C的一个实例中所有可访问的槽的名称是由C和它的超类中定义的槽的名称集合的并. 实例的结构是该实例中本地槽名称的集合.

在最简单的情况中, 类C和它的超类中只有一个用指定的槽名称定义了槽. 如果槽在C的超类中定义, 称槽是继承的. 槽的特性是由定义类中的槽描述符确定的. 考虑槽S的定义类, 如果槽选项`:allocation`的值是`:instance`, 则S是本地槽, C的每个实例有自己的名称为S的槽, 存储自己的值. 如果槽选项`:allocate`的值是`:class`, 则S是共享槽, 定义S的类存储值, C的所有实例可以访问这个槽. 如果槽选项`:allocation`被忽略, 值为`:instance`.

通常, 类C和它的超类中有多个定义了指定名称的槽. 在这种情况下, C的实例中可访问的指定名称的槽只有一个, 槽的特性是几个槽描述符的组合, 按下述方式计算:

- 给定槽名称的所有槽描述符按从最特殊到最不特殊的顺序排列, 依据C的类优先级列表中有该槽名称定义的类的顺序. 后面对槽描述符特殊性的引用都按这个顺序.
- 对特殊的槽描述符控制槽的分配. 如果最特殊的槽描述符没有包含槽选项`:allocation`, 使用`:instance`. 较不特殊的槽描述符不影响分配.
- 槽的默认初始值形式是槽选项`:initform`的槽描述符中最特殊的指定的值. 如果没有槽描述符有槽选项`:initform`, 则槽没有默认初始值形式.
- 槽的内容总是有类型`(and T1 ... Tn)`, T1...Tn是在所有槽描述符中槽选项`:type`的值. 如果没有槽描述符有槽选项`:type`, 槽的内容总是类型`t`. 尝试在槽中存储不满足槽的类型的值的后果是未定义的.
- 初始化给定槽的初始化传递参数是在所有槽描述符中槽选项`:initarg`中声明的初始化传递参数的并集.
- 槽的文档字符串是在最特殊的槽描述符中槽选项`:documentation`的值. 如果没有槽描述符有槽选项`:documentation`, 槽没有文档字符串.

分配规则的影响是共享槽可被遮盖. 例如, 如果类C1定义了槽S, 它的槽选项`:allocation`的值是`:class`, 这个槽在C1和它的所有子类中是可访问的. C2是C1的子类, 也定义了槽S, C1的槽S不被C2及其子类的实例共享. 当类C1定义了一个共享槽, C2为C1的子类, C2会共享这个槽, 除非C2的`defclass`形式指定了同名的槽、在C2的类优先级列表中有C2的超类出现在C1之前, 这个C2的超类中定义了同名的槽.

类型规则的影响是, 槽值满足与这个槽相关的没有槽描述符中的类型约束. 因为尝试在槽中存储不满足槽类型约束的后果是未定义的, 槽值可能不满足类型约束.

槽选项`:reader`、`:writer`、`:accessor`创建方法, 而不是定义槽的特性. 读写方法按**7.6.7 方法继承**中描述的方式继承.

访问槽的方法只使用槽的名称和槽值的类型. 假设超类中提供了要访问给定名称的共享槽的方法, 子类中定义了同名的本地槽. 如果在子类的实例上使用超类提供的方法, 这个方法会访问本地槽.

## 7.6 广义函数和方法

### 7.6.1 广义函数的介绍

广义函数是一个函数, 它的行为依赖于提供给它的传递参数的类或标识. 一个广义函数对象与一组方法、一个lambda列表、一个方法组合和其他信息关联.

与常规函数类似, 广义函数接受传递参数, 执行一个动作序列, 可能返回有用的值. 常规函数有一个代码体, 被调用时总被执行. 广义函数有一组代码体, 其中的一个子集被选择用于执行. 被选择的代码体, 以及它们组合的方式, 是由广义函数及其方法组合的一个或多个传递参数的类或标识确定的.

常规函数和广义函数的调用语法是相同的.

广义函数是可被作为传递参数、用作`funcall`和`apply`第一个传递参数的函数.

建立函数名称到广义函数的绑定有几种方式. 在全局环境中用`ensure-generic-function`、`defmethod`(隐式的由于`ensure-generic-function`)或`defgeneric`(隐式的由于`ensure-generic-function`)建立绑定. 没有标准机制支持在词法环境中建立函数名称到广义函数的绑定.

求值`defgeneric`形式时, 会执行下面的一个动作(由于`ensure-generic-function`):

- 如果给定名称的广义函数已存在, 则修改已存在的广义函数对象. 当前`defgeneric`形式指定的方法被添加, 已存在的广义函数的方法中由之前的`defgeneric`形式定义的被移除. 由当前`defgeneric`形式添加的方法可能替换用`defmethod`、`defclass`、`define-condition`、`defstruct`定义的方法. 广义函数中其他方法不受影响.
- 如果给定的名称命名了一个常规函数、宏或特殊操作符, 发出错误信号.
- 否则, 创建一个带有用`defgeneric`形式中的方法定义指定的方法的广义函数.

一些操作符允许描述广义函数的选项, 例如它使用的方法组合的类型、它的传递参数优先级. 这些操作符被称为 **指定广义函数的选项的操作符**. 这类操作符中唯一标准的是`defgeneric`.

图 7-1. 标准的定义方法的操作符.

```
defclass
defgeneric
define-condition
defmethod
defstruct
```

注意, 在标准的定义方法的操作符中, 只有`defgeneric`可以指定广义函数的选项. `defgeneric`与任意可以指定广义函数的选项的实现定义的操作符, 称为 **指定广义函数的选项的操作符**.

### 7.6.2 方法的介绍

方法定义了广义函数类特定或标识特定的行为和操作.

一个方法对象关联了实现方法行为的代码、一个指定该方法何时可应用时的参数特化符序列、一个lambda列表、一个被方法组合工具用于区分方法的限定符序列.

方法对象不是函数, 不可作为函数调用. 对象系统中有多种机制在方法对象上调用方法函数, 就像调用广义函数一样. 当出现这种情况时, 称方法被调用了.

一个定义方法的形式包含代码, 这些代码在传递给广义函数的传递参数导致它定义的方法被调用时运行. 当定义方法的形式被求值时, 会创建一个方法对象, 执行下面的一个动作:

- 如果给定名称的广义函数已存在, 且已存在一个在参数特化符和限定符上一致的方法对象, 则新的方法对象会替代旧的方法对象. 方法对象在参数特化符和限定符上一致的详细定义见**7.6.3 参数特化和限定的约定**.
- 如果给定名称的广义函数已存在, 且没有在参数特化符和限定符上一致的方法对象, 则修改已存在的广义函数对象以包含新的方法对象.
- 如果给定的名称命名了一个常规函数、一个宏或者一个特殊操作符, 发出错误信号.
- 否则, 创建带由定义方法的形式指定的方法的广义函数.

如果新方法的lambda列表不与广义函数的lambda列表一致, 发出错误信号. 如果不能指定广义函数的选项的一个定义方法的操作符创建了一个新广义函数, 这个广义函数的lambda列表是一致性的从定义方法的形式中的方法的lambda列表导出的. 有关一致性的讨论, 见**7.6.4 广义函数的所有方法的一致lambda列表**.

每个方法有一个特化的lambda列表, 它确定了何时可以应用这个方法. \**特化的lambda列表** 与常规lambda列表类似, 除了特化参数可以作为必备参数出现. 特化的参数是一个列表`(variable-name parameter-specializer-name)`, 这里的`parameter-specializer-name`是下面的其中一个:

- 一个符号: 表示参数特化符是该符号命名的类
- 一个类: 表示参数特化符是类本身
- `(eql form)`: 表示参数特化符满足类型描述符`(eql object)`, 这里`object`是`form`的求值结果. 形式`form`在定义方法的形式被求值的词法环境中求值. 注意`form`只被求值一次, 在方法定义时而不是每次调用广义函数时.

参数特化符名称在宏中作为用户层接口(`defmethod`)使用, 参数特化符在函数性接口中使用.

只有必备参数可被特化, 对每个必备参数都需要有一个相应的参数特化符. 为了方便, 如果定义方法的形式中特化的lambda列表中的必备参数是一个变量名称, 它的参数特化符默认为类`t`.

给定一个广义函数和一组传递参数, **可应用的方法** 是这个广义函数的方法, 它的参数特化符被相应的传递参数满足. 下面的定义阐述了方法可应用和传递参数满足参数特化符的含义.

$\<A\_{1},...,A\_{n}>$ 是广义函数中的必备传递参数, $\<P\_{1},...,P\_{n}>$ 是方法 $M$ 中必备参数对应的参数特化符. 当每个 $A\_{i}$ 术语类型描述符 $P\_{i}$ 指定的类型时, 方法 $M$ 是可应用的. 因为每个有效的参数特化符同时也是有效的类型描述符, 函数`typep`可在方法选择时使用, 以确定一个传递参数是否满足一个参数特化符.

所有参数特化符是类`t`的方法被称为 **默认方法**; 它总是可应用的, 但可能被更特殊的方法遮盖.

方法可以有限定符, 它为方法组合过程提供了区分方法的方式. 带一个或多个限定符的方法被称为 **限定的方法**. 没有限定符的方法称为未限定的方法. 限定符是任意非列表对象. 标准的方法组合类型中定义的限定符是符号.

在该规范中, 术语主方法和辅助方法用于在方法组合类型中按用途划分方法. 在标准方法组合中, 主方法是未限定的方法, 辅助方法是有一个限定符(`:around`、`:before`、`:after`)的方法. 有这些限定符的方法分别被称为around方法、before方法和after方法. 当使用`define-method-combination`的短形式定义方法组合类型时, 主方法是用方法组合类型的名称限定的方法, 辅助方法有限定符`:around`. 因此, 术语主方法和辅助方法在给定方法组合类型中只有一个相对的定义.

### 7.6.3 参数特化和限定的一致性

两个方法在参数特化符和限定符上一致, 如果满足:

1. 两个方法有相同数量的必备参数. 假设俩那个方法的参数特化符分别是 $P\_{1,1},...P\_{1,n}$, $P\_{2,1},...P\_{2,n}$.
2. 对每个 $1 <= i <= n$, $P\_{1,i}$ 与 $P\_{2,i}$ 一致. $P\_{1,i}$ 与 $P\_{2,i}$ 一致, 是指它们是同一个类或者 $P\_{1,i}$ =`(eql object1)`, $P\_{1,i}$ =`(eql object2)`, 且`(eql object1 object2)`. 否则 $P\_{1,i}$ 与 $P\_{2,i}$ 不一致.
3. 两个限定符的列表在`equial`语义下相等.

### 7.6.4 广义函数的所有方法的一致lambda列表

下面的规则定义了一个lambda列表的一致性, 包括给定广义函数的每个方法的lambda列表, 和广义函数自身指定的lambda列表.

1. 每个lambda列表必须有相同数量的必备参数.
2. 每个lambda列表必须有相同数量的可选参数. 每个方法可以为可选参数提供自己的默认值.
3. 如果一个lambda列表中使用了`&rest`或`&key`, 每个lambda列表必须至少使用一个.
4. 如果广义函数的lambda列表中使用了`&key`, 每个方法必须接受`&key`之后的所有关键词名称, 通过显式接受、指定`&allow-other-keys`或指定`&rest`未指定`&key`. 每个方法可以接受自己额外的关键字参数. 检查关键字名称的有效性是在广义函数中完成的, 而不是在每个方法中. 每个方法就像使用关键字传递参数对`:allow-other-keys true`被调用, 尽管实际上不会传递这样的参数.
5. `&allow-other-keys`的使用不需要在lambda列表之间保持一致. 如果在任何可应用方法或广义函数的lambda列表中使用了`&allow-other-keys`, 在调用广义函数时可以使用任意关键字传递参数.
6. `&aux`的使用不需要在方法质检保持一致.  
    
7. 如果不能指定广义函数的选项的定义方法的操作符创建了一个广义函数, 且方法的lambda列表中使用了关键字传递参数, 广义函数的lambda列表中会使用`&key`(不会使用关键字传递参数).

### 7.6.5 广义函数和方法中的关键字传递参数

当广义函数或它的一些方法在lambda列表中使用`&key`, 广义函数可接受的关键字传递参数集合, 根据可应用的方法, 是不同的. 对一次对广义函数调用中可接受的关键字参数集合是, 被所有可应用方法接受的关键词传递参数与广义函数定义中`&key`之后的关键字传递参数的并集. 有`&rest`但没有`&key`的方法不影响可接受的关键字传递参数的集合. 如果可应用方法或广义函数定义的lambda列表中包含`&allow-other-keys`, 这个广义函数可以接受所有的关键字传递参数.

lambda列表一致性规则要求, 每个方法接受在广义函数定义中`&key`之后的所有关键字传递参数, 通过显式接受、指定`&allow-other-keys`或指定`&rest`但不指定`&key`. 每个方法在接受广义函数定义中的关键字传递参数之外, 也可以接受额外自己的关键字传递参数.

#### 7.6.5.1 示例: 广义函数和方法中的关键字传递参数

有两个方法:

```
(defmethod width ((c character-class) &key font) ...)

(defmethod width ((p picture-class) &key pixel-size) ...)
```

假设没有`width`的其他方法和广义函数定义. 求值下面形式应该发出错误信号, 因为关键字传递参数`:pixel-size`不被可应用方法接受.

```
(width (make-instance `character-class :char #\Q)
       :font 'baskerville :pixel-size 10)
```

下面的形式求值应该发出错误信号:

```
(width (make-instance `picture-class :glyph (glyph #\Q))
       :font 'baskerville :pixel-size 10)
```

如果命名为`character-picture-class`的类是`picture-class`和`character-class`的子类, 求值下面的形式不会发出错误信号:

```
(width (make-instance `character-picture-class :char #\Q)
       :font 'baskerville :pixel-size 10)
```

### 7.6.6 方法选择和组合

使用特定传递参数调用广义函数时, 必须确定要执行的代码. 这个代码称为 **这些传递参数的有效方法**. 有效方法是广义函数的可应用方法的组合, 调用一些或全部方法.

如果调用广义函数时没有方法可应用, 会调用广义函数`no-applicable-method`, 其结果作为调用原始广义函数的结果. 调用`no-applicable-method`发生在检查可接受的关键字传递参数之前, 见**7.6.5 广义函数和方法中的关键字传递参数**.

已确定有效方法之后, 使用传递给广义函数的传递参数调用它. 它返回的值作为广义函数的返回值.

#### 7.6.6.1 确定有效方法

使用下面三个步骤的过程确定有效方法:

- 选择可应用的方法
- 按优先级顺序排列可应用方法, 将最特殊的方法放在最前面
- 在已排序的可应用方法上应用方法组合, 生成有效方法

##### 7.6.6.1.1 选择可应用方法

这个步骤在**7.6.2 方法的介绍**中描述.

##### 7.6.6.1.2 按优先级顺序排列可应用方法

为比较两个方法的优先级, 按序检查它们的参数特化符. 默认的检查顺序是从左至右, 但可以使用`defgeneric`中`:argument-precedence-order`或其它指定广义函数选项的操作符指定其它顺序.

比较每个方法中相应的参数特化符. 当一对参数特化符一致时, 比较下一对的一致性. 如果所有相应的参数特化符均一致, 这两个方法必须有不同的限定符; 在这种情况下, 可以优先选择任意一个方法. 关于一致性的信息, 见**7.6.3 参数特化和限定的一致性**.

如果一些相应的参数特化符不一致, 第一对不一致的参数特化符确定优先级. 如果两个参数特化符是类, 两个方法中较特殊的一个是, 它的参数特化符在相应传递参数的类优先级列表中较早出现. 因为可应用方法被选择的方式, 可以保证参数特化符在传递参数的类的类优先级列表中出现.

如果一对相应的参数特化符中一个是`(eql object)`, 则有这个参数特化符的方法优先级较高. 如果两个参数特化符都是`eql`表达式, 则参数特化符必须一致(否则这两个方法不能应用于这个传递参数).

最终的可应用方法的列表中, 最特殊的在最前面, 最不特殊的在最后面.

##### 7.6.6.1.3 在已排序的可应用方法上应用方法组合

在简单的情况中, 即如果使用标准方法组合, 且所有可应用的方法都是主方法, 则有效方法是最特殊的方法. 这个方法可以使用函数`call-next-method`调用下一个最较特殊的方法. `call-next-method`调用的方法称为下一个方法. 谓词`next-method-p`检查是否存在下一个方法. 如果调用了`call-next-method`, 但不存在下一个最特殊的方法, 会调用广义函数`no-next-method`.

通常, 有效方法是可应用方法的组合. 这个组合是一个形式描述的, 形式中包含一些或全部可应用方法调用, 返回值作为广义函数的返回值, 可选的使用`call-next-method`调用一些方法.

有效方法中每个方法的角色是由它的限定符和特异性确定的. 限定符标记一个方法, 限定符的含义是由确定有效方法过程的步骤中使用标记的方式确定的. 如果一个可应用方法有不能识别的限定符, 这个步骤会发出错误信号, 同时不将这个方法纳入有效方法.

当标准方法组合与限定的方法一起使用时, 按**7.6.6.2 标准方法组合**中描述的方式生成有效方法.

其它类型的方法组合可以通过使用`defgeneric`的`:method-combination`选项或其它指定广义函数的选项的操作符指定. 按这种方法, 可以定制确定有效方法过程的这一步骤.

使用宏`define-method-combination`定义新的方法组合类型.

#### 7.6.6.2 标准方法组合

标准方法组合由类`standard-generic-function`支持. 在未指定其他方法组合类型或指定了内置的方法组合类型`standard`时使用.

主方法定义了有效方法的主要动作, 辅助方法修改这个主要动作. 主方法没有方法限定符.

辅助方法是限定符为`:before`、`:after`或`:around`的方法. 标准方法组合允许每个方法最多有一个限定符; 如果方法定义中指定了多个限定符, 发出错误信号.

- before方法有唯一限定符`:before`. before方法指定了在任何主方法之前执行的代码.
- after方法有唯一限定符`:after`. after方法指定了在主方法之后执行的代码.
- around方法有唯一限定符`:around`. around方法指定了替代其它可应用方法运行的代码, 它可以包含显式调用被遮盖方法的代码(通过`call-next-method`).

标准方法组合的语义如下:

- 如果有around方法, 调用最特殊的around方法. 它提供了广义函数的结果值.
- 在一个around方法体中, 可以使用`call-next-method`调用下一个方法. 当下一个方法返回时, around方法可以执行其它代码, 可能是基于下一个方法的返回值. 如果使用了`call-next-method`但没有可应用方法时, 调用广义函数`no-next-method`. 可以使用函数`next-method-p`确定是否有下一个方法存在.
- 如果一个around方法调用了`call-next-method`, 调用下一个最特殊的around方法(存在时). 如果没有around方法或者最不特殊的around方法调用了`call-next-method`, 会调用其它方法:  
    
- \– 按 **从最特殊到最不特殊** 的顺序, 调用所有before方法. 忽略它们的值. 如果在before方法中使用`call-next-method`, 发出错误信号.  
    
- \– 调用最特殊的主方法. 在主方法体中, 可以使用`call-next-method`调用下一个最特殊的主方法. 当这个方法返回时, 前一个主方法可以执行其它代码, 可能是基于返回的值. 如果使用了`call-next-method`但没有其它可应用的主方法时, 会调用广义函数`no-next-method`. 可以使用函数`next-method-p`确定下一个方法是否存在. 如果没有使用`call-next-method`, 只会调用最特殊的主方法.  
    
- \– 按 **从最不特殊到最特殊** 的顺序调用所有after方法. 忽略它们的值. 如果在after方法中使用`call-next-method`, 发出错误信号.  
    
- 如果没有调用around方法, 最特殊的主方法提供了广义函数的结果值. 在最不特殊的around方法中调用`call-next-method`返回的值, 是最特殊的主方法的返回值.

在标准方法组合中, 如果有一个可应用的方法, 但没有可应用的主方法, 发出错误信号.

before方法按从最特殊到最不特殊的顺序执行, after方法按从最不特殊到最特殊的顺序执行. 这样设计的原因可以通过一个示例展示. 假设类C1通过添加before方法和after方法, 修改了它的超类C2的行为. 类C2的形式是否由C2中方法直接定义的, 或者从它的超类中继承的, 不影响调用类C1的实例上方法的相对顺序. 类C1的before方法在C2所有方法之前执行. 类C1的after方法在C2所有方法之后执行.

与之相反, 所有around犯法在其他方法之前执行. 因此较不特殊的around方法在较特殊的主方法之前执行.

如果只使用了主方法, 没有使用`call-next-method`, 只会调用最特殊的方法; 即较特殊的方法遮盖了其它较通用的方法.

#### 7.6.6.3 声明性方法组合

宏`define-method-combination`定义了方法组合的新形式. 提供了定制生成有效方法的机制. 生成有效方法的默认过程在**7.6.6.1 确定有效方法**中阐述. 有两个形式的`define-method-combination`. 短形式是简单的工具, 而长形式能力更强且更复杂. 长形式编排`defmacro`的体为计算Lisp形式的表达式, 为在方法组合中实现任意控制结构以及任意处理方法限定符提供了机制.

#### 7.6.6.4 内置方法组合类型

对象系统提供了一组内置犯法组合类型. 为指定一个广义函数使用这些方法组合类型中的一个, 方法组合类型的名称作为`defgeneric`或其它指定广义函数的选项的操作的的`:method-combination`选项的传递参数.

图 7-2. 内置方法组合类型.

```
+
and
append
list
max
min
nconc
or
progn
standard
```

内置方法组合类型`standard`的语义在**7.6.6.2 标准方法组合**中阐述. 其他内置方法组合类型被称为 **简单的内置方法组合类型**.

简单的内置方法组合类型就像它们使用`define-method-combination`的短形式定义的. 它们识别方法的两个角色:

- 有关键字符号作为唯一限定符的around方法. `:around`方法的含义与标准方法组合中相同. around方法中支持函数`call-next-method`和`next-method-p`.
- 有方法组合类型名称作为唯一限定符的主方法. 例如, 内置方法组合类型`and`识别唯一限定符为`and`的方法; 这些是主方法. 主方法中不知吃使用函数`call-next-method`和`next-method-p`.

简单的内置方法组合类型的语义如下:

- 如果有around方法, 调用最特殊的around方法. 它提供了广义函数的结果值.
- 在around方法体中, 可以使用`call-next-method`调用下一个方法. 如果使用了`call-next-method`但没有可应用的方法时, 会调用冠以函数`no-next-method`. 可以使用函数`netx-method-p`确定下一个方法是否存在. 当下一个方法返回时, around方法执行其它代码, 可能基于这个返回值.
- 如果around方法调用`call-next-method`, 会调用下一个最特殊的around方法(存在时). 如果没有around方法或最不特殊的around方法调用了`call-next-method`, 从内置方法组合类型名称和可应用的主方法列表中导出的Lisp形式被求值, 生成广义函数的结果值.

假设方法组合类型的名称是`operator`, 对广义函数的调用是形式:

```
(generic-function a1...an)
```

`M1,...,Mk`是排序后的可应用的主方法, 则导出的Lisp形式是:

```
(operator <M1 a1...an>...<Mk a1...an>)
```

如果表达式`<M1 a1...an>`被求值, 方法`Mi`被应用在传递参数`a1...an`上. 例如, `operator`是`or`, 表达式`<Mi a1...an>`只在`<Mj a1...an>`(`1 <= j < i`)的求值结果为`nil`时求值.

主方法的默认顺序是`:most-specific-first`. 在将`:most-specific-last`作为`:method-combination`选项的第二个传递参数时, 取相反的顺序.

简单的内置方法组合类型要求每个方法有且只有一个限定符. 如果存在没有限定符或者有不被方法组合类型支持的限定符的可应用的方法时, 发出错误信号. 如果有可应用的around方法, 但没有可应用的主方法时, 发出错误信号.

### 7.6.7 方法继承

子类继承方法的含义是, 任何在类的所有实例中可应用的方法, 在它的任意子类的所有实例中可应用.

方法继承与创建方法的定义方法的描述符无关.

方法继承的详细描述见**7.6.6 方法选择和组合**.

## 7.7 对象的字典

- standard generic function **function-keywords**
- function **ensure-generic-function**
- standard generic function **allocate-instance**
- standard generic function **reinitialize-instance**
- standard generic function **shared-initialize**
- standard generic function **update-instance-for-different-class**
- standard generic function **update-instance-for-redefined-class**
- standard generic function **change-class**
- function **slot-boundp**
- function **slot-exists-p**
- function **slot-makunbound**
- standard generic function **slot-missing**
- standard generic function **slot-unbound**
- function **slot-value**
- standard generic function **method-qualifiers**
- standard generic function **no-applicable-method**
- standard generic function **no-next-method**
- standard generic function **remove-method**
- standard generic function **make-instance**
- standard generic function **make-instances-obsolete**
- standard generic function **make-load-form**
- function **make-load-form-saving-slots**
- macro **with-accessors**
- macro **with-slots**
- macro **defclass**
- macro **defgeneric**
- macro **defmethod**
- accessor **find-class**
- local function **next-method-p**
- local macro **call-method, make-method**
- local function **call-next-method**
- standard generic function **compute-applicable-methods**
- macro **define-method-combination**
- standard generic function **find-method**
- standard generic function **add-method**
- standard generic function **initialize-instance**
- standard generic function **class-name**
- standard generic function **(setf class-name)**
- function **class-of**
- condition **type unbound-slot**
- function **unbound-slot-instance**

# 8 结构

## 8.1 结构的字典

- macro `defstruct`
- function `copy-structure`

# 9 状况

## 9.1 状况系统的概念

Common Lisp的构造不仅是按在它们预期被使用的场景下的行为描述的(见每个操作符规范的 **Description** 部分), 也按其它场景描述(见每个操作符规范的 **Exceptional Situations** 部分).

**场景(situation)** 是在特定上下文中对表达式的求值过程. ==状况(conditon)== 是表示被检测到的特定场景的对象. 状况是类`condition`的通用实例. Common Lisp中定义了状况类的层次. 状况中有与它表示的场景相关的数据的槽.

**错误(error)** 是一个场景, 其中正常的程序执行在没有某种形式的干预(由用户或程序控制)时不能继续执行. 不是所有的错误都可被检测出的. 当一个错误不能被检测时, 它的作用是实现依赖的、实现定义的、未描述的或未定义的. 见**1.4 定义**. 所有可被检测出的错误可以用状况表示, 但不是所有状况表示错误.

**发出(signaling)** 是一个过程, 过程中通过抛出可被后续处理的状况来修改程序的控制流. 函数`error`、`cerror`、`signal`和`warn`可用于发出状况.

发布过程包括从一组活跃处理器中选择和调用一个处理器. **处理器(handler)** 是一个只有一个状况传递参数的函数, 用于处理状况. 每个处理器与一个状况类型关联, 一个处理器只在处理器关联的类型的状况上调用.

**活跃处理器** 是动态建立的(见`handler-bind`或`handler-case`). 处理器在与状况发出者等价的动态环境中被调用, 除了那些已特殊方式绑定的活跃处理器: 只包含在建立被调用的处理器时的活跃处理器. 发出状况在状况上没有副作用, 状况中没有动态字段.

如果处理器被调用, 它按如下方式处理状况:

- 拒绝(Decline): 拒绝处理状况: 简单的返回而不是转移控制. 这种情况下, 处理器的返回值被忽略, 调用下一个最近建立的处理器. 如果没有这样的处理器, 发出函数是`error`或`cerror`, 在发出者的动态环境中进入调试器. 如果没有这样的处理器, 发出函数是`signal`或`warn`, 发出函数返回`nil`.
- 处理(Handle): 通过执行非本地控制转移来处理状况, 可以是`go`、`return`、`throw`或`abort`、`invoke-restart`.
- 退出(Defer): 通过一组动作延期是否处理还是拒绝的决定, 这些动作通常是发出其它状况、重新发出同一状况或者强制进入调试器.

### 9.1.1 状况类型

下图列举了标准状况类型. 可以使用`define-condition`定义额外的状况类型.

图 9-1. 标准状况类型.

```
arithmetic-error
cell-error
condition
control-error
division-by-zero
end-of-file
error
file-error
floating-point-inexact
floating-point-invalid-operation
floating-point-overflow
floating-point-underflow
package-error
parse-error
print-not-readable
program-error
reader-error
serious-condition
simple-condition
simple-error
simple-type-error
simple-warning
storage-condition
stream-error
style-warning
type-error
unbound-slot
unbound-variable
undefined-function
warning
```

所有的状况类型是类型`condition`的子类型, 即: 当且仅当`c`是一个状况,

```
(typep c 'condition) => true
```

实现必须定义所有描述的子类型关系. 除非特殊说明, 该文档中所有的子类型关系不是互斥的. 状况继承它的超类型的结构.

类`condition`的元类未指定. 状况类型的名称可用于在`define-conditon`中指定超类型关系, 但尝试在`defclass`形式中将状况类型作为超类的后果是未描述的.

下图展示了定义状况类型和创建状况的操作符:

图 9-2. 定义和创建状况的操作符.

```
define-condition
make-condition
```

下图展示了读取状况槽值的操作符:

图 9-3. 读取状况操作的操作符.

```
arithmetic-error-operands
arithmetic-error-operation
cell-error-name
file-error-pathname
package-error-package
print-not-readable-object
simple-condition-format-arguments
simple-condition-format-control
stream-error-stream
type-error-datum
type-error-expected-type
unbound-slot-instance
```

#### 9.1.1.1 严重的状况

\==严重的状况== 是严重到未处理时需要交互式干预的状况. 典型的严重的状况是由`error`或`cerror`发出的; 非严重的状况是由`signal`或`warn`发出的.

### 9.1.2 创建状况

函数`make-condition`可用于显式的构造状况对象. 诸如`error`、`cerror`、`signal`和`warn`操作状况, 可能隐式的创建状况对象. 诸如`ccase`、`ctypecase`、`ecase`、`etypecase`、`check-type`和`assert`可能隐式的创建(和发出)状况.

#### 9.1.2.1 状况指示器

状况系统中的一些函数有称为状况指示器的传递参数. 通常这些传递参数记为:

```
datum &rest arguments
```

`datum`和`arguments`是默认类型`default-type`的状况的指示器. 被表示的状况是依赖于`datum`的类型计算出的:

- 如果`datum`是一个命名了状况类型的符号

被表示的状况是`(apply #'make-condition datum arguments)`的结果.

- 如果`datum`是一个格式化控制

被表示的状况是`(make-condition defaulted-type :format-control datum :format-arguments arguments)`的结果, 这里`defaulted-type`值`default-type`的子类型.

- 如果`datum`是一个状况

被表示的状况是`datum`自身. 在这种情况中, 除非在相关的操作符的描述中特别说明, `argument`必须为空; 即提供`arguments`的后果是未定义的.

注意到`default-type`只在提供`datum`字符串时使用. 在其它情况下, 结果状况不一有类型`default-type`.

这些例子显示不同的状况指示器可以表示等价的状况对象:

```
(let ((c (make-condition 'arithmetic-error :operator '/ :operands '(7 0))))
  (error c))
==  (error 'arithmetic-error :operator '/ :operands '(7 0))

(error "Bad luck.")
==  (error 'simple-error :format-control "Bad luck." :format-arguments '())
```

### 9.1.3 打印状况

如果`define-conditon`使用了`:report`传递参数, 则定义了一个打印函数, 每当定义的函数被打印时且`*print-escape*`是false时, 会调用这个打印函数. 这个函数称为 ==状况报告器==; 它输出的文本称为报告信息.

当打印状况且`*print-escape*`是false时, 会调用该状况的状况打印器. 状况被诸如函数`invoke-debugger`、`break`和`warn`自动打印.

当`*print-escape*`是true时, 应该根据实现风格中简略方式打印对象(`print-unreadble-object`). 不要求读取窗框的打印表示时重建状况.

没有提供直接访问或调用状况报告器的函数.

#### 9.1.3.1 状况报告的推荐风格

为确保将报告信息美观的呈现给用户, 这里推荐一些风格性约定.

有状况报告器输出消息的内容的风格推荐, 但没有对程序的形式化要求. 如果程序违背了推荐的消息风格, 输出的消息可能是不美观的, 但程序仍然是复合标准的程序.

对调用状况报告器的程序或实现的要求是有些高. 必须复合标准的程序做出假设: 如果遵循了这些风格指南, 会保持一定程度的美观. 下面显式的列出对这种程序的要求.

##### 9.1.3.1.1 状况报告中的大小写和标点符号

推荐报告消息是一个完整的句子, 有合适的大小写和标点符号. 在英文中, 这意味着首字母应该大写, 尾部应该有个点号.

```
(error "This is a message")  ; 不推荐
(error "this is a message.") ; 不推荐

(error "This is a message.") ; 推荐
```

##### 9.1.3.1.2 状况报告中的首尾新行

推荐报告消息不以介绍性文本开始, 例如`Error:` 或`Warning:` 或新行. 可以在调用状况报告器的例程上下文中添加这中文本.

推荐报告消息最后没有新行. 可以在调用状况报告器的例程上下文中添加这中文本.

```
(error "This is a message.~%")   ; 不推荐
(error "~&This is a message.")   ; 不推荐
(error "~&This is a message.~%") ; 不推荐

(error "This is a message.")     ; 推荐
```

##### 9.1.3.1.3 状况报告中的内嵌新行

当报告消息过长时, 可以内嵌一个或多个新行.

如果调用例程在消息的第一行插入一些前缀(例如`Error:` 或`;; Error:` ), 必须确保输出中后续行中有合适的前缀, 从而输出消息的左端会对齐.

```
(defun test ()
  (error "This is an error message.~%It has two lines."))

;; Implementation A
(test)
This is an error message.
It has two lines.

;; Implementation B
(test)
;; Error: This is an error message.
;;        It has two lines.

;; Implementation C
(test)
>> Error: This is an error message.
          It has two lines.
```

##### 9.1.3.1.4 状况报告中的`<Tab>`

因为报告消息中的缩进可能被左移或右移, 使用版标准字符`<Tab>`时需要特别注意. 除非实现描述了它在这个上下文中行为, 否则应该避免使用.

##### 9.1.3.1.5 状况报告中的涉及函数

涉及函数名称通常不应该出现在报告消息中. 调试器会在必要时显示这个信息.

### 9.1.4 发出和处理状况

状况系统中的操作依赖于从最近到最远排序的活跃的可应用处理器.

每个处理器与一个类型描述符关联, 这个类型描述符必须指定类型`condition`的一个子类型. 如果一个状况的类型是一个处理器关联的类型描述符指定的类型, 称 **这个处理器可用于这个状况**.

使用`handler-bind`(或者在`handler-bind`上的抽象, 例如`handler-case`或`ignore-errors`), 建立活跃处理器.

活跃处理器可以在其它活跃处理器的动态作用域中建立. 在程序执行中的任意一点, 有一个活跃处理器的集合. 当发出一个状况时, 从这个集合中选择与这个状况关联的最近的活跃的可应用的处理器. 给定一个状况, 活跃的可应用的处理器的相近性顺序是由下述两个规则定义的:

1. 活跃处理器集合H1和H2, 如果建立H1中处理器时, H2中处理器是活跃的, 则H1中每个处理器与H2中每个处理器相比, 更近.
2. h1和h2是使用同一个形式建立的两个个可应用的活跃的处理器, 如果在形式中h1在h2左边家里, 则h1比h2更近.

一旦在处理器绑定形式(例如`handler-bind`或`handler-case`)中选择了一个处理器, 在后续的发出过程中, 这个形式中的所有处理器变为不活跃的. 当被选择的处理器运行时, 这个形式建立的其它处理器都不是活跃的. 即, 如果这个处理器拒绝处理状况, 这个形式建立的其它处理器不可为调用.

下图展示了与处理状况相关的操作符:

图 9-4. 与处理状况相关的操作符.

```
handler-bind
handler-case
ignore-errors
```

#### 9.1.4.1 发出

当状况被发出时, 会调用最近的可应用的活跃的处理器. 有时处理器会通过简单返回而不转移控制拒绝处理. 在这种情况中, 下一个最近的可应用的活跃的处理器被调用.

如果发出了一个没有可应用的处理器的状况, 或者所有可应用的处理器拒绝处理, 这个状况未被处理.

不管发出的状况的类型, 如果是未处理的, 函数`cerror`和`error`会调用交互式状况处理器(调试器)而不是返回. 与之相反, 不管发出的状况的类型, 如果是未处理的, 函数`signal`返回`nil`.

变量`*break-on-signals*`可用于在开始发出过程之前进入调试器.

下图展示了与发出状况相关的已定义名称.

图 9-5. 与发出状况相关的已定义名称.

```
*break-on-signals*
cerror
error
signal
warn
```

##### 9.1.4.1.1 重新发出状况

在发出特定状况对象过程的动态extent时, 允许再次发出同一个状况对象, 当且仅当两种情形中表达式的场景相同.

例如, 一个处理器可以合法的发出作为参数的状况对象, 允许外部处理器处理这个状况(这种处理器有时称为默认处理器). 这个动作被允许的原因是第二个发出过程处理的场景是同一场景.

另一方面, 在通过调用`signal`中断用户进程实现了异步键盘事件的实现中, 对不同场景, 不允许两个不同的异步键盘事件同一发出同一个状况对象.

#### 9.1.4.2 重启

交互式状况处理器只可以通过非本地的将控制转移到特别定义的重启器返回, 重启器可以是系统或用户代码设置的. 将控制转移到重启器被称为调用重启器. 与处理器类似, 活跃的重启器是动态建立的, 只能调用活跃的处理器. 活跃的重启器可以被用户从调试器或者被使用`invoke-restart`的程序调用.

重启器包含一个当它被调用是调用的函数、一个可选的可用于查找和调用重启器的名称、一组可选的调试器为用户提供的手动调用重启器的交互式信息.

重启器的名称被`invoke-restart`使用. 只在调试器中被调用的重启器不需要名称.

可以使用`restart-bind`、`restart-case`和`with-simple-restart`建立重启器. 一个重启器函数自身可以调用另一个在建立该函数所属的重启器时活跃的重启器.

通过`restart-bind`形式、`restart-case`形式或`with-simple-restart`形式建立的重启器, 有扩展形式执行周期的动态extent.

有相同名称的重启器可以依据如下规则按最远到最近排序:

1. 如果当活跃重启器集R1中重启器建立时, 重启器集R2中重启器都是活跃的, 则R1中每个重启器比R2中每个重启器近;
2. r1和r2是由同一个形式建立的相同名称的活跃处理器, 如果在形式中r1在r2左边定义, 则r1比r2近.

如果一个重启器被调用, 但没有转移控制, 则调用重启器的函数(`invoke-restart`或`invoke-restart-interactively`)返回重启器函数的结果值.

##### 9.1.4.2.1 重启的交互式使用

对于交互式处理, 需要重启器的两类信息: 报告函数和交互函数.

报告函数被诸如调试器的称为使用, 以表示重启器将采取的动作的描述. 报告函数通过`restart-bind`的关键字参数`:report-function`或`restart-case`的关键字参数`:report`指定和建立.

交互式函数, 可以使用`restart-bind`的关键字参数`:interactive-function`或`restart-case`的关键字参数`:interactive`指定; 用于注入调试器交互式调用重启器时, 已生成一个恰当的传递参数列表.

`invoke-restart`调用最近建立的重启器, 该重启器的名称与其第一个传递参数相同. 如果重启器被调试器交互式的调用, 没有转移控制但返回值, 调试器在这些值上的详细动作是依赖于实现的.

##### 9.1.4.2.2 重启的接口

一个重启器有功能性接口, 例如`abort`、`continue`、`muffle-warning`、`store-value`和`use-value`. 它们是内部使用`find-restart`和`invoke-restart`的常规函数, 但有与它们操作的重启器相同的名称.

下图展示了与重启器相关的已定义名称.

图 9-6. 与重启器相关的已定义名称.

```
abort
compute-restarts
continue
find-restart
invoke-restart
invoke-restart-interactively
muffle-warning
restart-bind
restart-case
restart-name
store-value
use-value
with-simple-restart
```

##### 9.1.4.2.3 重启的测试

每个重启器有关联的测试, 它是有一个传递参数(一个状况或`nil`)的函数, 在重启器应该在当前场景中可见时返回true. 这个测试可以用`restart-bind`的选项`:test-function`或`restart-case`的选项`:test`创建.

##### 9.1.4.2.4 关联重启与状况

重启器可以与状况关联, 用`with-conditon-restarts`显式的关联, 或者用`restart-case`隐式的关联. 这种关联有动态extent.

单个重启器可以同时与多个状况关联. 单个状况可以同时与多个重启器关联.

与特定状况关联的活跃重启器, 可以通过调用诸如`find-restart`的函数获得, 将状况作为状况传递参数. 不关心是否有关联的状况时, 可以使用这种不带状况传递参数或状况传递参数为`nil`, 获取活跃的重启器.

### 9.1.5 断言

在键匹配、形式求值和类型上条件的发出状况, 使用断言操作符处理的. 下图展示了与断言相关的操作符.

图 9-7. 与断言相关的操作符.

```
assert
ccase
check-type
ctypecase
ecase
etypecase
```

### 9.1.6 备注: 状态系统的背景

本节描述的抽象概念的背景信息见 **Exceptional Situations in Lisp**[^1]. 这个文章的细节不与本文档绑定, 但可以为理解这些材料建立概念基础提供帮助.

[^1]: [https://www.nhplace.com/kent/Papers/Exceptional-Situations-1990.html](https://www.nhplace.com/kent/Papers/Exceptional-Situations-1990.html)

## 9.2 状况的字典

- condition type `condition`
- condition type `warning`
- condition type `style-warning`
- condition type `serious-condition`
- condition type `error`
- condition type `cell-error`
- function `cell-error-name`
- condition type `parse-error`
- condition type `storage-condition`
- macro `assert`
- function `error`
- function `cerror`
- macro `check-type`
- condition type `simple-error`
- function `invalid-method-error`
- function `method-combination-error`
- function `signal`
- condition type `simple-condition`
- function `simple-condition-format-control`
- function `warn`
- condition type `simple-warning`
- function `invoke-debugger`
- function `break`
- variable `*debugger-hook*`
- variable `*break-on-signals*`
- macro `handler-bind`
- macro `handler-case`
- macro `ignore-errors`
- macro `define-condition`
- function `make-condition`
- system class `restart`
- function `compute-restarts`
- function `find-restart`
- function `invoke-restart`
- function `invoke-restart-interactively`
- macro `restart-bind`
- macro `restart-case`
- function `restart-name`
- macro `with-condition-restarts`
- macro `with-simple-restart`
- restart `abort`
- restart `continue`
- restart `muffle-warning`
- restart `store-value`
- restart `use-value`
- function `abort`

# 10 符号

## 10.1 Symbol Concepts

下图列出了一些可用于符号的属性列表(property list)的已定义名称:

图 10-1. 属性列表的已定义名称.

```
get
remprop
symbol-plist
```

下图给出了一些可用于创建和探究符号的已定义名称:

图 10-2. 符号创建和探究的已定义名称.

```
copy-symbol
gensym
gentemp
keywordp
make-symbol
symbol-name
symbol-package
symbol-value
```

## 10.2 符号的字典

- system class `symbol`
- type `keyword`
- function `symbolp`
- function `keywordp`
- function `make-symbol`
- function `copy-symbol`
- function `gensym`
- variable `*gensym-counter*`
- function `gentemp`
- accessor `symbol-function`
- function `symbol-name`
- function `symbol-package`
- accessor `symbol-plist`
- accessor `symbol-value`
- accessor `get`
- function `remprop`
- function `boundp`
- function `makunbound`
- function `set`
- condition type `unbound-variable`

# 11 包

## 11.1 包的概念

### 11.1.1 包的介绍

**包**建立了名称到符号的映射. 任意时刻都有一个当前包, 当前包是`*package*`的值. 使用Lisp读取器时, 可能通过符号的打印表示中包前缀, 引用不在当前包的包中符号.

下图列出了可用于包的已定义名称. 当操作符有符号或符号列表传递参数时, 传递参数`nil`被视为符号的空列表. 任意包传递参数可以是字符串、符号或包. 如果指定了一个符号, 它的名称被用作包名称.

图 11-1. 与包相关的一些已定义名称.

```
*modules*
*package*
defpackage
do-all-symbols
do-external-symbols
do-symbols
export
find-all-symbols
find-package
find-symbol
import
in-package
intern
list-all-packages
make-package
package-name
package-nicknames
package-shadowing-symbols
package-use-list
package-used-by-list
provide
rename-package
require
shadow
shadowing-import
unexport
unintern
unuse-package
use-package
```

#### 11.1.1.1 包的名称和昵称

每个包有一个名称(一个字符串), 可能有一些昵称(也是字符串). 在包创建时赋值名称, 后续可修改.

包有一个命名空间. 函数`find-package`将包的名称或昵称转换为相应的包. 函数`package-name`返回包的名称. 函数`package-nicknames`返回包的一个所有昵称的列表. `rename-package`移除包的当前名称和昵称, 替换为调用者指定的新名称和昵称.

#### 11.1.1.2 包中符号

##### 11.1.1.2.1 内部和外部符号

包中的映射被分为两类: 内部的和外部的. 作为这些不同映射类型的符号分别称为包的 ==外部符号== 和 ==内部符号==. 在包中, 一个名称引用一个符号或不引用一个符号; 如果不引用一个符号, 则它是在包中或包外, 但不能两者都是. 外部符号是包对其它包的公开接口部分. 如果符号在给定包中被导出, 则该符号成为这个包的 **外部符号**.

不管符号在哪个包中, 总是有相同的名称, 但可以是一些包的外部符号以及另一些包的内部符号.

##### 11.1.1.2.2 包继承

可以按层次构建包. 某种程度上, **包** 是从字符串到内部符号和外部符号的映射的集合. 然而, 可以在包中建立一部分这些映射, 通过`use-package`从其它包中继承其它映射. 称一个符号 ==出现(present)== 在一个包中, 如果映射是在这个包中, 而不是从其它包继承的.

无法从另一个包中继承其内部符号, 使用Lisp读取器引用一个内部符号时, 包含该符号的包必须是当前包、必须使用包前缀, 或者该符号被导入当前包.

##### 11.1.1.2.3 包中符号的可访问性

符号在包中变为可访问的, 如果该包是符号创建时的 ==主包==, 或者被导入该包中, 或者通过`use-package`继承.

符号在包中是可访问的, 当该包是当前包时, 可以不带包前缀使用Lisp读取器引用这个符号, 不管它是否在包中出现或是继承的.

可以通过两种方法, 将一个包中的符号在另一个包中变为可访问的:

- 使用`import`将单个符号添加到包中. 调用`import`后, 该符号 **出现** 在执行导入的包中. 符号在来源包中的状态未改变, 符号的主包未改变. 一旦被引入, 符号出现在指定导入的包中, 只可以使用`unintern`移除.

在一些包中, 一个符号被另一个符号遮盖, 如果不是因为第二个符号的出现, 第一个符号可以通过继承被访问. 见`shadowing-import`.

- 第二个机制是使用`use-package`. 被使用的包中所有外部符号被使用包继承. 函数`unuse-package`撤销之前`use-package`的作用.

##### 11.1.1.2.4 在包中定位符号

当在给定包中定位符号时, 有:

- 在包的外部符号和内部符号中搜索该符号
- 按未描述的顺序在被使用的包的外部符号中搜索该符号. 顺序并不重要, 见下面处理名称冲突的规则.

##### 11.1.1.2.5 避免包中名称冲突

在一个包中, 任意一个名称可以引用至多一个符号. 当有多于一个的候选符号时, 发生 ==名称冲突==. 每当名称冲突出现时, 发出可修复错误信号.

使用下面的规则处理名称冲突:

- 只在可能发生名称冲突时检测, 即当包结构修改时. 不会在名称查找时检测名称冲突.
- 如果一个符号可以通过多个路径被一个包访问, 则不存在名称冲突. 一个符号不与自身冲突. 名称冲突只发生在相同名称(`string=`语义下)的不同符号间.
- 每个包有一组遮盖符号. 遮盖符号优先于包中其它相同名称的符号. 包含遮盖符号的冲突总是使用遮盖符号解决, 不发出错误信号(除了一个使用`import`的异常情况). 见`shadow`和`shadowing-import`.
- 函数`use-package`、`import`、`export`会检查名称冲突.
- `shadow`和`shadowing-import`从不会发出名称冲突错误信号.
- `unuse-package`和`unexport`不需要执行名称冲突检测. `unintern`只在被非内部化的符号是遮盖符号时, 执行名称冲突检测.
- 非内部化遮盖符号, 可能暴露之前通过遮盖解决的名称冲突.
- 包函数在修改包结构前发出类型为`package-error`的名称冲突错误信号. 有多个修改时, 允许实现分别处理每个修改. 例如, 给`export`传递一个符号的列表, 因第二个符号产生名称冲突而导致退出时, 第一个符号可能仍被导出. 然而, `export`单个符号产生的名称冲突错误, 会在这个符号在任意包中可访问行被修改前发出.
- 从名称冲突错误继续处理, 必须给用户提供使用备选解决名称冲突的机会. 必须通过`shadowing-import`、`unintern`或`unexport`修改包结构, 以反映解决了名称冲突.
- 使用`use-package`的在使用包中出现的符号与被使用包中外部符号之间的名称冲突, 或者优先将第一个符号设置为遮盖符号解决, 或者优先在使用包中将第一个符号内部化解决.
- 因为使用`export`或`unintern`, 一个包从两个包中继承相同名称(`string=`语义下)的两个不同符号产生的名称冲突, 可以通过优先将一个符号导入使用包中将其设置为遮盖符号, 就像`use-package`, 来解决冲突.

### 11.1.2 标准包

这一节描述在每个符合标准的实现中可用的包. 下图给出了这些标准包的名称和昵称.

图 11-2. 标准包名称.

```
名称               昵称
COMMON-LISP       CL
COMMON-LISP-USER  CL-USER
KEYWORD           none
```

#### 11.1.2.1 COMMON-LISP包

COMMON-LISP包中包含由该规范定义的Common Lisp系统中原语. 它的外部符号包括在Common Lisp系统中出现的所有已定义名称(除了KEYWORD包中的已定义名称), 例如`car`、`cdr`、`*package*`等. COMMON-LISP包昵称是`CL`.

COMMON-LISP包的外部符号均在**1.9 COMMON-LISP包中的符号**中. 这些外部符号出现在COMMON-LISP包中, 但它们的主包不一定是COMMON-LISP包.

例如, 符号`HELP`不能是COMMON-LISP包的外部符号, 因为它不在**1.9 COMMON-LISP包中的符号**中. 与之相反, 符号`variable`一定是COMMON-LISP包的外部符号, 尽管没有定义(作为函数`documentation`有效的第二个参数.)

COMMON-LISP包可以有其他内部符号.

##### 11.1.2.1.1 符合标准的实现中COMMON-LISP包的约束

在符合标准的实现中, COMMON-LISP包的外部符号可以有函数、宏或特殊操作符定义, 或全局变量定义(或用`special`公告的动态变量), 或在该标准中显式允许的类型定义. 例如`foundp`对COMMON-LISP包中不是标准函数、宏或特殊操作符的外部符号返回false, `boundp`对COMMON-LISP包不是标准全局变量的外部符号返回false. 允许符合标准的实现将COMMON-LISP包中外部符号用作本地才发变量, 在确定这些名称未被实现使用`special`公告, 且这些符号不是标准全局变量的名称时.

符合标准的实现必须不能在COMMON-LISP包的外部符号上使用属性指示器放置属性, 属性指示器包括任意标准包的外部符号, 或者COMMON-LISP包中可访问的符号.

##### 11.1.2.1.2 符合标准的程序中COMMON-LISP包的约束

除非特别支持, 如果在COMMON-LISP包的外部符号上执行下面动作的后果是未定义的.

1. 绑定或修改它的值(词法或动态的). (下面有一些例外情况)
2. 作为函数定义、解除定义或绑定. (下面有一些例外情况)
3. 作为宏或编译器宏定义、解除定义或绑定. (下面有一些例外情况)
4. 作为类型描述符定义(使用`defstruct`、`defclass`、`deftype`, `def-condition`).
5. 作为结构定义(使用`defstruct`).
6. 使用`declaration`公告, 作为声明定义.
7. 作为符号宏定义.
8. 修改它的主包.
9. 对它使用`trace`.
10. 将其声明或公告为`special`(通过`declare`、`declain`或`proclaim`).
11. 声明或公告它的`type`或`ftype`(通过`declar`、`declaim`或`proclaim`).(下面有一些例外情况).
12. 从COMMON-LISP包中移除.
13. 为它定义setf扩展器(通过`defsetf`或`define-setf-method`).
14. 定义、解除定义或绑定它的setf函数名称.
15. 作为方法组合定义(通过`define-method-combination`).
16. 作为`find-class`的`setf`的类名称参数使用.
17. 作为捕获标签绑定.
18. 作为重启器名称绑定.
19. 给标准广义函数定义方法, 该标准广义函数在所有参数是标准类的不同实例时可应用.

###### 11.1.2.1.2.1 符合标准的程序中COMMON-LISP包的约束的一些例外

如果COMMON-LISP包的外部符号不是全局定义为动态变量或常值变量, 允许词法绑定它, 声明该绑定的类型, 允许本地将它简历未符号宏(使用`symbol-macrolet`).

除非特别指出, 如果COMMON-LISP包的外部符号被全局的定义为标准动态变量, 在保证动态变量的值类型约束条件下, 允许绑定或赋值该动态变量, 变量的新值与变量被描述的意图一致.

如果COMMON-LISP包的外部符号没有被定义为标准函数、宏或特殊操作符, 允许词法绑定它到函数(使用`flet`), 声明该绑定的的`ftype`, 在该绑定上调用`trace`(实现支持时).

如果COMMON-LISP包的外部符号没有被定义为标准函数、宏或特殊操作符, 允许词法绑定它到宏(使用`macrolet`).

如果COMMON-LISP包的外部符号没有被定义为标准函数、宏或特殊操作符, 允许词法绑定它的setf函数名称到函数, 声明该绑定的`ftype`.

#### 11.1.2.2 COMMON-LISP-USER包

COMMON-LISP-USER包是当Common Lisp系统启动时的当前包. 这个包使用COMMON-LISP包. COMMON-LISP-USER包有昵称`CL-USER`. COMMON-LISP-USER包可以有额外的内部符号, 可以使用其他实现定义的包.

#### 11.1.2.3 KEYWORD包

KEYWORD包中有被称为 ==关键字== 的符号, 常被用作程序中特殊标记和相关联的数据表达式.

以包记号开始的符号记号被Lisp读取器解析为KEYWORD包中符号, 见**2.3.4 符号记号**. 这为在不同包中的程序间使用关键字通信提供了遍历. 例如, 在调用中传递关键字参数的机制使用关键字命名相应的传递参数, 见**3.4.1 常规lambda列表**.

KEYWORD包中符号的类型是`keyword`.

##### 11.1.2.3.1 在KEYWORD包中内部化符号

KEYWORD包与其它包不同的地方在于, 将符号在这个包中内部化时使用特殊处理. 通常, 在KEYWORD包中内部化符号时, 自动将其设置为外部符号, 自动设置为值为自身的常值变量.

##### 11.1.2.3.2 备注: KEYWORD包

通常最好将关键字的使用限定在有限可枚举的名称上. 例如, 如果有两个开关状态, 可以定义`:on`和`:off`.

在名称不是有限可枚举时(可能发生名称冲突), 通常最好使用KEYWORD包之外的包, 这样可以自然的避免冲突. 例如, 通常程序不应该将关键字作为属性指示器, 因为如果另一个程序做了同样的事情, 会互相影响数据.

#### 11.1.2.4 实现定义的包

初始Common Lisp环境中可以有实现定义的包.

推荐但不要求, 符合标准的实现有在该实现中但不在该规范中描述的包名称的完整列表(见函数`list-all-packages`).

## 11.2 包的字典

- system class `package`
- function `export`
- function `find-symbol`
- function `find-package`
- function `find-all-symbols`
- function `import`
- function `list-all-packages`
- function `rename-package`
- function `shadow`
- function `shadowing-import`
- function `delete-package`
- function `make-package`
- macro `with-package-iterator`
- function `unexport`
- function `unintern`
- macro `in-package`
- function `unuse-package`
- function `use-package`
- macro `defpackage`
- macro `do-symbols`
- function `intern`
- function `package-name`
- function `package-nicknames`
- function `package-shadowing-symbols`
- function `package-use-list`
- function `package-used-by-list`
- function `packagep`
- variable `*package*`
- condition type `package-error`
- function `package-error-package`

# 12 数值

## 12.1 数值的概念

### 12.1.1 数值操作

Common Lisp提供了大量与数值相关的操作. 这一节提供了这些操作的概览, 将它们分组以体现它们之间的关系.

图 12-1. 与算术相关的操作符.

```
*
+
-
/
1+
1-
conjugate
decf
gcd
incf
lcm
```

图 12-2. 与指数、对数和三角学相关的已定义名称.

```
abs
acos
acosh
asin
asinh
atan
atanh
cis
cos
cosh
exp
expt
isqrt
log
phase
pi
signum
sin
sinh
sqrt
tan
tanh
```

图 12-3. 数值比较和谓词操作符.

```
/=
<
<=
=
>
>=
evenp
max
min
minusp
oddp
plusp
zerop
```

图 12-4. 数值类型操作和转换相关的已定义名称.

```
ceiling
complex
decode-float
denominator
fceiling
ffloor
float
float-digits
float-precision
float-radix
float-sign
floor
fround
ftruncate
imagpart
integer-decode-float
mod
numerator
rational
rationalize
realpart
rem
round
scale-float
truncate
```

#### 12.1.1.1 数值操作中的可结合性和可交换性

对数学意义上可结合(可交换)的函数, 符合标准的实现可以按与可结合(可交换)重排一致的方式处理传递参数. 这并不影响传递参数求值的顺序; 关于求值顺序的讨论见**3.1.2.1.2.3 函数形式(Function Forms)**. 只是传递参数的值如何被处理的顺序未描述. 这意味着实现在自动转型上存在差异, 见**12.1.1.2 数值操作中的传播**.

符合标准的实现可以显式的将操作分隔为不同的(可能内嵌的)函数形式, 或者显式调用执行转型的函数, 来控制处理顺序.

##### 12.1.1.1.1 示例: 数值操作中的可结合性和可交换性

考虑下面的表达式, 假设`1.0`和`1.0e-15`表示单精度浮点数:

```
(+ 1/3 2/3 1.0d0 1.0 1.0e-15)
```

一个符合标准的实现可以按从左至右的顺序处理传递参数, 首先执行`1/3`与`2/3`相加获得`1`, 将其转换为双精度浮点数以与`1.0d0`相加, 后续转换并加上`1.0`和`1.0e-15`.

另一个符合标准的实现可以按从右至左的顺序处理床底参数, 首先执行`1.0`与`1.0e-15`单精度浮点数假发(可能在处理中丢失精度), 将其和转换为双精度浮点数以加上`1.0d0`, 然后将`2/3`转换为双精度浮点数并相加, 再将`1/3`转换为双精度浮点数并相加.

第三个符合标准的实现可以首先扫描所有传递参数, 首先处理所有有理数以精确计算这一部分, 然后找到有最大浮点数格式中传递参数并相加, 然后加上所有其他传递参数, 依次转换(可能是为保持计算尽可能精确的错误尝试).

在任何情况下, 这三个策略都是合法的.

符号标准的程序可以通过(使用括号)控制顺序, 例如:

```
(+ (+ 1/3 2/3) (+ 1.0d0 1.0e-15) 1.0)
```

#### 12.1.1.2 数值操作中的传播

数值操作中隐式的传递参数转型的传播规则, 见**12.1.4.4 浮点数精度传播规则**、**12.1.4.1 浮点数和有理数传播规则**、**12.1.5.2 复数传播规则**.

#### 12.1.1.3 将整数视为位和字节

##### 12.1.1.3.1 整数上的逻辑操作

逻辑操作要求整数作为传递参数, 如果提供的一个传递参数不是整数时, 应该发出类型为`type-error`的错误信号. 逻辑操作的整数传递参数被视为使用补码表示.

下图列出了与数值上逻辑操作相关的已定义名称.

图 12-5. 与数值上逻辑操作相关的已定义名称.

```
ash
boole
boole-1
boole-2
boole-and
boole-andc1
boole-andc2
boole-c1
boole-c2
boole-clr
boole-eqv
boole-ior
boole-nand
boole-nor
boole-orc1
boole-orc2
boole-set
boole-xor
integer-length
logand
logandc1
logandc2
logbitp
logcount
logeqv
logior
lognand
lognor
lognot
logorc1
logorc2
logtest
logxor
```

##### 12.1.1.3.2 整数上的字节操作

字节操作函数使用称为字节描述符的对象指定整数中特定字节的大小和位置. 字节描述符的表示是依赖于实现的, 可以是也可以不是一个数值. 函数`byte`构造一个字节描述符, 可被其他字节操作函数接受.

下图列出了与操作数值中字节相关的已定义名称.

图 12-6. 与操作数值中字节相关的已定义名称.

```
byte
byte-position
byte-size
deposit-field
dpb
ldb
ldb-test
mask-field
```

### 12.1.2 依赖于实现的数值常量

下图列出了与关于数值的依赖于实现的细节相关的已定义名称.

图 12-7. 与关于数值的依赖于实现的细节相关的已定义名称.

```
double-float-epsilon
double-float-negative-epsilon
least-negative-double-float
least-negative-long-float
least-negative-short-float
least-negative-single-float
least-positive-double-float
least-positive-long-float
least-positive-short-float
least-positive-single-float
long-float-epsilon
long-float-negative-epsilon
most-negative-double-float
most-negative-fixnum
most-negative-long-float
most-negative-short-float
most-negative-single-float
most-positive-double-float
most-positive-fixnum
most-positive-long-float
most-positive-short-float
most-positive-single-float
short-float-epsilon
short-float-negative-epsilon
single-float-epsilon
single-float-negative-epsilon
```

### 12.1.3 有理数计算

这一节的规则应用于有理数计算.

#### 12.1.3.1 未绑定的有理数精度规则

因为整数和比值可以是任意量级, 通常有理数计算不能上溢(尽管可能没有足够的表示结果的存储空间).

#### 12.1.3.2 有理数的标准表示规则

如果计算产生的结果是两个整数的数学比值, 分子能够整除分母, 则结果会被转换为等价的整数.

如果分子不能整除分母, 有理数的标准表示是比值, 该比值的分子和分母的最大公约数是1, 分子为大于1的正数.

`-0`作为输入(默认语法下), 总是表示整数`0`. 符合标准的实现中, 整数负零与整数零不能有不同的表示. 然而对浮点数这种不同是可以存在的, 见类型`float`.

#### 12.1.3.3 浮点数可代换性规则

当无理数数学函数的传递参数都是有理数, 且其数学结果也是有理数, 则除了特别说明, 允许实现返回精确的有理数结果或者单精度浮点数近似结果. 如果所有传递参数都是有理数, 但结果不能表示为有理数数值, 则总是返回单精度浮点数近似结果.

如果无理数数学函数的传递参数都是类型`(or rational (complex rational))`, 并且其数学结果是复数, 有有理数实部和虚部, 则除非显式说明, 允许实现或者返回类型为`(or rational (complex rational))`的精确结果, 或者返回单精度浮点数(只在数学结果的虚部为零时), 后者返回`(complex single-float)`. 如果所有传递参数的类型都是`(or rational (complex rational))`, 但结果不能表示为有理数或复数有理数, 则返回值的类型是`single-float`或者`(complex single-float)`.

浮点数的可代换性, 不能应用于有理数函数`+`、`-`、`*`和`/`, 也不能用于相关的操作符`1+`、`1-`、`incf`、`decf`和`conjugate`. 对于有理数函数, 如果所有传递参数都是有理数, 则结果是有理数; 如果所有传递参数类型都是`(or rational (complex rational))`, 则结果的类型是`(or rational (complex rational))`.

图 12-8. 受浮点数可代换性规则影响的函数.

```
函数       示例结果
abs       (abs #c(3 4)) =>  5 or 5.0
acos      (acos 1) =>  0 or 0.0
acosh     (acosh 1) =>  0 or 0.0
asin      (asin 0) =>  0 or 0.0
asinh     (asinh 0) =>  0 or 0.0
atan      (atan 0) =>  0 or 0.0
atanh     (atanh 0) =>  0 or 0.0
cis       (cis 0) =>  1 or #c(1.0 0.0)
cos       (cos 0) =>  1 or 1.0
cosh      (cosh 0) =>  1 or 1.0
exp       (exp 0) =>  1 or 1.0
expt      (expt 8 1/3) =>  2 or 2.0
log       (log 1) =>  0 or 0.0
          (log 8 2) =>  3 or 3.0
phase     (phase 7) =>  0 or 0.0
signum    (signum #c(3 4)) =>  #c(3/5 4/5) or #c(0.6 0.8)
sin       (sin 0) =>  0 or 0.0
sinh      (sinh 0) =>  0 or 0.0
sqrt      (sqrt 4) =>  2 or 2.0
          (sqrt 9/16) =>  3/4 or 0.75
tan       (tan 0) =>  0 or 0.0
tanh      (tanh 0) =>  0 or 0.0
```

### 12.1.4 浮点数计算

下面的规则应用于浮点数计算.

#### 12.1.4.1 浮点数和有理数传播规则

当有理数和浮点数用于数值函数时, 有理数被转换为与浮点数有相同格式的浮点数. 对于像函数`+`这种可以有多于两个传递参数的函数, 允许操作的部分使用有理数执行, 剩余部分使用浮点数算术执行.

当有理数和浮点数使用数值函数比较时, 调用函数`rational`将浮点数转换为有理数, 然后执行比较. 对于复数, 其实部和虚部被分别处理.

##### 12.1.4.1.1 示例: 浮点数和有理数传播规则

```
;;;; 组合使用有理数和浮点数
;;; This example assumes an implementation in which
;;; (float-radix 0.5) is 2 (as in IEEE) or 16 (as in IBM/360),
;;; or else some other implementation in which 1/2 has an exact
;;;  representation in floating point.
(+ 1/2 0.5) =>  1.0
(- 1/2 0.5d0) =>  0.0d0
(+ 0.5 -0.5 1/2) =>  0.5

;;;; 比较有理数和浮点数
;;; This example assumes an implementation in which the default float
;;; format is IEEE single-float, IEEE double-float, or some other format
;;; in which 5/7 is rounded upwards by FLOAT.
(< 5/7 (float 5/7)) =>  true
(< 5/7 (rational (float 5/7))) =>  true
(< (float 5/7) (float 5/7)) =>  false
```

#### 12.1.4.2 浮点数近似规则

浮点数计算只是近似计算, 尽管描述时结果是数学上正确的. 因为浮点数近似内在的误差, 数学上恒等的两个表达式可能计算结果不同. 浮点数的精度不一定与数值的精确性相关. 例如, `3.142857142857142857`是比`3.14159`更精密的对 $\pi$ 的近似, 但后者更精确. 精度的含义是表示中的位的数量. 当操作使用了短精度和长精度, 结果将是长精度. Common Lisp中函数假设它们的传递参数的精确性不超过他们的精度. 因此, 当使用两个小浮点数时, 结果是小浮点数. Common Lisp中函数从不自动将大精度转换为小精度.

#### 12.1.4.3 浮点数下溢和上溢规则

如果浮点数计算导致指数上溢或下溢, 则发出类型为`floating-point-overflow`或`floating-point-underflow`的错误信号.

#### 12.1.4.4 浮点数精度传播规则

数值函数的结果是与在所有浮点数传递参数中最大格式相同的浮点数.

### 12.1.5 复数计算

下面的规则应用于复数计算.

#### 12.1.5.1 复数可代换性规则

除了在执行无理数函数和超越函数时, 没有数值函数生成复数结果, 除非它的一个或多个传递参数是复数.

#### 12.1.5.2 复数传播规则

当计算中有实数和复数时, 实数被转换为虚部为`0`的复数.

#### 12.1.5.3 复数有理数标准表示规则

如果计算的结果是一个复数, 其实部的类型是`rational`, 虚部是零, 则结果被转换成实部部分的有理数.这个规则不适用于实数的各部分是浮点数的情况. 例如, `#C(5 0)`与`5`在Common Lisp中不是相异的两个对象(在`eql`语义下相同); `#C(5.0 0.0)`与`5.0`在Common Lisp中总是两个不同的对象, 在`eql`语义下不相同, 尽管在`equalp`和`=`语义下是相同的.

##### 12.1.5.3.1 示例: 复数有理数标准表示规则

```
#c(1.0 1.0) =>  #C(1.0 1.0)
#c(0.0 0.0) =>  #C(0.0 0.0)
#c(1.0 1) =>  #C(1.0 1.0)
#c(0.0 0) =>  #C(0.0 0.0)
#c(1 1) =>  #C(1 1)
#c(0 0) =>  0
(typep #c(1 1) '(complex (eql 1))) =>  true
(typep #c(0 0) '(complex (eql 0))) =>  false
```

#### 12.1.5.4 主值[^1]和分支切割[^2]

[^1]: [https://en.wikipedia.org/wiki/Principal_value](https://en.wikipedia.org/wiki/Principal_value)

[^2]: [https://zh.wikipedia.org/wiki/](https://zh.wikipedia.org/wiki/)复平面

有大量无理数函数和超越函数在复数域中是乘法定义的; 例如对数函数有无限数量的复数值. 在这种情况下, 必须选择一个主值作为函数结果返回. 通常, 这些值不能在连续的区间中选择; 不许在域中定义称为分支切割的线, 它定义了区间的不连续性. Common Lisp依据 **Principal Values and Branch Cuts in Complex APL.** 定义了复数函数的分支切割、主值和边界条件. 应用于每个函数的分支切割规则位于各函数的描述中.

下图列数了复数域中的恒等式:

图 12-9. 复数域中的三角恒等式.

```
sin i z = i sinh z  sinh i z = i sin z        arctan i z = i arctanh z
cos i z = cosh z    cosh i z = cos z          arcsinh i z = i arcsin z
tan i z = i tanh z  arcsin i z = i arcsinh z  arctanh i z = i arctan z
```

下图展示了讨论中分支切割的四象限数:

图 12-10. 分支切割的四象限数.

!["图 12-10. 分支切割的四象限数."](Quadrant.gif)

### 12.1.6 区间设计器

数值类型描述符的复合类型描述符形式, 允许用于指定实轴上的区间, 它描述了类型的子类型, 它应该使用相应的原子类型描述符描述. 类型T的子类型用称为类型T的区间设计器的一对有序对象描述.

类型T的两个区间设计器的第一个可以是:

- 类型为T的数值N: 表示N的包含下界, 即T的子类型的元素大于等于N.
- 元素为类型是T的数值M的单例列表: 表示M的不包含下界, 即T的子类型的元素大于M.
- 符号`*`: 表示区间没有下界

类型T的两个区间设计器的第二个可以是:

- 类型为T的数值N: 表示N的包含上界, 即T的子类型的元素小于等于N.
- 元素为类型是T的数值M的单例列表: 表示M的不包含上界, 即T的子类型的元素小于M.
- 符号`*`: 表示区间没有上界

### 12.1.7 随机状态操作

下图列出了一些可用于随机状态的已定义名称.

图 12-11. 随机状态的已定义名称.

```
*random-state*
make-random-state
random
random-state-p
```

## 12.2 数值的字典

- system class `number`
- system class `complex`
- system class `real`
- system class `float`
- type `short-float`
- type `single-float`
- type `double-float`
- type `long-float`
- system class `rational`
- system class `ratio`
- system class `integer`
- type `signed-byte`
- type `unsigned-byte`
- type `specifier mod`
- type `bit`
- type `fixnum`
- type `bignum`
- function `=`
- function `/=`
- function `<`
- function `>`
- function `<=`
- function `>=`
- function `max`
- function `min`
- function `minusp`
- function `plusp`
- function `zerop`
- function `floor`
- function `ffloor`
- function `ceiling`
- function `fceiling`
- function `truncate`
- function `ftruncate`
- function `round`
- function `fround`
- function `sin`
- function `cos`
- function `tan`
- function `asin`
- function `acos`
- function `atan`
- constant variable `pi`
- function `sinh`
- function `cosh`
- function `tanh`
- function `asinh`
- function `acosh`
- function `atanh`
- function `*`
- function `+`
- function `-`
- function `/`
- function `1+`
- function `1-`
- function `abs`
- function `evenp`
- function `oddp`
- function `exp`
- function `expt`
- function `gcd`
- macro `incf`
- macro `decf`
- function `lcm`
- function `log`
- function `mod`
- function `rem`
- function `signum`
- function `sqrt`
- function `isqrt`
- system class `random-state`
- function `make-random-state`
- function `random`
- function `random-state-p`
- variable `*random-state*`
- function `numberp`
- function `cis`
- function `complex`
- function `complexp`
- function `conjugate`
- function `phase`
- function `realpart`
- function `imagpart`
- function `upgraded-complex-part-type`
- function `realp`
- function `numerator`
- function `denominator`
- function `rational`
- function `rationalize`
- function `rationalp`
- function `ash`
- function `integer-length`
- function `integerp`
- function `parse-integer`
- function `boole`
- constant variable `boole-1`
- constant variable `boole-2`
- constant variable `boole-and`
- constant variable `boole-andc1`
- constant variable `boole-andc2`
- constant variable `boole-c1`
- constant variable `boole-c2`
- constant variable `boole-clr`
- constant variable `boole-eqv`
- constant variable `boole-ior`
- constant variable `boole-nand`
- constant variable `boole-nor`
- constant variable `boole-orc1`
- constant variable `boole-orc2`
- constant variable `boole-set`
- constant variable `boole-xor`
- function `logand`
- function `logandc1`
- function `logandc2`
- function `logeqv`
- function `logior`
- function `lognand`
- function `lognor`
- function `lognot`
- function `logorc1`
- function `logorc2`
- function `logxor`
- function `logbitp`
- function `logcount`
- function `logtest`
- function `byte`
- function `byte-size`
- function `byte-position`
- function `deposit-field`
- function `dpb`
- accessor `ldb`
- function `ldb-test`
- accessor `mask-field`
- constant variable `most-positive-fixnum`
- constant variable `most-negative-fixnum`
- function `decode-float`
- function `scale-float`
- function `float-radix`
- function `float-sign`
- function `float-digits`
- function `float-precision`
- function `integer-decode-float`
- function `float`
- function `floatp`
- constant variable `most-positive-short-float`
- constant variable `least-positive-short-float`
- constant variable `least-positive-normalized-short-float`
- constant variable `most-positive-double-float`
- constant variable `least-positive-double-float`
- constant variable `least-positive-normalized-double-float`
- constant variable `most-positive-long-float`
- constant variable `least-positive-long-float`
- constant variable `least-positive-normalized-long-float`
- constant variable `most-positive-single-float`
- constant variable `least-positive-single-float`
- constant variable `least-positive-normalized-single-float`
- constant variable `most-negative-short-float`
- constant variable `least-negative-short-float`
- constant variable `least-negative-normalized-short-float`
- constant variable `most-negative-single-float`
- constant variable `least-negative-single-float`
- constant variable `least-negative-normalized-single-float`
- constant variable `most-negative-double-float`
- constant variable `least-negative-double-float`
- constant variable `least-negative-normalized-double-float`
- constant variable `most-negative-long-float`
- constant variable `least-negative-long-float`
- constant variable `least-negative-normalized-long-float`
- constant variable `short-float-epsilon`
- constant variable `short-float-negative-epsilon`
- constant variable `single-float-epsilon`
- constant variable `single-float-negative-epsilon`
- constant variable `double-float-epsilon`
- constant variable `double-float-negative-epsilon`
- constant variable `long-float-epsilon`
- constant variable `long-float-negative-epsilon`
- condition `type arithmetic-error`
- function `arithmetic-error-operands`
- function `arithmetic-error-operation`
- condition `type division-by-zero`
- condition `type floating-point-invalid-operation`
- condition `type floating-point-inexact`
- condition `type floating-point-overflow`
- condition `type floating-point-underflow`

# 13 字符

## 13.1 字符的概念

### 13.1.1 字符的介绍

\==字符== 是表示在文本(一个字符串或一个文本流)中的单一记号(一个字母、一个特殊符号或一个控制字符)的对象.

Common Lisp允许实现提供国际语言字符和特殊用途(例如数学中)的字符支持.

下面的图列出了可用于字符的已定义名称.

下图列出了与字符属性和字符谓词相关的已定义名称.

图 13-1. 字符的已定义名称 – 1.

```
alpha-char-p
alphanumericp
both-case-p
char-code-limit
char-equal
char-greaterp
char-lessp
char-not-equal
char-not-greaterp
char-not-lessp
char/=
char<
char<=
char=
char>
char>=
digit-char-p
graphic-char-p
lower-case-p
standard-char-p
upper-case-p
```

下图列出了字符构造和转换的已定义名称.

图 13-2. 字符的已定义名称 – 2.

```
char-code
char-downcase
char-int
char-name
char-upcase
character
code-char
digit-char
name-char
```

### 13.1.2 字符的scripts和repertoires的介绍

#### 13.1.2.1 字符的scripts

\==script== 是构成类型`character`的完备部分的几个集合中的一个.

这些集合的数量和它们之间的边界是由实现定义的. Common Liso不要求这些集合是类型, 但允许实现扩展定义这种类型. 因为一个script中的字符不可以属于另一个script, 通常使用字符repertoires描述.

尽管选择了术语script以与ISO术语兼容, 符合标准的实现不要求使用任何由ISO或其他标准组织标准化的script.

任意使用script实现中, script是否命名和如何名称是依赖于实现的.

#### 13.1.2.2 字符的repertoires

\==repertoire== 是类型`character`的子类型的类型描述符. 这个术语通常用于描述一组独立于其编码的字符. repertoire中的字符用名称、象形符(glyph)或字符描述标识.

一个repertoire可以包含几个script中的字符, 一个字符可以在多个repertoire中出现.

repertoire的一些示例可以参考编码字符标准ISO 8859/1、ISO 8859/2和ISO 6937/2. 注意, 尽管选择了术语repertoire以与ISO术语兼容, 符合标准的实现不要求使用任何由ISO或其他标准组织标准化的repertoire.

### 13.1.3 字符的属性

字符只有一个标准属性: 编码(code). 字符的编码是一个非负整数. 这个编码是由字符script和依赖于实现的字符标签(label)组合构成的. 见函数`char-code`和`code-char`.

此外, 允许由实现定义的字符属性, 例如, 两个具有相同编码的字符可以在实现定义方面存在不同.

对于实现定义的属性, 有一个特殊的值称为属性的空值. 每个实现定义的属性都是空值的字符, 称为 ==简单字符==. 如果实现中没有实现定义的属性, 则所有字符都是简单字符.

### 13.1.4 字符的种类

有一些(可能重叠的)字符种类, 没有相应的类型, 但其名称是有用的. 包括: 图形字符、文字字符、有大小写的字符、数值字符、文字数字字符和(特定基数中的)数字.

对每个实现定义的字符属性, 这个实现的文档必须描述, 只在这个属性上存在不同的字符, 是否允许在是否是前述字符种类成员上存在不同.

注意这些术语是与已在当前`readtable`中启用任何特殊语法独立定义的.

#### 13.1.4.1 图形字符

分类为图形或可视的字符, 与一个图形关联, 这个图形是字符的可视化表示.

图形字符是有单个图形标准文本表示的字符, 例如`A`、`*`、`=`. `Space`有一个空图形, 也是图形的.

在标准字符中, 换行符不是图形的, 其他的都是图形字符, 见**2.1.3 标准字符**.

不是图形的字符称为非图形字符, 有时被称为格式化字符或控制字符.

`#\Backspace`、`#\Tab`、`#\Rubout`、`#\Linefeed`、`#\Return`和`#\Page`, 如果被实现支持, 是非图形的.

#### 13.1.4.2 文字字符

文字字符是图形字符的子集, 在标准字符中, 只有这些是文字字符:

```
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

a b c d e f g h i j k l m n o p q r s t u v w x y z
```

有大小写的实现定义的字符必须是文字字符. 对于每个没有大小写的实现定义的图形字符, 是否是文字字符, 是由实现定义的.

#### 13.1.4.3 大小写字符

有大小写的字符是文字字符的子集. 有大小写的字符有大写或小写属性. 每个有大小写的字符与具有相反大小写的字符有一一对应关系.

##### 13.1.4.3.1 大写字符

大写字符是有相应的不同的小写字符的字符, 小写字符用`char-downcase`获得.

在标准字符中, 只有这些大写字符:

```
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
```

##### 13.1.4.3.2 小写字符

小写字符是有相应的不同的大写字符的字符, 大写字符用`char-upcase`获得.

在标准字符中, 只有这些小写字符:

```
a b c d e f g h i j k l m n o p q r s t u v w x y z
```

##### 13.1.4.3.3 大小写对应字符

上面提到的大写标准字符与小写标准字符有对应关系. 例如大写字符`E`与小写字符`e`对应, 反之亦然.

##### 13.1.4.3.4 实现定义的字符中大小写

实现中可以定义其他实现定义的图形字符有大小写. 这种定义必须成对出现: 一个大写字符与一个小写字符对应.

#### 13.1.4.4 数值字符

数值字符是图形字符的子集. 在标准字符中, 只有这些数值字符:

```
0 1 2 3 4 5 6 7 8 9
```

对每个没有大小写的实现定义的图形字符, 实现中必须定义它是否是数值字符.

#### 13.1.4.5 文字数字字符

文字数字字符是文字字符和数值字符的并集.

#### 13.1.4.6 基数中数字

数字依赖于其定义的基数(从2到36的整数). 潜在的数字有:

```
0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
```

它们相应的权重是`0,1,2, ..., 35`. 在给定基数n中, 只有头n个数值被视为数字. 例如基数2中数字是0和1, 基数10中数字是0到9, 基数16中数字是0到F.

数字中大小写不敏感; 例如在基数16中, F和f都是有权重15的数字.

### 13.1.5 字符的本体

两个在`eql`、`char=`或`char-equal`意义下等价的字符, 不一定要`eq`等价.

### 13.1.6 字符的顺序

字符上的全序保证有如下属性:

- 如果两个字符有相同的实现定义的属性, 则它们按`char<`比较排序的顺序, 与在它们的编码上按谓词`<`比较排序的顺序一致.
- 如果两个字符在任意属性上存在不同, 则它们不是`char=`相同的.
- 这个全序不一定要与在字符上应用`char-int`后的整数排序后的顺序相同.
- 给定大小写的文字字符不许有一个偏序, 不需要是连续的; 允许大写和小写字符交错出现. 因此`(char<= #\a x #\z)`不是确定`x`是否是小写的有效方法.

在标准字符中, 文字数字字符上有如下偏序:

```
A<B<C<D<E<F<G<H<I<J<K<L<M<N<O<P<Q<R<S<T<U<V<W<X<Y<Z
a<b<c<d<e<f<g<h<i<j<k<l<m<n<o<p<q<r<s<t<u<v<w<x<y<z
0<1<2<3<4<5<6<7<8<9

9<A 或者 Z<0
9<a 或者 z<0
```

这意味着, 标准字符中文字字符顺序在大小写下保持, 数值字符不与文字字符交错. 然而大小写字符间的顺序以及是否交错出现是由实现定义的.

### 13.1.7 字符的名称

所有符合标准的实现中必须有如下字符名称:

- Newline: 表示行之间的分隔. 实现必须支持`#\Newline`、单个字符表示和外部表示之间的转换.
- Space: 空格字符.

下面的名称是半标准的, 如果实现中支持, 它们应该只被用于描述的字符:

- Rubout: 删除字符
- Page: 页分隔字符
- Tab: 制表字符
- Backspace: 退格字符
- Return: 回车字符
- Linefeed: 换行字符

在一些实现中, 这些字符名称可能表示标准字符; 例如, 在一些实现中`#\Linefeed`与`#\Newline`可以是同一个字符.

### 13.1.8 输入输出时处理换行符

当在输出文件中写入`#\Newline`时, 实现中需要执行产生行分隔的动作. 这可以是写出一个记录, 或者将`#\Newline`翻译为CR/LF序列. 读取时, 需要执行相反的动作.

### 13.1.9 字符的编码

字符有时只用它的编码表示, 有时用从编码导出的整数值和所有实现定义的属性表示(按实现定义的方式, 在同一实现的不同Lisp镜像间也可能不同). 函数`char-int`返回的整数, 称为字符的编解码(encoding). 因为编解码的主要用途是不需要逆操作的哈希, 不存在从字符的编解码获取字符的函数.

### 13.1.10 实现定义的scripts文档记录

实现必须提供它支持的字符script的文档. 对每个支持的字符script, 这个文档必须至少有:

- 字符标签、图形和描述. 字符标签必须有唯一名称, 只能使用拉丁大写字母A-Z、连字符-、数字0-9.
- 读取器标准形式. 必须记录`read`将不同字符视为等价的机制.
- 对`char-upcase`、`char-downcase`和大小写敏感的格式化指令的影响. 通常, 对每个有大小写的字符, 记录它是否是大写或小写、大小写相反的字符等.
- 大小写敏感的函数`char-equal`、`char-not-equal`、`char-lessp`、`char-greaterp`、`char-not-greaterp`和`char-not-lessp`的行为.
- 字符谓词的行为; 通常是`alpha-char-p`、`lower-case-p`、`upper-case-p`、`both-case-p`、`graphic-char-p`和`alphanumericp`的作用.
- 与文件IO的交互, 通常需要记录支持的编码字符集(例如ISO8859/1-1987)和外部编码方案.

## 13.2 字符的字典

- system class `character`
- type `base-char`
- type `standard-char`
- type `extended-char`
- function `char=`
- function `char/=`
- function `char<`
- function `char>`
- function `char<=`
- function `char>=`
- function `char-equal`
- function `char-not-equal`
- function `char-lessp`
- function `char-greaterp`
- function `char-not-greaterp`
- function `char-not-lessp`
- function `character`
- function `characterp`
- function `alpha-char-p`
- function `alphanumericp`
- function `digit-char`
- function `digit-char-p`
- function `graphic-char-p`
- function `standard-char-p`
- function `char-upcase`
- function `char-downcase`
- function `upper-case-p`
- function `lower-case-p`
- function `both-case-p`
- function `char-code`
- function `char-int`
- function `code-char`
- constant variable `char-code-limit`
- function `char-name`
- function `name-char`

# 14 Conses

## 14.1 Cons概念

Cons是复合数据对象, 有两个组件: car和cdr.

图 14-1. Cons相关的一些已定义名称.

```
car
cdr
cons
rplaca
rplacd
```

依赖于上下文, 一组连接的Cons可以有不同的处理视角. 不同的处理视角有多种操作支持.

### 14.1.1 Cons作为树

\==树== 是由Cons和原子构成的二元递归数据结构: Cons也可以是树(有时称为子树或分支), 原子是终结符号(有时称为叶子). 通常, 叶子表示数据, 而分支建立数据之间的关系.

图 14-2. 树相关的一些已定义名称.

```
caaaar
caaadr
caaar
caadar
caaddr
caadr
caar
cadaar
cadadr
cadar
caddar
cadddr
caddr
cadr
cdaaar
cdaadr
cdaar
cdadar
cdaddr
cdadr
cdar
cddaar
cddadr
cddar
cdddar
cddddr
cdddr
cddr
copy-tree
nsublis
nsubst
nsubst-if
nsubst-if-not
nthcdr
sublis
subst
subst-if
subst-if-not
tree-equal
```

#### 14.1.1.1 树作为参数的常见约束

除非特别指出, 对任意接收树作为参数的标准函数, 如果树是循环的, 后果未定义.

### 14.1.2 Conse作为列表

\==列表== 是Cons链, 每个Cons的car是列表的一个元素, 每个Cons的cdr或者指向是链中下一个Cons或者是终结原子.

\==合式列表(proper list)== 是以空列表结束的列表. 空列表是合式列表, 但不是Cons.

\==非合式列表== 是不是合式列表的列表, 即是循环列表或点列表.

\==点列表== 是终结原子不是空列表的列表. 非`nil`的原子自身不被是被一个列表, 更不是点列表.

\==循环列表== 是没有终结的Cons链, 因为链中一些Cons是后续某个Cons的cdr.

图 14-3. 列表相关的一些已定义名称.

```
append
butlast
copy-alist
copy-list
eighth
endp
fifth
first
fourth
last
ldiff
list
list*
list-length
make-list
member
member-if
member-if-not
nbutlast
nconc
ninth
nreconc
nth
nthcdr
pop
push
pushnew
rest
revappend
second
seventh
sixth
tailp
tenth
third
```

#### 14.1.2.1 列表作为关联列表

\==关联列表== 是表示关联键和值的Cons的列表, 每个Cons的car是键, cdr是与该键关联的值.

图 14-4. 关联列表相关的一些已定义名称.

```
acons
assoc
assoc-if
assoc-if-not
pairlis
rassoc
rassoc-if
rassoc-if-not
```

#### 14.1.2.2 列表作为集

列表有时被看作集, 将其元素视为无序的, 同时假设不存在重复元素.

图 14-5. 集相关的一些已定义名称.

```
adjoin
intersection
nintersection
nset-difference
nset-exclusive-or
nunion
set-difference
set-exclusive-or
subsetp
union
```

#### 14.1.2.3 列表作为参数的常见约束

除非特别说明, 对任意接收列表作为参数的标准函数, 在值是点列表时, 应该准备发出类型为`type-error`的错误信号.

除非特别说明, 对任意接收列表作为参数的标准函数, 如果列表是循环的, 后果未定义.

## 14.2 Cons字典

- system class `list`
- system class `null`
- system class `cons`
- type `atom`
- function `cons`
- function `consp`
- function `atom`
- function `rplaca, rplacd`
- accessor `car`
- accessor `cdr`
- accessor `caar`
- accessor `cadr`
- accessor `cdar`
- accessor `cddr`
- accessor `caaar`
- accessor `caadr`
- accessor `cadar`
- accessor `caddr`
- accessor `cdaar`
- accessor `cdadr`
- accessor `cddar`
- accessor `cdddr`
- accessor `caaaar`
- accessor `caaadr`
- accessor `caadar`
- accessor `caaddr`
- accessor `cadaar`
- accessor `cadadr`
- accessor `caddar`
- accessor `cadddr`
- accessor `cdaaar`
- accessor `cdaadr`
- accessor `cdadar`
- accessor `cdaddr`
- accessor `cddaar`
- accessor `cddadr`
- accessor `cdddar`
- accessor `cddddr`
- function `copy-tree`
- function `sublis`
- function `nsublis`
- function `subst`
- function `subst-if`
- function `subst-if-not`
- function `nsubst`
- function `nsubst-if`
- function `nsubst-if-not`
- function `tree-equal`
- function `copy-list`
- function `list`
- function `list*`
- function `list-length`
- function `listp`
- function `make-list`
- macro `push`
- macro `pop`
- accessor `first`
- accessor `second`
- accessor `third`
- accessor `fourth`
- accessor `fifth`
- accessor `sixth`
- accessor `seventh`
- accessor `eighth`
- accessor `ninth`
- accessor `tenth`
- accessor `nth`
- function `endp`
- function `null`
- function `nconc`
- function `append`
- function `revappend`
- function `nreconc`
- function `butlast`
- function `nbutlast`
- function `last`
- function `ldiff`
- function `tailp`
- function `nthcdr`
- accessor `rest`
- function `member`
- function `member-if`
- function `member-if-not`
- function `mapc`
- function `mapcar`
- function `mapcan`
- function `mapl`
- function `maplist`
- function `mapcon`
- function `acons`
- function `assoc`
- function `assoc-if`
- function `assoc-if-not`
- function `copy-alist`
- function `pairlis`
- function `rassoc`
- function `rassoc-if`
- function `rassoc-if-not`
- function `get-properties`
- accessor `getf`
- macro `remf`
- function `intersection`
- function `nintersection`
- function `adjoin`
- macro `pushnew`
- function `set-difference`
- function `nset-difference`
- function `set-exclusive-or`
- function `nset-exclusive-or`
- function `subsetp`
- function `union`
- function `nunion`

# 15 数组

## 15.1 数组的概念

### 15.1.1 数组元素

数组包含一组被称为元素的对象, 可以通过线性坐标系统访问每个元素.

#### 15.1.1.1 数组索引

用(可能为空的)一系列索引引用数组元素. 这个系列的长度必须等于数组的维秩. 每个索引必须是非负的小于相应数组维度有限数. 数组索引从0开始.

#### 15.1.1.2 数组的维

数组的一个轴(aixs)称为**维**.

每个维是一个非负的有限数; 如果数组的任一维是零, 这个数组没有元素. 允许一个维为零, 在这种情况下数组没有元素, 尝试访问元素是一个错误. 可以使用数组的其他属性, 例如维.

##### 15.1.1.2.1 数组维度上的实现限制

实现可以在数组的维上添加限制, 但对该限制有一个最小需求. 见变量`array-dimension-limit`.

#### 15.1.1.3 数组的维秩

数组可以有任意数量的维(包括零). 维的数量称为 ==维秩==.

如果数组的维秩是零, 则称该数组没有维, 维的积(见`array-total-size`)是1; 维秩为零的数组有一个元素.

##### 15.1.1.3.1 向量

维秩为1的数组(一维数组), 称为**向量**.

###### 15.1.1.3.1.1 填充指针

填充指针是不比向量中元素总数大的非负整数. 不是所有的向量都有填充指针. 见函数`make-array`和`adjust-array`.

如果向量中元素有大于等于零、小于填充指针(如果存在的话)的索引, 则称该元素是 **活跃的**. 没有填充指针的数组, 所有元素都是活跃的.

只有向量有填充指针, 多维数组没有. 可以创建代替有填充指针的向量的多维数组.

##### 15.1.1.3.2 多维数组

###### 15.1.1.3.2.1 多维数组的存储布局

多维数组按行主序的顺序存储元素, 即内部将多维数组保存为一个一维数组, 多维索引按字典序排列, 最后一个索引变化最快.

###### 15.1.1.3.2.2 数组的维秩上实现限制

实现中可以在数组的维秩上添加显式, 但对该显式有一个最小需求. 见变量`array-rank-limit`.

### 15.1.2 特殊的数组

数组可以是 ==常规数组==, 即每个元素可以是任何对象; 也可以是 ==特殊的数组==, 即每个元素必须属于受限的类型.

短语 **特化为类型**`<<type>>`**的数组** 有时用于强调数组的元素类型. 当`<<type>>`是`t`时, 这个短语也使用, 虽然了特化为类型`t`的数组是常规数组, 不是特殊的数组.

下图列出了可用于数组创建、访问和信息操作的已定义名称.

图 15-1. 通用的数组相关的已定义名称.

```
adjust-array
adjustable-array-p
aref
array-dimension
array-dimension-limit
array-dimensions
array-displacement
array-element-type
array-has-fill-pointer-p
array-in-bounds-p
array-rank
array-rank-limit
array-row-major-index
array-total-size
array-total-size-limit
fill-pointer
make-array
svref
upgraded-array-element-type
upgraded-complex-part-type
vector
vector-pop
vector-push
vector-push-extend
```

#### 15.1.2.1 数组升级

类型T1的 **升级的数组元素类型** 是类型T2, T2是T1的超类型, 每当在对象创建或区分类型中T1被用作数组元素类型时, 替代T1.

在创建对象时, 被要求的元素类型被称为 **表达的数组元素类型**. 表达的数组元素类型的升级的数组元素类型, 称为被创建数组的 **实际数组元素类型**.

类型升级意味着在类型层次格中向上移动. 一个类型总是它的升级的数组元素类型的子类型. 同时, 如果类型Tx是另一个类型Ty的子类型, 则Tx的升级的数组元素类型必须是Ty的升级的数组元素类型的子类型. 两个不相交的类型可以升级为同一个类型.

类型T1的升级的数组元素类型T2是T1自身的一个函数, 即与使用T2的数组的任意其他属性不相关, 例如维秩、可调整性、填充指针或替代. 符合标准的实现可以使用函数`upgraded-array-element-type`预测实现如何升级指定的类型.

#### 15.1.2.2 特殊数组的必备种类

元素的类型被限制为类型`character`或`chatacter`的子类型的向量, 被称为字符串. 字符串属于类型`string`. 下图列出了与字符串相关的已定义名称.

字符串是特殊的数组, 逻辑上被这一章包含. 然而, 关于字符串的更多信息见**16. 字符串**.

图 15-2. 操作字符串的操作符.

```
char
make-string
nstring-capitalize
nstring-downcase
nstring-upcase
schar
string
string-capitalize
string-downcase
string-equal
string-greaterp
string-left-trim
string-lessp
string-not-equal
string-not-greaterp
string-not-lessp
string-right-trim
string-trim
string-upcase
string/=
string<
string<=
string=
string>
string>=
```

元素的类型被限制为类型`bit`的向量, 称为位向量. 位向量属于类型`bit-vector`. 下图列出了位数组的操作的已定义名称.

图 15-3. 操作位数组的操作符.

```
bit
bit-and
bit-andc1
bit-andc2
bit-eqv
bit-ior
bit-nand
bit-nor
bit-not
bit-orc1
bit-orc2
bit-xor
sbit
```

## 15.2 数组的字典

- system class `array`
- type `simple-array`
- system class `vector`
- type `simple-vector`
- system class `bit-vector`
- type `simple-bit-vector`
- function `make-array`
- function `adjust-array`
- function `adjustable-array-p`
- accessor `aref`
- function `array-dimension`
- function `array-dimensions`
- function `array-element-type`
- function `array-has-fill-pointer-p`
- function `array-displacement`
- function `array-in-bounds-p`
- function `array-rank`
- function `array-row-major-index`
- function `array-total-size`
- function `arrayp`
- accessor `fill-pointer`
- accessor `row-major-aref`
- function `upgraded-array-element-type`
- constant variable `array-dimension-limit`
- constant variable `array-rank-limit`
- constant variable `array-total-size-limit`
- function `simple-vector-p`
- accessor `svref`
- function `vector`
- function `vector-pop`
- function `vector-push`
- function `vector-push-extend`
- function `vectorp`
- accessor `bit`
- accessor `sbit`
- function `bit-and`
- function `bit-andc1`
- function `bit-andc2`
- function `bit-eqv`
- function `bit-ior`
- function `bit-nand`
- function `bit-nor`
- function `bit-not`
- function `bit-orc1`
- function `bit-orc2`
- function `bit-xor`
- function `bit-vector-p`
- function `simple-bit-vector-p`

# 16 字符串

## 16.1 字符串的概念

### 16.1.1 字符串蕴含数组

因为所有字符串都是数组, 所有适用于数组的规则也适用于字符串. 见**15.1 数组的概念**.

例如, 字符串可以有填充指针, 也遵循应用在数组上的元素类型升级的规则.

### 16.1.2 `STRING`的子类型

所有操作字符串的函数, 也可以操作字符串的子类型.

然而, 如果在字符串中插入一个字符, 但该字符串的元素类型不包括这个字符的类型, 后果是未定义的.

## 16.2 字符串的字典

- system class `string`
- type `base-string`
- type `simple-string`
- type `simple-base-string`
- function `simple-string-p`
- accessor `char`
- accessor `schar`
- function `string`
- function `string-upcase`
- function `string-downcase`
- function `string-capitalize`
- function `nstring-upcase`
- function `nstring-downcase`
- function `nstring-capitalize`
- function `string-trim`
- function `string-left-trim`
- function `string-right-trim`
- function `string=`
- function `string/=`
- function `string<`
- function `string>`
- function `string<=`
- function `string>=`
- function `string-equal`
- function `string-not-equal`
- function `string-lessp`
- function `string-greaterp`
- function `string-not-greaterp`
- function `string-not-lessp`
- function `stringp`
- function `make-string`

# 17 序列

## 17.1 序列的概念

序列是有序的元素集合, 通过向量或列表实现.

序列可以用函数`make-sequence`创建, 也可以使用创建类型`sequence`的子类型的对象的函数创建(例如`list`、`make-list`、`mapcar`和`vector`).

序列函数是该规范定义的或被实现扩展添加的函数, 操作一个或多个序列. 每当序列函数必须构造并返回一个新向量, 它总是返回一个简单向量. 类似的, 构造的字符串是简单字符串.

图 17-1. 标准的序列函数.

```
concatenate
copy-seq
count
count-if
count-if-not
delete
delete-duplicates
delete-if
delete-if-not
elt
every
fill
find
find-if
find-if-not
length
map
map-into
merge
mismatch
notany
notevery
nreverse
nsubstitute
nsubstitute-if
nsubstitute-if-not
position
position-if
position-if-not
reduce
remove
remove-duplicates
remove-if
remove-if-not
replace
reverse
search
some
sort
stable-sort
subseq
substitute
substitute-if
substitute-if-not
```

### 17.1.1 序列参数的限制

通常, 被视为序列的列表(包括关联列表和属性列表), 必须是合式列表.

## 17.2 测试函数的规则

### 17.2.1 满足两个传递参数的测试

当用下图列出的操作符F组合处理对象O与序列S中每个元素Ei时, 有时需要控制F测试O是否在S中出现的方式. 这个控制是由带`:test`或`:test-not`传递参数的函数提供的.

图 17-2. 有两个传递参数测试的操作符.

```
adjoin
assoc
count
delete
find
intersection
member
mismatch
nintersection
nset-difference
nset-exclusive-or
nsublis
nsubst
nsubstitute
nunion
position
pushnew
rassoc
remove
remove-duplicates
search
set-difference
set-exclusive-or
sublis
subsetp
subst
substitute
tree-equal
union
```

可能并不直接比较对象O和Ei. 如果提供了`:key`传递参数, 它是一个将每个Ei作为传递参数的单传递函数的指示器, 生成用于比较的对象Zi. (如果没有`:key`传递参数, Zi是Ei).

由`:key`传递参数指示的函数从不在O上调用. 然而, 如果这个函数在多个队列上操作(例如`set-difference`), O是在其它序列的一个元素上调用`:key`函数的结果.

F的传递参数`:test`, 是一个有两个传递参数(O和Zi)的函数的指示器. 如果`:test`函数返回表示true的广义布尔值, 称Ei满足测试(或O与Ei满足测试).

F的传递参数`:test-not`, 是一个有两个传递参数(O和Zi)的函数的指示器. 如果`:test`函数返回表示false的广义布尔值, 称Ei满足测试(或O与Ei满足测试).

如果没有提供`:test`或`:test-not`传递参数, 则`:test`传递参数默认为`#'eql`.

如果在对F的同一个调用中同时有`:test`和`:test-not`传递参数, 后果是未定义的.

#### 17.2.1.1 实例: 满足两个传递参数的测试

```
;; 使用:test
(remove "FOO" '(foo bar "FOO" "BAR" "foo" "bar") :test #'equal)
=>  (foo bar "BAR" "foo" "bar")
(remove "FOO" '(foo bar "FOO" "BAR" "foo" "bar") :test #'equalp)
=>  (foo bar "BAR" "bar")
(remove "FOO" '(foo bar "FOO" "BAR" "foo" "bar") :test #'string-equal)
=>  (bar "BAR" "bar")
(remove "FOO" '(foo bar "FOO" "BAR" "foo" "bar") :test #'string=)
=>  (BAR "BAR" "foo" "bar")

;; 使用:test-not
(remove 1 '(1 1.0 #C(1.0 0.0) 2 2.0 #C(2.0 0.0)) :test-not #'eql)
=>  (1)
(remove 1 '(1 1.0 #C(1.0 0.0) 2 2.0 #C(2.0 0.0)) :test-not #'=)
=>  (1 1.0 #C(1.0 0.0))
(remove 1 '(1 1.0 #C(1.0 0.0) 2 2.0 #C(2.0 0.0)) :test (complement #'=))
=>  (1 1.0 #C(1.0 0.0))

;; 使用:key
(count 1 '((one 1) (uno 1) (two 2) (dos 2)) :key #'cadr) =>  2

(count 2.0 '(1 2 3) :test #'eql :key #'float) =>  1

;; 使用:key和:test
(count "FOO" (list (make-pathname :name "FOO" :type "X")
                   (make-pathname :name "FOO" :type "Y"))
       :key #'pathname-name
       :test #'equal)
=>  2
```

### 17.2.2 满足一个传递参数的测试

当使用下图中的函数时, 筛选出序列S中元素E, 不是基于两传递参数谓词和**17.2.1 满足两个传递参数的测试**中描述的函数下对象O出现与否, 而是基于单传递参数谓词.

图 17-3. 有单个传递参数测试的操作符.

```
assoc-if
assoc-if-not
count-if
count-if-not
delete-if
delete-if-not
find-if
find-if-not
member-if
member-if-not
nsubst-if
nsubst-if-not
nsubstitute-if
nsubstitute-if-not
position-if
position-if-not
rassoc-if
rassoc-if-not
remove-if
remove-if-not
subst-if
subst-if-not
substitute-if
substitute-if-not
```

可能并不直接使用Ei. 如果有`:key`传递参数, 它是将Ei作为传递参数的单传递参数函数的指示器, 生成用于比较的对象Zi(如果没有`:key`传递参数, Zi是Ei).

该规范中定义的以`-if`结尾的函数接受的第一个传递参数是单传递参数Zi的函数的指示器. 如果`:test`函数返回表示true的广义布尔值, 称Ei满足测试.

该规范中定义的以`-if-not`结尾的函数接受的第一个传递参数是单传递参数Zi的函数的指示器. 如果`:test`函数返回表示false的广义布尔值, 称Ei满足测试.

#### 17.2.2.1 示例: 满足一个传递参数的测试

```
;; 使用-if
(count-if #'zerop '(1 #C(0.0 0.0) 0 0.0d0 0.0s0 3)) =>  4

;; 比较使用-if和-if-not
(remove-if-not #'symbolp '(0 1 2 3 4 5 6 7 8 9 A B C D E F))
=>  (A B C D E F)
(remove-if (complement #'symbolp) '(0 1 2 3 4 5 6 7 8 9 A B C D E F))
=>  (A B C D E F)

;; 使用:key
(count-if #'zerop '("foo" "" "bar" "" "" "baz" "quux") :key #'length)
=>  3
```

## 17.3 序列的字典

- system class `sequence`
- function `copy-seq`
- accessor `elt`
- function `fill`
- function `make-sequence`
- accessor `subseq`
- function `map`
- function `map-into`
- function `reduce`
- function `count`
- function `count-if`
- function `count-if-not`
- function `length`
- function `reverse`
- function `nreverse`
- function `sort`
- function `stable-sort`
- function `find`
- function `find-if`
- function `find-if-not`
- function `position`
- function `position-if`
- function `position-if-not`
- function `search`
- function `mismatch`
- function `replace`
- function `substitute`
- function `substitute-if`
- function `substitute-if-not`
- function `nsubstitute`
- function `nsubstitute-if`
- function `nsubstitute-if-not`
- function `concatenate`
- function `merge`
- function `remove`
- function `remove-if`
- function `remove-if-not`
- function `delete`
- function `delete-if`
- function `delete-if-not`
- function `remove-duplicates`
- function `delete-duplicates`

# 18 哈希表

## 18.1 哈希表的概念

### 18.1.1 哈希表操作

下图列出了可用于哈希表的已定义名称. 哈希表上有下述规则:

- 一个哈希表只可以为一个给定键关联一个值. 如果尝试给给定键添加第二个值, 则第二个值将覆盖第一个值. 因此, 在哈希表中添加一个值是破坏性操作; 修改了哈希表.
- 有四种哈希表: 键按`eq`比较的、键按`eql`比较的、键按`equal`比较的和键按`equalp`比较的.
- 使用`make-hash-table`创建哈希表. 使用`gethash`查找键和对应的值. 使用`setf`和`gethash`添加新项. 使用`remhash`移除项. 例如

```
(setq a (make-hash-table)) =>  #<HASH-TABLE EQL 0/120 32536573>
(setf (gethash 'color a) 'brown) =>  BROWN
(setf (gethash 'name a) 'fred) =>  FRED
(gethash 'color a) =>  BROWN, true
(gethash 'name a) =>  FRED, true
(gethash 'pointy a) =>  NIL, false
```

在这个例子中, 符号`color`和`name`用作键, 符号`brown`和`fred`用作相应的值. 这个哈希表有两项, 一个是`color`到`brown`的关联, 另一个是`name`到`fred`的关联.

- 键和值可以是任意对象.
- 使用`gethash`返回的第二个值, 可以确定项在哈希表中是否存在.

图 18-1. 哈希表已定义名称.

```
clrhash
gethash
hash-table-count
hash-table-p
make-hash-table
maphash
remhash
sxhash
```

### 18.1.2 修改哈希表键

作为`make-hash-table`的传递参数`:test`的函数指定了它创建的哈希表的等价性测试.

修改一个对象, 如果存在一组对象(或潜在对象)在修改之前与该对象等价, 修改之后不与该对象等价, 称对象在等价测试下 ==被可见修改==.

如果对象O1用作哈希表H中的键, 后在H的等价测试下被可见修改, 则在后续H的操作中将O1或(修改前或修改后)在等价测试下与其等价的对象O2用作键, 后果是未描述的. 如果O1被可见修改, 后续被再次修改撤销了可见修改, 将O1用作键的后果是未描述的.

下面是哈希表必须支持的等价测试可见的修改的描述. 修改被描述为对组件的修改, 是递归定义的. 对象的组件上可见修改是对象的可见修改.

#### 18.1.2.1 EQ和EQL下对象的可见修改

没有提供`eq`或`eql`等价性测试下可见修改对象的标准函数.

#### 18.1.2.2 EQUAL下对象的可见修改

受`equal`行为的影响, 没有在这一节显式描述的对象可见修改规则, 从**18.1.2.1 EQ和EQL下对象的可见修改**中继承.

##### 18.1.2.2.1 EQUAL下Cons的可见修改

在`equal`等价性测试下, 对一个Cons的car或cdr的可见修改, 被视为该Cons的可见修改.

##### 18.1.2.2.2 EQUAL下位向量和字符串的可见修改

在`equal`等价性测试下, 对类型为`bit-vector`或`string`的向量, 对向量中活跃对象的可见修改, 或对向量长度的可见修改(如果是实际可调整的或者有填充指针), 被视为该向量的可见修改.

#### 18.1.2.3 EQUALP下对象的可见修改

受`equalp`行为的影响, 没有在这一节显式描述的对象可见修改规则, 从**18.1.2.2 EQUAL下对象的可见修改**中继承.

##### 18.1.2.3.1 EQUALP下结构的可见修改

在`equalp`等价性测试下, 对结构的槽的可见修改, 被视为该结构的可见修改.

##### 18.1.2.3.2 EQUALP下数组的可见修改

在`equalp`等价性测试下, 对活跃元素的可见修改、对填充指针的可见修改(如果有)、对维的修改(如果数组是实际可调整的), 被视为该数组的可见修改.

##### 18.1.2.3.3 EQUALP下哈希表的可见修改

在`equalp`等价性测试下, 对哈希表中项数量的可见修改、对键的可见修改、对与键对应的值的可见修改, 被视为该哈希表的可见修改.

注意对键的可见修改依赖于哈希表的等价性测试, 不是`equalp`等价性测试.

#### 18.1.2.4 语言扩展的可见修改

通过提供修改器函数(或既有修改器函数的额外行为)来扩展原因的实现, 必须记录如何结合等价性测试和哈希表搜索使用这些扩展.

通过定义额外的哈希表可接受的等价性测试(允许`make-hash-table`的其它`:test`传递参数的值)来扩展语言的实现, 必须记录这些测试的可见组件.

## 18.2 哈希表的字典

- system class `hash-table`
- function `make-hash-table`
- function `hash-table-p`
- function `hash-table-count`
- function `hash-table-rehash-size`
- function `hash-table-rehash-threshold`
- function `hash-table-size`
- function `hash-table-test`
- accessor `gethash`
- function `remhash`
- function `maphash`
- macro `with-hash-table-iterator`
- function `clrhash`
- function `sxhash`

# 19 文件名

## 19.1 文件名的概述

有多种文件系统, 它们在表面的语法细节和内部的功能和解构方面存在差异. Common Lisp中选择提供的引用和操作文件的工具与多种文件系统兼容, 同时最小化了不同文件系统之间的程序可见的差异.

因为文件系统的文件命名约定存在不同, 有两种表示文件名的方法: **名称字符串**和**路径名**.

### 19.1.1 名称字符串作为文件名

名称字符串是表示文件名的字符串.

通常, 名称字符串的语法使用实现定义的约定, 通常是命名的文件驻留的文件系统的惯例. 唯一的例外是逻辑路径名称字符串的语法, 见**19.3.1 逻辑路径名名称字符串的语法**.

因为Common Lisp没有定义除逻辑路径名之外的可以保证可移植性的名称字符串语法, 符合标准的程序从不无条件使用除逻辑路径名称字符串之外的字面量名称字符串. 然而, 符合标准的程序可以操作用户提供的包含或引用了不可移植的名称字符串的数据.

使用函数`pathname`或`parse-namestring`可以将名称字符串转换成路径名.

### 19.1.2 路径名作为文件名

路径名是结构化的对象, 可以按依赖于实现的方式表示被底层文件系统原生使用的文件名.

此外, 路径名可以表示部分构成的文件名, 底层文件系统可能没有特定的名称字符串表示的文件名.

路径名不需要与实际存在的文件对应, 多个路径名可以引用同一个文件. 例如, 有版本`:newest`的路径名, 可能与没有版本组件但其他组件相同的路径名, 引用同一个文件. 随着时间推移, 有版本`:newest`的路径名可能会引用不同的文件, 因为这个路径名的含义依赖于文件系统的状态.

一些文件系统本质上使用了一个文件名的结构模型, 而其他文件系统没有. 在Common Lisp路径名模型中, 所有文件名被视为有特定的解构, 甚至该结构在底层文件系统中没有对应物时. 路径名引入的结构与底层文件系统使用的结构之间的映射, 是由实现定义的.

每个路径名有6个组件: 主机、设备、目录、名称、类型和版本. 通过使用路径名命名文件, Common Lisp程序可以在多种文件系统上一致性的工作. 关于这些组件的详细信息, 见**19.2.1 路径名的组件**.

路径名组件与每个文件系统中特定概念之间的映射, 是由实现定义的. 存在有路径名、但在特定实现中没有对应的语法有效的文件名的情况. 实现可以使用多种策略找到这个映射; 例如, 实现可以简单的截断超出底层文件系统长度限制的文件名, 或者忽略文件系统不支持的组件. 如果不能找到这个映射, 发布类型`file-error`的错误信号.

这个映射和相应的发出错误信号的时间, 是依赖于实现的. 可以发生在构造路径名时、将路径名转换为文件名时、尝试打开或访问由路径名指示的文件时.

下图列出了可用于路径名的已定义名称.

图 19-1. 路径名操作.

```
*default-pathname-defaults*
directory-namestring
enough-namestring
file-namestring
file-string-length
host-namestring
make-pathname
merge-pathnames
namestring
open
parse-namestring
pathname
pathname-device
pathname-directory
pathname-host
pathname-match-p
pathname-name
pathname-type
pathname-version
pathnamep
translate-pathname
truename
user-homedir-pathname
wild-pathname-p
```

### 19.1.3 将名称字符串解析为路径名

解析是指将名称字符串转换为路径名的操作. 因为名称字符串的格式是依赖于实现的, 除了在解析逻辑路径名称字符串中, 这个操作是依赖于实现的.

符号标准的实现可以在路径名表示中引入其它文件系统的特征, 提供可以处理这种名称字符串描述的解析器. 因为这些特征是不可移植的, 符合标准的程序不能依赖于这些特征.

## 19.2 路径名

### 19.2.1 路径名的组件

路径名有6个组件: 主机、设备、目录、名称、类型和版本.

#### 19.2.1.1 路径名的主机组件

文件驻留的文件系统的名称, 或者是逻辑主机的名称.

#### 19.2.1.2 路径名的设备组件

与多种主机文件系统中设备或文件结构对应: 包含文件的逻辑或物理设备的名称.

#### 19.2.1.3 路径名的目录组件

与多种主机文件系统中目录概念对应: 一组相关文件的名称.

#### 19.2.1.4 路径名的名称组件

一组可被认为是改练相关的文件的名称部分.

#### 19.2.1.5 路径名的类型组件

与多种主机文件系统中文件类型或扩展名对应, 表示文件的种类. 这个组件总是字符串、`nil`、`:wild`或`:unspecific`.

#### 19.2.1.6 路径名的版本组件

与多种主机文件系统中版本号对应.

版本或者是一个正整数, 或者是一个符号: `nil`、`:wild`、`:unspecific`或`:newest`(读取文件时已在文件系统中存在的最大版本号, 或者写入文件时比已在文件系统中存在的版本号大的版本号). 实现可以定义其他特殊的版本符号.

### 19.2.2 解释路径名的组件值

#### 19.2.2.1 组件值中的字符串

##### 19.2.2.1.1 路径名组件中的特殊字符

路径名组件值中的字符串从不包含表示路径名字段间间隔的特殊字符, 例如Unix文件名中的斜线号. 在路径名组件中的字符串中是否允许出现分隔符是由实现定义的; 然而如果实现允许这种情况出现, 在构造名称字符串时需要适当的引用该字符. 例如:

```
;; In a TOPS-20 implementation, which uses ^V to quote
(NAMESTRING (MAKE-PATHNAME :HOST "OZ" :NAME "<TEST>"))
=>  #P"OZ:PS:^V<TEST^V>"
NOT=>  #P"OZ:PS:<TEST>"
```

##### 19.2.2.1.2 路径名组件中的大小写

名称字符串总是使用本地文件系统中的大小写约定, 但Common Lisp中操作路径名组件的函数, 允许调用者提供`:case`关键字传递参数选择组件值的大小写选项. 下图列出了与路径名相关的可以使用`:case`传递参数的函数:

图 19-2. 使用`:CASE`传递参数的路径名函数.

```
make-pathname
pathname-device
pathname-directory
pathname-host
pathname-name
pathname-type
```

###### 19.2.2.1.2.1 路径名组件中的本地大小写

对于**图 19-2**中列出的函数, `:case`传递参数的值为`:local`(默认值)表示, 这些函数应该根据主机文件系统的大小写约定接受和生成组件值中的字符串.

如果文件系统支持大小写, 在该协议下作为路径名组件值指定或接受的字符串应该按书写时大小写处理. 如果文件系统只支持大写或小写, 需要转换字符串的大小写.

###### 19.2.2.1.2.2 路径名组件中的通用大小写

对于**图 19-2**中列出的函数, `:case`传递参数的值为`:common`时, 这些函数应该按如下约定接受或生成组件值中的字符串:

- 所有大写表示使用文件系统特定的大/小写
- 所有小写表示使用与特定大/小写相反的大/小写
- 混合使用表示其自身

注意这些约定在从`:local`转换为`:common`后再转换为`:local`时保持信息.

#### 19.2.2.2 特殊的路径名组件值

##### 19.2.2.2.1 NIL作为组件值

作为路径名组件值, `nil`表示这个组件未填充, 见**19.2.3 合并路径名**.

任意路径名组件的值可以是`nil`.

构造路径名时, 主机组件值为`nil`在一些实现中表示默认主机而不是实际的`nil`.

##### 19.2.2.2.2 :WILD作为组件值

如果路径名组件值是`:wild`, 这个组件被视为通配的, 匹配任何情况.

符合标准的程序必须能够处理`:wild`作为任意路径名组件的值或目录组件值列表的元素的情况.

构造路径名时, 符合标准的实现可以使用`:wild`作为目录、名称、类型或版本组件的值, 但不能用作主机或设备组件的值.

如果构造路径名时将`:wild`用作目录组件的值, 效果与指定列表`(:absolute :wild-inferiors)`一样, 或者在不支持`:wild-inferiors`的文件系统功能中与`(:absolute :wild)`一样.

##### 19.2.2.2.3 :UNSPECIFIC作为组件值

如果将`:unspecific`作为路径名组件值, 这个组件在由路径名表示的文件命中不存在或没有意义.

是否允许在实现可访问的给定文件系统中使用`:unspecific`作为组件值, 是由实现定义的. 因为不能保证在所有实现中被允许, 符合标准的程序从不无条件的将`:unspecific`作为路径名组件值. 然而, 符合标准的程序可以处理用户提供的包含或引用不可移植的路径名组件的数据. 当然符合标准的程序应该能够处理路径名组件值为`:unspecific`的情况.

读取路径名组件值时, 符合标准的实现应该能够准备处理`:unspecific`值.

写入路径名组件值时, 如果路径名组件值为`:unspecific`在文件系统中无意义, 其后果是未定义的.

###### 19.2.2.2.3.1 组件值NIL与:UNSPECIFIC之间的关系

将路径名转换为名称字符串时, 符号`nil`和`:unspecific`导致该字段被视为是空的. 即`nil`和`:unspecific`导致该组件不在名称字符串中出现.

然而, 使用一组默认值合并路径名时, 只有组件值`nil`被默认值替换, 组件值`:unspecific`不会被替换, 见函数`merge-pathnames`和**19.2.3 合并路径名**.

#### 19.2.2.3 通配路径名的限制

通配路径名可以用于函数`directory`, 不可用于函数`open`, 用于`wild-pathname-p`时返回true. 检查通配路径名的通配组件时, 符合标准的程序必须能够处理下面的值在任意组件值或目录组件值列表的元素中出现的情况:

- 符号`:wild`, 匹配任何情况
- 包含依赖于实现的特殊通配字符的字符串
- 任意表示依赖于实现的通配模式的对象

#### 19.2.2.4 检查路径名组件的限制

符合标准的程序中用于存储读取路径名组件值的对象的存储空间, 比用于写入的存储空间大.

尽管这一节的子章节、**19.2.2.2 特殊的路径名组件值**、**19.2.2.3 通配路径名的限制**中讨论的值应用在读取组件值时可能遇到的值, 但在构造路径名时有更受限的规则; 见**19.2.2.5 构造路径名的限制**.

##### 19.2.2.4.1 检查路径名主机组件的限制

哪些对象可用于表示主机是依赖于实现的.

##### 19.2.2.4.2 检查路径名设备组件的限制

设备组件值可以是字符串、`:wild`、`:unspecific`或`nil`.

注意尽管可移植的程序被限制将`:wild`作为组件值写入, `:wild`可能是读取路径名组件值获得的; 见**19.2.2.3 通配路径名的限制**和**19.2.2.5 构造路径名的限制**.

##### 19.2.2.4.3 检查路径名目录组件的限制

目录组件值可以是字符串、`:wild`、`:unspecific`或`nil`.

目录组件值可以是字符串和符号的列表. 这个列表的car是`:absolute`或`:relative`的含义是:

- `:absolute`  
    
- 表示目录路径从根目录开始. `(:absolute)`表示根目录. `(:absolute "foo" "bar" "baz")`在Unix中表示`"/foo/bar/baz"`.
- `:relative`  
    
- 表示目录路径从一个默认目录开始. `(:relative)`与`nil`含义相同, 因此不被使用. `(:relative "foo" "bar")`表示默认目录中有目录`"foo"`, 其中有目录`"bar"`.

这个列表中剩余的元素是字符串或符号.

每个字符串命名了目录结构的一层. 这个字符串应该只包含目录名称自身, 不包含标点符号字符.

在列表中出现字符串的地方都可以使用符号, 表示特殊的文件记法. 下图列出了有标准含义的符号. 允许实现必要时添加任意非`string`类型的对象, 表示不能使用标准的字符串和符号表示的文件系统特征.

提供给文件系统的非字符串对象, 包括下面列出的符号, 如果没有意义, 则发出类型为`file-error`的错误信号. 例如, 在大多数实现中Unix不支持`:wild-inferiors`.

图 19-3. 目录组件中特殊标记.

| 符号              | 含义                   |
| :---------------- | ---------------------- |
| `:wild`           | 通配匹配一层目录结构   |
| `:wild-inferiors` | 通配匹配任意层目录结构 |
| `:up`             | (语义)上一层目录结构   |
| `:back`           | (语法)上一层目录结构   |

上图的备注:

- 无效的组合  
    
- 在`:absolute`或`:wild-inferiors`后使用`:up`或`:back`, 发出类型为`file-error`的错误信号.
- 语法与语义  
    
- 语法表示`:back`的动作只依赖于路径名, 不依赖于文件系统的内容.  
    
- 语义表示`:up`的动作依赖于文件系统的内容; 将有`:up`的路径名解析为目录组件只有`:absolute`和字符串的路径名, 需要探查文件系统.  
    
- `:up`与`:back`的区别在于文件系统是否支持目录的多个名称(可能是符号链接). 例如, 假设目录`(:absolute "X" "Y" "Z")`链接到`(:absolute "A" "B" "C")`, 已存在目录`(:absolute "A" "B" "Q")`和`(:absolute "X" "Y" "Q")`. 则`(:absolute "X" "Y" "Z" :up "Q")`表示`(:absolute "A" "B" "Q")`, 而`(:absolute "X" "Y" "Z" :back "Q")`表示`(:absolute "X" "Y" "Q")`.

###### 19.2.2.4.3.1 无层级文件系统中目录组件

在无层级文件系统中, 路径名目录组件唯一有效的列表值是`(:absolute string)`和`(:absolute :wild)`. 无层级文件系统中不使用`:relative`目录和关键字`:wild-inferiors`、`:up`和`:back`.

##### 19.2.2.4.4 检查路径名名称组件的限制

名称组件值可以是字符串、`:wild`、`:unspecific`或`nil`.

##### 19.2.2.4.5 检查路径名类型组件的限制

类型组件值可以是字符串、`:wild`、`:unspecific`或`nil`.

##### 19.2.2.4.6 检查路径名版本组件的限制

版本组件值可以是符号或整数.

读取、覆盖、追加、替换或查看目录一个已有文件时, 符号`:newest`表示已在文件系统中存在的最大版本号. 创建文件时, 符号`:newest`表示比已有最大版本号大的最小版本号.

符号`nil`、`:unspecific`和`:wild`有特殊的含义和限制; 将**19.2.2.2 特殊的路径名组件值**和**19.2.2.5 构造路径名的限制**.

其它符号和整数有实现定义的含义.

##### 19.2.2.4.7 备注: 路径名版本组件

建议但不要求, 实现中遵循:

- 使用从1开始的正整数作为版本号
- 将符号`:oldest`是被为已有最小版本号
- 使用关键字作为其它特殊版本

#### 19.2.2.5 构造路径名的限制

从组件构造路径名时, 符合标准的程序必须遵循如下规则:

- 任意组件值可以是`nil`. 在一些实现中主机组件值为`nil`表示默认主机而不是实际`nil`.
- 主机、设备、目录、名称和类型组件值可以是字符串. 存在依赖于实现的对字符串中字符的数量和类型的限制.
- 目录组件值可以是字符串和符号的列表. 存在依赖于实现的对列表长度和内容的限制.
- 版本组件值可以是`:newest`.
- 任意组件可以使用另一个路径名中相应组件的值. 对于用于不同文件系统的两个文件名(如果实现支持多文件系统), 需要有一个恰当的翻译过程. 如果没有有含义的翻译过程, 发出错误信号. "恰当的"和"有含义的"的定义是依赖于实现的.
- 实现可以为一些组件提供其他值, 但可移植的程序不能使用这些值. 符合标准的程序可以使用依赖于实现的值, 但会变为不可移植的; 例如, 只可在Unix文件系统上工作.

### 19.2.3 合并路径名

\==合并== 取带有未填充组件的路径名, 从一组默认值中为这些组件提供值.

如果组件值为`nil`, 这个组件被认为是未填充的. 如果组件值是非`nil`的对象, 包括`:unspecific`, 这个组件本人未是已填充的.

除非作特别说明, 操作或查询文件系统中文件的函数, 在访问文件系统之前, 它们的路径名传递参数与`*default-pathname-defaults*`合并(就像使用`merge-pathnames`).

#### 19.2.3.1 示例: 合并路径名

尽管下面的示例可能只能在允许`:unspecific`和4字母类型组件值的实现中执行, 但可以展示路径名合并的基本概念.

```
(pathname-type
  (merge-pathnames (make-pathname :type "LISP")
                   (make-pathname :type "TEXT")))
=>  "LISP"

(pathname-type
  (merge-pathnames (make-pathname :type nil)
                   (make-pathname :type "LISP")))
=>  "LISP"

(pathname-type
  (merge-pathnames (make-pathname :type :unspecific)
                   (make-pathname :type "LISP")))
=>  :UNSPECIFIC
```

## 19.3 逻辑路径名

### 19.3.1 逻辑路径名称字符串的语法

**逻辑路径名称字符串**的语法如下.(注意与该文档中大部分记法描述不同, 这是字符序列的语法描述, 不是对象的结构描述.)

```
logical-pathname::= [host host-marker]
                    [relative-directory-marker] {directory directory-marker}*
                    [name] [type-marker type [version-marker version]]
host::= word
directory::= word | wildcard-word | wild-inferiors-word
name::= word | wildcard-word
type::= word | wildcard-word
version::= pos-int | newest-word | wildcard-version
```

- host-marker: 一个冒号(:).
- relative-directory-marker: 一个分号(;).
- directory-marker: 一个分号(;).
- type-marker: 一个点号(.).
- version-marker: 一个点号(.).
- wild-inferiors-word: 两个字符的序列`**`.
- newest-word: 6个字符的序列`newest`或`NEWEST`.
- wildcard-version: 一个星号(\*).
- wildcard-word: 一个或多个的星号、大写字母、数字和连字符, 至少有一个星号, 没有两个连在一起的星号.
- word: 一个或多个的大写字母、数值和连字符.
- pos-int: 一个正整数.

#### 19.3.1.1 解析逻辑路径名称字符串的额外信息

##### 19.3.1.1.1 逻辑路径名称字符串的主机部分

主机必须已被定义为逻辑路径名主机, 使用`logical-pathname-translations`上的`setf`来定义.

逻辑路径名主键名称`"SYS"`被保留给实现使用. 它的存在和含义是由实现定义的.

##### 19.3.1.1.2 逻辑路径名称字符串的设备部分

因为逻辑路径名的设备组件总是`:unspecific`, 没有逻辑路径名设备的语法; 见**19.3.2.1 逻辑路径名中不确定的组件**.

##### 19.3.1.1.3 逻辑路径名称字符串的目录部分

如果`relative-directory-marker`在`directories`之前出现, 目录组件被相对解析; 否则被绝对解析.

如果有`wild-inferiors-marker`, 被解析为`:wild-inferiors`.

##### 19.3.1.1.4 逻辑路径名称字符串的类型部分

源代码文件的逻辑路径名中`type`是`"LIPS"`. 这应该被翻译为物理路径名中恰当的类型.

##### 19.3.1.1.5 逻辑路径名称字符串的版本部分

一些文件系统没有版本号. 翻译到这种文件系统的逻辑路径名忽略`version`. 这意味着, 程序不能假设可以存储逻辑路径名命名的文件的多个版本.

如果有`wildcard-version`, 被解析为`:wild`.

##### 19.3.1.1.6 逻辑路径名称字符串中通配词

`wildcard-word`中每个星号匹配零个或多个字符的序列. `wildcard-word`为`*`时解析为`:wild`, 其它`wildcard-word`解析为字符串.

##### 19.3.1.1.7 逻辑路径名称字符串中小写字母

解析`words`和`wildcard-words`时, 小写字母被转换为大写.

##### 19.3.1.1.8 逻辑路径名称字符串中其他语法

使用不在这里描述的逻辑路径名称字符串的字符的后果是未描述的.

使用不在这里描述的逻辑路径名称组件的值的后果是未描述的.

### 19.3.2 逻辑路径名组件

#### 19.3.2.1 逻辑路径名中不确定的组件

逻辑路径名称的设备组件总是`:unspecific`; 逻辑路径名称的其他组件不可以是`:unspecific`.

#### 19.3.2.2 空字符串作为逻辑路径名中组件值

空字符串`""`不是有效的逻辑路径名称组件值.

## 19.4 文件名的字典

- system class `PATHNAME`
- system class `LOGICAL-PATHNAME`
- Function `PATHNAME`
- Function `MAKE-PATHNAME`
- Function `PATHNAMEP`
- Function `PATHNAME-HOST`
- Function `PATHNAME-DEVICE`
- Function `PATHNAME-DIRECTORY`
- Function `PATHNAME-NAME`
- Function `PATHNAME-TYPE`
- Function `PATHNAME-VERSION`
- Function `LOAD-LOGICAL-PATHNAME-TRANSLATIONS`
- Accessor `LOGICAL-PATHNAME-TRANSLATIONS`
- Function `LOGICAL-PATHNAME`
- Variable `*DEFAULT-PATHNAME-DEFAULTS*`
- Function `NAMESTRING`
- Function `FILE-NAMESTRING`
- Function `DIRECTORY-NAMESTRING`
- Function `HOST-NAMESTRING`
- Function `ENOUGH-NAMESTRING`
- Function `PARSE-NAMESTRING`
- Function `WILD-PATHNAME-P`
- Function `PATHNAME-MATCH-P`
- Function `TRANSLATE-LOGICAL-PATHNAME`
- Function `TRANSLATE-PATHNAME`
- Function `MERGE-PATHNAMES`

# 20 文件

## 20.1 文件系统的概念

这一部分描述Common Lisp中的文件系统接口. 这个接口的模型假设文件是由文件名命名的, 文件名可用路径名对象表示, 按给定路径名可以构造连接到其表示的文件的流.

关于打开和关闭文件、操作文件内容的信息, 见**21. 流**.

下图列出了可用于文件和目录的操作符.

图 20-1. 文件和目录操作.

```
compile-file
delete-file
directory
file-author
file-length
file-position
file-write-date
load
open
probe-file
rename-file
with-open-file
```

### 20.1.1 将流转换为路径名

与文件关联的流或者是文件流, 或者是等价于与文件关联的流的同义流. 这些流可以用作路径名指示器.

通常, 当与文件关联的流用作指示器时, 它表示用于打开这个文件的路径名; 可以是但不要求是文件的实际名称.

一些函数, 例如`truename`、`delete-file`, 按不同的方式将流转换为路径名, 包括引用实际打开的文件, 它可以是也可以不是最初用其名称打开的文件. 这些特殊情况总被特别的记录, 不是默认情况.

### 20.1.2 在打开的和关闭的流上的文件操作

大量执行文件操作的函数, 接受打开的流或关闭的流作为传递参数, 见**21.1.3 标准函数的流传递参数**.

下图列出的函数视打开的流与关闭的流是不同的:

图 20-2. 视打开的流与关闭的流是不同的文件函数.

```
delete-file
directory
file-author
file-write-date
probe-file
truename
```

实现之间对文件系统打开的流的处理方式存在差异, 然而, 关闭的流可能是一些函数中最可靠的一种传递参数, 这些函数列在下图中. 例如, 在一些文件系统中, 打开的文件用临时文件写入, 在关闭前不被重命名和/或在关闭钱不可见. 通常, 可移植的代码需要谨慎的使用这种函数.

图 20-3. 最好使用关闭的流的文件函数.

```
directory
probe-file
truename
```

### 20.1.3 真名称

许多文件系统允许多个文件名指定一个特定的文件.

在可能出现一个文件多个名称时, 大多数文件系统有为这种情况生成标准文件名的约定. 这种标准文件名(或表示这种文件名的路径名)被称为 ==真名称==.

因为文件系统中的符号链接、版本号、逻辑设备翻译, Common Lisp中逻辑路径名翻译, 和文件系统的其它特性的存在, 文件的真名称可以与文件的其它文件名不同.

文件的真名称通常但不一定是唯一的. 例如, 有多个硬链接的Unix文件可以有多个真名称.

#### 20.1.3.1 示例: 真名称

例如, 在DEC TOPS-20系统中有文件`PS:<JOE>FOO.TXT.1`和`PS:<JOE>FOO.TXT.2`, 可以允许第二个文件被引用为`PS:<JOE>FOO.TXT.0`, 因为`.0`标记表示文件的最新版本. 在这个文件系统中, 逻辑设备`JOE:`引用`PS:<JOE>`, 从而名称`JOE:FOO.TXT.2`或`JOE:FOO.TXT.0`可以引用`PS:<JOE>FOO.TXT.2`. 在这些情况中, 这个文件的真名称是`PS:<JOE>FOO.TXT.2`.

如果一个文件是另一个文件的符号链接(在有符号链接的文件系统中), 通常约定这个文件的真名称是跟随符号链接后的文件的标准名称; 即如果文件的输入流被打开, 其内容可用的文件的标准名.

在文件仍处于创建中(即打开了文件的输出流), 这个文件的真名称可能在流被关闭之前不可知. 这这种情况中, 函数`truename`可能在流被关闭之前和之后返回不同的值. 实际上, 在流关闭之前, `truename`返回的值可能不是文件系统中有效的名称, 例如, 在所有文件有数值版本的文件系统中, 当写入文件时, 它可能有版本`:newest`, 可能在文件被关闭后再指定一个数值版本值.

## 20.2 文件的字典

- function `directory`
- function `probe-file`
- function `ensure-directories-exist`
- function `truename`
- function `file-author`
- function `file-write-date`
- function `rename-file`
- function `delete-file`
- condition type `file-error`
- function `file-error-pathname`

# 21 流

## 21.1 流的概念

### 21.1.1 流的介绍

流是一个对象, 被输入或输出函数使用, 用于表示该操作的字符或字节的源或汇. 字符流是字符的源或汇. 二进制流是字节的源或汇.

一些操作可以在任何种类的流上执行; 下图列出了可在任何种类的流上可用的标准操作.

图 21-1. 一些通用流操作.

```
close
input-stream-p
interactive-stream-p
output-stream-p
stream-element-type
streamp
with-open-stream
```

其它的操作只在特定流类型上有意义. 例如, `read-char`只可用于字符流, `read-byte`只可用于二进制流.

#### 21.1.1.1 流的抽象分类 - 1

##### 21.1.1.1.1 输入、输出和双向流

流, 不管是字符流还是二进制流, 可以是输入流(数据的来源)、输出流(数据的汇), 或者两者都是(`open`中使用`:direction :probe`).

下图列出了与输入流相关的操作符:

图 21-2. 与输入流相关的操作符.

```
clear-input
listen
peek-char
read
read-byte
read-char
read-char-no-hang
read-delimited-list
read-from-string
read-line
read-preserving-whitespace
unread-char
```

下图列出了与输出流相关的操作符:

图 21-3. 与输出流相关的操作符.

```
clear-output
finish-output
force-output
format
fresh-line
pprint
prin1
prin1-to-string
princ
princ-to-string
print
terpri
write
write-byte
write-char
write-line
write-string
write-to-string
```

同时是输入流和输出流的流称为双向流. 见函数`input-stream-p`和`output-stream-p`.

上面的两个图中的操作符都可用于双向流. 此外, 下图列出了特定的与双向流相关的操作符:

图 21-4. 与双向流相关的操作符.

```
y-or-n-p
yes-or-no-p
```

##### 21.1.1.1.2 打开的和关闭的流

流或者是打开的, 或者是关闭的.

除非特别说明, 创建和返回流的操作返回打开的流.

关闭流的动作标记流作为数据的源或汇的使用结束, 允许实现释放内部数据结构、释放可能被流打开时锁住的外部资源.

除非特别说明, 调用流时传入关闭的流的后果是未定义的.

可以将关闭的流转换为路径名; 在一些情况中, 例如真名称计算, 在关闭的流上转换的结果可能与打开的流的结果不同.

##### 21.1.1.1.3 交互式流

交互式流是可以执行交互式查询的流.

交互式流的准确含义是由实现定义的, 可能依赖于底层操作系统. 实现选择的用于表示交互式流的特征的内容的例子:

- 流连接到人(或等价物), 程序提示信息, 期望收到不同的输入.
- 程序提示输入, 支持常见的输入编辑.
- `read-char`可能在立即返回一个字符串或文件结束符之前, 等待用户的输入.

包含交互式流的意图是将这些流与有批量(背景或命令文件)输入的流区分开. 到批量流的输出通常被忽略或者保存以便后续查看, 所以对这种流的交互式查询可能不可用.

终端IO可以是也可以不是一个交互式流.

#### 21.1.1.2 流的抽象分类 - 2

##### 21.1.1.2.1 文件流

一些称为文件流的流, 可用于访问文件. 类`file-stream`的对象用于表示文件流.

打开文件的基本操作是`open`, 它返回一个文件流. 关闭流的基本操作是`close`. 宏`with-open-file`用于表示打开文件并执行一个代码体、并确保退出代码体时文件的习惯用法.

#### 21.1.1.3 流的其他子类

类`stream`有一些子类. 下图列出了关于这些子类的信息:

图 21-5. 与特殊的流相关的已定义名称.

| 类                  | 相关操作符                                                                                                                                   |
| :------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| broadcast-stream    | make-broadcast-stream  <br>broadcast-stream-streams                                                                                          |
| concatenated-stream | make-concatenated-stream  <br>concatenated-stream-streams                                                                                    |
| echo-stream         | make-echo-stream  <br>echo-stream-input-stream  <br>echo-stream-output-stream                                                                |
| string-stream       | make-string-input-stream  <br>with-input-from-string  <br>make-string-output-stream  <br>with-output-to-string  <br>get-output-stream-string |
| synonym-stream      | make-synonym-stream  <br>synonym-stream-symbol                                                                                               |
| two-way-stream      | make-two-way-stream  <br>two-way-stream-input-stream  <br>two-way-stream-output-stream                                                       |

### 21.1.2 流变量

值必须是流的变量被称为流变量.

该规范中为多种需要输入或输出时但没有提供特定的流的情况, 定义了一些流变量. 下图列出了这些标准流变量. 如果任意时刻这些变量的值不是打开的流, 后果是未定义的.

图 21-6. 标准的流变量.

| 术语      | 变量名称            |
| :-------- | :------------------ |
| 调试IO    | `*debug-io*`        |
| 错误输出  | `*error-output*`    |
| 查询IO    | `*query-io*`        |
| 标准输入  | `*standard-input*`  |
| 标准输出  | `*standard-output*` |
| 终端IO    | `*terminal-io*`     |
| trace输出 | `*trace-output*`    |

注意, 通常标准的流变量, 如果是输入流则名称以`-input*`结束, 如果是输出流则名称已`-output*`结束, 如果是双向流则以`-io*`结束.

用户程序可以指派或绑定除`*terminal-io*`之外的任意标准的流变量.

### 21.1.3 标准函数的流传递参数

下图中的操作符接受打开的或关闭的流的流传递参数:

图 21-7. 接受打开的或关闭的流的操作符.

```
broadcast-stream-streams
close
compile-file
compile-file-pathname
concatenated-stream-streams
delete-file
directory
directory-namestring
dribble
echo-stream-input-stream
echo-stream-ouput-stream
ed
enough-namestring
file-author
file-namestring
file-write-date
host-namestring
load
logical-pathname
merge-pathnames
namestring
open
open-stream-p
parse-namestring
pathname
pathname-match-p
pathnamep
probe-file
rename-file
streamp
synonym-stream-symbol
translate-logical-pathname
translate-pathname
truename
two-way-stream-input-stream
two-way-stream-output-stream
wild-pathname-p
with-open-file
```

下图中的操作符只接受打开的流的流传递参数:

图 21-8. 只接受打开的流的操作符.

```
clear-input
clear-output
file-length
file-position
file-string-length
finish-output
force-output
format
fresh-line
get-output-stream-string
input-stream-p
interactive-stream-p
listen
make-broadcast-stream
make-concatenated-stream
make-echo-stream
make-synonym-stream
make-two-way-stream
output-stream-p
peek-char
pprint
pprint-fill
pprint-indent
pprint-linear
pprint-logical-block
pprint-newline
pprint-tab
pprint-tabular
prin1
princ
print
print-object
print-unreadable-object
read
read-byte
read-char
read-char-no-hang
read-delimited-list
read-line
read-preserving-whitespace
stream-element-type
stream-external-format
terpri
unread-char
with-open-stream
write
write-byte
write-char
write-line
write-string
y-or-n-p
yes-or-no-p
```

### 21.1.4 聚合流的限制

如果聚合流中的任意组件在聚合流关闭之前是关闭的, 后果是未定义的.

如果从同义流的创建到关闭期间, 同义流符号没有绑定到打开的流, 后果是未定义的.

## 21.2 流的字典

- system class `stream`
- system class `broadcast-stream`
- system class `concatenated-stream`
- system class `echo-stream`
- system class `file-stream`
- system class `string-stream`
- system class `synonym-stream`
- system class `two-way-stream`
- function `input-stream-p`
- function `output-stream-p`
- function `interactive-stream-p`
- function `open-stream-p`
- function `stream-element-type`
- function `streamp`
- function `read-byte`
- function `write-byte`
- function `peek-char`
- function `read-char`
- function `read-char-no-hang`
- function `terpri`
- function `fresh-line`
- function `unread-char`
- function `write-char`
- function `read-line`
- function `write-string`
- function `write-line`
- function `read-sequence`
- function `write-sequence`
- function `file-length`
- function `file-position`
- function `file-string-length`
- function `open`
- function `stream-external-format`
- macro `with-open-file`
- function `close`
- macro `with-open-stream`
- function `listen`
- function `clear-input`
- function `finish-output`
- function `force-output`
- function `clear-output`
- function `y-or-n-p`
- function `yes-or-no-p`
- function `make-synonym-stream`
- function `synonym-stream-symbol`
- function `broadcast-stream-streams`
- function `make-broadcast-stream`
- function `make-two-way-stream`
- function `two-way-stream-input-stream`
- function `two-way-stream-output-stream`
- function `echo-stream-input-stream`
- function `echo-stream-output-stream`
- function `make-echo-stream`
- function `concatenated-stream-streams`
- function `make-concatenated-stream`
- function `get-output-stream-string`
- function `make-string-input-stream`
- function `make-string-output-stream`
- macro `with-input-from-string`
- macro `with-output-to-string`
- variable `*debug-io*`
- variable `*error-output*`
- variable `*query-io*`
- variable `*standard-input*`
- variable `*standard-output*`
- variable `*trace-output*`
- variable `*terminal-io*`
- condition type `stream-error`
- function `stream-error-stream`
- condition type `end-of-file`

# 22 打印器

## 22.1 Lisp打印器

### 22.1.1 Lisp打印器概述

Common Lisp提供了大多数对象的打印文本的表示, 称为打印的表示. 诸如`print`函数接受一个对象, 将它的打印的表示发送给流. 执行这个操作的一组例程称为(Common Lisp)打印器.

读取打印的形式通常生成与原始打印的对象`equal`语义下相同的对象.

#### 22.1.1.1 多种可能的文本表示

大多数对象有多个可能的文本表示. 例如, 正数27有下述方式的文本表示:

```
27    27.    #o33    #x1B    #b11011    #.(* 3 3 3)    81/3
```

包含两个符号A和B的列表可以有多种文本表示:

```
(A B)    (a b)    (  a  b )    (\A |B|)
(|\A|
 B
)
```

通常, 从Lisp读取器的视角看, 在文本表示中允许出现空格的位置, 标准语法中允许出现任意数量的空白和换行.

诸如`print`函数产生打印的表示时, 必须从多种可能的文本表示中做出选择. 在大多数情况下, 它会选择一个程序可读的表示, 但在特定情况下它会选择更紧凑的但不是程序可读的表示.

一些称为打印器控制变量的可选变量, 用于控制对象打印的表示的各个方面. 下图展示了标准的打印器控制变量; 可能也有一些实现定义的打印器控制变量.

图 22-1. 标准的打印器控制变量.

```
*print-array*
*print-base*
*print-case*
*print-circle*
*print-escape*
*print-gensym*
*print-length*
*print-level*
*print-lines*
*print-miser-width*
*print-pprint-dispatch*
*print-pretty*
*print-radix*
*print-readably*
*print-right-margin*
```

除了打印器控制变量外, 下面的已定义名称与Lisp打印器的行为相关或影响该行为:

图 22-2. Lisp打印器的额外影响因素.

```
*package*
*read-default-float-format*
*read-eval*
*readtable*
readtable-case
```

#### 22.1.1.2 打印器的转义

变量`*print-escape*`控制Lisp打印器是否尝试产生诸如转义字符和包前缀的标记.

变量`*print-readably*`用于在程序可读的输出特别重要时, 覆盖其它打印器控制变量控制的多个独立方面.

将`*print-readably*`设置为true的多个作用中的其中一个是Lisp打印器的行为就像`*print-escape*`同时也设置为true一样. 为便于描述, 我们说如果`*print-readably*`或`*print-escape*`为true, 则打印器的转义是开启的, 如果`*print-readably*`和`*print-escape*`都是false, 则打印器的转义是关闭的.

### 22.1.2 打印器的分发

Lisp打印器就如何打印对象的决策如下:

如果`*print-pretty*`的值为true, 打印由当前美观打印分发表控制; 见**22.2.1.4 美观打印分发表**.

否则(如果`*print-pretty*`的值为false), 使用对象的`print-object`方法; 见**22.1.3 默认的print-object方法**.

### 22.1.3 默认的print-object方法

这一节描述标准类型的`print-object`方法的默认行为.

#### 22.1.3.1 打印数值

##### 22.1.3.1.1 打印整数

整数按当前输出基指定的基数打印, 最重要的数字优先. 合适的情况下, 基数描述符也被打印出; 见`*print-radix*`. 如果是负整数, 先打印一个负号, 接着打印出该整数的绝对值. 整数零由单个数字0表示, 不带符号. 依赖于`*print-radix*`的值, 可以打印出小数点.

关于整数的信息见**2.3.2.1.1 整数的语法**.

##### 22.1.3.1.2 打印比值

比值按如下方式打印: 作为整数打印分子的绝对值, 一个`/`, 然后是分母. 分子和分母都按当前输出基指定的基数被打印; 它们是用`numerator`和`denominator`获取的, 所以比值是按化简后的形式打印的. 合适的情况下, 可以打印出基数描述符. 如果比值是负的, 在分子之前打印一个负号.

关于比值的语法信息见**2.3.2.1.2 比值的语法**.

##### 22.1.3.1.3 打印浮点数

如果浮点数的数量级是0或者在10^-3(包含)与10^7(不包含)之间, 先打印数值的整数部分, 然后是一个小数点, 然后是数值的小数部分; 小数点的两边总是至少有一个数字. 如果数值的符号(由`float-sign`确定)是负号, 则在数值之前打印一个负号. 如果数值的格式不与`*read-default-float-format*`指定的格式匹配, 则也打印出该格式的指数标记和数字0. 例如, 作为短浮点数的自然对数的基被打印为2.71828S0.

对于范围10^-3到10^7之外的非零数量级, 浮点数按计算机科学记数法打印. 数值的表示被缩放到1(包括)与10(不包含)之间后再打印, 在小数点之前有一个数字, 之后至少有一个数字. 接着打印出格式的指数标记, 除非数值的格式匹配`*read-default-float-format*`指定的格式, 接着使用指数标记`E`. 最后, 将与小数部分乘后与原始数值相等的10的幂作为十进制整数打印. 例如, 作为短浮点数的Avogadro数被打印为6.02S23.

关于浮点数的语法信息见**2.3.2.2 浮点数的语法**.

##### 22.1.3.1.4 打印复数

复数打印为`#C`、一个`(`、实数部分的打印表示、一个空格、虚数部分的打印表示和一个`)`.

关于复数的语法信息见**2.3.2.3 复数的语法**和**2.4.8.11 `#C`**.

##### 22.1.3.1.5 备注: 打印数值

数值的打印表示必须不能包含转义字符; 见**2.3.1.1.1 转义字符与可能的数值**.

#### 22.1.3.2 打印字符

当打印器的转义开启时, 字符打印为其自身; 直接被发送给输出流. 当打印器的转义开启时, 使用`#\`语法.

当打印器打出字符的名称时, 使用与读取器宏`#\`相同的表示; 因此任何打出的字符名称可被输入接受(在那个实现中). 如果一个非图形字符有标准的名称, 则在打印`#\`标记时这个名称较非标准名称优先. 对图形标准字符, 这个字符总是在打印`#\`标记中使用, 甚至在这个字符有一个名称时.

关于读取器宏`#\`的详情见**2.4.8.1 `#C`**.

#### 22.1.3.3 打印符号

当打印器的转义开启时, 只输出符号名称的字符(但名称中打印字符的大小写由`*print-case*`控制; 见**22.1.3.3.2 readtable的大小写对Lisp打印器的影响**).

这一节的剩余部分只应用在打印器的转义开启时.

当打印符号时, 打印器插入足够的单转义和/或多转义字符(`\`和或`|`), 保证如果使用相同的`*readtable*`和绑定到当前输出基的`*read-base*`调用`read`, 会返回相同的符号(如果它不是明显非内部化)或者有相同打印名称的非内部化符号(其它情况下).

例如, 如果打印符号`face`时`*print-base*`的值是16, 因为记号`face`将被读取为十六进制数(十进制数值为64206), 它将被打印为`\FACE`或`\Face`或`|FACE|`.

关于在当前readtable中有非标准语法类型的字符上的约束信息见变量`*print-readably*`.

关于Lisp读取器如何解析符号的信息, 见**2.3.4 符号记号**和**2.4.8.5 `#:`(sharpsign colon)**.

当`*print-pretty`为true且打印器的转义开启时, `nil`被打印为`()`.

##### 22.1.3.3.1 符号的包前缀

必要时要打印出包前缀. 包前缀的打印规则如下. 打印符号时, 如果它在`KEYWORD`包中, 则它使用前缀`:`打印; 否则, 如果在当前包中它是可访问的, 则它不使用任何包前缀打印; 否则使用包前缀打印.

如果`*print-gensym*`为true且打印器的转义开启, 明显非内部化的符号使用前缀`#:`打印; 如果`*print-gensym*`为false或打印器的转义关闭, 则不使用前缀打印, 就像在当前包中一样.

因为`#:`语法不会内部化后续的符号, 如果`*print-circle*`为true且相同的非内部化符号在需要打印出的表达式中出现多次, 需要使用循环列表语法. 例如, `(let ((x (make-symbol "FOO"))) (list x x))`的结果在`*print-circle*`为false时打印为`(#:foo #:foo)`, 在`*print-circle*`为true时打印为`(#1=#:foo #1#)`.

前面描述的包前缀规则总结如下:

- `foo:bar`  
    
- 当符号`bar`在其主包`foo`中是外部化的, 在当前包中不可访问时打印出`foo:bar`.
- `foo::bar`  
    
- 当符号`bar`在其主包`foo`中是内部化的, 在当前包中不可访问时打印出`foo::bar`.
- `:bar`  
    
- 当符号`bar`的主包是`KEYWORD`包时打印出`:bar`.
- `#:bar`  
    
- 当符号`bar`是明显未内部化的, 甚至在`bar`没有主包但在当前包中可访问时, 初始`#:bar`.

##### 22.1.3.3.2 readtable的大小写对Lisp打印器的影响

当打印器的转义关闭, 或者字符没有使用单转义或多转义语法, 当前readtable的大小写影响Lisp打印器打印符号的方式:

- `:upcase`  
    
- 当readtable的大小写是`:upcase`, 大写字符按`*print-case*`指定的大小写打印, 小写字符打印为自身.
- `:downcase`  
    
- 当readtable的大小写是`:downcase`, 大写字符打印为自身, 小写字符按`*print-case*`指定的大小写打印.
- `:preserve`  
    
- 当readtable的大小写是`:preserve`, 所有字母字符打印为自身.
- `:invert`  
    
- 当readtable的大小写是`:invert`, 只有一个大小写情况的符号名称中所有字母字符的大小写被翻转. 混合大小写的字符名称打印为自身.

如果打印器的转义开始, 转义符号名称中字母字符的规则受`readtable-case`影响. 字母字符按如下方式转义:

- `:upcase`  
    
- 当readtable的大小写是`:upcase`, 所有小写字符必须被转义.
- `:downcase`  
    
- 当readtable的大小写是`:downcase`, 所有大写字符必须被转义.
- `:preserve`  
    
- 当readtable的大小写是`:preserve`, 不需要转义字母字符.
- `:invert`  
    
- 当readtable的大小写是`:invert`, 不需要转义字母字符.

###### 22.1.3.3.2.1 示例: readtable的大小写对Lisp 打印器的影响

```
(defun test-readtable-case-printing ()
  (let ((*readtable* (copy-readtable nil))
        (*print-case* *print-case*))
    (format t "READTABLE-CASE *PRINT-CASE*  Symbol-name  Output~
             ~%--------------------------------------------------~
             ~%")
    (dolist (readtable-case '(:upcase :downcase :preserve :invert))
      (setf (readtable-case *readtable*) readtable-case)
      (dolist (print-case '(:upcase :downcase :capitalize))
        (dolist (symbol '(|ZEBRA| |Zebra| |zebra|))
          (setq *print-case* print-case)
          (format t "~&:~A~15T:~A~29T~A~42T~A"
                  (string-upcase readtable-case)
                  (string-upcase print-case)
                  (symbol-name symbol)
                  (prin1-to-string symbol)))))))
```

`(test-readtable-case-printing)`的输出如下:

```
READTABLE-CASE *PRINT-CASE*  Symbol-name  Output
--------------------------------------------------
:UPCASE        :UPCASE       ZEBRA        ZEBRA
:UPCASE        :UPCASE       Zebra        |Zebra|
:UPCASE        :UPCASE       zebra        |zebra|
:UPCASE        :DOWNCASE     ZEBRA        zebra
:UPCASE        :DOWNCASE     Zebra        |Zebra|
:UPCASE        :DOWNCASE     zebra        |zebra|
:UPCASE        :CAPITALIZE   ZEBRA        Zebra
:UPCASE        :CAPITALIZE   Zebra        |Zebra|
:UPCASE        :CAPITALIZE   zebra        |zebra|
:DOWNCASE      :UPCASE       ZEBRA        |ZEBRA|
:DOWNCASE      :UPCASE       Zebra        |Zebra|
:DOWNCASE      :UPCASE       zebra        ZEBRA
:DOWNCASE      :DOWNCASE     ZEBRA        |ZEBRA|
:DOWNCASE      :DOWNCASE     Zebra        |Zebra|
:DOWNCASE      :DOWNCASE     zebra        zebra
:DOWNCASE      :CAPITALIZE   ZEBRA        |ZEBRA|
:DOWNCASE      :CAPITALIZE   Zebra        |Zebra|
:DOWNCASE      :CAPITALIZE   zebra        Zebra
:PRESERVE      :UPCASE       ZEBRA        ZEBRA
:PRESERVE      :UPCASE       Zebra        Zebra
:PRESERVE      :UPCASE       zebra        zebra
:PRESERVE      :DOWNCASE     ZEBRA        ZEBRA
:PRESERVE      :DOWNCASE     Zebra        Zebra
:PRESERVE      :DOWNCASE     zebra        zebra
:PRESERVE      :CAPITALIZE   ZEBRA        ZEBRA
:PRESERVE      :CAPITALIZE   Zebra        Zebra
:PRESERVE      :CAPITALIZE   zebra        zebra
:INVERT        :UPCASE       ZEBRA        zebra
:INVERT        :UPCASE       Zebra        Zebra
:INVERT        :UPCASE       zebra        ZEBRA
:INVERT        :DOWNCASE     ZEBRA        zebra
:INVERT        :DOWNCASE     Zebra        Zebra
:INVERT        :DOWNCASE     zebra        ZEBRA
:INVERT        :CAPITALIZE   ZEBRA        zebra
:INVERT        :CAPITALIZE   Zebra        Zebra
:INVERT        :CAPITALIZE   zebra        ZEBRA
```

#### 22.1.3.4 打印字符串

字符串中字符按顺序打印. 如果打印器的转义开始, 字符串之前和之后输出`"`, 字符串中所有`"`和单转义需要前继有`\`. 打印字符串不受`*print-array*`影响. 只打印字符串的活跃元素.

关于Lisp读取洗如何解析字符串的信息, 见**2.4.5 `"`(double-quote)**.

#### 22.1.3.5 打印列表和Cons

在可能的情况下, 列表记法优先于点记法. 因此, 使用下述算法打印Cons x:

1. 打印`(`.
2. 打印x的car.
3. 如果x的cdr是一个Cons, 将其设置为当前Cons, 打印器一个空格, 进入步骤2.
4. 如果x的cdr不是空、空格、点, 打印x的cdr.
5. 打印`)`.

实际上上述算法只在`*print-pretty*`为false是使用. 当`*print-pretty*`为true(或者使用`pprint`)时, 额外空格可以替代单个空格, 使用有相似目标但更有表示灵活性的更高效算法; 见**22.1.2 打印器的分发**.

尽管下面的两个表达式是等价的, 读取器均会产生相同的Cons, 打印器总是使用第二种形式:

```
(a . (b . ((c . (d . nil)) . (e . nil))))
(a b (c d) e)
```

Cons的引起受`*print-level`、`*print-length*`和`*print-circle*`的影响.

下面是列表的打印表示的示例:

```
(a . b)     ;A dotted pair of a and b
(a.b)       ;A list of one element, the symbol named a.b
(a. b)      ;A list of two elements a. and b
(a .b)      ;A list of two elements a and .b
(a b . c)   ;A dotted list of a and b with c at the end; two conses
.iot        ;The symbol whose name is .iot
(. b)       ;Invalid -- an error is signaled if an attempt is made to read this syntax.
(a .)       ;Invalid -- an error is signaled.
(a .. b)    ;Invalid -- an error is signaled.
(a . . b)   ;Invalid -- an error is signaled.
(a b c ...) ;Invalid -- an error is signaled.
(a \. b)    ;A list of three elements a, ., and b
(a |.| b)   ;A list of three elements a, ., and b
(a \... b)  ;A list of three elements a, ..., and b
(a |...| b) ;A list of three elements a, ..., and b
```

关于Lisp读取器如何解析列表和Cons的信息, 见**2.4.1 `(`(left-parenthesis)**.

#### 22.1.3.6 打印位向量

位向量打印为`#*`后接按序排列的位向量中的位. 如果`*print-array*`为false, 则位向量按简洁但不可读的格式(使用`#<`)打印. 只打印位向量中的活跃元素.

关于Lisp读取器如何解析位向量的信息, 见**2.4.8.4 `#*`(sharpsign asterisk)**.

#### 22.1.3.7 打印其它向量

如果`*print-array*`为true, `*print-readably*`为false, 不是字符串或位向量的向量使用通用向量语法打印; 这意味着特化的向量表示的信息不回出现. 长度为零的向量的打印表示是`#()`. 长度非零的向量的打印表示以`#(`开始. 然后打印向量的第一个元素. 如果有其它元素, 它们按需打印, 如果`*print-pretty*`为false时每个元素前继有空格, 为true是有空白. 在最后一个元素之后的`)`结束向量的打印表示. 打印向量受`*print-level*`和`**print-length`影响. 如果向量有填充指针, 只打印在填充指针之前的元素.

如果`*print-array*`和`*print-readably*`都为false, 向量不按上面描述的方式打印, 按使用`#<`的间接但不可读的格式打印.

如果`*print-readably*`为true, 按实现定义的方式打印向量, 见变量`*print-readably*`.

关于Lisp读取器如何解析这些其它向量的信息, 见**2.4.8.3 `#(`(sharpsign left-parenthesis)**.

#### 22.1.3.8 打印其它数组

如果`*print-array*`为true, `*print-readably*`为false, 不是向量的数组使用`#nA`格式打印. `n`是数组的维秩. 先打印`#`, 将`n`作为十进制整数打印, 然后打印`A`和`n`个`(`. 接着, 按行主序顺序扫描元素, 在每个元素上使用`write`, 使用空白分隔元素. 数组的维按从左至右的顺序编号为0到`n-1`, 按最右的索引变化最快的方式枚举. 每当维j的索引递增时, 采取下述动作

- 如果 j < n-1, 打印`)`.
- 如果维j的索引递增导致它等于维j, 这个索引被重置为0, 递增维j-1的索引(从而递归的执行这三个步骤), 除非j=0, 这时整个算法结束. 如果维j的索引递增未导致它等于维j, 打印一个空格.
- 如果 j < n-1, 打印`(`.

这导致打印的内容的格式适用于`make-array`的`:initial-contents`. 这个过程打印的列表会被`*print-level`和`*print-length*`截断.

如果列表是特化的类型, 包含位或字符, 则按上述算法生成的最内层列表可以使用位向量或字符串语法打印, 这些内层列表不会被`*print-length*`截断.

如果`*print-array*`和`*print-readably*`都为false, 则数组按简洁但不可读的格式(使用`#<`)打印.

如果`*print-readably*`为true, 数组按实现定义的方式打印; 见变量`*print-readably*`. 通常这对有维0的数组是中药的.

关于Lisp读取器如何解析这些其它数组的信息, 见**2.4.8.12 `#A`(sharpsign A)**.

#### 22.1.3.9 示例: 打印数组

```
(let ((a (make-array '(3 3)))
      (*print-pretty* t)
      (*print-array* t))
  (dotimes (i 3) (dotimes (j 3) (setf (aref a i j) (format nil "<~D,~D>" i j))))
  (print a)
  (print (make-array 9 :displaced-to a)))
>>  #2A(("<0,0>" "<0,1>" "<0,2>")
>>      ("<1,0>" "<1,1>" "<1,2>")
>>      ("<2,0>" "<2,1>" "<2,2>"))
>>  #("<0,0>" "<0,1>" "<0,2>" "<1,0>" "<1,1>" "<1,2>" "<2,0>" "<2,1>" "<2,2>")
=>  #<ARRAY 9 indirect 36363476>
```

#### 22.1.3.10 打印随机状态

没有指定打印类型为`random-state`的对象的特定语法. 摊儿, 每个实现必须以下述方式打印随机状态对象, 在相同的实现中, `read`可以从打印的表示中构造随机状态对象的一个副本, 就像使用`make-random-state`生成的副本一样.

如果是使用`defstruct`进制实现打印随机状态的, 可以使用常规的解构语法打印随机状态对象; 可能看到:

```
#S(RANDOM-STATE :DATA #(14 49 98436589 786345 8734658324 ... ))
```

这里的构成部分是依赖于实现的.

#### 22.1.3.11 打印路径名

当打印器的转义开启时, 语法`#P"..."`是使用`write`和这里描述的其它函数打印路径名的方式. `"..."`是路径名的名称字符串表示.

当打印器的转义关闭时, `write`用输出`(namestring P)`替代输出路径名P.

关于Lisp读取器如何解析路径名的信息, 见**2.4.8.14 `#P`(sharpsign P)**.

#### 22.1.3.12 打印结构

默认情况下, 类型为S的解构使用`#S`语法发音. 这个行为可以用在定义S的`defstruct`形式中指定`:print-function`或`:print-object`选项, 或者通过编写特化到类型S的对象上的`print-object`方法来定制.

不同的结构可能按不同的方式打印; 结构的默认记法为:

```
#S(structure-name {slot-key slot-value}*)
```

这里`#S`标记结构语法, `structure-name`是结构名称, 每个`slot-key`是结构中槽的初始化传递参数名称, 每个相应的`slot-value`是槽中对象的表示.

关于Lisp读取器如何解析结构的信息, 见**2.4.8.13 `#S`(sharpsign S)**.

#### 22.1.3.13 打印其它对象

其它对象按依赖于实现的方式打印. 不要求实现将这些对象打印为可读的.

例如, 哈希表、readtable、包、流和函数不要求打印为可读的.

用于这种情况的常见记法是`#<...>`. 因为Lisp读取器不可读`#<`, 其后续的文本格式是不重要的, 当宏`print-unreadable-object`提供了一个常见的格式.

关于Lisp读取器如何处理这种记法的信息, 见**2.4.8.20 `#<`(sharpsign less-than-sign)**. 关于如何标记不能打印为可读的对象的信息见**2.4.8.6 `#.`(sharpsign dot)**.

### 22.1.4 示例: 打印器行为

```
(let ((*print-escape* t)) (fresh-line) (write #\a))
>>  #\a
=>  #\a
```

```
(let ((*print-escape* nil) (*print-readably* nil))
  (fresh-line)
  (write #\a))
>>  a
=>  #\a
```

```
(progn (fresh-line) (prin1 #\a))
>>  #\a
=>  #\a
(progn (fresh-line) (print #\a))
>>
>>  #\a
=>  #\a
(progn (fresh-line) (princ #\a))
>>  a
=>  #\a
```

```
(dolist (val '(t nil))
  (let ((*print-escape* val) (*print-readably* val))
    (print '#\a)
    (prin1 #\a) (write-char #\Space)
    (princ #\a) (write-char #\Space)
    (write #\a)))
>>  #\a #\a a #\a
>>  #\a #\a a a
=>  NIL
```

```
(progn (fresh-line) (write '(let ((a 1) (b 2)) (+ a b))))
>>  (LET ((A 1) (B 2)) (+ A B))
=>  (LET ((A 1) (B 2)) (+ A B))

(progn (fresh-line) (pprint '(let ((a 1) (b 2)) (+ a b))))
>>  (LET ((A 1)
>>        (B 2))
>>    (+ A B))
=>  (LET ((A 1) (B 2)) (+ A B))

(progn (fresh-line)
       (write '(let ((a 1) (b 2)) (+ a b)) :pretty t))
>>  (LET ((A 1)
>>        (B 2))
>>    (+ A B))
=>  (LET ((A 1) (B 2)) (+ A B))
```

```
(with-output-to-string (s)
   (write 'write :stream s)
   (prin1 'prin1 s))
=>  "WRITEPRIN1"
```

## 22.2 Lisp美观打印器

### 22.2.1 美观打印器的概念

美观打印器提供的功能允许程序重新定义代码展示的方式, 同时用于美观打印应用到数据结构的复杂组合上.

给定输出风格是否是美观本质上是一个有些主观的问题. 然而, 因为美观打印器的作用可被符合标准的程序定制, 需要给各独立程序提供实现不同程序美观控制的灵活性.

通过提供美观打印器中布局动态决策机制的直接访问, 宏和函数`pprint-logical-block`、`pprint-newline`和`pprint-indent`使得指定美观打印布局规则作为产生输出的函数的一部分成为可能. 同时使得基于这些函数支持的长度和内嵌深度确定循环、共享和缩写变得容易.

美观打印器完全是由基于`*print-pprint-dispatch*`的值分发驱动的. 函数`set-pprint-dispath`使得符合标准的程序将新的美观打印函数关联到类型成为可能.

#### 22.2.1.1 输出安排的动态控制

当美观打印器的一段输出过大不能被可用空间容纳时, 美观打印器的动作可被精确控制. 这些操作工作方式下的三个概念是: 逻辑块、条件换行和节. 在继续阐述之前, 需要定义这些术语.

下图中的第一行展示了输出的概要部分. 输出中的每个字符用`-`表示. 条件换行的位置用数字标示. 逻辑块的开始和结束分别用`<`和`>`标示.

输出的整体是一个逻辑块和最外层的节. 这个节用第二行中的0标示. 输出中内嵌的逻辑块用宏`pprint-logical-block`指定. 条件换行位置通过调用`pprint-newline`指定. 每个条件换行定义了两个节(一个在它前面, 一个在它后面)和关联的第三个节(立即包含它的节).

条件换行后面的节的成分有: 直到但不包含这些的所有输出:

(a) 立即包含在同一个逻辑块中的下一个条件换行; 或者如果(a)不适用,  
(b) 在内嵌在逻辑块的更小层次中的下一个条件换行; 或者如果(b)不适用,  
(c) 输出的结尾.

条件换行前面的节的成分有: 回溯到但不包含这些的所有输出:

(a) 立即包含在同一个逻辑块中的前一个条件换行; 或者如果(a)不适用,  
(b) 立即包含这个节的逻辑块的开始. 图中的最后四行标示出在四个条件换行之前和之后的节.

立即包含条件换行的节是包含这个条件换行的最短的节. 在图中, 第一个条件换行被立即包含在用0标记的节中, 第二个和第三个条件换行立即包含在第四个条件换行前面的节中, 第四个条件换行激励包含在第一个条件换行后面的节中.

图 22-3. 逻辑块、条件换行和节的示例.

<-1—<–<–2—3->–4–>-> 000000000000000000000000000 11 111111111111111111111111 22 222 333 3333 44444444444444 44444

美观打印器尽可能的将节的全部内容展示在一行中. 然而, 如果节过长不能被可用空间容纳, 在节中条件换行位置上插入转行.

#### 22.2.1.2 格式化指令接口

动态确定输出安排的操作的主要接口是通过美观打印器的函数和宏提供的. 下图列出了与美观打印相关的已定义名称.

图 22-4. 与美观打印相关的已定义名称.

```
*print-lines*
*print-miser-width*
*print-pprint-dispatch*
*print-right-margin*
copy-pprint-dispatch
format
formatter
pprint-dispatch
pprint-exit-if-list-exhausted
pprint-fill
pprint-indent
pprint-linear
pprint-logical-block
pprint-newline
pprint-pop
pprint-tab
pprint-tabular
set-pprint-dispatch
write
```

下图列出了一组作为相同美观打印操作的文本更紧凑形式的接口的格式化指令:

图 22-5. 与美观打印相关的格式化指令.

```
~I
~:T
~W
~/.../
~<...~:>
~_
```

#### 22.2.1.3 编译格式化字符串

格式化字符串本质上是执行打印的特殊用途语言编写的程序, 由函数`format`解释. 宏`formatter`提供了做相同打印功能的已编译函数, 但丧失了格式化字符串的文本紧凑型表示.

格式化控制或者是一个格式化字符串, 或者是由宏`formatter`返回的函数.

#### 22.2.1.4 美观打印分发表

美观打印分发表是一个键到一对值的映射. 每个键是一个类型描述符. 与键相关的值是一个函数(一个函数指示器或者`nil`)和一个数值优先级(一个实数). 基于键的基本插入和检索操作使用键的`equal`测试语义.

当`*print-pretty*`为true时, 当前美观分发表(在`*print-pprint-dispath*`中)控制如何打印对象. 这个表中的信息比其它指定如何打印对象的机制具有更高的优先级. 通常, 因为当前每段分发表被首先使用, 它比用户定义的`print-object`方法的优先级高.

通过在当前美观分发表中查找与对象匹配的类型描述符对应的最高优先级的函数; 如果有多个最高优先级的函数, 使用哪一个是依赖于实现的.

然而, 如果表中没有关于特定对象的美观打印信息, 调用使用`print-object`的函数打印这个对象. 当这个函数被调用时`*print-pretty*`的值仍为true, `print-object`的方法仍被用于按依赖于`*print-pertty*`值的特殊格式产生输出.

#### 22.2.1.5 打印器的边距

美观打印的一个主要目标是保持输出在一对边距之间. 输出开始的列作为左边距. 如果当前列不能在输出开始时确定, 左边距被设置为零. 右边距由`*print-right-margin*`控制.

### 22.2.2 示例: 使用美观打印器

作为逻辑块、条件换行和索引的示例,考虑下面的函数`simple-pprint-defun`. 这个函数假设一个car是`defun`的列表的长度为4, 打印出该列表.

```
(defun simple-pprint-defun (*standard-output* list)
  (pprint-logical-block (*standard-output* list :prefix "(" :suffix ")")
    (write (first list))
    (write-char #\Space)
    (pprint-newline :miser)
    (pprint-indent :current 0)
    (write (second list))
    (write-char #\Space)
    (pprint-newline :fill)
    (write (third list))
    (pprint-indent :block 1)
    (write-char #\Space)
    (pprint-newline :linear)
    (write (fourth list))))
```

考虑下面的求值:

```
(simple-pprint-defun *standard-output* '(defun prod (x y) (* x y)))
```

如果可用的行宽度大于等于26, 则所有的输出出现在一行中. 如果可用的行宽度是25, 则在表达式`(* x y )`之前的线性风格条件换行处插入行断, 产生下面的输出. `(pprint-ident :block 1)`导致`(* x y)`在逻辑块中有相对缩进1.

```
(DEFUN PROD (X Y)
  (* X Y))
```

如果可用的行宽度是15, 则在传递参数列表之前填充风格条件换行处也插入一个行断. `(pprint-ident :current 0)`导致传递参数列表在函数名称下对齐.

```
(DEFUN PROD
       (X Y)
  (* X Y))
```

因为在吝啬(miser)模式中所有缩进变化被忽略, 且行断在吝啬风格条件换行处插入, 如果`*print-miser-width*`大于等于14, 上面示例的输出如下:

```
(DEFUN
 PROD
 (X Y)
 (* X Y))
```

作为行前缀的示例, 考虑在行宽度为20且`*print-miser-width*`为`nil`时, 下面的求值产生的输出:

```
(pprint-logical-block (*standard-output* nil :per-line-prefix ";;; ")
  (simple-pprint-defun *standard-output* '(defun prod (x y) (* x y))))

;;; (DEFUN PROD
;;;        (X Y)
;;;   (* X Y))
```

作为更复杂的(也更实际的)示例, 考虑下面的`pprint-let`函数. 这个函数描述了如何在传统风格下打印一个`let`形式. 因为需要处理内嵌解构, 所以它比上面的示例更为复杂. 同时, 与上面的示例不同的是, 它包含了完整的可读打印出所有以符号`let`开始的列表的代码. 最外层的`pprint-logical-block`形式将输入列表作为整个打印处理, 说明了括号应该打印到输出中. 第二个`ppring-logical-block`形式处理绑定对的列表. 列表中每个对本身是用最内层的`pprint-logical-block`打印的.(使用一个`loop`形式而不是简单的将对分解为两个对象, 从而不管与对相应的列表是包含一个元素、两个元素、还是多于两个元素(错误的). 可以产生可读的输出.) 除最后一个对外, 在每个对之后插入一个空格和一个填充风格的条件换行. 在最顶层的`pprint-logical-block`形式末尾处的循环打印出在`let`形式体中被空格和线性风格条件换行分隔的形式.

```
(defun pprint-let (*standard-output* list)
  (pprint-logical-block (nil list :prefix "(" :suffix ")")
    (write (pprint-pop))
    (pprint-exit-if-list-exhausted)
    (write-char #\Space)
    (pprint-logical-block (nil (pprint-pop) :prefix "(" :suffix ")")
      (pprint-exit-if-list-exhausted)
      (loop (pprint-logical-block (nil (pprint-pop) :prefix "(" :suffix ")")
              (pprint-exit-if-list-exhausted)
              (loop (write (pprint-pop))
                    (pprint-exit-if-list-exhausted)
                    (write-char #\Space)
                    (pprint-newline :linear)))
            (pprint-exit-if-list-exhausted)
            (write-char #\Space)
            (pprint-newline :fill)))
    (pprint-indent :block 1)
    (loop (pprint-exit-if-list-exhausted)
          (write-char #\Space)
          (pprint-newline :linear)
          (write (pprint-pop)))))
```

考虑`*print-level*`为4且`*print-circle*`为true时下面的求值:

```
(pprint-let *standard-output*
            '#1=(let (x (*print-length* (f (g 3)))
                      (z . 2) (k (car y)))
                  (setq x (sqrt z)) #1#))
```

如果行长度大于等于77, 产生的输出出现在一行中. 然而, 如果行长度是76, 在体中分隔形式的线性风格条件换行处插入行断, 产生下面的输出. 注意, 尽管绑定`x`的对不是一个列表也被打印为可读的; 在`(g 3)`处打印出一个深度缩略标记; 绑定对`(z . 2)`不是合式列表但也被打印为可读的; 同时也打印出一个恰当的循环标记.

```
#1=(LET (X (*PRINT-LENGTH* (F #)) (Z . 2) (K (CAR Y)))
     (SETQ X (SQRT Z))
     #1#)
```

如果行长度为35, 在分隔绑定对的填充风格条件换行中的一处插入行断.

```
#1=(LET (X (*PRINT-PRETTY* (F #))
         (Z . 2) (K (CAR Y)))
     (SETQ X (SQRT Z))
     #1#)
```

假设行长度为22且`*print-length*`为3. 在这种情况下, 在第一个和第二个绑定对之后都插入行断. 此外, 第二个绑定对被拆分成两行. 填充风格条件换行描述中的句子(b)(见函数`pprint-newline`)阻止对`(z . 2)`打印在在第三行末尾. 注意长度缩写隐藏了循环, 因此没有循环标记.

```
(LET (X
      (*PRINT-LENGTH*
       (F #))
      (Z . 2) ...)
  (SETQ X (SQRT Z))
  ...)
```

下面的函数使用`#(...)`记法打印向量.

```
(defun pprint-vector (*standard-output* v)
  (pprint-logical-block (nil nil :prefix "#(" :suffix ")")
    (let ((end (length v)) (i 0))
      (when (plusp end)
        (loop (pprint-pop)
              (write (aref v i))
              (if (= (incf i) end) (return nil))
              (write-char #\Space)
              (pprint-newline :fill))))))
```

在行长度为15时:

```
(pprint-vector *standard-output* '#(12 34 567 8 9012 34 567 89 0 1 23))

#(12 34 567 8
  9012 34 567
  89 0 1 23)
```

作为使用格式化字符串描述美观打印的示例, 考虑上面的函数`simple-pprint-defun`和`pprint-let`可以按下面的方式紧凑的定义. (因为`pprint-vector`遍历的数据结构不是列表, 所以它不能用`format`定义).

```
(defun simple-pprint-defun (*standard-output* list)
  (format T "~:<~W ~@_~:I~W ~:_~W~1I ~_~W~:>" list))

(defun pprint-let (*standard-output* list)
  (format T "~:<~W~^~:<~@{~:<~@{~W~^~_~}~:>~^~:_~}~:>~1I~@{~^~_~W~}~:>" list))
```

在下面的示例中, 第一个形式将`*print-pprint-dispatch*`恢复到其初始值. 下面两个形式设置了美观打印比值的特殊方法. 注意, 更特殊的类型描述符需要与更高的优先级关联.

```
(setq *print-pprint-dispatch* (copy-pprint-dispatch nil))

(set-pprint-dispatch 'ratio
  #'(lambda (s obj)
      (format s "#.(/ ~W ~W)"
                (numerator obj) (denominator obj))))

(set-pprint-dispatch '(and ratio (satisfies minusp))
  #'(lambda (s obj)
      (format s "#.(- (/ ~W ~W))"
              (- (numerator obj)) (denominator obj)))
  5)

(pprint '(1/3 -2/3))
(#.(/ 1 3) #.(- (/ 2 3)))
```

下面的两个形式展示了代码类型的美观打印函数的定义. 第一个形式展示了如何描述打印使用单引号的引用对象的传统方法. 注意, 恰好以`quote`开始的数据列表列表需要被可读打印. 第二个形式描述了在初始美观打印分发表生效时, 以符号`my-let`开始的列表应该用与以`let`开始的列表同样的方式打印.

```
(set-pprint-dispatch '(cons (member quote)) ()
  #'(lambda (s list)
      (if (and (consp (cdr list)) (null (cddr list)))
         (funcall (formatter "'~W") s (cadr list))
         (pprint-fill s list))))

(set-pprint-dispatch '(cons (member my-let))
                     (pprint-dispatch '(let) nil))
```

下一个示例描述了打印不与函数调用对应的列表的默认方法. 注意, 函数`pprint-linear`、`pprint-fill`和`pprint-tabular`都有选项`colon-p`和`at-sign-p`, 因此它们可以用作美观打印分发函数和`~/.../`函数.

```
(set-pprint-dispatch '(cons (not (and symbol (satisfies fboundp))))
                     #'pprint-fill -5)

;; Assume a line length of 9
(pprint '(0 b c d e f g h i j k))
(0 b c d
 e f g h
 i j k)
```

最后一个例子展示了如何为用户定义的数据结构定义美观打印函数.

```
(defstruct family mom kids)

(set-pprint-dispatch 'family
  #'(lambda (s f)
      (funcall (formatter "~@<#<~;~W and ~2I~_~/pprint-fill/~;>~:>")
              s (family-mom f) (family-kids f))))
```

结构`family`的美观打印函数描述了如何调整输出的布局, 以美观的适用于多种行宽. 此外, 它受控制变量`*print-level*`、`*print-length*`、`*print-lines*`、`*print-circle*`和`*print-escape*`控制, 可以容忍数据结构中多种类型的错误. 在右边局为25、`*print-pertty*`为true、`*print-escape*`为false和一个错误的`kids`列表时:

```
(write (list 'principal-family
             (make-family :mom "Lucy"
                          :kids '("Mark" "Bob" . "Dan")))
       :right-margin 25 :pretty T :escape nil :miser-width nil)
(PRINCIPAL-FAMILY
 #<Lucy and
     Mark Bob . Dan>)
```

注意, 结构的美观打印函数与结构的`print-object`方法不同. `print-object`方法是与结构永久关联的, 而美观打印函数存储在美观打印分发表中, 可以为满足不同打印需要而快速改变. 如果在当前美观打印分发表中没有结构的美观打印函数, 则使用它的`print-object`方法.

### 22.2.3 备注: 美观打印器的背景

关于这一节描述的抽象概念的背景引用, 见 **XP: A Common Lisp Pretty Printing System**\[^1].这篇文档的细节不是与该文档绑定的, 但在建立理解这些材料的概念基础上有帮助.

\[^1]: XP: A Common Lisp Pretty Printing System [https://dspace.mit.edu/bitstream/handle/1721.1/6503/AIM-1102.pdf](https://dspace.mit.edu/bitstream/handle/1721.1/6503/AIM-1102.pdf)

## 22.3 格式化的输出

`format`用于生成漂亮的格式化文本、消息等. `format`可以生成并返回一个字符串或到目的地的输出.

`format`的`control-string`传递参数实际上是一个格式控制. 即, 它是格式化字符串或一个函数, 例如宏`formatter`返回的函数.

如果它是一个函数, 这个函数被与作为其起一个传递参数的恰当的输出流和传递给`format`的数据传递参数一起调用. 这个函数应该执行必要的输出并返回未使用的传递参数尾(如果有的话).

`formatter`执行的编译过程生成一个函数, 这个函数按与`format`解释器一样的方式处理它的传递参数.

这一节的剩下部分描述如果`control-string`是格式化字符串时发生什么.

`control-string`由简单文本(字符)和内嵌的指令组成.

`format`原样输出简单文本; 每个内嵌的指令描述了在简单文本中响应位置出现的文本输出. 大多数指令使用一个或多个`args`创建输出.

指令由变音符(tilde, `~`)、可选的按`,`分隔的前缀参数、可选的`:`和`@`修饰符和一个标识指令种类的单个字符组成. 在`:`与`@`之间不要求顺序. 指令字符的大小写被忽略. 前缀参数记为有符号的十进制数值(符号是可选的), 或单个字符的引用. 例如, `~5,'0d`用于将十进制基的整数按前缀0的5列打印, 或者使用`~5,'*d`指定前缀为`*`.

在指令的前缀参数处, 可以使用`V`(或`v`). 在这种情况下, `format`从`args`取一个传递参数作为指令的参数. 这个传递参数应该是一个整数或字符. 如果被v参数使用的`arg`是`nil`, 其效果是该参数被省略. `#`可用于前缀参数处; 它表示剩下的需要处理的`args`的数量. 当在递归格式的`~?`或`~{`上下文中, `#`前缀参数表示在递归调用中格式化传递参数的数量.

格式化字符串的示例:

图 22-6. 格式控制字符串的示例.

```
"~S"        ; S指令, 没有参数和修饰符
"~3,-4:@s"  ; S指令, 有两个参数: 3和-4, 有:和@标签
"~,+4S"     ; 第一个参数被省略, 取默认值; 第二个参数为4
```

`format`将输出发送到目的地. 如果目的地是`nil`, `format`创建并返回一个包含按`control-string`产生的输出的字符串. 如果目的地不是`nil`, 它必须是一个有填充指针的字符串、一个流或符号`t`. 如果目的地是有填充指针的字符串, 输出被添加到字符串的末尾. 如果目的地是一个流, 输出被发送到这个流. 如果目的地是`t`, 输出被发送到标准输出流.

在下文指令的描述中, 项`arg`通常表示`args`中下一个要被处理的项. 每个描述开始处的单词或短语是指令的助记词句. 除非在后面说明, `format`指令不会绑定任何打印器控制变量(`*print-...*`). 实现可以为每个`format`指令定义新的特定于实现的打印器控制变量, 但它们不能绑定任何在`format`指令描述中未涉及的标准打印器控制变量, 或者不能绑定到描述中任何标准打印器控制变量.

### 22.3.1 FORMAT的基本输出

#### 22.3.1.1 `~C`: 字符

下一个`arg`应该是一个字符, 根据修饰符标志打印.

在字符是简单字符时, `~C`就像使用`write-char`打印这个字符. 不是简单字符的字符不一定要像使用`write-char`打印, 但按时限定义的简洁格式展示. 例如:

```
(format nil "~C" #\A) =>  "A"
(format nil "~C" #\Space) =>  " "
```

`~:C`与`~C`在可打印字符方面相同, 但其它字符是被拼出的. 意图是这是打印字符的美观的格式. 对不可打印的简单字符, 被拼出的是字符的名称(见`char-name`). 对不简单的不可打印字符, 被拼出的是由实现定义的. 例如:

```
(format nil "~:C" #\A) =>  "A"
(format nil "~:C" #\Space) =>  "Space"

;; This next example assumes an implementation-defined "Control" attribute.
(format nil "~:C" #\Control-Space)
=>  "Control-Space"
OR=>  "c-Space"
```

`~:@C`打印出`~:C`打印的内容, 然后如果字符需要键盘上不常用的Shift键打出, 会提及这个事实. 例如:

```
(format nil "~:@C" #\Control-Partial) =>  "Control-<PARTIAL> (Top-F)"
```

这是用于告知关于他期望打出的键的格式, 例如在提示中. 具体的输出可能不仅依赖于实现, 也依赖于使用的I/O设备.

`~@C`使用`#\`语法, 按Lisp读取器可以理解的方式打印字符.

`~@C`绑定`*print-escape*`为`t`.

#### 22.3.1.2 `~%`: 换行

这会输出`#\Newline`字符, 从而结束当前输入行病开启新行. `~n%`输出`n`个新行. 不使用`arg`.

#### 22.3.1.3 `~&`: 新行

除非可以确定输出流当前在行的开始处, 这会输出新行. `~n%`调用`fresh-line`, 然后输出`n-1`个新行. `~0&`什么也不做.

#### 22.3.1.4 `~|`: 页

可能的情况下, 这会输出一个页分隔字符. `~n|`输出`n`个.

#### 22.3.1.5 `~~`: `~`

这输出一个变音符(`~`). `~n~`输出`n`个.

### 22.3.2 FORMAT基数控制

#### 22.3.2.1 `~R`: 基数

`~nR`按基数`n`打印`arg`. 修饰符标志和任何剩下的参数用于`~D`指令. `~D`与`~10R`相同. 完整的格式是`~` `radix,mincol,padchar,commachar,comma-interval` `R`.

如果`~R`没有前缀参数, 则给出不同的解释. 这个参数需要是一个整数. 例如, 如果`arg`是4:

- `~R`将`arg`打印为基数英语数值: `four`.
- `~:R`将`arg`打印为英语序数: `fourth`.
- `~@R`将`arg`打印为罗马数字: `IV`.
- `~:@R`将`arg`打印为旧式罗马数字: `IIII`.

例如:

```
(format nil "~,,' ,4:B" 13) =>  "1101"
(format nil "~,,' ,4:B" 17) =>  "1 0001"
(format nil "~19,0,' ,4:B" 3333) =>  "0000 1101 0000 0101"
(format nil "~3,,,' ,2:R" 17) =>  "1 22"
(format nil "~,,'|,2:D" #xFFFF) =>   "6|55|35"
```

当且仅当提供了第一个参数`n`, `~R`绑定`*print-escape*`为false、`*print-radix*`为false、`*print-base*`为`n`、`*print-readably*`为false.

当且仅当没有提供参数, `~R`绑定`*print-base*`为10.

#### 22.3.2.2 `~D`: 十进制

是整数的`arg`, 应该按十进制基数打印. `~D`从不在数值后打印一个小数点.

`~` `mincol` `D`使用列宽`mincol`; 如果数值需要比`mincol`少的列展示它的数字和符号, 在数值的左边插入空格. 如果数值不能纳入`mincol`列中, 使用额外的列.

`~` `mincol,padchar` `D`使用`padchar`作为填充字符而不是空格.

如果`arg`不是整数, 它被使用`~A`格式和十进制基数打印.

修饰符`@`导致数值的符号总被但引出; 默认只在数值是负数时打印出符号. 修饰符`:`导致在数字组之间打印出逗号; `commachar`用于修改用于逗号的字符. `comma-interval`必须是一个整数, 默认值为3. 当在这些指令中使用了修饰符`:`时, 在`comma-interval`个数字作为一组的组之间打印出`commachar`.

因此, `~D`的通用形式是`~` `mincol,padchar,commachar,comma-interval` `D`.

`~D`绑定`*print-escape*`为false、`*print-radix*`为false、`*print-base*`为10、`*print-readably*`为false.

#### 22.3.2.3 `~B`: 二进制

与`~D`类似, 这会按二进制基数打印数值. 因此完整的形式是`~` `mincol,padchar,commachar,comma-interval` `B`.

`~B`绑定`*print-escape*`为false、`*print-radix*`为false、`*print-base*`为2、`*print-readably*`为false.

#### 22.3.2.4 `~O`: 八进制

与`~D`类似, 这会按八进制基数打印数值. 因此完整的形式是`~` `mincol,padchar,commachar,comma-interval` `O`.

`~O`绑定`*print-escape*`为false、`*print-radix*`为false、`*print-base*`为8、`*print-readably*`为false.

#### 22.3.2.5 `~X`: 十六进制

与`~D`类似, 这会按十六进制基数打印数值. 因此完整的形式是`~` `mincol,padchar,commachar,comma-interval` `X`.

`~X`绑定`*print-escape*`为false、`*print-radix*`为false、`*print-base*`为16、`*print-readably*`为false.

### 22.3.3 FORMAT浮点数打印器

#### 22.3.3.1 `~F`: 固定格式的浮点数

将下一个`arg`作为浮点数打印.

完整的形式是`~` `w,d,k,overflowchar,padchar` `F`. 参数`w`是被打印的字段的宽度; `d`在小数点之后打印的数字的数量; `k`是默认为0的缩放因子.

会输出`w`个字符. 首先, 必要时先打印字符`padchar`(默认为空格)的副本, 在字段左端填充. 如果`arg`是负数, 则打印一个负号; 如果`arg`非负, 当且仅当使用了修饰符`@`是打印一个正号. 然后是一个数字序列, 包含一个内嵌的小数点; 这表示`arg`乘以10^k的量级, 四舍五入到`d`位小数. 如果向上和向下舍入的值与`arg`的缩放值等距, 则实现可以使用任意一个. 例如, 使用`~4,2F`打印传递参数`6.375`可以正确的产生`6.37`或`6.38`. 不允许有前缀0, 除非打印的值比1小时小数点前有单个零, 如果`w=d+1`, 不需要打印出这个零.

如果不能按宽度`w`打印出值, 则采取这两个动作的一个. 如果提供了参数`overflowchar`, 则打印`w`个`overflowchar`替代`arg`的缩放值. 如果省略了参数`overflowchar`, 则使用多于`w`个字符打印出缩放值.

如果省略了参数`w`, 则字段是变宽的. 实际上, 按不需要头部填充字符和小数点后`d`个字符的方式选择`w`的值. 例如, 指令`~,2F`将在小数点后打印两个数字, 之前打印必要数量的数字.

如果省略了参数`d`, 则在小数点后出现的数字数量上没有限制. `d`值得选择方式是, 由参数`w`引入的宽度和小数部分没有尾部零约束下尽可能多的数字数量, 如果小数部分是零, 则在宽度约束允许的情况下在小数点后有一个零.

如果同时省略了参数`w`和`d`, 则使用常规的自由格式输出打印值; `prin1`使用这个格式打印量级或者是0或者在10^-3(包含)与10^7之间的数值.

如果省略了`w`,且`arg`的量级很大(或者省略了`d`且`arg`的量级很小), 需要打印出多于100个数字时, 允许实现使用指数记法打印数字, 就像使用指令`~E`(使用`~E`的默认参数, 不使用`~F`中的参数).

如果`arg`是一个有理数, 则被转换为单浮点数并被打印. 也允许实现用其它方法处理有理数, 这些方法本质上有相同的行为、但避免了因转换带来的精度丢失或上溢. 如果没有指定`w`和`d`, 数值没有精确的十进制表示, 例如`1/3`, 因为只能打印出有限数量的数字, 实现必须选择精度截止值.

如果`arg`是一个复数或非数值对象, 则使用格式指令`~WD`打印, 从而按十进制基数和最小字段宽度`w`打印.

`~F`绑定`*print-escape*`为false、`*print-readably*`为false.

#### 22.3.3.2 `~E`: 指数浮点数

下一个`arg`作为浮点数按指数记法打印.

完整的格式是`~` `w,d,e,k,overflowchar,padchar,exponentchar` `E`. 参数`w`是被打印的字段的宽度; `d`是小数点之后打印的数字的数量; `e`是打印的指数的数字的数量; `k`是默认为1(不是零)的缩放因子.

会输出`w`个字符. 首先, 必要时先打印字符`padchar`(默认为空格)的副本, 在字段左端填充. 如果`arg`是负数, 则打印一个负号; 如果`arg`非负, 当且仅当使用了修饰符`@`是打印一个正号. 然后是一个数字序列, 包含一个内嵌的小数点. 这个数字序列的形式依赖于缩放因子`k`. 如果`k`是零, 则小数点之后打印`d`个数字, 且如果宽度允许时在小数点之前打印一个零. 如果`k`是正数, 则它必须必`d+2`小; 在小数点之前打印`k`个显著数字, 在小数点之后打印`d-k+1`个数字. 如果`k`是负数, 则它必须大于`-d`; 如果宽度允许时在小数点之前打印一个零, 在小数点后先打印`-k`个零和`d+k`个显著数字. 打印的小数部分必须被恰当的舍入. 当向上和向下舍入的值与`arg`的缩放值等距是, 实现可以使用任意一个. 例如, 使用格式`~8,2E`打印传递参数`637.5`可以正确的生成`6.37E+2`或`6.38E+2`.

在数字序列之后打印指数. 首先打印字符参数`exponentchar`; 如果省略了这个参数, 则打印出`prin1`使用的指数标记, 它是根据浮点数的类型和`*read-default-float-format*`的当前值确定的. 然后, 打印一个正号或负号, 然后是`e`个表示10的幂的数字, 与打印的小数部分相乘可以恰当的表示`arg`的舍入值.

如果不能按宽度`w`打印出值, 可能是因为`k`过大或多小、指数不能在`e`个字符位置中打印出, 则采取这两个动作的一个. 如果提供了参数`overflowchar`, 则打印`w`个`overflowchar`替代`arg`的缩放值. 如果省略了参数`overflowchar`, 则使用多于`w`个字符打印出缩放值; 如果问题是对于提供的`k`, `d`太小或`e`太小, 则为`d`或`e`使用一个更大的值.

如果省略了参数`w`, 则字段是变宽的. 实际上, 按不需要头部填充字符的方式选择`w`的值.

如果省略了参数`d`, 则出现的数字的数量上没有约束. `d`值得选择方式是, 由参数`w`引入的宽度、缩放因子`k`和小数部分没有尾部零数字的约束下尽可能多的数字数量, 如果打印的小数部分是零, 则小数点后应该出现单个零数字.

如果省略了参数`e`, 则指数按最少的表示其值的必要的数字数量方式打印.

如果同时省略了`w`、`d`和`e`, 则使用常规的自由格式的指数记法输出打印值; `prin1`为任何量级小于10^-3或大于10^7的非零数值使用相似的格式. 唯一的区别是, 指令`~E`总是在指数前打印一个正号或负号, 而`prin1`在指数为非负时省略正号.

如果`arg`是一个有理数, 则被转换为单浮点数并被打印. 也允许实现用其它方法处理有理数, 这些方法本质上有相同的行为、但避免了因转换带来的精度丢失或上溢. 如果没有指定`w`和`d`, 数值没有精确的十进制表示, 例如`1/3`, 因为只能打印出有限数量的数字, 实现必须选择精度截止值.

如果`arg`是一个复数或非数值对象, 则使用格式指令`~WD`打印, 从而按十进制基数和最小字段宽度`w`打印.

`~E`绑定`*print-escape*`为false、`*print-readably*`为false.

#### 22.3.3.3 `~G`: 常规浮点数

下一个`arg`作为浮点数按固定格式或指数记法打印.

完整的形式是`~` `w,d,e,k,overflowchar,padchar,exponentchar` `G`. 打印`arg`的格式依赖于`arg`(的绝对值)的量级. 整数 $n$ 满足 $10^{n-1} \le |arg| \lt 10^n$. $ee$ 等于 $e+2$, 在省略了`e`时等于4. $ww$ 等于 $w-ee$, 在省略了`w`是等于`nil`. 如果省略了`d`, $q$ 是不丢失信息和没有头尾零条件下打印`arg`需要的数字数量; 则`d`等于`(max q (min n 7))`. $dd = d-n$.

如果 $0 \le dd \lt d$, 则使用下面的格式指令打印`arg`:

```
~ww,dd,,overflowchar,padcharF~ee@T
```

注意缩放因子`k`没有传递给指令`~F`. 对所有其它`dd`值, 使用下面的格式指令打印`arg`:

```
~w,d,e,k,overflowchar,padchar,exponentcharE
```

在两种情况中, 当且仅当给指令`~G`提供了修饰符`@`时, 它会提供给指令`~F`或`~E`.

`~G`绑定`*print-escape*`为false、`*print-readably*`为false.

#### 22.3.3.4 `~$`: 货币浮点数

下一个`arg`作为浮点数按固定格式记法打印.

完整的格式是`~` `d,n,w,padchar` `$`. 参数`d`是小数点后数字的数量(默认值是2); `n`是小数点之前最小的数字数量(默认值是1); `w`是被打印的字段的最小总宽度(默认值是0).

首先输出填充和符号. 如果`arg`是负数, 则打印一个符号; 如果`arg`非负, 当且仅当提供了修饰符`@`时打印一个正号. 如果使用了修饰符`:`, 则符号在填充之前出现, 否则在填充之后出现. 如果提供了`w`且输出的其它字符的数量小于`w`, 则输出一些`padchar`(默认为空格)的副本使得字段总宽度等于`w`. 然后, 打印`arg`整数部分的`n`个数字, 必要时有前缀零; 接着是一个小数点; 接着是恰当舍入的n个小数数字.

如果`arg`的量级需要打印出多于`m`个数字, `m`是`w`和100的较大者, 则允许实现按指令`~` `w,q,,,,padchar` `E`使用指数记法打印数值, 这里, `w`和`padchar`根据它们是否在指令`~$`中出现或省略而出现或省略, `q=d+n-1`, `d`和`n`是提供给指令`~$`的值(可能是默认值).

如果`arg`是一个有理数, 则被转换为单浮点数并被打印. 也允许实现用其它方法处理有理数, 这些方法本质上有相同的行为、但避免了因转换带来的精度丢失或上溢.

如果`arg`是一个复数或非数值对象, 则使用格式指令`~WD`打印, 从而按十进制基数和最小字段宽度`w`打印.

`~$`绑定`*print-escape*`为false、`*print-readably*`为false.

### 22.3.4 FORMAT打印器操作

#### 22.3.4.1 `~A`: 美观的

作为任意对象的`arg`, 不使用转义字符打印(就像使用`princ`). 如果`arg`是一个字符串, 它的字符被原样输出. 如果`arg`是`nil`, 它将被打印为`nil`; 修饰符`:`(`~:A`)将为`nil`的`arg`打印为`()`, 但如果`arg`是聚合结构, 例如列表或向量, 其中包含的`nil`仍被打印为`nil`.

`~` `mincol` `A`必要时在右边插入空格, 使得宽度至少为`mincol`列. 修饰符`@`导致在左边插入空格.

`~A`的完整形式是`~` `mincol,colinc,minpad,padchar` `A`, 它允许控制填充. 在字符串的右边填充至少`minpad`个`padchar`(如果使用了修饰符`@`在左边填充); 然后一次插入`colinc`个填充字符直到总宽度至少为`mincol`. `mincol`和`minpad`的默认值为0, `colinc`的默认值为1, `padchar`的默认值为空格字符.

`~A`绑定`*print-escape*`为false、`*print-readably*`为false.

#### 22.3.4.2 `~S`: 标准的

与`~A`类似, 但使用转义字符打印`arg`(就像使用`prin1`而不是`princ`). 因此输出可被`read`读取. `~S`接受`~A`可以接受的所有传递参数和修饰符.

`~S`绑定`*print-escape*`为`t`.

#### 22.3.4.3 `~W`: `write`

作为任意对象的传递参数的打印遵循每个打印器控制变量(就像使用`write`). 此外, `~W`正确的处理深度缩写, 但不将深度计数器充值为零. `~W`不接受参数. 如果给定了修饰符`:`, `~W`绑定`*print-pretty*`为true. 如果给定了修饰符`@`, `~W`绑定`*print-level*`和`*print-length*`为`nil`.

`~W`自动支持检测循环和共享. 如果`*print-circle*`的值不是`nil`, `~W`被应用在一个循环的(或共享的)引用的传递参数上, 在输出中传递参数的位置插入恰当的`#n#`标记.

### 22.3.5 FORMAT美观打印器操作

下面的构造支持对美观打印器的访问.

#### 22.3.5.1 `~_`: 条件换行

不带任何修饰符的`~_`与`(pprint-newline :linear)`相同. `~@_`与`(pprint-newline :miser)`相同. `~:_`与`(pprint-newline :fill)`相同. `~:@_`与`(pprint-newline :mandatory)`相同.

#### 22.3.5.2 `~<`: 逻辑块

```
~<...~:>
```

当使用`~:>`结束`~<...~:>`时, 这个指令等价于调用`pprint-logical-block`. 与指令`~<...~:>`相应的传递参数被视为`pprint-logical-block`的列表传递参数, 从而提供了非列表传递参数和循环、共享和深度缩写的自动支持. 在`~<...~:>`中内嵌的`control-string`部分指定了`pprint-logical-block`的`:prefix`(或`:per-line-prefix`)、`:suffix`和体.

`~<...~:>`中的`control-string`部分可以用指令`~;`拆分为片段`~<prefix~;body~:suffix~:>`. 如果第一节用`~@;`结束, 它指定了一个行前缀而不是简单前缀. `prefix`和`suffix`不能包含格式指令. 如果`prefix`或`suffix`不是常量字符串或包含的部分被拆分为多于三个片段, 则发出错误信号.

如果包含的部分只被拆分为两个片段, `suffix`默认为空字符串. 如果包含的部分只有一个片段构成, 则`prefix`和`suffix`默认为空字符串. 如果使用了修饰符`:`(即`~:<...~:>`), `prefix`和`suffix`分别默认为`"("`和`")"`.

体片段可以是任意格式字符串. 这个格式字符串作为整体应用在与指令`~<...~:>`对应的列表的元素上. 使用`pprint-pop`从这个列表中提取元素, 从而提供了不良格式的列表和循环、共享、长度缩写的自动支持. 在体片段中, `~^`就像`pprint-exit-if-list-exhausted`一样.

`~<...~:>`支持一些`pprint-logical-block`不支持的特性. 如果`~:@>`用于结束指令(即`~<...~:@>`), 则在体重立即包含的每个空白组之后插入填充风格的条件换行(除了换行指令后的空白). 这为支持段落填充提供了便利.

如果将`~<...~:>`与`@`一起使用, 整个剩下的传递参数列表作为该指令的传递参数. 所有剩下的传递参数总是被`~@<...~:>`消费, 甚至它们没有在该指令的内嵌格式字符串中被全部使用时. 除了传递参数的不同, `~@<...~:>`与`~<...~:>`相同, 除了如果在格式字符串的顶层遇到`~@<...~:>`时循环检测不适用. 这确保了循环检测只适用于数据列表, 而不是格式传递参数列表.

如果循环或共享必须被指定为整体作为传递参数, 则打印出`" . #n#"`.

在一定长度上, 指令`~<...~>`的基本形式与使用`~W`、`~_`、`~<...~:>`、`~I`和`~:T`输出安排的动态控制不兼容. 所以, 如果这些指令出现在`~<...~>`中会发出错误信号. 此外, 如果`~<...~>`的形式`~<...~:;...~>`用于`~W`、`~_`、`~<...~:>`、`~I`和`~:T`的格式字符串中, 也会发出错误信号.

见**22.3.6.2 `~<`: 调整**.

#### 22.3.5.3 `~I`: 缩进

`~nI`与`(pprint-indent :block n)`相同.

`~n:I`与`(pprint-indent :current n)`相同. 在这两种情况下, 如果省略了`n`, 默认值为零.

#### 22.3.5.4 `~/`: 调用函数

```
~/name/
```

使用指令`~/name/`可以在格式字符串中调用用户定义的函数. 可以将指令`~/name/`与修饰符`:`、`@`和任意数量的参数一起使用. `name`可以是任意不包含`"/"`的字符串. `name`中所有字符被视为是大写的. 如果`name`包含`:`或`::`, 则直到但不包括第一个`:`或`::`的字符串被视为命名了包的字符串. 第一个`:`或`::`之后的字符串(如果有的话)被视为命名了符号的字符串. 与指令`~/name/`对应的函数通过从指定包中查找指定名称的符号获得. 如果`name`不包含`:`或`::`, 则在包`COMMON-LISP-USER`中查找字符串`name`.

当遇到指令`~/name/`时, 使用四个或更多个传递参数调用相应的函数. 头四个传递参数是: 输出流、指令对应的格式传递参数、使用修饰符`:`时为true的广义布尔值、使用修饰符`@`时为true的广义布尔值. 剩下的传递参数由指令中指定的任意参数构成. 这个函数应该恰当的打印这些传递参数. 这个函数的返回值被忽略.

特殊设计的三个函数`pprint-linear`、`pprint-fill`和`pprint-tabular`可被`~/.../`调用(即`~/pprint-linear/`、`~/pprint-fill/`和`~/pprint-tabular/`). 通常它们有传递参数`:`和`@`.

### 22.3.6 FORMAT布局控制

#### 22.3.6.1 `~T`: 制表

这在给定列上指定空格. `~` `colnum,colinc` `T`会输出足够多的空格将游标移动到列`colnum`处. 如果游标已在列`colnum`或在列`colnum`之后, 除非`colinc`为零, 它会输出空格将游标移动到列`colnum+k*colinc`, 取最小的正整数`k`; 如果`colinc`为零, 不会输出空格. `colnum`和`colinc`的默认值为1.

如果出于某些原因当前绝对列位置不能通过直接查询确定, `format`可以根据一些指令(例如`~%`、`~&`和包含换行的字符串作为传递参数的`~A`)将列位置重置为零推断出当前列位置, 并从那个位置开始计数字符串的数量. 如果还是不能确定, `format`将会在其被调用时目的地在列零上的冒险假设上尝试类似的推断. 甚至在尝试失败或不方便实现的情况下, `~T`操作最坏的情况下简单的输出两个空格.

`~@T`执行相对制表. `~` `colrel,colinc` `@T`输出`colrel`个空格, 然后输出需要将游标移动到`colinc`倍数位置列的最小非负数量的额外空格. 例如, 指令`~3,8T`输出三个空格, 然后如果游标不在标准8倍制表停止处, 将游标移动到这个标准8倍制表停止处. 如果不能确定当前输出列, 忽略`colinc`, 只输出`colrel`个空格.

如果将修饰符`:`与指令`~T`一起使用, 则制表计算是相对于立即包含指令的节的开始处水平位置的, 而不是相对于水平位置零. 数值参数被解释为字符宽度单元, 默认值为1. `n,m:T`与`(pprint-tab :section n m)`相同. `~n,m:@T`与`(pprint-tab :section-relative n m)`相同.

#### 22.3.6.2 `~<`: 对齐

```
~mincol,colinc,minpad,padchar<str~>
```

这个指令调整在宽度至少为`mincol`列的字段中处理`str`生成的字符串. 可以用`~;`将`str`划分为片段, 在这种情况下, 间隔在文本片段之间均匀划分.

不带修饰符时, 最左边的文本片段在字段中被左对齐, 最右边的文本片段被右对齐. 如果只有一个文本元素, 它被右对齐. 修饰符`:`在第一个文本片段之前引入间隔; 修饰符`@`在最后一个文本片段之后加上间隔. 参数`minpad`是在每个片段之间输出的填充字符的最小数量, 默认为0. 参数`padchar`指定填充字符, 默认为空格字符. 如果需要满足这些约束的总宽度大于`mincol`, 则使用宽度`mincol+k*colinc`, 取最小的非负整数值`k`. `colinc`默认为1, `mincol`默认为0.

注意, `str`可能包含格式化指令. 按序处理`str`中的子句; 对齐的是子句的结果文本.

指令`~^`可用于提前结束处理子句, 在这种情况下, 只对齐完成处理的子句.

如果用`~:;`而不是`~;`结束`~<`的第一个子句, 则这个子句被按特殊方式使用. 所有子句已被处理(当然是对`~^`而言的), 但第一个不被用于执行生成间隔和填充. 当已确定填充后的结果时, 如果它可纳入当前输出行, 则输出它, 忽略第一个子句的文本. 然而, 如果填充后的文本不能纳入当前行, 则在填充后的文本之前输出第一个子句的文本片段. 第一个子句应该包含换行(例如指令`~%`). 第一个子句总被处理, 它引用的任意传递参数总会被使用; 是是否使用结果文本片段的决策, 而不是是否处理第一个子句的决策. 如果`~:;`有前缀参数`n`, 则在避免输出第一个子句的文本而节省`n`个字符位置的情况下填充后的文本必须可以纳入当前行. 例如, 控制字符串:

```
"~%;; ~{ ~<~%;; ~1:; ~S~>~^ ,~} .~%"
```

可用于不在行边界上折断项下打印由逗号分隔项的列表, 每行以`;;`开始. `~1:;`中的前缀参数1是被对齐的元素不是列表中最后一个元素时后面出现的逗号的宽度, 或者是最后一个元素时句号的宽度. 如果`~:;`由第二个前缀参数, 则它被用作行的宽度, 因此覆盖了输出流的自然行宽度. 将前面的列子中行宽度设置为50, 可以用:

```
"~%;; ~{ ~<~%;; ~1,50:; ~S~>~^ ,~}  .~%"
```

如果没有提供第二个传递参数, 则`format`使用目的地输出流的行宽度. 如果不能确定这个航宽度(例如生成字符串结果时), `format`使用72作为行长度.

见**22.3.5.2 `~<`: 逻辑块**.

#### 22.3.6.3 `~>`: 结束对齐

`~>`结束`~<`. 在其它地方使用它的后果是未定义的.

### 22.3.7 FORMAT控制流操作

#### 22.3.7.1 `~*`: 跳转到

忽略下一个`arg`. `~n*`忽略后面的`n`个传递参数.

`~:*`在传递参数列表中备份, 从而最后处理的传递参数可被再次处理. `~n:*`备份`n`个传递参数.

在构造`~{`中时, (任意方向上的)忽略是相对于被迭代处理的传递参数列表.

`~n@*`跳转到第`n`个`arg`, 0表示第一个; `n`默认为0, 所以`~@*`跳转到第一个`arg`. `~n@*`之后的指令将使用序列中从跳转到的参数开始的参数. 当在构造`~{`中时, 跳转时相对于被迭代处理的传递参数列表.

#### 22.3.7.2 `~[`: 条件表达式

```
~[str0~;str1~;...~;strn~]
```

这是一组称为子句的控制字符串, 选择和使用其中的一个. 这些子句是用`~;`分隔的, 这个构造用`~]`结束. 例如:

```
"~[Siamese~;Manx~;Persian~] Cat"
```

选择第`arg`个子句, 这里的第一个子句是数0. 如果给定了一个前缀参数(`n[`), 则使用这个参数而不是传递参数. 如果`arg`在可选范围之外, 则不会选择子句且不会发出错误信号. 在处理了选择的子句之后, 继续处理在`~]`之后的控制字符串.

`~[str0~;str1~;...~;strn~:;default~]`有一个默认子句. 如果最后一个用于分隔子句的是`~:;`, 则最后一个是没有选择其它子句可选择时选择的子句. 例如:

```
"~[Siamese~;Manx~;Persian~:;Alley~] Cat"
```

`~:[alternative~;consequent~]`在`arg`为false时选择控制字符串`alternative`, 否则选择`consequent`.

`~@[consequent~]`测试传递参数. 如果传递参数是true, 则它不被`~[`命名使用, 而是作为下一个被处理的传递参数, 子句`consequent`被处理. 如果`arg`是false, 则它被使用, 子句不被处理. 所以子句通常应该使用一个传递参数, 并期望它是非`nil`的. 例如:

```
(setq *print-level* nil *print-length* 5)
(format nil
       "~@[ print level = ~D~]~@[ print length = ~D~]"
       *print-level* *print-length*)
=>   " print length = 5"
```

同时注意到有:

```
(format stream "...~@[str~]..." ...)
==  (format stream "...~:[~;~:*str~]..." ...)
```

可以组合使用`~[`和`#`, 例如用于以英语习惯处理打印列表时:

```
(setq foo "Items:~#[ none~; ~S~; ~S and ~S~
          ~:;~@{~#[~; and~] ~S~^ ,~}~].")
(format nil foo) =>   "Items: none."
(format nil foo 'foo) =>   "Items: FOO."
(format nil foo 'foo 'bar) =>   "Items: FOO and BAR."
(format nil foo 'foo 'bar 'baz) =>   "Items: FOO, BAR, and BAZ."
(format nil foo 'foo 'bar 'baz 'quux) =>   "Items: FOO, BAR, BAZ, and QUUX."
```

#### 22.3.7.3 `~]`: 结束条件表达式

`~]`结束`~[`. 在其它地方使用它的后果是未定义的.

#### 22.3.7.4 `~{`: 迭代

```
~{str~}
```

这是一个迭代构造. 传递参数应该是一个列表, 就像递归调用`format`的一组传递参数. 字符串`str`作为控制字符串被重复使用. 每个迭代吸收列表中的元素作为传递参数; 如果`str`自身使用了两个传递参数, 则在循环中每次会使用列表中的两个元素. 如果在任意迭代步骤前列表是空的, 则迭代终止. 同时, 如果给定了前缀参数`n`, 则最多会处理`str` `n`次. 最后, 可以使用指令`~^`提前结束迭代.

例如:

```
(format nil "The winners are:~{ ~S~}."
        '(fred harry jill))
=>  "The winners are: FRED HARRY JILL."

(format nil "Pairs:~{ <~S,~S>~}."
        '(a 1 b 2 c 3))
=>  "Pairs: <A,1> <B,2> <C,3>."
```

`~:{str~}`是类似的, 但传递参数应该是子列表的列表. 在每个重复步骤中, 使用一个子列表作为处理`str`的一组传递参数; 在下一个重复步骤中, 使用新的子列表, 不管最后一个子列表是否已被处理. 例如:

```
(format nil "Pairs:~:{ <~S,~S>~} ."
                '((a 1) (b 2) (c 3)))
=>  "Pairs: <A,1> <B,2> <C,3>."
```

`~@{str~}`与`~{str~}`类似, 但不是使用一个列表传递参数, 而是将所有剩下的传递参数作为迭代的传递参数列表使用. 例如:

```
(format nil "Pairs:~@{ <~S,~S>~} ." 'a 1 'b 2 'c 3)
=>  "Pairs: <A,1> <B,2> <C,3>."
```

如果迭代在消费所有剩余参数之前终止, 则任何未被迭代处理的传递参数被保留给迭代构造后面的指令处理.

`~:@{str~}`组合了`~:{str~}`和`~@{str~}`的特性. 使用了所有的剩余传递参数, 且每个传递参数必须是一个列表. 在每个迭代中, 下一个参数被用作`str`的传递参数列表. 例如:

```
(format nil "Pairs:~:@{ <~S,~S>~} ."
             '(a 1) '(b 2) '(c 3))
=>  "Pairs: <A,1> <B,2> <C,3>."
```

使用`~:}`而不是`~}`结束迭代构造会强制至少处理一次`str`, 甚至在处理传递参数列表是空时. 然而, 这不会覆盖显式前缀参数为零的情况.

如果`str`为空, 则一个传递参数作为`str`使用. 它必须是一个格式控制, 并且在任何迭代处理的传递参数之前出现. 例如有:

```
(apply #'format stream string arguments)
==  (format stream "~1{~:}" string arguments)
```

这会将`string`作为格式字符串使用. `~1{`说明它之多被处理一次, `~:}`说明它将被至少处理一次. 所以它会被使用`arguments`作为传递参数处理一次. 这种情况使用指令`~?`可能更侵袭, 但`~{`的特性比`~?`更强.

#### 22.3.7.5 `~}`: 结束迭代

`~}`结束`~{`. 在其它地方使用它的后果是未定义的.

#### 22.3.7.6 `~?`: 递归处理

下一个`arg`必须是一个格式控制, 它后面是一个列表; 都被指令`~?`消费. 这两个被作为`control-string`处理, 将列表中元素作为传递参数. 一旦递归处理已经完成, 恢复包含指令`~?`的控制字符串的处理. 例如:

```
(format nil "~? ~D" "<~A ~D>" '("Foo" 5) 7) =>  "<Foo 5> 7"
(format nil "~? ~D" "<~A ~D>" '("Foo" 5 14) 7) =>  "<Foo 5> 7"
```

注意, 在第二个示例中给格式化字符串`"<~A ~D>"`提供了三个传递参数, 但只处理了两个, 第三个被忽略.

带修饰符`@`时, 只有一个`arg`被直接消费. 这个`arg`必须是一个字符串; 就像它在控制字符串的`~@?`构造处出现一样处理, 递归处理的控制字符串中的任何指令可以消费包含指令`~@?`的控制字符串的传递参数. 例如:

```
(format nil "~@? ~D" "<~A ~D>" "Foo" 5 7) =>  "<Foo 5> 7"
(format nil "~@? ~D" "<~A ~D>" "Foo" 5 14 7) =>  "<Foo 5> 14"
```

### 22.3.8 FORMAT杂项操作

#### 22.3.8.1 `~(`: 大小写转换

```
~(str~)
```

被包含的控制字符串`str`被处理, 它生成的内容会被大小写转换处理.

不带修饰符标志时, 每个大写字符被转换为相应的小写字符.

`~:(`将所有单词的首字母转换为大写, 就像使用了`string-capitalize`.

`~@(`只将第一个单词的首字母转换为大写, 将后续的单词转换为小写.

`~:@(`将每个小写字符转换为相应的大写字符.

在下面的示例中, 使用`~@(`将`~@R`生成的首个单词的首字母大写:

```
(format nil "~@R ~(~@R~)" 14 14)
=>  "XIV xiv"

(defun f (n) (format nil "~@(~R~) error~:P detected." n)) =>  F
(f 0) =>  "Zero errors detected."
(f 1) =>  "One error detected."
(f 23) =>  "Twenty-three errors detected."
```

当出现嵌套的大小写转换时, 最外层的转换起支配作用, 例如:

```
(format nil "~@(how is ~:(BOB SMITH~)?~)")
=>  "How is bob smith?"
NOT=>  "How is Bob Smith?"
```

#### 22.3.8.2 `~)`: 结束大小写转换

`~)`结束`~(`. 在其它地方使用它的后果是未定义的.

#### 22.3.8.3 `~P`: 复数(Plural)

如果`arg`不与整数1在`eql`下相等, 则打印出一个小写的`s`; 如果相等则不会打印内容. 如果`arg`是浮点数1.0, 则打印出`s`.

`~:P`在使用`~:*`备份一个传递参数后做同样的事情, 即如果前一个传递参数不是1时它打印出一个小写的`s`.

`~@P`在传递参数是1时打印出`y`, 不是时打印出`ies`. `~:@P`做同样的事情, 但会先备份一个传递参数.

```
(format nil "~D tr~:@P/~D win~:P" 7 1) =>  "7 tries/1 win"
(format nil "~D tr~:@P/~D win~:P" 1 0) =>  "1 try/0 wins"
(format nil "~D tr~:@P/~D win~:P" 1 3) =>  "1 try/3 wins"
```

### 22.3.9 FORMAT杂项伪操作

#### 22.3.9.1 `~;`: 子句分隔

这会在`~[`和`~<`构造中分隔子句. 在其它地方使用它的后果是未定义的.

#### 22.3.9.2 `~^`: 向上转义

```
~^
```

这是一个转义构造. 如果没有剩余传递参数需要处理, 则立即包含它的`~{`或`~<`构造终止. 如果外部没有这样的构造, 则这个格式化操作终止. 在`~<`情况中, 执行格式化, 但在对齐之前不处理其它片段. `~^`可以在`~{`构造中的任何位置出现.

```
(setq donestr "Done.~^ ~D warning~:P.~^ ~D error~:P.")
=>  "Done.~^ ~D warning~:P.~^ ~D error~:P."
(format nil donestr) =>  "Done."
(format nil donestr 3) =>  "Done. 3 warnings."
(format nil donestr 1 5) =>  "Done. 1 warning. 5 errors."
```

如果给定了前缀参数, 且参数为零则立即终止. (因此`~^`等价于`~#^`). 如果给定了两个参数, 且它们相等时立即终止. 如果给定了三个参数, 且第一个小于等于第二个, 且第二个小于等于第三个时, 立即终止. 当然, 这在所有前缀参数是常量时没什么用; 至少有一个参数是`#`或`V`参数.

如果在`~:{`构造中使用`~^`, 因为在标准情形下它只会测试当前步骤的剩余传递参数, 它会结束当前迭代步骤; 立即开始下一个迭代步骤. `~:^`用于结束迭代处理. `~:^`只在它将结束的命令是`~:{`或`~:@{`时使用. 当且仅当为当前迭代步骤提供传递参数的子列表是`~:{`中的最后一个子列表或`~:@{`中的最后一个格式化传递参数时, 结束整个迭代处理. `~:^`不等价于`~#:^`; 当且仅当没有用于当前迭代步骤的剩余传递参数时, 后者终止整个迭代. 例如:

```
(format nil "~:{ ~@?~:^ ...~} " '(("a") ("b"))) =>  "a...b"
```

如果`~^`出现在指令`~?`控制下处理的控制字符串中, 但不在这个字符串的任何`~{`或`~<`构造中出现, 则被处理的字符串会终止, 从而结束处理指令`~?`. 在包含指令`~?`的字符串中继续处理它后面的内容.

如果`~^`出现在`~[`或`~(`构造中, 则所有到`~^`的命令被恰当的选择或大小写转换, 结束处理`~[`或`~(`, `~{`或`~<`构造的外向搜索终止. 例如:

```
(setq tellstr "~@(~@[~R~]~^ ~A!~)")
=>  "~@(~@[~R~]~^ ~A!~)"
(format nil tellstr 23) =>  "Twenty-three!"
(format nil tellstr nil "losers") =>  " Losers!"
(format nil tellstr 23 "losers") =>  "Twenty-three losers!"
```

下面是在`~<`构造中使用`~^`的示例:

```
(format nil "~15<~S~;~^~S~;~^~S~>" 'foo)
=>   "            FOO"
(format nil "~15<~S~;~^~S~;~^~S~>" 'foo 'bar)
=>   "FOO         BAR"
(format nil "~15<~S~;~^~S~;~^~S~>" 'foo 'bar 'baz)
=>   "FOO   BAR   BAZ"
```

#### 22.3.9.3 `~%`: 忽略的换行

紧跟在换行后的变音符(`~`)会略换行和任何后续的非换行的空白字符. 带修饰符`:`时, 忽略换行, 但保留后续的空白符. 带修饰符`@`是, 保留换行, 但忽略后续的空白符. 例如:

```
(defun type-clash-error (fn nargs argnum right-type wrong-type)
  (format *error-output*
          "~&~S requires its ~:[~:R~;~*~]~
          argument to be of type ~S,~%but it was called ~
          with an argument of type ~S.~%"
          fn (eql nargs 1) argnum right-type wrong-type))

(type-clash-error 'aref nil 2 'integer 'vector)  prints:
AREF requires its second argument to be of type INTEGER,
but it was called with an argument of type VECTOR.
NIL

(type-clash-error 'car 1 1 'list 'short-float)  prints:
CAR requires its argument to be of type LIST,
but it was called with an argument of type SHORT-FLOAT.
NIL
```

注意到这个示例中, 只出现指令`~&`和`~%`指定的换行; 控制字符串中的实际换行被抑制, 因为行末有`~`.

### 22.3.10 FORMAT操作的额外信息

#### 22.3.10.1 FORMAT操作的嵌套

大小写转换、条件、迭代和对齐构造可以使用括弧包含其它格式构造. 这些构造必须互相恰当的嵌套. 例如, 将大小写转换构造的开始放在条件构造的分支中, 而大小写转换的构造结尾放在条件构造的外部是非法的:

```
(format nil "~:[abc~:@(def~;ghi~
:@(jkl~]mno~)" x) ;Invalid!
```

因为`~[...~;...~]`和`~(...~)`构造没有恰当的嵌套, 这个记法是无效的.

由指令`~?`产生的间接处理也是一种这种恰当嵌套规则需要考虑的嵌套. 不允许在指令`~?`控制下处理的字符串中开始一个括弧构造, 且在包含该构造的字符串中`~?`后面结束这个构造, 或者反之. 例如, 这种情况是无效的:

```
(format nil "~@?ghi~)" "abc~@(def") ;Invalid!
```

因为`~?`和`~(...~)`构造没有恰当的嵌套, 这个记法是无效的.

#### 22.3.10.2 FORMAT的缺失和额外传递参数

如果在指令需要一个传递参数时没有剩余的`arg`, 后果是未定义的. 然而, 允许有一个或多个未被指令处理的`args`; 这些`args`被忽略.

#### 22.3.10.3 额外的FORMAT参数

如果给格式化指令提供了这里描述为可接受的参数之外的参数, 后果是未定义的.

#### 22.3.10.4 未定义的FORAMT修饰符组合

如果个格式化指令提供了这里没有描述为有意义的修饰符`:`或`@`, 后果是未定义的.

### 22.3.11 示例: FORMAT

```
(format nil "foo") =>  "foo"
(setq x 5) =>  5
(format nil "The answer is ~D." x) =>  "The answer is 5."
(format nil "The answer is ~3D." x) =>  "The answer is   5."
(format nil "The answer is ~3,'0D." x) =>  "The answer is 005."
(format nil "The answer is ~:D." (expt 47 x))
=>  "The answer is 229,345,007."
(setq y "elephant") =>  "elephant"
(format nil "Look at the ~A!" y) =>  "Look at the elephant!"
(setq n 3) =>  3
(format nil "~D item~:P found." n) =>  "3 items found."
(format nil "~R dog~:[s are~; is~] here." n (= n 1))
=>  "three dogs are here."
(format nil "~R dog~:*~[s are~; is~:;s are~] here." n)
=>  "three dogs are here."
(format nil "Here ~[are~;is~:;are~] ~:*~R pupp~:@P." n)
=>  "Here are three puppies."
```

```
(defun foo (x)
  (format nil "~6,2F|~6,2,1,'*F|~6,2,,'?F|~6F|~,2F|~F"
          x x x x x x)) =>  FOO
(foo 3.14159)  =>  "  3.14| 31.42|  3.14|3.1416|3.14|3.14159"
(foo -3.14159) =>  " -3.14|-31.42| -3.14|-3.142|-3.14|-3.14159"
(foo 100.0)    =>  "100.00|******|100.00| 100.0|100.00|100.0"
(foo 1234.0)   =>  "1234.00|******|??????|1234.0|1234.00|1234.0"
(foo 0.006)    =>  "  0.01|  0.06|  0.01| 0.006|0.01|0.006"
```

```
(defun foo (x)
   (format nil
          "~9,2,1,,'*E|~10,3,2,2,'?,,'$E|~
           ~9,3,2,-2,'%@E|~9,2E"
          x x x x))
(foo 3.14159)  =>  "  3.14E+0| 31.42$-01|+.003E+03|  3.14E+0"
(foo -3.14159) =>  " -3.14E+0|-31.42$-01|-.003E+03| -3.14E+0"
(foo 1100.0)   =>  "  1.10E+3| 11.00$+02|+.001E+06|  1.10E+3"
(foo 1100.0L0) =>  "  1.10L+3| 11.00$+02|+.001L+06|  1.10L+3"
(foo 1.1E13)   =>  "*********| 11.00$+12|+.001E+16| 1.10E+13"
(foo 1.1L120)  =>  "*********|??????????|%%%%%%%%%|1.10L+120"
(foo 1.1L1200) =>  "*********|??????????|%%%%%%%%%|1.10L+1200"
```

作为多种缩放因子的效果的实力, 下面的代码:

```
(dotimes (k 13)
  (format t "~%Scale factor ~2D: |~13,6,2,VE|"
          (- k 5) (- k 5) 3.14159))
```

生成下面的输出:

```
Scale factor -5: | 0.000003E+06|
Scale factor -4: | 0.000031E+05|
Scale factor -3: | 0.000314E+04|
Scale factor -2: | 0.003142E+03|
Scale factor -1: | 0.031416E+02|
Scale factor  0: | 0.314159E+01|
Scale factor  1: | 3.141590E+00|
Scale factor  2: | 31.41590E-01|
Scale factor  3: | 314.1590E-02|
Scale factor  4: | 3141.590E-03|
Scale factor  5: | 31415.90E-04|
Scale factor  6: | 314159.0E-05|
Scale factor  7: | 3141590.E-06|
```

```
(defun foo (x)
  (format nil "~9,2,1,,'*G|~9,3,2,3,'?,,'$G|~9,3,2,0,'%G|~9,2G"
         x x x x))
(foo 0.0314159) =>  "  3.14E-2|314.2$-04|0.314E-01|  3.14E-2"
(foo 0.314159)  =>  "  0.31   |0.314    |0.314    | 0.31    "
(foo 3.14159)   =>  "   3.1   | 3.14    | 3.14    |  3.1    "
(foo 31.4159)   =>  "   31.   | 31.4    | 31.4    |  31.    "
(foo 314.159)   =>  "  3.14E+2| 314.    | 314.    |  3.14E+2"
(foo 3141.59)   =>  "  3.14E+3|314.2$+01|0.314E+04|  3.14E+3"
(foo 3141.59L0) =>  "  3.14L+3|314.2$+01|0.314L+04|  3.14L+3"
(foo 3.14E12)   =>  "*********|314.0$+10|0.314E+13| 3.14E+12"
(foo 3.14L120)  =>  "*********|?????????|%%%%%%%%%|3.14L+120"
(foo 3.14L1200) =>  "*********|?????????|%%%%%%%%%|3.14L+1200"
```

```
(format nil "~10<foo~;bar~>")   =>  "foo    bar"
(format nil "~10:<foo~;bar~>")  =>  "  foo  bar"
(format nil "~10<foobar~>")     =>  "    foobar"
(format nil "~10:<foobar~>")    =>  "    foobar"
(format nil "~10:@<foo~;bar~>") =>  "  foo bar "
(format nil "~10@<foobar~>")    =>  "foobar    "
(format nil "~10:@<foobar~>")   =>  "  foobar  "
```

```
(FORMAT NIL "Written to ~A." #P"foo.bin")
=>  "Written to foo.bin."
```

### 22.3.12 备注: FORMAT

格式化的输出不仅仅由`format`生成, 也可以通过其它与`format`一样接受格式化控制的其它函数生成. 例如, 诸如`cerror`的错误发出函数接受格式化控制.

注意作为`format`目的地的`nil`和`t`的含义与它们作为流设计器的含义不同.

因为`~^`中断它所在的整个子句(以及后面的子句), 它应该只在`~<`子句的开始处出现.

## 22.4 打印器的字典

- function `copy-pprint-dispatch`
- macro `formatter`
- function `pprint-dispatch`
- local `macro pprint-exit-if-list-exhausted`
- function `pprint-fill`
- function `pprint-linear`
- function `pprint-tabular`
- function `pprint-indent`
- macro `pprint-logical-block`
- function `pprint-newline`
- local `macro pprint-pop`
- function `pprint-tab`
- standard generic function `print-object`
- macro `print-unreadable-object`
- function `set-pprint-dispatch`
- function `write`
- function `prin1`
- function `print`
- function `pprint`
- function `princ`
- function `write-to-string`
- function `prin1-to-string`
- function `princ-to-string`
- variable `*print-array*`
- variable `*print-base*`
- variable `*print-radix*`
- variable `*print-case*`
- variable `*print-circle*`
- variable `*print-escape*`
- variable `*print-gensym*`
- variable `*print-level*`
- variable `*print-length*`
- variable `*print-lines*`
- variable `*print-miser-width*`
- variable `*print-pprint-dispatch*`
- variable `*print-pretty*`
- variable `*print-readably*`
- variable `*print-right-margin*`
- condition type `print-not-readable`
- function `print-not-readable-object`
- function `format`

# 23 读取器

## 23.1 读取器的概念

### 23.1.1 Lisp读取器的动态控制

可以动态控制Lisp读取器的多个当面. 见**2.1.1 `readtable`**和**2.1.2 影响Lisp读取器的变量**.

### 23.1.2 Lisp读取器中readtable大小写的作用

当前readtable的到小写按下面的方式影响Lisp读取器:

- `:upcase`  
    
- 当readtable的大小写是`:upcase`时, 未转义的成分字符被转换为大写, 见**2.2 读取器算法**.
- `:downcase`  
    
- 当readtable的大小写是`:downcase`时, 未转义的成分字符被转换为小写.
- `:preserve`  
    
- 当readtable的大小写是`:preserve`时, 所有字符的大小写保持不变.
- `:invert`  
    
- 当readtable的大小写是`:invert`时, 如果在扩展记号中的所有未转义字母有同样的大小写, 则这些(未转义)的字母被转换为相反的大小写.

#### 23.1.2.1 示例: Lisp读取器中readtable大小写的作用

```
(defun test-readtable-case-reading ()
  (let ((*readtable* (copy-readtable nil)))
    (format t "READTABLE-CASE  Input   Symbol-name~
             ~%-----------------------------------~
             ~%")
    (dolist (readtable-case '(:upcase :downcase :preserve :invert))
      (setf (readtable-case *readtable*) readtable-case)
      (dolist (input '("ZEBRA" "Zebra" "zebra"))
        (format t "~&:~A~16T~A~24T~A"
                (string-upcase readtable-case)
                input
                (symbol-name (read-from-string input)))))))
```

`(test-readtable-case-reading)`的输出是:

```
READTABLE-CASE     Input Symbol-name
-------------------------------------
   :UPCASE         ZEBRA   ZEBRA
   :UPCASE         Zebra   ZEBRA
   :UPCASE         zebra   ZEBRA
   :DOWNCASE       ZEBRA   zebra
   :DOWNCASE       Zebra   zebra
   :DOWNCASE       zebra   zebra
   :PRESERVE       ZEBRA   ZEBRA
   :PRESERVE       Zebra   Zebra
   :PRESERVE       zebra   zebra
   :INVERT         ZEBRA   zebra
   :INVERT         Zebra   Zebra
   :INVERT         zebra   ZEBRA
```

### 23.1.3 一些读取器函数的传递参数转换

#### 23.1.3.1 EOF-ERROR-P传递参数

在输入函数调用中的`eof-error-p`, 控制当是从文件的输入(或其它有确定尾部的输入源)且达到文件尾时会发生什么. 如果`eof-error-p`是true(默认情况), 在文件尾发出类型为`end-of-file`的错误信号. 如果是false, 不会发出错误信号, 函数会返回`eof-value`.

诸如`read`的读取对象表示而不是单个字符的函数, 不限于`eof-error-p`, 在文件在对象表示中间结束时总是会发出错误信号. 例如, 如果文件没有包含足够的平衡左括号的右括号, `read`发出错误信号. 如果文件在一个符号或数值后立即以文件结束符结束, `read`会成功读取符号或数值, 当继续调用时动作会与`eof-error-p`一样. 类似的, 函数`read-line`会成功的读取文件的最后一行, 甚至这一行中包含文件结束符而不是换行符时也是如此. 可被忽略的文本, 例如只包含空白或注释的文本, 不被视为对象的开始; 如果`read`开始读取一个表达式, 但值看到这种可被忽略的文本, 它不会认为文件在对象中间结束. 因此, 传递参数`eof-error-p`控制文件在对象中间结束时发生什么.

#### 23.1.3.2 RECURSIVE-P传递参数

如果提供了非`nil`的`recursive-p`, 它表明这个函数调用不是罪外层的`read`调用, 而是内嵌的调用, 通常是从读取器宏函数中的调用. 提出这种递归调用有三个原因.

1. 最外层的调用建立了`#n=`和`#n#`语法作用的上下文. 考虑下面的表达式:

```
(cons '#3=(p q r) '(x y . #3#))
```

如果单引用读取器宏按如下方式定义:

```
(set-macro-character #\'       ;incorrect
   #'(lambda (stream char)
        (declare (ignore char))
        (list 'quote (read stream))))
```

则每次对单引用读取器宏函数的调用都会建立独立的`read`信息作用域的上下文, 这个作用域包括像`#3=`和`#3#`标记之间的标识的作用域. 然而, 对这个表达式, 作用域明显是想用外层括号组确定的, 所以这个定义是不正确的. 正确的方式是用`recursive-p`定义单引用读取器宏:

```
(set-macro-character #\'       ;correct
   #'(lambda (stream char)
        (declare (ignore char))
        (list 'quote (read stream t nil t))))
```

1. 递归调用不会改变读取过程是否保留是空白(由最外层调用是否是`read`或`read-preserving-whitespace`确定). 假设单引用是按上面不正确的方式定义的, 则读取表达式`'foo<Space>`的`read-preserving-whitespace`调用不会保留符号`foo`之后的空格符号, 因为这个单引用读取器宏函数调用了`read`而不是`read-preserving-whitespace`来读取后面的表达式(这种情况下的`foo`). 正确的定义, 给`read`传递值为true的`recursive-p`, 允许最外层调用确定是否保留空白.
2. 当遇到文件结束符且传递参数`eof-error-p`非`nil`时, 发出的错误信号种类可能依赖于recursive-p的值. 如果`recursive-p`是true, 则文件结束符被视为已在打印的表示中间出现; 如果为false, 则文件结束符被视为已在对象之间而不是在一个对象中出现.

## 23.2 读取器的字典

- system class `readtable`
- function `copy-readtable`
- function `make-dispatch-macro-character`
- function `read`
- function `read-preserving-whitespace`
- function `read-delimited-list`
- function `read-from-string`
- accessor `readtable-case`
- function `readtablep`
- function `set-dispatch-macro-character`
- function `get-dispatch-macro-character`
- function `set-macro-character`
- function `get-macro-character`
- function `set-syntax-from-char`
- macro `with-standard-io-syntax`
- variable `*read-base*`
- variable `*read-default-float-format*`
- variable `*read-eval*`
- variable `*read-suppress*`
- variable `*readtable*`
- condition type `reader-error`

# 24 系统构造

## 24.1 系统构造的概念

### 24.1.1 加载

`load`文件将其内容视为代码, 并执行代码. 文件可以包含源代码或编译后的代码.

包含源代码的文件称为源文件. 加载源文件是通过顺序的读文件中形式、读取后立即求值完成的.

包含已编译的代码的文件称为已编译的文件. 加载已编译的文件与加载源文件类似, 除非这个文件不包含文本而是包含由编译器创建的预先理解的表达式的依赖于实现的表示. 通常, 加载已编译的文件比加载源文件快. 见**3.2 编译**.

区分源文件与已编译文件的方法是依赖于实现的.

### 24.1.2 特性

特性是Common Lisp的实现或环境的一个方面或属性. 特性由符号标识.

当且仅当命名特性的符号是变量`*features*`(称为特性列表)中的一个元素时, 称特性在Lisp镜像中存在.

#### 24.1.2.1 特性表达式

特性的布尔组合称为特性表达式, 使用读取器宏`#+`和`#-`指导Lisp读取器对表达式的条件读取.

解释特性表达式的规则如下:

- `feature`  
    
- 如果命名了特性的符号被用作特性表达式, 且该特性存在, 则该表达式(求值)成功, 否则失败.
- `(not feature-conditional)`  
    
- 如果这个表达式中`feature-conditional`(求值)失败, 则该表达式(求值)成功, 否则失败.
- `(and feature-conditional*)`  
    
- 如果这个表达式中所有`feature-conditional`(求值)成功, 则该表达式(求值)成功, 否则失败.
- `(or feature-conditional*)`  
    
- 如果这个表达式中有一个`feature-conditional`(求值)成功, 则该表达式(求值)成功, 否则失败.

##### 24.1.2.1.1 示例: 特性表达式

例如, 在实现A中存在特性`spice`和`perq`, 不存在`lispm`; 在实现B中存在特性`lispm`, 不存在`spice`和`perq`; 在实现C中, 不存在`spice`,`lispm`和`perq`.

下图展示了一些示例特性表达式, 以及它们如何被实现中读取的:

图 24-1. 特性示例.

```
(cons #+spice "Spice" #-spice "Lispm" x)

in implementation A ...  (CONS "Spice" X)
in implementation B ...  (CONS "Lispm" X)
in implementation C ...  (CONS "Lispm" X)

(cons #+spice "Spice" #+LispM "Lispm" x)

in implementation A ...  (CONS "Spice" X)
in implementation B ...  (CONS "Lispm" X)
in implementation C ...  (CONS X)

(setq a '(1 2 #+perq 43 #+(not perq) 27))

in implementation A ...  (SETQ A '(1 2 43))
in implementation B ...  (SETQ A '(1 2 27))
in implementation C ...  (SETQ A '(1 2 27))

(let ((a 3) #+(or spice lispm) (b 3)) (foo a))

in implementation A ...  (LET ((A 3) (B 3)) (FOO A))
in implementation B ...  (LET ((A 3) (B 3)) (FOO A))
in implementation C ...  (LET ((A 3)) (FOO A))

(cons #+Lispm "#+Spice" #+Spice "foo" #-(or Lispm Spice) 7 x)

in implementation A ...  (CONS "foo" X)
in implementation B ...  (CONS "#+Spice" X)
in implementation C ...  (CONS 7 X)
```

## 24.2 系统构造的字典

- function `compile-file`
- function `compile-file-pathname`
- function `load`
- macro `with-compilation-unit`
- variable `*features*`
- variable `*compile-file-pathname*`
- variable `*compile-file-truename*`
- variable `*load-pathname*`
- variable `*load-truename*`
- variable `*compile-print*`
- variable `*compile-verbose*`
- variable `*load-print*`
- variable `*load-verbose*`
- variable `*modules*`
- function `provide`
- function `require`

# 25 环境

## 25.1 外部环境

### 25.1.1 顶层循环

顶层循环是用于与Common Lisp系统交互的机制. 因为它由无终止的读取表达式、求值该表达式并打印结果的循环构成, 这个循环有时被称为Lisp读-求值-打印循环(REPL).

顶层循环没有被完整描述, 因此它的用户接口是由实现定义的. 顶层循环打印求值形式的结果中的所有值. 下图列出了Lisp REPL操作的变量.

图 25-1. REPL操作的变量.

```
*
**
***
+
++
+++
/
//
///
-
```

### 25.1.2 调试工具

下图列出了与调试相关的已定义名称:

图 25-2. 与调试相关的已定义名称.

```
*debugger-hook*
apropos
apropos-list
break
describe
documentation
dribble
ed
inspect
invoke-debugger
step
time
trace
untrace
```

### 25.1.3 探究环境

探究环境的已定义名称提供了关于Common Lisp程序执行所在的硬件和软件的配置信息.

下图列出了与探究环境相关的已定义名称:

图 25-3. 与探究环境相关的已定义名称.

```
*features*
lisp-implementation-type
lisp-implementation-version
long-site-name
machine-instance
machine-type
machine-version
room
short-site-name
software-type
software-version
```

### 25.1.4 时间

Common Lisp中时间按四种方式表示: 解码的时间、世界时间、内部时间和秒. 解码的时间和世界时间主要用于表示日历时间, 精确到秒. 内部时间用于表示计算机时间(例如运行时间)的度量, 其精确性是依赖于实现的, 是由`internal-time-units-per-second`指定的内部时间单元. 内部时间可用于绝对或相对时间度量. 世界时间和解码的时间智能用于绝对时间度量. 在函数`sleep`中, 时间间隔由非负实数的秒数表示.

下图列出了与时间相关的已定义名称:

图 25-4. 包含时间的已定义名称.

```
decode-universal-time
encode-universal-time
get-decoded-time
get-internal-real-time
get-internal-run-time
get-universal-time
internal-time-units-per-second
sleep
```

#### 25.1.4.1 解码的时间

解码的时间是由9个值组成的系列, 表示日历时间中一个时刻点(不考虑闰秒).

- 秒: 0到59的整数, 包含两端值.
- 分钟: 0到59的整数, 包含两端值.
- 小时: 0到23的整数, 包含两端值.
- 日: 1到31的整数, 包含两端值(当然上界依赖于年和月).
- 月: 1到12的整数, 包含两端值; 1表示1月, 2表示2月等等.
- 年: 表示公元年的整数. 然而, 如果整数在0到99之间, 使用显式年; 即实际年模100后在当前年五十年范围内(前包含后不包含).因此, 在1978年, 年28表示1928, 但年27表示2027. (按这种格式返回时间的函数总是返回完整的年数字)
- 一周中的一天: 0到6的整数, 包含两端值. 0表示周一, 1表示周二等等.
- 夏令时标志: 一个广义布尔值, 为true时表示使用夏令时.
- 时区: 一个时区.

下图列出了与解码的时间相关的已定义名称:

图 25-5. 包含解码的时间中时间的已定义名称.

```
decode-universal-time
get-decoded-time
```

#### 25.1.4.2 世界时间

> GMT: 格林尼治时间.

世界时间是表示为一个非负整数的绝对时间, 从1900 GMT 1月1日午夜历经的秒数(不考虑闰秒). 因此时间1表示1999 GMT 1月一日 00:00:01(即12:00:01 a.m.). 类似的, 时间2398291201表示 1976 GMT 1月1日 00:00:01. 1900年不是闰年, 在Common Lisp的一年是闰年, 当且仅当, 它对应的数值被4整除, 例外情况: 被100整除的不是闰年, 被400整除的是润年. 因为, 2000年是闰年. 因为世界时间必须是一个非负整数, Common Lisp不能处理基时间之前的时间.

图 25-6. 包含时间时间中时间的已定义名称.

```
decode-universal-time
encode-universal-time
get-universal-time
```

#### 25.1.4.3 内部时间

内部时间依据称为内部时间单元的依赖于实现的单元, 将时间表示为单个整数. 相对时间按这些单元计算. 绝对时间是相对于任意时间基的.

下图列出了与内部时间相关的已定义名称.

图 25-7. 包含内部时间中时间的已定义名称.

```
get-internal-real-time
get-internal-run-time
internal-time-units-per-second
```

#### 25.1.4.4 秒

函数`sleep`的传递参数是非负的实数秒数. 可以认为这是一个相对世界时间, 但存在一个重要的差别: 世界时间总是非负的整数, `sleep`的传递参数可以是任意非负的实数, 允许表示分数秒.

图 25-8. 包含秒中时间的已定义名称.

```
sleep
```

## 25.2 环境的字典

- function `decode-universal-time`
- function `encode-universal-time`
- function `get-universal-time`
- function `get-decoded-time`
- function `sleep`
- function `apropos`
- function `apropos-list`
- function `describe`
- standard generic function `describe-object`
- macro `trace`
- macro `untrace`
- macro `step`
- macro `time`
- constant variable `internal-time-units-per-second`
- function `get-internal-real-time`
- function `get-internal-run-time`
- function `disassemble`
- standard generic function `documentation`
- standard generic function `(setf documentation)`
- function `room`
- function `ed`
- function `inspect`
- function `dribble`
- variable `-`
- variable `+`
- variable `++`
- variable `+++`
- variable `*`
- variable `**`
- variable `***`
- variable `/`
- variable `//`
- variable `///`
- function `lisp-implementation-type`
- function `lisp-implementation-version`
- function `short-site-name`
- function `long-site-name`
- function `machine-instance`
- function `machine-type`
- function `machine-version`
- function `software-type`
- function `software-version`
- function `user-homedir-pathname`

# Figures

- 1 介绍
    - 图 1-1. NIL的记法.
- 2 语法
    - 图 2-1. `readtable`相关的已定义名称.
    - 图 2-2. 影响Lisp读取器的变量.figure
    - 图 2-3. 标准字符子表
    - 图 2-4. 标准字符子表
    - 图 2-5. 标准字符子表
    - 图 2-6. 可能的字符语法类型.
    - 图 2-7. 标准语法中字符的语法类型.
    - 图 2-8. 标准字符和半标准字符的要素特质.
    - 图 2-9. 数值记号的语法.
    - 图 2-10. 保留记号示例.
    - 图 2-11. 符号示例.
    - 图 2-12. 符号或可能的数值的示例.
    - 图 2-13. 比值示例.
    - 图 2-14. 浮点数的示例.
    - 图 2-15. 符号的打印表示示例
    - 图 2-16. 符号的打印表示示例
    - 图 2-17. 记号的有效模式.
    - 图 2-18. 双引号使用示例.
    - 图 2-19. 标准`#`分发宏字符语法.
    - 图 2-20. 进制指示器示例.
- 3 求值和编译
    - 图 3-1. 一些可用于变量的已定义名称.
    - 图 3-2. Common Lisp特殊操作符.
    - 图 3-3. 可用于宏的已定义名称.
    - 图 3-4. 一些函数相关的已定义名称.
    - 图 3-5. 一些可用于接收多值的操作符.
    - 图 3-6. 可用于编译器宏的已定义名称.
    - 图 3-7. EVAL-WHEN处理.
    - 图 3-8. 影响编译时环境的定义宏.
    - 图 3-9. Common Lisp声明标识符.
    - 图 3-10. lambda列表的种类.
    - 图 3-11. 可用于lambda列表的已定义名称.
    - 图 3-12. 使用常规lambda列表的标准操作符.
    - 图 3-13. 常规lambda列表中使用的lambda列表关键字.
    - 图 3-14. 广义函数lambda列表中可以使用的lambda列表关键字.
    - 图 3-15. 使用特化的lambda列表的标准操作符.
    - 图 3-16. 特化的lambda列表使用的lambda列表关键字.
    - 图 3-17. 使用宏lambda列表的操作符.
    - 图 3-18. 宏lambda列表使用的lambda列表关键字.
    - 图 3-19. `defsetf` lambda列表使用的lambda列表关键字.
    - 图 3-20. `define-modify-macro` lambda列表可以使用的lambda列表关键字.
    - 图 3-21. `define-method-combination` 传递参数lambda列表可以使用的lambda列表关键字.
- 4 类型和类
    - 图 4-1. 数据类型信息的引用.
    - 图 4-2. 标准原子类型描述符.
    - 图 4-3. 标准复合类型描述符名称.
    - 图 4-4. 标准的只用于复合类型描述符的名称.
    - 图 4-5. 与类型和声明相关的已定义名称.
    - 图 4-7. 对象系统类.
    - 图 4-8. 与预定义的类型描述对应的类.
- 5 数据和控制流
    - 图 5-1. setf的示例.
    - 图 5-2. 与位置和通用的引用相关的操作符.
    - 图 5-3. 变量的setf展开的示例.
    - 图 5-4. CAR形式的setf展开的示例.
    - 图 5-5. SUBSEQ形式的setf展开的示例.
    - 图 5-6. LDB形式的setf展开的示例.
- 6 迭代: 无.
- 7 对象
    - 图 7-1. 标准的定义方法的操作符.
    - 图 7-2. 内置方法组合类型.
- 8 结构: 无.
- 9 条件
    - 图 9-1. 标准状况类型.
    - 图 9-2. 定义和创建状况的操作符.
    - 图 9-3. 读取状况操作的操作符.
    - 图 9-4. 与处理状况相关的操作符.
    - 图 9-5. 与发出状况相关的已定义名称.
    - 图 9-6. 与重启器相关的已定义名称.
    - 图 9-7. 与断言相关的操作符.
- 10 符号
    - 图 10-1. 属性列表的已定义名称.
    - 图 10-2. 符号创建和探究的已定义名称.
- 11 包
    - 图 11-1. 与包相关的一些已定义名称.
    - 图 11-2. 标准包名称.
- 12 数值
    - 图 12-1. 与算术相关的操作符.
    - 图 12-2. 与指数、对数和三角学相关的已定义名称.
    - 图 12-3. 数值比较和谓词操作符.
    - 图 12-4. 数值类型操作和转换相关的已定义名称.
    - 图 12-5. 与数值上逻辑操作相关的已定义名称.
    - 图 12-6. 与操作数值中字节相关的已定义名称.
    - 图 12-7. 与关于数值的依赖于实现的细节相关的已定义名称.
    - 图 12-8. 受浮点数可代换性规则影响的函数.
    - 图 12-9. 复数域中的三角恒等式.
    - 图 12-10. 分支切割的四象限数.
    - 图 12-11. 随机状态的已定义名称.
- 13 字符
    - 图 13-1. 字符的已定义名称 – 1.
    - 图 13-2. 字符的已定义名称 – 2.
- 14 Cons
    - 图 14-1. Cons相关的一些已定义名称.
    - 图 14-2. 树相关的一些已定义名称.
    - 图 14-3. 列表相关的一些已定义名称.
    - 图 14-4. 关联列表相关的一些已定义名称.
- 15 数组
    - 图 15-1. 通用的数组相关的已定义名称.
    - 图 15-2. 操作字符串的操作符.
- 16 字符串: 无.
- 17 序列
    - 图 17-1. 标准的序列函数.
    - 图 17-2. 有两个传递参数测试的操作符.
    - 图 17-3. 有单个传递参数测试的操作符.
- 18 哈希表
    - 图 18-1. 哈希表已定义名称.
- 19 文件名
    - 图 19-1. 路径名操作.
    - 图 19-2. 使用`:CASE`传递参数的路径名函数.
    - 图 19-3. 目录组件中特殊标记.
- 20 文件
    - 图 20-1. 文件和目录操作.
    - 图 20-2. 视打开的流与关闭的流是不同的文件函数.
    - 图 20-3. 最好使用关闭的流的文件函数.
- 21 流
    - 图 21-1. 一些通用流操作.
    - 图 21-2. 与输入流相关的操作符.
    - 图 21-3. 与输出流相关的操作符.
    - 图 21-4. 与双向流相关的操作符.
    - 图 21-5. 与特殊的流相关的已定义名称.
    - 图 21-6. 标准的流变量.
    - 图 21-7. 接受打开的或关闭的流的操作符.
    - 图 21-8. 只接受打开的流的操作符.
- 22 打印器
    - 图 22-1. 标准的打印器控制变量.
    - 图 22-2. Lisp打印器的额外影响因素.
    - 图 22-3. 逻辑块、条件换行和节的示例.
    - 图 22-4. 与美观打印相关的已定义名称.
    - 图 22-5. 与美观打印相关的格式化指令.
    - 图 22-6. 格式控制字符串的示例.
- 23 读取器
- 24 系统构造
    - 图 24-1. 特性示例.
- 25 环境
    - 图 25-1. REPL操作的变量.
    - 图 25-2. 与调试相关的已定义名称.
    - 图 25-3. 与探究环境相关的已定义名称.
    - 图 25-4. 包含时间的已定义名称.
    - 图 25-5. 包含解码的时间中时间的已定义名称.
    - 图 25-6. 包含时间时间中时间的已定义名称.
    - 图 25-7. 包含内部时间中时间的已定义名称.
    - 图 25-8. 包含秒中时间的已定义名称.
- 26 词汇表
- 27 符号

# Progress

| 章节         | 翻译时间   | 校对时间 | 完成度 | 备注 |
| ------------ | ---------- | -------- | ------ | ---- |
| 介绍         | 2019-08-24 | -        | 80     |      |
| 语法         | 2019-08-27 |          | 100    |      |
| 求值和编译   | 2019-09-02 |          | 80     |      |
| 类型和类     | 2019-09-10 |          | 80     |      |
| 数据和控制流 | 2019-09-16 |          | 80     |      |
| 迭代         | 2019-09-29 |          | 80     |      |
| 对象         | 2019-09-16 |          | 80     |      |
| 结构         | -          | -        | -      |      |
| 状况         | 2019-09-21 |          | 80     |      |
| 符号         | 2019-08-29 |          | 100    |      |
| 包           | 2019-09-06 |          | 100    |      |
| 数值         | 2019-09-24 |          | 80     |      |
| 字符         | 2019-09-27 |          | 80     |      |
| Cons         | 2019-09-10 |          | 100    |      |
| 数组         | 2019-09-27 |          | 80     |      |
| 字符串       | 2019-09-27 |          | 100    |      |
| 序列         | 2019-09-27 |          | 80     |      |
| 哈希表       | 2019-09-27 |          | 80     |      |
| 文件名       | 2019-09-28 |          | 80     |      |
| 文件         | 2019-09-29 |          | 80     |      |
| 流           | 2019-09-29 |          | 80     |      |
| 打印器       | 2019-10-05 |          | 80     |      |
| 读取器       | 2019-10-08 |          | 80     |      |
| 系统构造     | 2019-09-29 |          | 80     |      |
| 环境         | 2019-09-29 |          | 80     |      |
| 词汇表       | -          |          | 0      |      |
| 978个符号    | 2019-10-08 |          |        |      |
| 图片索引     | -          | -        | -      |      |

# See Also
* [clhs (thin ASDF wrapper)](https://www.hexstreamsoft.com/libraries/clhs/): This library wraps the CLHS, a proprietary component!