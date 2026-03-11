# The Scheme Programming Language

> [!warning] "记录范围"
> 
> 这里只记录概念型内容, 有关syntax和procedure的定义和语义见[Chez Scheme Cheatsheet](../chez/Chez%20Scheme%20Cheatsheet.md).

# Terminology
- syntactic form: 句法形式

- form
- syntactic extension
- library define and usage: 不同版本如何共存
- how to view the code of standard libraries
- 怎么判断比较对象: 等价性等 - The equivalence test for memq is eq?, for memv is eqv?, and for member is equal?.
- continuation
- continuation passing style


# 1 Introduction

标识符(identifier): 字母、数字、特殊字符(`?!.+-*/<=>:$%^&_~@`)和 Unicode 字符; **大小写敏感**.

带结构的形式(form)和列表(list)常量用括号`()`包裹, `[]`可以用在`()`可以出现的地方.

向量(vector)用`#()`包裹, 字节向量(bytevector)用`#vu8()`包裹.

字符串用`""`包裹, 字符以`#\`开始.

数字例:

- 整数: `-123`
- 分数: `1/2`
- 浮点数: `1.3`
- 科学记数法: `1e23`
- 复数: `1.3-2.7i`, `-1.2@73`.

布尔值: `#t`, `#f`.

注释:

- 行注释: `;`
- 过程(procedure)注释: `;;;`
- 块(block)注释: `#|`, `#|`
- 数据项(datum)注释: `#;`.

不可打印的表示: `#<procedure>`, `#<port>`.

命名约定:

- 谓词(predicate)以`?`结尾, 例: `eq?`, `zero?`, `string=?`;
- 类型谓词(type predicate)用类型加上`?`表示, 例: `pair?`;
- 字符、字符串和向量的过程(procedure)分别以`char-`、`string-`、`vector-`开始;
- 转换对象类型的过程用`type1->type2`表示, 例: `vector->list`;
- 产生副作用的过程和句法形式(syntactic form)的名称以`!`结尾, 例: `set!`, `vector-set!`.

记法约定:

- `unspecified`: 只用于产生副作用的标准过程或句法形式的返回值是未描述的;
- `syntax violation`: 描述程序是形式错误的(malformed), 在句法形式的结构不匹配它的原型(prototype)时发生;
- `...`用于表示子表达式(subexpression)或参数(argument)的零次或多次出现. 例: `(or expr ...)`描述句法形式`or`, 它有 0 个或多个子表达式.


# 2 Getting Started

> [!tip] "TLDR"
> 
> REPL
> 
> simple expressions
> 
> evaluating Scheme expressions
> 
> variables and `let` expressions: `(let ((var expr) ...) body1 body2 ...)`
> 
> lambda expressions: `(lambda (var ...) body1 body2 ...)`
> 
> top-level definitions:
> 
> - `(define var expr)`
> - the defun syntax for `define`
> 
> conditional expressions:
> 
> - `(if test consequent alternative)`
> - `(or expr ...)`, `(and expr ...)`, `(not expr)`
> - predicates: `null?`, `eqv?`, `pair?`
> - `(cond (test expr) ... (else expr))`
> 
> simple recursion:
> 
> - `(trace name)`
> 
> assignment:
> 
> - `set!`
> - stack
> - queue

## 2.1 Interacting with Scheme

> [!example] "REPL: read-evalute-print loop"
>
> ``` scheme
> > "Hi Mom!"
> "Hi Mom!"
> > "hello"
> "hello"
> > 42
> 42
> > 22/7
> 22/7
> > 3.141592653
> 3.141592653
> > +
> #<procedure +>
> > (+ 76 31)
> 107
> > (* -12 10)
> -120
> > '(a b c d)
> (a b c d)
>
> > (car '(a b c))
> a
> > (cdr '(a b c))
> (b c)
> > (cons 'a '(b c))
> (a b c)
> > (cons (car '(a b c))
>     (cdr '(d e f)))
> (a e f)
> ```

`define`建立变量绑定, `lambda`创建过程:
> [!example] "define, lambda"
>
> ``` scheme
> > (define square
>     (lambda (n)
>       (* n n)))
> > (square 5)
> 25
> > (square -200)
> 40000
> > (square 0.5)
> 0.25
> > (square 1/2)
> 1/4
> ```

加载文件:
> [!quote] inline end
> square.ss
```scheme
(load "square.ss")
```

## 2.2 Simple Expressions

数值:

> [!example] "数值"
>
> ``` scheme
> > 123456789987654321  ; exact integer numbers
> 123456789987654321
> > 3/4                 ; rational numbers
> 3/4
> > 2.718281828         ; ineact numbers
> 2.718281828
> > 2.2+1.1i            ; complex numbers
> 2.2+1.1i
> ```

过程应用(procedure application): `(procedure arg ...)`.

> [!example] "过程应用"
>
> ``` scheme
> > (+ 1/2 1/2)
> 1
> > (- 1.5 1/2)
> 1.0
> > (* 3 1/2)
> 3/2
> > (/ 1.5 3/4)
> 2.0
>
> ; nested procedure applications
> > (+ (+ 2 2) (+ 2 2))
> 8
> > (- 2 (* 4 1/3))
> 2/3
> > (* 2 (* 2 (* 2 (* 2 2))))
> 32
> > (/ (* 6/7 7/2) (- 4.5 1.5))
> 1.0
> ```

对象的列表: `(obj1 obj2 ...)`.

`quote`: 显式的告知 Scheme 将列表视为数据而不是过程应用.

> [!example] "quote"
>
> ``` scheme
> ; different between procedure applications and lists
> > (1 2 3 4 5)
> Exception: attempt to apply non-procedure 1
> Type (debug) to enter the debugger.
>
> > (quote (1 2 3 4 5))
> (1 2 3 4 5)
> > (quote ("this" "is" "a" "list"))
> ("this" "is" "a" "list")
> > (quote (+ 3 4))
> (+ 3 4)
>
> ; ': a single quotation mark
> > '(1 2 3 4)
> (1 2 3 4)
> > '((1 2) (3 4))
> ((1 2) (3 4))
> > '(/ (* 2 -1) 3)
> (/ (* 2 -1) 3)
>
> ; numbers and strings may be quoted
> > '2
> 2
> > '2/3
> 2/3
> > (quote "Hi Mom!")
> "Hi Mom!"
> ```

列表操作:

> [!example] "car, cdr"
>
> ``` scheme
> ; car, cdr
> > (car '(a b c))
> a
> > (cdr '(a b c))
> (b c)
> > (cdr '(a))
> ()
> > (car (cdr '(a b c)))
> b
> > (cdr (cdr '(a b c)))
> (c)
> > (car '((a b) (c d)))
> (a b)
> > (cdr '((a b) (c d)))
> ((c d))
> ```

> [!example] "cons"
>
> ``` scheme
> ; cons
> > (cons 'a '())
> (a)
> > (cons 'a '(b c))
> (a b c)
> > (cons 'a (cons 'b (cons 'c '())))
> (a b c)
> > (cons '(a b) '(c d))
> ((a b) c d)
>
> > (car (cons 'a '(b c)))
> a
> > (cdr (cons 'a '(b c)))
> (b c)
> > (cons (car '(a b c)) (cdr '(d e f)))
> (a e f)
> > (cons (car '(a b c)) (cdr '(a b c)))
> (a b c)
> ```

列表是 pair 的序列, 每个 pair 的 cdr 是序列中下一个 pair:

```
+---+---+   +---+---+   +---+---+   +---+---+
| a | --|-->| b | --|-->| c | --|-->| d | ()|
+---+---+   +---+---+   +---+---+   +---+---+
```

合式列表(proper list): 列表的最后一个对的`cdr`是空列表;

非合式列表(improper list): 以点对(dotted-pair)记法打印.

> [!example] "点对记法"
>
> ``` scheme
> ; improper lists
> > (cons 'a 'b)
> (a . b)
> > (cdr '(a . b))
> b
> > (cons 'a '(b . c))
> (a b . c)
>
> ; 使用点对记法打印合式列表
> > '(a . (b . (c . ())))
> (a b c)
> ```

`list`过程创建列表:

> [!example] "list"
>
> ``` scheme
> > (list 'a 'b 'c)
> (a b c)
> > (list 'a)
> (a)
> > (list)
> ()
> ```

## 2.3 Evaluating Scheme Expressions

```
(procedure arg1 ... argn)
```

- Scheme 求值起可以按任意顺序求值这些表达式: `procedure`, `argi`;
- `procedure`的求值方式与`argi`相同.

核心句法形式(core syntactic form): 常量对象, 过程应用, `quote`表达式等;<br/>
句法扩展(syntactic extension): 用核心句法形式定义的句法形式.

过程应用的求值注意项

- Scheme 求值器可以自由的按任意顺序求值表达式: 从左至右, 从右至左, 或其他顺序.
- `procedure`以与`arg1 ... argn`相同的方式求值, 例: `((car (list + - * /)) 2 3)`.

## 2.4 Variables and Let Expressions

`let`表达式:

```scheme
; (var expr): 变量-表达式对
(let ((var expr) ...) body1 body2 ...)

; 使用[]来分隔绑定
```

> [!tip] "在`let`中使用`[]`来分隔绑定"
>
> ``` scheme
> (let [(var expr) ...] body1 body2 ...)
>
> > (let ((x 2) (y 3))
>     (+ x y))
> 5
> > (let ([x 2] [y 3])
>     (+ x y))
> 5
> ```

- `let`绑定的变量比在`let`的体中可见;
- 嵌套的`let`表达式: 在内部`let`表达式中绑定了与外部`let`相同的变量, 内部`let`的体中只可见内部`let`创建的绑定;
- 内部的绑定遮盖(shadow)了外部的绑定;
- 作用域(scope): 变量绑定可见的区域;
- 词法作用域(lexical scoping): 每个绑定的作用域可以通过直接文本分析程序获得.

> [!example] "nested let expressions"
>
> ``` scheme
> ; nested let expressions
> > (let ([x 1])
>     (let ([x (+ x 1)])
>       (+ x x)))
> 4
>
> > (let ([x 1])
>     (let ([new-x (+ x 1)])
>       (+ new-x new-x)))
> 4
> ```

## 2.5 Lambda Expressions

`lambda`表达式: 创建新的过程

```scheme
(lambda (var ...) body1 body2 ...)

> (lambda (x) (+ x x))
<procedure>

; 应用`lambda`表达式
> ((lambda (x) (+ x x)) (* 3 4))
24
```

> [!example] "`lambda`表达式是对象(过程是对象)"
>
> ``` scheme
> > (let ([double (lambda (x) (+ x x))])
>     (list (double (* 3 4))
>       (double (/ 99 11))
>       (double (- 2 7))))
> (24 18 -10)
> ```

在`lambda`表达式中未定义的变量, 在结果过程被实际应用之前, 不应该导致异常:

```scheme
> (define proc1 (lambda (x y) (proc2 y x)))
> (define proc2 cons)
> (proc1 'a 'b)
(b . a)
```

`x`在`lambda`表达式中自由出现, 是自由变量(free variable); `y`不是:

```scheme
(let ([x 'a])
  (let ([f (lambda (y) (list x y))])
> (f 'b)))
```

> [!tip] "`let`表达式是`lambda`和过程应用定义的句法扩展"
>
> ``` scheme
> (let ((var expr) ...) body1 body2 ...)
> ((lambda (var ...) body1 boyd2 ...)
>   expr ...)
> ```

`lambda`表达式中`(var ...)`不一定是合式列表, 可以是:

> [!quote] inline end
>
> ex-lambda.ss

- 变量的合式列表`(var1 ... varn)`: 必须提供 n 个实际参数.
- 单个变量`varr`: 任意数量的实际参数, 所有实际参数放置在一个列表中, 该列表绑定到`varr`.
- 变量的非合式列表`(var1 ... varn . varr)`: 至少提供 n 个实际参数, 变量`varr`绑定到包含剩余实际参数的列表.

## 2.6 Top-Level Definitions

`define`创建顶级定义(top-level definition):

```scheme
(define var expr)
```

> [!example] "定义过程, 定义对象"
>
> ``` scheme
> ; 定义过程
> (define double-any
>   (lambda (f x)
>     (f x x)))
>
> ; 定义对象
> (define sandwich "peanut-butter-and-jelly")
> ```

> [!tip] "`define`的 defun 语法"
>
> 当`expr`是一个`lambda`表达式时
>
> ``` scheme
> (define var0 (lambda (var1 ... varn) e1 e2 ...))
> (define (var0 var1 ... varn) e1 e2 ...)
>
> (define var0 (lambda varr) e1 e2 ...)
> (define (var0 . varr) e1 e2 ...)
>
> (define var0 (lambda var1 ... varn . varr) e1 e2 ...)
> (define (var0 var1 ... varn . varr) e1 e2 ...)
> ```

## 2.7 Conditional Expressions

```scheme
(if test consequent alternative)
(if test consequent)

(and expr ...)
(or expr ...)
(not obj)

(cond clause1 clause2 ...)
; clause
(test)
(test expr1 expr2 ...)
(test => expr)
(else expr1 expr2 ...)                  ; else clause
```

> [!tip] "真假值"
>
> 只有`#f`视为假, 其他对象均视为真.

> [!tip] "`and` `or` `not`表达式求值"
>
> - `and`: 按序对expr求值, 有一个expr求值为假时结果为`#f`; 耗尽expr时结果为最后一个表达式的值.
>
> - `or`: 按序对expr求值, 有一个expr求值为真时结果为该expr的值; 耗尽expr时结果为`#f`.
>
> - `not`: 真假值取反.

谓词(predicates): `=`, `<`, `>`, `<=`, `>=`, `null?`, `eqv?`等.

类型谓词(type predicates): `pair?`, `symbol?`, `number?`, `string?`等.

> [!example] "cond"
>
> ``` scheme
> (define sign
>   (lambda (n)
>     (cond
>       [(< n 0) -1]
>       [(> n 0) +1]
>       [else 0])))
> ```

## 2.8 Simple Recursion

递归过程(recursive procedure): 应用自身的过程.
两个基本元素: base case, recursion step.

> [!example] "length"
>
> ``` scheme
> (define length
>     (lambda (lst)
>         (if (null? lst)
>             0
>             (+ (length (cdr lst)) 1))))
> ```
>
> Trace:
>
> ``` scheme
> (trace length)
>
> |(length (a b c d))
> | (length (b c d))
> | |(length (c d))
> | | (length (d))
> | | |(length ())
> | | |0
> | | 1
> | |2
> | 3
> |4
> 4
> ```

> [!quote] inline end
>
> traces.ss

迭代构造(iteration construct)用递归表示: list, pair. <br/>
特殊的迭代形式: `map`

```scheme
(define abs
> (lambda (x)
>     (if (< x 0)
>         (- 0 x)
>         x)))

(map abs '(1 -2 3 -4 5 -6)) ; (1 2 3 4 5 6)
```

## 2.9 Assignment

赋值(assignment)并不像使用`let`和`lambda`创建新的绑定(binding), 而是使用`set!`修改既有绑定的值.

> [!example] "set!"
>
> ``` scheme
> > (define abcde '(a b c d e))
> > abcde
> (a b c d e)
> > (set! abcde (cdr abcde))
> > abcde
> (b c d e)
> > (let ([abcde '(a b c d e)])
>     (set! abcde (reverse abcde))
>     abcde)
> (e d c b a)
> ```

所有局部变量在绑定时立即赋予一个值.

> [!quote] inline end
>
> stack.ss

赋值通常用于实现一些必须维护内部状态的过程.

> [!example] "使用赋值和不实用赋值的风格比较"
>
> 例: root of ax^2 + bx + c = 0
>
> 使用赋值:
>
> ``` scheme
> (define quadratic-formula
>     (lambda (a b c)
>         (let ([root1 0] [root2 0] [minusb 0] [radical 0] [divisor 0])
>             (set! minusb (- 0 b))
>             (set! radical (sqrt (- (* b b) (* 4 (* a c)))))
>             (set! divisor (* 2 a))
>             (set! root1 (/ (+ minusb radical) divisor))
>             (set! root2 (/ (- minusb radical) divisor))
>             (cons root1 root2))))
> ```
>
> 不使用赋值:
>
> ``` scheme
> (define quadratic-formula2
>     (lambda (a b c)
>         (let ([minusb (- 0 b)]
>             [radical (sqrt (- (* b b) (* 4 (* a c))))]
>             [divisor (* 2 a)])
>             (let ([root1 (/ (+ minusb radical) divisor)]
>                 [root2 (/ (- minusb radical) divisor)])
>                 (cons root1 root2)))))
> ```

设置 pair 的 car 和 cdr: `set-car!`, `set-cdr!`.

> [!quote] inline end
> queue.ss


# 3 Going Further

> [!tip] "TLDR"
>
>    syntactic extension
>
>    more recursion
>
>    continuation
>
>    continuation passing style
>
>    internal definitions
>
>    libraries

## 3.1 Syntactic Extension

见 **8 Syntactic Extension**.

## 3.2 More Recursion

尾递归(tail recursion): 一个过程尾调用(tail-call)自身, 或者通过一系列尾调用间接调用自身.

在`lambda`表达式中一个调用在尾部位置(in tail position): 调用的结果值作为`lambda`表达式的返回值返回.

> [!example] "factorial: 递归与迭代"
>
> recursive version:
>
> ``` scheme
> ; recursive version
> (define factorial
>   (lambda (n)
>     (let fact ([i n])
>       (if (= i 0)
>           1
>           (* i (fact (- i 1)))))))
>
> ; trace
> |(fact 10)
> | (fact 9)
> | |(fact 8)
> | | (fact 7)
> | | |(fact 6)
> | | | (fact 5)
> | | | |(fact 4)
> | | | | (fact 3)
> | | | | |(fact 2)
> | | | | | (fact 1)
> | | | |[10](fact 0)
> | | | |[10]1
> | | | | | 1
> | | | | |2
> | | | | 6
> | | | |24
> | | | 120
> | | |720
> | | 5040
> | |40320
> | 362880
> |3628800
> ```
>
> iterative version:
>
> ``` scheme
> ; iterative version
> (define factorial
>   (lambda (n)
>     (let fact
>       ([i n]  ; iter
>       [a 1])  ; acc
>       (if (= i 0)
>           a
>           (fact (- i 1) (* a i))))))
>
> ; trace
> |(fact 10 1)
> |(fact 9 10)
> |(fact 8 90)
> |(fact 7 720)
> |(fact 6 5040)
> |(fact 5 30240)
> |(fact 4 151200)
> |(fact 3 604800)
> |(fact 2 1814400)
> |(fact 1 3628800)
> |(fact 0 3628800)
> |3628800
> ```

## 3.3 Continuations

求值表达式时需要关注的事情:

- 求值什么(what to evaluate);
- 使用这个值做什么(what to do with the value): 称为计算的延续(the **continuation** of a computation).

在表达式求值的过程中任意点, 存在continuation准备好完成(complete), 或者至少可以继续(continue)从该点开始的计算.

Scheme支持使用过程`call/cc`捕获任意表达式的continuation:

> 参数, 返回值.

- `call/cc`的参数是一个接受单个参数过程`p`;
- `call/cc`构造出当前continuation的具体表示, 并传递给`p`; 这个continuation本身被表示为过程`k`;
- 每次`k`应用到一个值上时, 返回该值到`call/cc`应用的continuation; 这个值成为`call/cc`应用的值;
- 如果`p`在没有调用`k`的情况下返回, 其返回的值成为`call/cc`应用的值.

使用`call/cc`实现断点(breakpoint): 每个遇到断点, 保存该断点的continuation, 从而计算可以(多次的)从断点重新开始计算.

continuation也可用于实现多种形式的多任务(multitasking).

例: `continuations.ss`.

## 3.4 Continuation Passing Style

通常, 每个过程调用都会关联一个continuation:

- 非尾部调用: 被调用过程接受一个隐式的continuation, 该continuation负责完成调用过程体和返回到调用过程的 continutation.
- 尾部调用: 被调用的过程接受调用过程的continuation.

传递continuation风格(CPS): 将过程调用中的隐式continuation以参数形式表示.

例: `cps.ss`.

## 3.5 Internal Definitions

内部定义: 定义可以出现在`lambda`、`let`或`letrec`的体中, 创建的绑定的作用域在出现的体中.

使用内部定义创建的绑定可以是互递归的(mutually recursive).


## 3.6 Libraries

见 [[#5.10 Libraries and Top-Level Programs]]

# 4 Procedures and Variable Bindings

> [!tip] "TLDR"
>
>   variable
>
>   lambda:
>   - `(lambda formals body1 body2 ...)`
>
>   case-lambda:
>   - `(case-lambda clause ...)`
>
>   local binding:
>   - `(let ((var expr) ...) body1 body2 ...)`
>   - `(let* ((var expr) ...) body1 body2 ...)`
>   - `(letrec ((var expr) ...) body1 body2 ...)`
>   - `(letrec* ((var expr) ...) body1 body2 ...)`
>
>   multiple values:
>   - `(let-values ((formals expr) ...) body1 body2 ...)`
>   - `(let*-values ((formals expr) ...) body1 body2 ...)`
>
>   variable definitions:
>   - `(define var expr)`
>   - `(define var)`
>   - `(define (var0 var1 ...) body1 body2 ...)`
>   - `(define (var0 . varr) body1 body2 ...)`
>   - `(define (var0 var1 var2 ... . varr) body1 body2 ...)`
>
>   assignment:
>   - `(set! var expr)`

# 5 Control Operations

> [!tip] "TLDR"
>
>   procedure application:
>
>   - `(expr0 expr1 ...)`
>   - `(apply procedure obj ... list)`
>
>   sequencing: `(begin expr1 expr2 ...)`
>
>   conditionals:
>
>   - `(if test consequent alternative)`
>   - `(if test consequent)`
>   - `(not obj)`
>   - `(and expr ...)`
>   - `(or expr ...)`
>   - `(cond clause1 clause2 ...)`
>
>   ``` scheme
>   ;;; clause
>   (test)
>   (test expr1 expr2 ...)
>   (test => expr)
>   (else expr1 expr2 ...)
>   ```
>
>   - `else`, `=>`
>   - `(when test-expr expr1 expr2 ...)`
>   - `(unless test-expr expr1 expr2 ...)`
>   - `(case expr0 clause1 clause2 ...)`
>
>   ``` scheme
>   ;;; clause
>   ((key ...) expr1 expr2 ...)
>   (else expr1 expr2 ...)
>   ```
>
>   recursion and iteration:
>
>   - `(let name ((var expr) ...) body1 body2 ...)`
>   - `(do ((var init update) ...) (test result ...) expr ...)`
>
>   mapping and folding:
>
>   - `(map procedure list1 list2 ...)`
>   - `(for-each procedure list1 list2 ...)`
>   - `(exists procedure list1 list2 ...)`
>   - `(for-all procedure list1 list2 ...)`
>   - `(fold-left procedure obj list1 list2 ...)`
>   - `(fold-right procedure obj list1 list2 ...)`
>   - `(vector-map procedure vector1 vector2 ...)`
>   - `(vector-for-each procedure vector1 vector2 ...)`
>   - `(string-for-each procedure string1 string2 ...)`
>
>   continuations:
>
>   - `(call/cc procedure)`, `(call-with-current-continuation procedure)`
>   - `(dynamic-wind in body out)`
>
>   delayed evaluation:
>
>   - `(delay expr)`
>   - `(force promise)`
>
>   multiple values:
>
>   - `(values obj ...)`
>   - `(call-with-values producer consumer)`
>
>   eval:
>
>   - `(eval obj environment)`
>   - `(environment import-spec ...)`
>   - `(null-environment version)`
>   - `(scheme-report-environment version)`

# 6 Operations on Objects

> [!tip] "TLDR: constants and quotation"
>
>   - `(quote obj)`, `'obj`
>   - `(quasiquote obj ...)`, ``` `obj ```
>   - `(unquote obj ...)`, `,obj`
>   - `(unquote-splicing obj ...)`, `,@obj`

> [!tip] "TLDR: generic equivalence and type predicates"
>
>   - `(eq? obj1 obj2)`
>   - `(eqv? obj1 obj2)`
>   - `(equal? obj1 obj2)`
>   - `(boolean? obj)`
>   - `(null? obj)`, `(pair? obj)`
>   - `(number? obj)`, `(complex? obj)`, `(real? obj)`, `(rational? obj)`, `(integer? obj)`
>   - `(real-valued? obj)`, `(rational-valued? obj)`, `(integer-valued? obj)`
>   - `(char? obj)`
>   - `(string? obj)`
>   - `(vector? obj)`
>   - `(symbol? obj)`
>   - `(procedure? obj)`
>   - `(bytevector? obj)`
>   - `(hashtable? obj)`

> [!tip] "TLDR: list and pairs"
>
>   - `(cons obj1 obj2)`
>   - `(car pair)`
>   - `(cdr pair)`
>   - `(set-car! pair obj)`
>   - `(set-cdr! pair obj)`
>   - `(caar pair)`, `(cadr pair)`, ..., `(cddddr pair)`
>   - `(list obj ...)`
>   - `(cons* obj ... final-obj)`
>   - `(list? obj)`
>   - `(length list)`
>   - `(list-ref list n)`
>   - `(list-tail list n)`
>   - `(append)`, `(append list ... obj)`
>   - `(reverse list)`
>   - `(memq obj list)`, `(memv obj list)`, `(member obj list)`
>   - `(memp procedure list)`
>   - `(remq obj list)`, `(remv obj list)`, `(remove obj list)`
>   - `(remp procedure list)`
>   - `(filter procedure list)`
>   - `(partition procedure list)`
>   - `(find procedure list)`
>   - `(assq obj alist)`, `(assv obj alist)`, `(assoc obj alist)`
>   - `(assp procedure alist)`
>   - `(list-sort predicate list)`

> [!tip] "TLDR: numbers"
>
>   - `(exact? num)`, `(inexact? num)`
>   - `(= num1 num2 num3 ...)`, `(< real1 real2 real3 ...)`, `(> real1 real2 real3 ...)`, `(<= real1 real2 real3 ...)`, `(>= real1 real2 real3 ...)`
>   - `(+ num ...)`
>   - `(- num)`, `(- num1 num2 num3 ...)`
>   - `(* num ...)`
>   - `(/ num)`, `(/ num1 num2 num3 ...)`
>   - `(zero? num)`
>   - `(positive? real)`, `(negative? real)`
>   - `(even? int)`, `(odd? int)`
>   - `(finite? real)`, `(infinite? real)`, `(nan? real)`
>   - `(quotient int1 int2)`, `(remainder int1 int2)`, `(module int1 int2)`
>   - `(div x1 x2)`, `(mod x1 x2)`, `(div-and-mod x1 x2)`
>   - `(div0 x1 x2)`, `(mod0 x1 x2)`, `(div0-and-mod0 x1 x2)`
>   - `(truncate real)`, `(floor real)`, `(ceiling real)`, `(round real)`
>   - `(abs real)`
>   - `(max real1 real2 ...)`, `(min real1 real2 ...)`
>   - `(gcd int ...)`, `(lcm int ...)`
>   - `(expt num1 num2)`, `(exp num)`
>   - `(log num)`, `(log num1 num2)`
>   - `(inexact num)`, `(exact num)`, `(exact->inexact num)`, `(inexact->exact num)`
>   - `(rationalize real1 real2 ...)`
>   - `(numerator rat)`, `(denominator rat)`
>   - `(real-part num)`, `(imag-part num)`
>   - `(make-rectangular real1 real2)`, `(make-polar real1 real2)`, `(angle num)`, `(magnitude num)`
>   - `(sqrt num)`, `(exact-integer-sqrt n)`
>   - `(sin num)`, `(cos num)`, `(tan num)`, `(asin num)`, `(acos num)`, `(atan num)`, `(atan real1 real2)`
>   - `(bitwise-not exint)`, `(bitwise-and exint ...)`, `(bitwise-ior exint ...)`, `(bitwise-xor exint ...)`
>   - `(bitwise-if exint1 exint2 exint3)`
>   - `(bitwise-bit-count exint)`
>   - `(bitwise-length exint)`
>   - `(bitwise-first-bit-set exint)`
>   - `(bitwise-bit-set? exint1 exint2)`
>   - `(bitwise-copy-bit exint1 exint2 exint3)`
>   - `(bitwise-bit-field exint1 exint2 exint3)`
>   - `(bitwise-copy-bit-field exint1 exint2 exint3 exint4)`
>   - `(bitwise-arithmetic-shift-right exint1 exint2)`
>   - `(bitwise-arithmetic-shift-left exint1 exint2)`
>   - `(bitwise-arithmetic-shift exint1 exint2)`
>   - `(bitwise-rotate-bit-field exint1 exint2 exint3 exint4)`
>   - `(bitwise-reverse-bit-field exint1 exint2 exint3)`
>   - `(string->number string)`, `(string->number string radix)`
>   - `(number->string num)`, `(number->string num radix)`, `(number->string num radix precision)`

> [!tip] "TLDR: fixnums"
>
>   - `(fixnum? obj)`
>   - `(least-fixnum)`, `(greatest-fixnum)`, `(fixnum-width)`
>
>   - `fx=?` ...
>
> `(fx=? fx1 fx2 fx3 ...)`
> `(fx<? fx1 fx2 fx3 ...)`
> `(fx>? fx1 fx2 fx3 ...)`
> `(fx<=? fx1 fx2 fx3 ...)`
> `(fx>=? fx1 fx2 fx3 ...)`
>
>   - `(fxzero? fx)`, `(fxpositive? fx)`, `(fxnegative? fx)`
>   - `(fxeven? fx)`, `(fxodd? fx)`
>   - `(fxmin fx1 fx2 ...)`, `(fxmax fx1 fx2 ...)`
>   - `(fx+ fx1 fx2)`
>   - `(fx- fx)`, `(fx- fx1 fx2)`
>   - `(fx* fx1 fx2)`
>   - `(fxdiv fx1 fx2)`, `(fxmod fx1 fx2)`, `(fxdiv-and-mod fx1 fx2)`
>   - `(fxdiv0 fx1 fx2)`, `(fxmod0 fx1 fx2)`, `(fxdiv0-and-mod0 fx1 fx2)`
>   - `(fx+/carry fx1 fx2 fx3)`, `(fx-/carry fx1 fx2 fx3)`, `(fx*/carry fx1 fx2 fx3)`
>   - `(fxnot fx)`, `(fxand fx ...)`, `(fxior fx ...)`, `(fxxor fx ...)`
>   - `(fxif fx1 fx2 fx3)`
>   - `(fxbit-count fx)`
>   - `(fxlength fx)`
>   - `(fxfirst-bit-set fx)`
>   - `(fxbit-set? fx1 fx2)`
>   - `(fxcopy-bit fx1 fx2 fx3)`
>   - `(fxbit-field fx1 fx2 fx3)`
>   - `(fxcopy-bit-field fx1 fx2 fx3 fx4)`
>   - `(fxarithmetic-shift-right fx1 fx2)`, `(fxarithmetic-shift-left fx1 fx2)`
>   - `(fxarithmetic-shift fx1 fx2)`
>   - `(fxrotate-bit-field fx1 fx2 fx3 fx4)`
>   - `(fxreverse-bit-field fx1 fx2 fx3)`

> [!tip] "TLDR: flonums"
>
>   - `(flonum? obj)`
>   - `fl=?` ...
>
>   `(fl=? fl1 fl2 fl3 ...)`
>   `(fl<? fl1 fl2 fl3 ...)`
>   `(fl>? fl1 fl2 fl3 ...)`
>   `(fl<=? fl1 fl2 fl3 ...)`
>   `(fl>=? fl1 fl2 fl3 ...)`
>
>   - `(flzero? fx)`, `(flpositive? fx)`, `(flnegative? fx)`
>   - `(flinteger? fx)`
>   - `(flfinite? fl)`, `(flinfinite? fl)`, `(flnan? fl)`
>   - `(fleven? fl-int)`, `(flodd? fl-int)`
>   - `(flmin fl1 fl2 ...)`, `(flmax fl1 fl2 ...)`
>   - `(fl+ fl ...)`
>   - `(fl- fl)`, `(fl- fl1 fl2 fl3 ...)`
>   - `(fl* fl ...)`
>   - `(fl/ fl)`, `(fl/ fl1 fl2 fl3 ...)`
>   - `(fldiv fl1 fl2)`, `(flmod fl1 fl2)`, `(fldiv-and-mod fl1 fl2)`
>   - `(fldiv0 fl1 fl2)`, `(flmod0 fl1 fl2)`, `(fldiv0-and-mod0 fl1 fl2)`
>   - `(flround fl)`, `(fltruncate fl)`, `(flfloor fl)`, `(flceiling fl)`
>   - `(flnumerator fl)`, `(fldenominator fl)`
>   - `(flabs fl)`
>   - `(flexp fl)`, `(flexpt fl1 fl2)`, `(fllog fl)`, `(fllog fl1 fl2)`
>   - `(flsin fl)`, `(flcos fl)`, `(fltan fl)`, `(flasin fl)`, `(flacos fl)`, `(flatan fl)`, `(flatan fl1 fl2)`
>   - `(flsqrt fl)`
>   - `(fixnum->flonum fx)`, `(real->flonum real)`

> [!tip] "TLDR: characters"
>
>   - `char=?` ...
>
>   `(char=? char1 char2 char3 ...)`
>   `(char<? char1 char2 char3 ...)`
>   `(char>? char1 char2 char3 ...)`
>   `(char<=? char1 char2 char3 ...)`
>   `(char>=? char1 char2 char3 ...)`
>
>   - `char-ci=?` ...
>
>   `(char-ci=? char1 char2 char3 ...)`
>   `(char-ci<? char1 char2 char3 ...)`
>   `(char-ci>? char1 char2 char3 ...)`
>   `(char-ci<=? char1 char2 char3 ...)`
>   `(char-ci>=? char1 char2 char3 ...)`
>
>   - `(char-alphabetic? char)`, `(char-numeric? char)`, `(char-whitespace? char)`
>   - `(char-lower-case? char)`, `(char-upper-case? char)`, `(char-title-case? char)`
>   - `(char-general-category char)`
>   - `(char-uppercase char)`, `(char-downcase char)`, `(char-titlecase char)`, `(char-foldcase char)`
>   - `(char->integer char)`, `(integer->char n)`

> [!tip] "TLDR: strings"
>
>   - `string=?` ...
>
>   `(string=? string1 string2 string3 ...)`
>   `(string<? string1 string2 string3 ...)`
>   `(string>? string1 string2 string3 ...)`
>   `(string<=? string1 string2 string3 ...)`
>   `(string>=? string1 string2 string3 ...)`
>
>   - `string-ci=?` ...
>
>   `(string-ci=? string1 string2 string3 ...)`
>   `(string-ci<? string1 string2 string3 ...)`
>   `(string-ci>? string1 string2 string3 ...)`
>   `(string-ci<=? string1 string2 string3 ...)`
>   `(string-ci>=? string1 string2 string3 ...)`
>
>   - `(string char ...)`
>   - `(make-string n)`, `(make-string n char)`
>   - `(string-length string)`
>   - `(string-ref string n)`
>   - `(string-set! string n char)`
>   - `(string-copy string)`
>   - `(string-append string ...)`
>   - `(substring string start end)`
>   - `(string-fill string char)`
>   - `(string-upcase string)`, `(string-downcase string)`, `(string-foldcase string)`, `(string-title string)`
>   - `(string-normalize-nfd string)`, `(string-normalize-nfkd string)`, `(string-normalize-nfc string)`, `(string-normalize-nfkc string)`
>   - `(string->list string)`, `(list->string list)`

> [!tip] "TLDR: vectors"
>
>   - `(vector obj ...)`
>   - `(make-vector n)`, `(make-vector n obj)`
>   - `(vector-length vector)`
>   - `(vector-ref vector n)`
>   - `(vector-set! vector n obj)`
>   - `(vector-fill! vector obj)`
>   - `(vector->list vector)`, `(list->vector list)`
>   - `(vector-sort predicate vector)`, `(vector-sort! predicate vector)`

> [!tip] "TLDR: bytevectors"
>
>   - `(endianness symbol)`
>   - `(native-endianness)`
>   - `(make-bytevector n)`, `(make-bytevector n fill)`
>   - `(bytevector-length bytevector)`
>   - `(bytevector=? bytevector1, bytevector2)`
>   - `(bytevector-fill! bytevector fill)`
>   - `(bytevector-copy bytevector)`
>   - `(bytevector-copy! src src-start dst dst-start n)`
>   - `(bytevector-u8-ref bytevector n)`
>   - `(bytevector-s8-ref bytevector n)`
>   - `(bytevector-u8-set! bytevector n u8)`
>   - `(bytevector-s8-set! bytevector n s8)`
>   - `(bytevector->u8-list bytevector)`, `(u8-list->bytevector list)`,
>   - `(bytevector-u16-native-ref bytevector n)`, `(bytevector-s16-native-ref bytevector n)`, `(bytevector-u32-native-ref bytevector n)`, `(bytevector-s32-native-ref bytevector n)`, `(bytevector-u64-native-ref bytevector n)`, `(bytevector-s64-native-ref bytevector n)`
>   - `(bytevector-u16-native-set! bytevector n u16)`, `(bytevector-s16-native-set! bytevector n s16)`, `(bytevector-u32-native-set! bytevector n u32)`, `(bytevector-s32-native-set! bytevector n s32)`, `(bytevector-u64-native-set! bytevector n u64)`, `(bytevector-s64-native-set! bytevector n s64)`
>   - `(bytevector-u16-ref bytevector n eness)`, `(bytevector-s16-ref bytevector n eness)`, `(bytevector-u32-ref bytevector n eness)`, `(bytevector-s32-ref bytevector n eness)`, `(bytevector-u64-ref bytevector n eness)`, `(bytevector-s64-ref bytevector n eness)`
>   - `(bytevector-u16-set! bytevector n u16 eness)`, `(bytevector-s16-set! bytevector n s16 eness)`, `(bytevector-u32-set! bytevector n u32 eness)`, `(bytevector-s32-set! bytevector n s32 eness)`, `(bytevector-u64-set! bytevector n u64 eness)`, `(bytevector-s64-set! bytevector n s64 eness)`
>   - `(bytevector-uint-ref bytevector n eness size)`, `(bytevector-sint-ref bytevector n eness size)`
>   - `(bytevector-uint-set! bytevector n uint eness size)`, `(bytevector-sint-set! bytevector n sint eness size)`
>   - `(bytevector->uint-list bytevector eness size)`, `(bytevector->sint-list bytevector eness size)`
>   - `(uint-list->bytevector list eness size)`, `(sint-list->bytevector list eness size)`
>   - `(bytevector-ieee-single-native-ref bytevector n)`, `(bytevector-ieee-double-native-ref bytevector n)`
>   - `(bytevector-ieee-single-native-set! bytevector n x)`, `(bytevector-ieee-double-native-set! bytevector n x)`
>   - `(bytevector-ieee-single-ref bytevector n eness)`, `(bytevector-ieee-double-ref bytevector n eness)`
>   - `(bytevector-ieee-single-set! bytevector n x eness)`, `(bytevector-ieee-double-set! bytevector n x eness)`

> [!tip] "TLDR: symbols"
>
>   - `(symbol=? symbol1 symbol2)`
>   - `(string->symbol string)`, `(symbol->string symbol)`

> [!tip] "TLDR: booleans"
>
>   - `(boolean=? boolean1 boolean2)`

> [!tip] "TLDR: hashtables"
>
>   - `(make-eq-hashtable)`, `(make-eq-hashtable size)`
>   - `(make-eqv-hashtable)`, `(make-eqv-hashtable size)`
>   - `(make-hashtable hash equiv?)`, `(make-hashtable hash equiv? size)`
>   - `(hashtable-mutable? hashtable)`
>   - `(hashtable-hash-function hashtable)`, `(hashtable-equivalence-function hashtable)`
>   - `(equal-hash obj)`, `(string-hash string)`, `(string-ci-hash string)`, `(symbol-hash symbol)`
>   - `(hashtable-set! hashtable key obj)`
>   - `(hashtable-ref hashtable key default)`
>   - `(hashtable-contains hashtable key)`
>   - `(hashtable-update! hashtable key proceure default)`
>   - `(hashtable-delete! hashtable key)`
>   - `(hashtable-size hashtable)`
>   - `(hashtable-copy hashtable)`, `(hashtable-copy hashtable mutable?)`
>   - `(hashtable-clear! hashtable)`, `(hashtable-clear hashtable size)`
>   - `(hashtable-keys hashtable)`
>   - `(hashtable-entries hashtable)`

> [!tip] "TLDR: enumerations"
>
>   - `(define-enumeration name (symbol ...) constructor)`
>   - `(make-enumeration symbol-list)`
>   - `(enum-set-constructor enum-set)`
>   - `(enum-set-universe enum-set)`
>   - `(enum-set->list enum-set)`
>   - `(enum-set-subset? enum-set1 enum-set2)`
>   - `(enum-set=? enum-set1 enum-set2)`
>   - `(enum-set-member? symbol enum-set)`
>   - `(enum-set-union enum-set1 enum-set2)`, `(enum-set-intersection enum-set1 enum-set2)`, `(enum-set-difference enum-set1 enum-set2)`
>   - `(enum-set-complement enum-set)`
>   - `(enum-set-projection enum-set1 enum-set2)`
>   - `(enum-set-indexer enum-set)`


# 7 Input and Output
> [!tip] "TLDR"
>
>   - Transcoders
>   - Opening Files
>   - Standard Ports
>   - String and Bytevector Ports
>   - Opening Custom Ports
>   - Port Operations
>   - Input Operations
>   - Output Operations
>   - Convenience I/O
>   - Filesystem Operations
>   - Bytevector/String Conversions

# 8 Syntactic Extension
> [!tip] "TLDR"
>
>   keyword bindings:
>
>   - `(define-syntax keyword expr)`
>   - `(let-syntax ((keyword expr) ...) form1 form2 ...)`
>   - `(letrec-syntax ((keyword expr) ...) form1 form2 ...)`
>
>   syntax-rules transformers:
>
>   - `(syntax-rules (literal ...) clause)`
>
>   ;;; literal
>   ;;; an identifier other than _ or ...
>   ;;; clause
>   (pattern template)
>
>   - `_`
>   - `...`
>   - `(identifier-syntax tmpl)`
>   - `(identifier-syntax (id1 tmpl1) ((set! id2 e2) tmpl2))`
>
>   syntax-case transformers:
>
>   - `(syntax-case expr (literal ...) caluse)`
>
>   ;;; literal
>   ;;; an identifier
>   ;;; clause
>   (pattern output-expression)
>   (pattern fender output-expression)
>
>   - `(syntax template)`, `#'template`
>   - `(identifier? obj)`
>   - `(free-identifier=? identifier1 identifier2)`
>   - `(bound-identifier=? identifier1 identifier2)`
>   - `(with syntax ((pattern expr) ...) body1 body2 ...)`
>   - `(quasisyntax template ...)`, ``` #`template ```
>   - `(unsyntax template ...)`, `#,template`
>   - `(unsyntax-splicing template ...)`, `#,@template`
>   - `(make-variable-transformer procedure)`
>   - `(syntax->datum obj)`
>   - `(datum->syntax template-identifier obj)`
>   - `(generate-temporaries list)`

# 9 Records
> [!tip] "TLDR"
>
>   defining records:
>
>   - `(define-record-type record-name clause ...)`
>   - `(define-record-type (record-name constructor pred) clause ...)`
>   - `fields`, `mutable`, `immutable`, `parent`, `protocol`, `sealed`, `opaque`, `nongenerative`, `parent-rtd`
>
>   procedural interface:
>
>   - `(make-record-type-descriptor name parent uid s? o? fields)`
>   - `(record-type-descriptor? obj)`
>   - `(make-record-constructor-descriptor rtd parent-rcd protocol)`
>   - `(record-type-descriptor record-name)`
>   - `(record-constructor-descriptor record-name)`
>   - `(record-constructor rcd)`
>   - `(record-predicate rtd)`
>   - `(record-accessor rtd idx)`
>   - `(record-mutator rtd idx)`
>
>   inspection:
>
>   - `(record-type-name rtd)`
>   - `(record-type-parent rtd)`
>   - `(record-type-uid rtd)`
>   - `(record-type-generative? rtd)`
>   - `(record-type-sealed? rtd)`
>   - `(record-type-opaque? rtd)`
>   - `(record-type-field-names rtd)`
>   - `(record-field-mutable? rtd idx)`
>   - `(record? obj)`
>   - `(record-rtd record)`

# 10 Libraries and Top-Level Programs
> [!tip] "TLDR"
>
>   standard libraries: `(rnrs base (6))`
>
>   defining new libraries:
>
>   (library library-name
>     (export export-spec ...)
>     (import import-spec ...)
>     library-body)
>
>   top-level programs:
>
>   (import import-spec ...)
>   definition-or-expressions
>   ...

# 11 Exceptions and Conditions
> [!tip] "TLDR"
>
>   raising and handling expcetions:
>
>   - `(raise obj)`, `(raise-continuable obj)`
>   - `(error who msg irritant ...)`, `(assertion-violation who msg irritant)`
>   - `(assert expression)`
>   - `(syntax-violation who msg form)`, `(syntax-violation who msg form subform)`
>   - `(with-exception-handler procedure thunk)`
>   - `(guard (var clause1 clause2 ...) b1 b2 ...)`
>
>   defining condition types:
>
>   - `&condition`
>   - `(condition? obj)`
>   - `(condition condition1 ...)`
>   - `(simple-conditions condition)`
>   - `(define-condition-type name parent constructor pred field ...)`
>   - `(condition-predicate rtd)`, `(condition-accessor rtd procedure)`
>
>   standard condition types:
>
>   - `&serious`
>   - `&violation`
>   - `&assertion`
>   - `&error`
>   - `&warning`
>   - `&message`
>   - `&irritants`
>   - `&who`
>   - `&implementation-restriction`
>   - `&lexical`
>   - `&syntax`
>   - `&undefined`
>   - `&i/o` ...
>   - `*i/o-read` ...
>   - `*i/o-write` ...
>   - `*i/o-invalid-position` ...
>   - `*i/o-filename` ...
>   - `*i/o-file-protection` ...
>   - `*i/o-file-is-read-only` ...
>   - `*i/o-file-already-exists` ...
>   - `*i/o-file-does-not-exist` ...
>   - `*i/o-port` ...
>   - `*i/o-decoding` ...
>   - `*i/o-encoding` ...
>   - `&no-infinities`
>   - `&no-nans`

# 12 Extended Examples

- matrix.ss: matrix multiplication.
- sort.ss: sorting and merging lists.
- sets.ss: set construction with customed syntax.
- wrfreq.ss: calculate word frequency.
- printer.ss: print Scheme objects.
- formatted-output.ss: formatted output.
- interpreter.ss: a meta-circular interpreter for Scheme.
- oop.ss: define abstract objects.
- Fast Fourier Transform: TODO.
- unification.ss: Unification algorithm.
- engine.ss: multitasking engine.

# 13 Formal Syntax

The formal grammars and accompanying text appearing here describe the written syntax of Scheme data values, or *datums*. The grammars also effectively cover the written syntax of Scheme syntactic forms, since every Scheme syntactic form has a representation as a Scheme datum. In particular, parenthesized syntactic forms are written as lists, and identifiers (e.g., keywords and variables) are written as symbols. The high-level structure of each syntactic form is described in detail by the entries marked "syntax" in Chapters 4 through 11, and the syntactic forms are summarized in the Summary of Forms.

The written representation of a datum involves tokens, whitespace, and comments. *Tokens* are sequences of one or more characters representing atomic datums or serving as punctuation marks. The tokens that represent atomic datums are symbols, numbers, strings, booleans, and characters, while the tokens serving as punctuation marks are open and close parentheses, open and close brackets, the open vector parenthesis `#(`, the open bytevector parenthesis `#vu8(`, the dotted pair marker `.` (dot), the quotation marks `'` and ``` ` ```, the unquotation marks `,` and `,@`, the syntax quotation marks `#'` and ``` #` ```, and the syntax unquotation marks `#,` and `#,@`.

*Whitespace* consists of space, tab, newline, form-feed, carriage-return, and next-line characters along with any additional characters categorized as Zs, Zl, or Zp by the Unicode standard. A newline character is also called a linefeed character. Some whitespace characters or character sequences serve as *line endings*, which are recognized as part of the syntax of line comments and strings. A line ending is a newline character, a next-line character, a line-separator character, a carriage-return character followed by a newline character, a carriage return followed by a next-line character, or a carriage return not followed by a newline or next-line character. A different set of whitspace characters serve as *intraline whitespace*, which are recognized as part of the syntax of strings. Intraline whitespace includes spaces, tabs, and any additional Unicode characters whose general category is Zs. The sets of intraline whitespace characters and line endings are disjoint, and there are other whitespace characters, such as form feed, that are not in either set.

*Comments* come in three flavors: line comments, block comments, and datum comments. A line comment consists of a semicolon ( `;` ) followed by any number of characters up to the next line ending or end of input. A block comment consists of a `#|` prefix, any number of characters and nested block comments, and a `|#` suffix. A datum comment consists of a `#;` prefix followed by any datum.

Symbols, numbers, characters, booleans, and the dotted pair marker ( `.` ) must be delimited by the end the input, whitespace, the start of a comment, an open or close parenthesis, an open or close bracket, a string quote ( `"` ), or a hash mark ( `#` ). Any token may be preceded or followed by any number of whitespace characters and comments.

Case is significant in the syntax of characters, strings, and symbols except within a hex scalar value, where the hexadecimal digits "a" through "f" may be written in either upper or lower case. (Hex scalar values are hexadecimal numbers denoting Unicode scalar values.) Case is insignificant in the syntax of booleans and numbers. For example, `Hello` is distinct from `hello`, `#\A` is distinct from `#\a`, and `"String"` is distinct from `"string"`, while `#T` is equivalent to `#t`, `#E1E3` is equivalent to `#e1e3`, `#X2aBc` is equivalent to `#x2abc`, and `#\x3BA` is equivalent to `#\x3ba`.

A conforming implementation of the Revised6 Report is not permitted to extend the syntax of datums, with one exception: it is permitted to recognize any token starting with the prefix `#!` as a flag indicating certain extensions are valid in the text following the flag. So, for example, an implementation might recognize the flag `#!braces` and switch to a mode in which lists may be enclosed in braces as well as in parentheses and brackets.

```scheme
#!braces '{a b c} ;=> (a b c)
```

The flag `#!r6rs` may be used to declare that the subsequent text is written in R6RS syntax. It is good practice to include `#!r6rs` at the start of any file containing a portable library or top-level program to specify that R6RS syntax is being used, in the event that future reports extend the syntax in ways that are incompatible with the text of the library or program. `#!r6rs` is otherwise treated as a comment.

In the grammars appearing below, `<empty>` stands for an empty sequence of characters. An item followed by an asterisk ( `*` ) represents zero or more occurrences of the item, and an item followed by a raised plus sign ( `+` ) represents one or more occurrences. Spacing between items within a production appears for readability only and should be treated as if it were not present.

**Datums**.  A datum is a boolean, character, symbol, string, number, list, vector, or bytevector.

```
<datum>            -->	<boolean>
                    |	<character>
                    |	<symbol>
                    |	<string>
                    |	<number>
                    |	<list>
                    |	<vector>
                    |	<bytevector>
```

Lists, vectors, and bytevectors are compound datums formed from groups of tokens possibly separated by whitespace and comments. The others are single tokens.

**Booleans**.  Boolean false is written #f. While all other values count as true, the canonical true value (and only other value to be considered a boolean value by the boolean? predicate) is written #t.

```
<boolean>          -->	#t | #f
```

Case is not significant in the syntax of booleans, so these may also be written as #T and #F.

**Characters**.  A character object is written as the prefix #\ followed by a single character, a character name, or a sequence of characters specifying a Unicode scalar value.

```
<character>        -->	#\ <any character> | #\ <character name> | #\x <hex scalar value>
<character name>   -->	alarm | backspace | delete | esc | linefeed
                    |	newline | page | return | space | tab | vtab
<hex scalar value> -->	<digit 16>+
```

The named characters correspond to the Unicode characters alarm (Unicode scalar value 7, i.e., U+0007), backspace (U+0008), delete (U+007F), esc (U+001B), linefeed (U+000A; same as newline), newline (U+000A), page (U+000C), return (U+000D), space (U+0020), tab (U+0009) and vertical tab (U+000B).

A hex scalar value represents a Unicode scalar value n, $0 \le n \le D800_{16}$ or $E000_{16} \le n \le 10FFF_{16}$. The `<digit 16>` nonterminal is defined under **Numbers** below.

A `#\` prefix followed by a character name is always interpreted as a named character, e.g., `#\page` is treated as `#\page` rather than `#\p` followed by the symbol `age`. Characters must also be delimited, as described above, so that `#\pager` is treated as a syntax error rather than as the character `#\p` followed by the symbol `ager` or the character `#\page` followed by the symbol `r`.

Case is significant in the syntax of character objects, except within a hex scalar value.

**Strings**.  A string is written as a sequence of string elements enclosed in string quotes (double quotes). Any character other than a string quote or backslash can appear as a string element. A string element can also consist of a backslash followed by a single character, a backslash followed by sequence of characters specifying a Unicode scalar value, or a backslash followed by sequence of intraline whitespace characters that includes a single line ending.

```
<string>           -->	" <string character>* "
<string element>   -->	<any character except " or \>
                    |	\" | \\ | \a | \b | \f | \n | \r | \t | \v
                    |	\x <hex scalar value> ;
                    |	\ <intraline whitespace>* <line ending> <intraline whitespace>*
```

A string element consisting of a single character represents that character, except that any single character or pair of characters representing a line ending represents a single newline character. A backslash followed by a double quote represents a double quote, while a backslash followed by a backslash represents a backslash. A backslash followed by `a` represents the alarm character (U+0007); by `b`, backspace (U+0008); by `f`, form feed (U+000C); by `n`, newline (U+000A); by `r`, carriage return (U+000D); by `t`, tab (U+0009); and by `v`, vertical tab (U+000B). A backslash followed by `x`, a hex scalar value, and a semi-colon ( `;` ) represents the Unicode character specified by the scalar value. The `<hex scalar value>` nonterminal is defined under **Characters** above. Finally, a sequence of characters consisting of a backslash followed by intraline whitespace that includes a single line ending represents no characters.

Case is significant in the syntax of strings, except within a hex scalar value.

**Symbols**.  A symbol is written either as an "initial" character followed by a sequence of "subsequent" characters or as a "peculiar symbol." Initial characters are letters, certain special characters, an additional set of Unicode characters, or arbitrary characters specified by Unicode scalar values. Subsequent characters are initial characters, digits, certain additional special characters, and a set of additional Unicode characters. The peculiar symbols are `+`, `-`, ..., and any sequence of subsequent characters prefixed by `->`.

```
<symbol>           -->	<initial> <subsequent>*
<initial>          -->	<letter> | ! | $ | % | & | * | / | : | < | = | > | ? | ~ | _ | ^
                    |	<Unicode Lu, Ll, Lt, Lm, Lo, Mn, Nl, No, Pd, Pc, Po, Sc, Sm, Sk, So, or Co>
                    |	\x <hex scalar value> ;
<subsequent>       -->	<initial> | <digit 10> | . | + | - | @ | <Unicode Nd, Mc, or Me>
<letter>           -->	a | b | ... | z | A | B | ... | Z
```

`<Unicode Lu, Ll, Lt, Lm, Lo, Mn, Nl, No, Pd, Pc, Po, Sc, Sm, Sk, So, or Co>` represents any character whose Unicode scalar value is greater than 127 and whose Unicode category is one of the listed categories. <Unicode Nd, Mc, or Me> represents any character whose Unicode category is one of the listed categories. The `<hex scalar value>` nonterminal is defined under **Characters** above, and `<digit 10>` is defined under **Numbers** below.

Case is significant in symbols.

**Numbers**.  Numbers can appear in one of four radices: 2, 8, 10, and 16, with 10 the default. Several of the productions below are parameterized by the radix, `r`, and each represents four productions, one for each of the four possible radices. Numbers that contain radix points or exponents are constrained to appear in radix 10, so `<decimal r>` is valid only when `r` is 10.

```
<number>           -->	<num 2> | <num 8> | <num 10> | <num 16>
<num r>            -->	<prefix r> <complex r>
<prefix r>         -->	<radix r> <exactness> | <exactness> <radix r>
<radix 2>          -->	#b
<radix 8>          -->	#o
<radix 10>         -->	<empty> | #d
<radix 16>         -->	#x
<exactness>        -->	<empty> | #i | #e
<complex r>        -->	<real r> | <real r> @ <real r>
                    |	<real r> + <imag r> | <real r> - <imag r>
                    |	+ <imag r> | - <imag r>
<real r>           -->	<sign> <ureal r> | +nan.0 | -nan.0 | +inf.0 | -inf.0
<imag r>           -->	i | <ureal r> i | inf.0 i | nan.0 i
<ureal r>          -->	<uinteger r> | <uinteger r> / <uinteger r> | <decimal r> <suffix>
<uinteger r>       -->	<digit r>+
<decimal 10>       -->	<uinteger 10> <suffix>
                    |	. <digit 10>+ <suffix>
                    |	<digit 10>+ . <digit 10>* <suffix>
<suffix>           -->	<exponent> <mantissa width>
<exponent>         -->	<empty> | <exponent marker> <sign> <digit 10>+
<exponent marker>  -->	e | s | f | d | l
<mantissa width>   -->	<empty> | | <digit 10>+
<sign>             -->	<empty> | + | -
<digit 2>          -->	0 | 1
<digit 8>          -->	0 | 1 | 2 | 3 | 4 | 5 | 6 | 7
<digit 10>         -->	0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
<digit 16>         -->	<digit 10> | a | b | c | d | e | f
```

A number written as above is inexact if it is prefixed by `#i` or if it is not prefixed by `#e` and contains a decimal point, nonempty exponent, or nonempty mantissa width. Otherwise, it is exact.

Case is not significant in the syntax of numbers.

**Lists**.  Lists are compound datums formed from groups of tokens and possibly involving other datums, including other lists. Lists are written as a sequence of datums within parentheses or brackets; as a nonempty sequence of datums, dotted-pair marker ( `.` ), and single datum enclosed within parentheses or brackets; or as an abbreviation.

```
<list>	           -->	(<datum>*) | [<datum>*]
                    |	(<datum>+ . <datum>) | [<datum>+ . <datum>]
                    |	<abbreviation>
<abbreviation>     -->	' <datum> | ` <datum> | , <datum> | ,@ <datum>
                    |	#' <datum> | #` <datum> | #, <datum> | #,@ <datum>
```

If no dotted-pair marker appears in a list enclosed in parentheses or brackets, it is a proper list, and the datums are the elements of the list, in the order given. If a dotted-pair marker appears, the initial elements of the list are those before the marker, and the datum that follows the marker is the tail of the list. The dotted-pair marker is typically used only when the datum that follows the marker is not itself a list. While any proper list may be written without a dotted-pair marker, a proper list can be written in dotted-pair notation by placing a list after the dotted-pair marker.

The abbreviations are equivalent to the corresponding two-element lists shown below. Once an abbreviation has been read, the result is indistinguishable from its nonabbreviated form.

```
'<datum>           -> (quote <datum>)
`<datum>           -> (quasiquote <datum>)
,<datum>           -> (unquote <datum>)
,@<datum>          -> (unquote-splicing <datum>)
#'<datum>          -> (syntax <datum>)
#`<datum>          -> (quasisyntax <datum>)
#,<datum>          -> (unsyntax <datum>)
#,@<datum>         -> (unsyntax-splicing <datum>)
```

**Vectors**.  Vectors are compound datums formed from groups of tokens and possibly involving other datums, including other vectors. A vector is written as an open vector parenthesis followed by a sequence of datums and a close parenthesis.

```
<vector>           -->	#(<datum>*)
```

**Bytevectors**.  Bytevectors are compound datums formed from groups of tokens, but the syntax does not permit them to contain arbitrary nested datums. A bytevector is written as an open bytevector parenthesis followed by a sequence of octets (unsigned 8-bit exact integers) and a close parenthesis.

```
<bytevector>       -->	#vu8(<octet>*)
<octet>            -->	<any <number> representing an exact integer n, 0 ≤ n ≤ 255>
```

