# Chez Scheme Cheatsheet
* [Summary of Forms - Chez Scheme Version 9 User's Guide](https://cisco.github.io/ChezScheme/csug9.5/summary.html)
* [Summary of Forms - The Scheme Programming Language, Fourth Edition](https://www.scheme.com/tspl4/summary.html)


# 1 Core Syntactic Forms

核心句法形式(core syntactic forms)

- top-level `define` forms,
- constants,
- variables,
- procedure applications,
- `quote` expressions,
- `lambda` expressions,
- `if` expressions,
- `set!` expressions.

Scheme 的核心语法

```
; 程序
<program>               --> <form>*
; 形式
<form>                  --> <definition>
                            | <expression>
; 定义
<definition>            --> <variable definition>
                            | (begin <definition>*)
; 变量定义
<variable definition>   --> (define <variable> <expression>)
; 表达式
<expression>            --> <constant>
                            | <variable>
                            | (quote <datum>)
                            | (lambda <formals> <expression> <expression>*)
                            | (if <expression> <expression> <expression>)
                            | (set! <variable> <expression>)
                            | <application>
; 常量
<constant>              --> <boolean> | <number> | <character> | <string>
; 参数
<formals>               --> <variable>
                            | (<variable>*)
                            | (<variable> <variable>* . <variable>)
; 过程应用
<application>           --> (<expression> <expression>*)
```

其中:

- `|`表示选择, `*`表示零次或多次出现;
- `<variable>`是Scheme标识符;
- `<dataum>`是任意Scheme对象, 例如数字、列表、符号或向量等;
- `<boolean>`是`#t`或`#f`;
- `<number>`是任意数字;
- `<character>`是任意字符;
- `<string>`是任意字符串;

# 2 Procedures and Variable Bindings

## 2.1 Variable References


```scheme
syntax: variable
returns: the value of variable
```

程序中表达式中出现的任意标识符(idenfitier)是一个变量(variable), 如果一个该标识符的可见变量绑定存在, 即改标识符在由`define`、`lambda`、`let`或其他变量绑定构造创建的绑定作用域中出现.

如果一个标识符引用(identifier reference)出现在`library`形式或顶层程序中, 没有绑定为一个变量、关键字(keyword)、记录名称(record name)或其他实体, 产生语法错误.

因为`library`、顶层程序、`lambda`或其他局部体中定义的作用域是整个体, 变量的定义不一定需要在它的引用首次出现之前出现, 只要这个引用在这个定义已完成之前没有实际求值. 例:

```scheme
(define f
  (lambda (x)
    (g x)))      ; ok
(define q (g 3)) ; error
(define g
  (lambda (x)
    (+ x x)))
```

## 2.2 Lambda, Case-Lambda


```scheme
syntax: (lambda formals body1 body2 ...)
returns: a procedure
libraries: (rnrs base), (rnrs)
```

`lambda`句法形式(syntactic form)用于创建过程(procedure). 任意创建过程或建立局部变量绑定的操作, 本质上是用`lambda`或`case-lambda`定义的.

`formals`中的变量是过程的形式参数(formal arguments), 子形式序列`body1 body2 ...`是过程的体(body).

体中可以以定义的序列(a sequence of definitions)开始, 这种情况下由这些定义创建的绑定的作用域是这个体. 如果存在定义, 在展开体时使用并丢弃关键字绑定(keyword bindings), 体被展开为由变量定义和剩余表达式构成的一个`letrec*`表达式(见关键字绑定). 下面的关于`lambda`的描述假设必要时这个转换已经完成, 从而体时没有定义的表达式序列.

创建过程时, 除形式化参数外, 所有变量的绑定在体中自由出现并保留(retained)在过程中. 每当过程应用到实际参数序列(sequence of actual parameters)上, 形式参数绑定到实际参数, 恢复(restore)保留的绑定, 再求值体.

在应用过程时, `formals`定义的形式化参数按如下方式绑定到实际参数:

- 如果`formals`是变量的合式列表(proper list), 例如`(x y z)`, 每个变量绑定到相应的实际参数. 如果提供了过多或过少的实际参数, 抛出状况类型(condition type)`&assertion`的异常(exception).
- 如果`formals`是单个变量, 例如`z`, 该变量绑定到一个实际参数的列表.
- 如果`formals`是以一个变量结束的非合式列表, 例如`(x y . z)`, 除最后一个变量外每个变量绑定到相应的实际参数, 最后一个变量绑定到一个剩余实际参数的列表. 如果提供了过少的实际参数, 抛出状况类型`&assertion`的异常.

求值体时, 体中表达式按顺序求值, 过程以最后一个表达式的值作为返回值.

例:

```scheme
> (lambda (x) (+ x 3))
<procedure>
```


``` scheme
syntax: (case-lambda clause ...)
returns: a procedure
libraries: (rnrs control), (rnrs)
```

一个`case-lambda`表达式由一组子句(clause)构成, 每个子句类似于一个`lambda`表达式.

`clause`的形式:

```scheme
[formals body1 body2 ...]
```

每个子句中的形式参数按与`lambda`表达式同样的方式用`formals`定义. `case-lambda`表达式的过程值可以接受的实际参数的数量, 由各子句可以接受的实际参数数量确定.

当`case-lambda`创建的过程被调用时, 按顺序考察这些子句. 选中接受给定实际参数数量的第一个子句, 由`formals`定义的形式参数绑定到相应的实际参数, 体按`lambda`表达式的方式求值. 

如果一个子句的`formals`是一个标识符的合式列表, 则该子句接受与形式参数数量相同的实际参数. 当一个子句的`formals`是单个标识符, 该子句接受任意数量的实际参数; 当`formals`是以单个标识符结束的非合式列表, 该子句接受大于或等于除最后一个结尾标识符外的形式参数数量的实际参数.

如果没有接受实际参数的子句存在, 抛出状况类型`&assertion`的异常.

## 2.3 Local Binding


```scheme
syntax: (let ((var expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
```

`let`建立局部变量绑定. 每个变量`var`绑定到相应的表达式`expr`的值. `let`的体中变量是绑定的, 由子形式序列`body1 body2 ...`构成, 按与`lambda`体类似的方式处理并求值.

与`let*`、`letrec`和`letrec*`不同, **表达式`expr`在变量`var ...`的作用域之外**. 与`let*`和`letrec*`不同, 表达式`expr ...`的 **求值顺序没有要求**, 可以从左向右、从右向左或其他任意顺序.

在表达式的值独立于变量和表达式求值顺序不重要时, 使用`let`.

例:

```scheme
> (let ([x (* 3.0 3.0)] [y (* 4.0 4.0)])
    (sqrt (+ x y)))
5.0
```


```scheme
syntax: (let* ((var expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
```

`let*`与`let`类似, 但表达式`expr ...` **从左向右** 求值, **每个表达式在其左边的变量的作用域中**.

在表达式的值之间存在线性依赖或表达式的求值顺序重要时, 使用`let*`.

例:

```scheme
> (let* ([x (* 5.0 5.0)]
     [y (- x (* 4.0 4.0))])
(sqrt y))
3.0
```


```scheme
syntax: (letrec ((var expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
```

`letrec`与`let`、`let*`类似, 但**所有表达式`expr ...`在所有变量`var ...`的作用域中**.

因为表达式`expr ...`的 **求值顺序是未描述的(unspecified)**, 不能在所有值已计算出之前, 求值任何由`letrec`表达式绑定的变量的引用. 如果违背这个约束, 抛出状况类型`&assertion`的异常.

一个`expr`不应该返回超过一次, 即不应该同时正常返回、通过求值中获得的continuation调用返回, 不应该两次调用这种continuation返回两次. 实现不要求检测这种语法错误, 但支持时抛出状况类型`&assertion`的异常.

当变量之间存在循环依赖或表达式求值顺序不重要时, 选择使用`letrec`.

例:

```scheme
> (letrec ([sum (lambda (x)
              (if (zero? x)
                  0
                  (+ x (sum (- x 1)))))])
(sum 5))
15
```


```scheme
syntax: (letrec* ((var expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
```

`letrec*`与`letrec`类似, 但按 **从左向右** 的顺序求值表达式`expr ...`. 程序不可在相应的表达式`expr`已被求值之前求值任意`var`的引用, `var`的引用可以在之后的任意时刻求值, 包括后续绑定的`expr`求值过程中.

例:

```scheme
> (letrec* ([sum (lambda (x)
                (if (zero? x)
                    0
                    (+ x (sum (- x 1)))))]
            [f (lambda () (cons n n-sum))]
            [n 15]
            [n-sum (sum n)])
    (f))
(15 . 120)

> (letrec* ([f (lambda () (lambda () g))]
        [g (f)])
    (eq? (g) g))
t
> (letrec* ([g (f)]
            [f (lambda () (lambda () g))])
    (eq? (g) g))
Exception: attempt to reference undefined variable f
```

## 2.4 Multiple Values


``` scheme
syntax: (let-values ((formals expr) ...) body1 body2 ...)
syntax: (let*-values ((formals expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs base), (rnrs)
```

`let-values`接受多值(multiple values), 并将它们绑定到变量. 结构与`let`类似, 但允许每个LHS上出现任意的形参列表(类似于`lambda`的形参列表).

`let*-value`与之类似, 但按从左向右的顺序执行绑定.

如果`expr`返回的值的数量与相应的`formals`不相配, 抛出状况类型`&assertion`的异常.

例:

```scheme
> (let-values ([(a b) (values 1 2)]
            [c (values 1 2 3)])
    (list a b c))
(1 2 (1 2 3))
> (let*-values ([(a b) (values 1 2)]
                [(a b) (values b a)])
    (list a b))
(2 1)
```


## 2.5 Variable Definitions


``` scheme
syntax: (define var expr)                                       ; (1)
syntax: (define var)                                            ; (2)
syntax: (define (var0 var1 ...) body1 body2 ...)                ; (3)
syntax: (define (var0 . varr) body1 body2 ...)                  ; (4)
syntax: (define (var0 var1 var2 ... . varr) body1 body2 ...)    ; (5)
libraries: (rnrs base), (rnrs)
```

形式(1)中, `define`创建`var`到`expr`值的新绑定. `expr`不应该返回超过一次.

形式(2)等价于`(define var unspecified)`, `unspecified`是某个未指定的值.

形式(3)(4)(5)是绑定变量到过程的简写形式, 等价于:

``` scheme
; (3) formals: (var1 ...)
; (4) formals: varr
; (5) formals: (var1 var2 ... . varr)
(define var
  (lambda formals
    body1 body2 ...))
```

定义可以在`library`体中前面部分、顶层程序体中形式之间、`lambda`或`case-lambda`体/由`lambda`导出的任意形式(例如`let`或`letrec*`)的体中前面部分出现. 任意以定义序列开始的体在宏展开(macro expansion)时转换为一个`letrec*`表达式.

语法定义可以在变量定义出现的地方出现.

一组定义可以包裹在一个`begin`形式中, 出现在常规变量定义或语法定义可以出现的地方. 被视为移除了包裹的`begin`形式后分别定义的.

```scheme
> (define x 3)
> x
3

> (define f
    (lambda (x y)
    (* (+ x y) 2)))
> (f 5 4)
18

> (define (sum-of-square x y)
    (+ (* x x) (* y y)))
> (sum-of-square 3 4)
25

> (define f
    (lambda (x)
    (+ x 1)))
> (let ([x 2])
(define f
  (lambda (y)
    (+ y x)))
(f 3))
5
> (f 3)
4
```

## 2.6 Assignment


``` scheme
syntax: (set! var expr)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`set!`没有为`var`建立新的绑定, 而是修改了已存在绑定的值. 首先求值`expr`, 将`expr`的值赋值给`var`.
后续在被修改的绑定的作用域中对`var`的引用, 求值为新的值.

例: 实现状态修改

```scheme
> (define flip-flop
    (let ([state #f])
    (lambda ()
        (set! state (not state))
        state)))
> (flip-flop)
t
> (flip-flop)
f
> (flip-flop)
t
```

例: 缓存值

```scheme
> (define memoize
    (lambda (proc)
      (let ([cache '()])
        (lambda (x)
          (cond
            [(assq x cache) => cdr]
            [else
             (let ([ans (proc x)])
               (set! cache (cons (cons x ans) cache))
               ans)])))))
> (define fibonacci
    (memoize
      (lambda (n)
        (if (< n 2)
            1
            (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))
> (fibonacci 100)
573147844013817084101
```


# 3 Control Operations

## 3.1 Procedure Application


``` scheme
syntax: (expr0 expr1 ...)
returns: values of applying the value of expr0 to the values of expr1 ...
```

过程应用(procedure application)是Scheme中最基本的控制结构. 任意不以语法关键字作为第一个位置元素的结构化的形式是一个过程应用. 表达式`expr0`和`expr1 ...`被求值, 每个应该求值为单个值. 在这些表达式求值后, `expr0`的值应用到`expr1 ...`的值. 如果`expr0`的值不是过程, 或者该过程不能接受提供的实际参数, 抛出状况类型`&assertion`的异常.

过程表达式和实际参数表达式求值的顺序是未描述的, 可以从左向右、从右向左或者任意顺序. 但保证求值是顺序性的, 不管选择哪种顺序, 每个表达式在下一个表达式开始求值之前已完成求值.

例:

```scheme
> (+ 3 4)
7
> ((if (odd? 3) + -) 6 2)
8
> ((lambda (x) x) 5)
5
> (let ([f (lambda (x) (+ x x))])
    (f 8))
16
```


``` scheme
procedure: (apply procedure obj ... list)
returns: the values of applying procedure to obj ... and the elements of list
libraries: (rnrs base), (rnrs)
```

`apply`调用`procedure`, 传递第一个`obj`作为第一个实际参数, 第二个`obj`作为第二个实际参数, 诸如此类, 按序传递`list`中元素作为剩余的实际参数.

在传递给过程的实际参数部分或全部在一个列表中时使用`apply`.

例:

```scheme
> (apply + '(4 5))
9
> (apply min '(6 8 3 2 5))
2
> (apply min 5 1 3 '(6 8 3 2 5))
1
```

## 3.2 Sequencing


```scheme
syntax: (begin expr1 expr2 ...)
returns: the values of the last subexpression
libraries: (rnrs base), (rnrs)
```

表达式`expr1 expr2 ...`按顺序从左向右求值. `begin`用于顺序化赋值、I/O或其他产生副作用的操作.

`begin`形式在表达式`expr1 expr2 ...`出现的位置, 可以包含零个或多个定义, 该形式被视为一个定义, 可以在定义能够出现的位置上出现.

`begin`形式主要用于必须展开为多个定义的句法扩展.

很多句法形式的体, 包括`lambda`、`case-lambda`、`let`、`let*`、`letrec`、`letrec*`和`cond`、`case`、`do`的结果子句(result clauses), 被视为在一个隐含的`begin`中; 即, 构成体或结果子句的表达式按顺序执行, 最后一个表达式的值作为返回值.

例:

```scheme
> (define x 3)
> (begin
    (set! x (+ x 1))
    (+ x x))
8
> (let ()
    (begin (define x 3) (define y 4))
    (+ x y))
7
> (define swap-pair!
    (lambda (x)
    (let ([temp (car x)])
        (set-car! x (cdr x))
        (set-cdr! x temp)
        x)))
> (swap-pair! '(a . b))
(b . a)
```    

## 3.3 Conditionals


```scheme
syntax: (if test consequent alternative)    ; (1)
syntax: (if test consequent)                ; (2)
returns: the values of consequent or alternative depending on the value of test
libraries: (rnrs base), (rnrs)
```

`test`、`consequent`和`alternative`子形式必须是表达式. 

如果`test`求值为一个真值(除`#f`之外的任意值), `consequent`被求值, 并将该值作为返回值.
否则, `alternative`被求值, 并将该值作为返回值. 在(2)中, 如果`test`求值为假, 结果为未描述的.

例:

```scheme
> (let ([ls '(a b c)])
    (if (null? ls)
        '()
        (cdr ls)))
(b c)
```


```scheme
procedure: (not obj)
returns: #t if obj is false, #f otherwise
libraries: (rnrs base), (rnrs)
```

`not`等价于`(lambda (x) (if x #f #t))`.


```scheme
syntax: (and expr ...)
returns: see below
libraries: (rnrs base), (rnrs)
```

如果没有子表达式, `and`形式求值为`#t`.

否则, `and`按从左向右的顺序求值每个子表达式, 直到只剩下一个子表达式或一个子表达式返回`#f`:

- 如果只剩下一个子表达式, 求值该表达式, 并将值作为返回值;
- 如果一个子表达式返回`#f`, `and`不会求值剩余的子表达式, 而是直接返回`#f`.

例:

```scheme
> (let ([x 3])
    (and (> x 2) (< x 4)))
#t
> (and '(a b) '(c d))
(c d)
```


```scheme
syntax: (or expr ...)
returns: see below
libraries: (rnrs base), (rnrs)
```

如果没有子表达式, `or`形式返回`#f`.

否则, `or`按从左向右的顺序求值每个子表达式, 直到只剩下一个子表达式或一个子表达式返回不是`#f`的值:

- 如果只剩下一个子表达式, 求值该表达式, 并将值作为返回值;
- 如果一个子表达式返回不是`#f`的值, `or`不会求值剩余的子表达式, 而是直接返回该值.

例:

```scheme
> (let ([x 5])
    (or (< x 2) (> x 4)))
#t
> (or #f '(a b) '(c d))
(a b)
```


```scheme
syntax: (cond clause1 clause2 ...)
returns: see below
libraries: (rnrs base), (rnrs)

;;; clause
(test)                  ; (1)
(test expr1 expr2 ...)  ; (2)
(test => expr)          ; (3)
(else expr1 expr2 ...)  ; (4) else clause: only the last clause

syntax: else
syntax: =>
libraries: (rnrs base), (rnrs exceptions), (rnrs)
```

每个`test`按序求值, 直到一个求值为真值或所有的测试已求值:

- 如果第一个其`test`求值为真值的子句的形式为(1): 返回`test`的值.
- 如果为(2): 按顺序求值表达式`expr1 expr2 ...`, 返回最后一个表达式的值.
- 如果为(3): 求值`expr`, 该值应该是接受单个参数的过程, 将该过程应用到`test`的值, 应用的结果值作为返回值.
- 如果为(4): 按顺序求值表达式`expr1 expr2 ...`, 返回最后一个表达式的值.
- 如果每个测试求值为真值且没有`else`子句, 返回值是未描述的.

`else`、`=>`是`cond`和`guard`的辅助关键字(auxiliary keywords). `else`也作为`case`的辅助关键字. 在它们被识别为辅助关键字的上下文之外引用这些标识符是语法错误.

例:

```scheme
> (define select
    (lambda (x)
    (cond
        [(not (symbol? x))]
        [(assq x '((a . 1) (b . 2) (c . 3))) => cdr]
        [else 0])))
> (select 3)
#t
> (select 'b)
2
> (select 'd)
0
```


```scheme
syntax: (when test-expr expr1 expr2 ...)
syntax: (unless test-expr expr1 expr2 ...)
returns: see below
libraries: (rnrs control), (rnrs)
```

对于`when`:

- 如果`test-expr`求值为真值, 按顺序求值表达式`expr1 expr2 ...`, 返回最后一个表达式的值;
- 如果`test-expr`求值为假, 不求值这些表达式, 返回值是未描述的.

对于`unless`:

- 如果`test-expr`求值为假, 按顺序求值表达式`expr1 expr2 ...`, 返回最后一个表达式的值;
- 如果`test-expr`求值为真值, 不求值这些表达式, 返回值是未描述的.


```scheme
syntax: (case expr0 clause1 clause2 ...)
returns: see below
libraries: (rnrs base), (rnrs)

;;; clause
((key ...) expr1 expr2 ...)     ; (1)
(else expr1 expr2 ...)          ; (2) else clause: only the last clause
```

求值`expr0`, 将该值按顺序与每个子句中的键比较(使用`eqv?`):

- 如果找到匹配键的子句, 按顺序求值表达式`expr1 expr2 ...`, 返回最后一个表达式的值;
- 如果没有找到匹配键的子句, 但由`else`子句, 按顺序求值`else`子句中的表达式`expr1 expr2 ...`, 返回最后一个表达式的值;
- 否则, 返回值是未描述的.

例:

```scheme
> (let ([x 4] [y 5])
    (case (+ x y)
    [(1 3 5 7 9) 'odd]
    [(0 2 4 6 8) 'even]
    [else 'out-of-range]))
odd
```

## 3.4 Recursion and Iteration


```scheme
syntax: (let name ((var expr) ...) body1 body2 ...)
returns: values of the final body expression
libraries: (rnrs base), (rnrs)
```

命名的`let`(named `let`)是一个通用的迭代和递归构造. 与通常的`let`形式类似, 在体`body1 body2 ...`中绑定变量`var ...`到值`expr ...`, 体按`lambda`中体的方式处理和求值. 此外, 变量`name`在体中绑定到一个过程, 该过程被调用用于迭代(recur or iterate), 过程的实际参数程序变量`var ...`的新值.

例:

```scheme
> (define divisors
    (lambda (n)
    (let f ([i 2])
        (cond
        [(>= i n) '()]
        [(integer? (/ n i)) (cons i (f (+ i 1)))]
        [else (f (+ i 1))]))))
> (divisors 5)
()
> (divisors 32)
(2 4 8 16)

; tail-recursive version
> (define divisors2
    (lambda (n)
    (let f ([i 2] [ls '()])
        (cond
        [(>= i n) ls]
        [(integer? (/ n i)) (f (+ i 1) (cons i ls))]
        [else (f (+ i 1) ls)]))))
> (divisors2 5)
()
> (divisors2 32)
(16 8 4 2)
```


```scheme
syntax: (do ((var init update) ...) (test result ...) expr ...)
returns: the values of the last result expression
libraries: (rnrs control), (rnrs)
```

`do`支持简便的表述迭代的常见的受限形式. 变量`var ...`初始时绑定到`init ...`的值, 在每个后继迭代中重新绑定到`update ...`的值. 表达式`test`、`update ...`、`expr ...`和`result ...`在`var ...`建立的绑定的作用域中.

在每一步中, 求值测试表达式`test`:

- 如果其值为真, 迭代停止(cease), 按顺序求值结果表达式`result ...`, 返回最后一个表达式的值. 如果没有结果表达式, 则返回值是未描述的.
- 如果其值为假, 按顺序求值表达式`expr ...`, 求值表达式`update ...`, 创建变量`var ...`到`update ...`值的新绑定, 迭代继续(continue).

表达式`expr ...`求值只为作用(effect), 通常被省略. 任意`update`表达式也可被省略, 这种情况下, 作用等价于`update`为相应的`var`.

例:

```scheme
> (define factorial
    (lambda (n)
    (do ([i n (- i 1)] [a 1 (* a i)])
        ((zero? i) a))))
> (factorial 10)
3628800

> (define divisors
    (lambda (n)
    (do ([i 2 (+ i 1)]
        [ls '()
            (if (integer? (/ n i)) (cons i ls) ls)])
        ((>= i n) ls))))
> (divisors 5)
()
> (divisors 32)
(16 8 4 2)
```

## 3.5 Mapping and Folding


``` scheme
procedure: (map procedure list1 list2 ...)
returns: list of results
libraries: (rnrs base), (rnrs)
```

`map`应用`procedure`到列表`list1 list2 ...`相应的元素上, 返回一个结果值的列表. 
列表`list1 list2 ...`必须长度相同.
`procedure`应该接受数量与列表数量相同的实际参数, 返回单个值, 不应该修改`list`实际参数.

尽管这些应用本身出现的顺序是未描述的, 但输出列表中值的顺序与输入列表中相应值的顺序相同.

例:

```scheme
> (map abs '(1 -2 3 -4 5 -6))
(1 2 3 4 5 6)
> (map (lambda (x y) (* x y))
    '(1 2 3 4)
    '(8 7 6 5))
(8 14 18 20)
```


``` scheme
procedure: (for-each procedure list1 list2 ...)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`for-each`与`map`类似, 但不创建和返回一个结果值的列表, `for-each`保证按从左向右的顺序在元素上执行应用.
`procedure`应该接受数量与列表数量相同的实际参数, 不应该修改`list`实际参数.

例:

```scheme
> (for-each (lambda (x) (display x) (newline))
    '(1 2 3 4))
1
2
3
4
```


``` scheme
procedure: (exists procedure list1 list2 ...)
returns: see below
libraries: (rnrs lists), (rnrs)
```

列表`list1 list2 ...`的长度必须相同. `procedure`应该接受数量与列表数量相同的实际参数, 不应该修改`list`实际参数.

如果列表为空, `exists` **返回** `#f`; 否则`exists`按顺序在列表`list1 list2 ...`相应的元素上应用`procedure`, 直到:

- 每个列表只剩下一个元素: `exists`应用`procedure`在剩余元素上; 或者
- `procedure`返回真值`t`: **返回** `t`. (注意: 不是`#t`.)

例:

```scheme
> (exists symbol? '(1.0 #\a "hi" '()))
#f
> (exists symbol? '(1.0 #\a a "hi" '()))
#t

> (exists member
    '(a b c)
    '((c b) (b a) (a c)))
(b a)

> (exists (lambda (x y z) (= (+ x y) z))
    '(1 2 3 4)
    '(1.2 2.3 3.4 4.5)
    '(2.3 4.4 6.4 8.6))
#t
```


``` scheme
procedure: (for-all procedure list1 list2 ...)
returns: see below
libraries: (rnrs lists), (rnrs)
```

列表`list1 list2 ...`的长度必须相同. `procedure`应该接受数量与列表数量相同的实际参数, 不应该修改`list`实际参数.

如果列表为空, `for-all` **返回** `#t`; 否则`for-all`按顺序在列表`list1 list2 ...`相应的元素上应用`procedure`, 直到:

- 每个列表只剩下一个元素: `for-all`应用`procedure`在剩余元素上; 或者
- `procedure`返回真值`#f`: **返回** `#f`.

例:

```scheme
> (for-all symbol? '(a b c d))
#t

> (for-all =
    '(1 2 3 4)
    '(1.0 2.0 3.0 4.0))
#t

> (for-all (lambda (x y z) (= (+ x y) z))
    '(1 2 3 4)
    '(1.2 2.3 3.4 4.5)
    '(2.2 4.3 6.5 8.5))
#f
```


``` scheme
procedure: (fold-left procedure obj list1 list2 ...)
returns: see below
libraries: (rnrs lists), (rnrs)
```

`list`实际参数应该有相同的长度. `procedure`应该接受数量比列表数量大1的实际参数, 并返回单个值; 不应该修改`list`实际参数.

如果`list`实际参数为空, `fold-left`返回`obj`.

如果`list`实际参数不为空, `fold-left`在`obj`和`list1 list2 ...`的car上应用`procedure`, 用`procedure`的返回值替换`obj`, 并重复的在`obj`和`list1 list2 ...`的cdr上应用`procedure`.

例:

```scheme
> (fold-left cons '() '(1 2 3 4))
((((() . 1) . 2) . 3) . 4)

> (fold-left
    (lambda (a x) (+ a (* x x)))
    0 '(1 2 3 4 5))
55

> (fold-left
    (lambda (a . args) (append args a))
    '(question)
    '(that not to)
    '(is to be)
    '(the be: or))
(to be or not to be: that is the question)
```


``` scheme
procedure: (fold-right procedure obj list1 list2 ...)
returns: see below
libraries: (rnrs lists), (rnrs)
```

`list`实际参数应该有相同的长度. `procedure`应该接受数量比列表数量大1的实际参数, 并返回单个值; 不应该修改`list`实际参数.

如果`list`实际参数为空, `fold-right`返回`obj`.

如果`list`实际参数不为空, `fold-right`重复的用每个`list`的cdr替换`list`, 然后在`list1 list2 ...`的car和递归返回的结果上应用`procedure`.

例:

```scheme
> (fold-right cons '() '(1 2 3 4))
(1 2 3 4)

> (fold-right
    (lambda (x a) (+ a (* x x)))
    0 '(1 2 3 4 5))
55

> (fold-right
    (lambda (x y a) (cons* x y a))
    '((with apologies))
    '(parting such sorrow go ya)
    '(is sweet gotta see tomorrow))
(parting is such sweet sorrow gotta go see ya tomorrow
(with apologies))
```


``` scheme
procedure: (vector-map procedure vector1 vector1 ...)
returns: vector of results
libraries: (rnrs base), (rnrs)
```

`vector-map`在向量`vector1 vector2 ...`相应元素上应用`procedure`, 返回一个结果值的向量.
向量`vector1 vector2 ...`的长度必须相同, `procedure`应该接受数量与向量数量相同的实际参数, 并返回单个值.

尽管这些应用本身出现的顺序是未描述的, 但输出向量中值的顺序与输入向量中相应值的顺序相同.

例:

```scheme
> (vector-map abs '#(1 -2 3 -4 5 -6))
#(1 2 3 4 5 6)

> (vector-map (lambda (x y) (* x y))
    '#(1 2 3 4)
    '#(8 7 6 5))
#(8 14 18 20)
```


``` scheme
procedure: (vector-for-each procedure vector1 vector2 ...)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`vector-for-each`与`vector-map`类似, 但不创建和返回一个结果值的向量. `vector-for-each`保证按从左向右的顺序在元素上执行应用.

例:

```scheme
> (let ([same-count 0])
    (vector-for-each
    (lambda (x y)
        (when (= x y)
        (set! same-count (+ same-count 1))))
    '#(1 2 3 4 5 6)
    '#(2 3 3 4 7 6))
    same-count)
3
```


``` scheme
procedure: (string-for-each procedure string1 string2 ...)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`string-for-each`与`for-each`和`vector-for-each`类似, 但输入是字符串.

例:

```scheme
> (let ([ls '()])
    (string-for-each
    (lambda r (set! ls (cons r ls)))
    "abcd"
    "===="
    "1234")
    (map list->string (reverse ls)))
("a=1" "b=2" "c=3" "d=4")
```

## 3.6 Continuations


Scheme中的continuation是一个过程, 表示从计算中某一点后剩余的计算. 可以用`call-with-current-continuation`获取continuation, 其简写为`call/cc`.


``` scheme
procedure: (call/cc procedure)
procedure: (call-with-current-continuation procedure)
returns: see below
libraries: (rnrs base), (rnrs)
```

`call/cc`获取它的continuation, 并传递给只接受一个实际参数的`procedure`.
 
这个continuation本身表示为一个过程`k`. 

(1) 每次这个continuation过程(`k`)应用在零个或多个值上时, 它将这些值返回给`call/cc`应用的continuation. 即, 当continuation过程被调用时, 它将其实际参数作为`call/cc`应用的值.

(2) 如果`procedure`没有使用continuation过程(`k`)且正常返回, `call/cc`应用的值是`procedure`应用的值.

continuation可以用于实现非局部退出(nonlocal exit)、回溯(backtracking)、协程(coroutine)和多任务(multitasking).

当前的continuation在内部通常表示为一个过程活跃记录(activation record)的栈, 获取continuation涉及在一个过程性对象中封装这个栈.

例:

```scheme
> (call/cc (lambda (k) (* 5 4)))            ; (2) 没有使用continuation过程且正常返回
20

> (call/cc (lambda (k) (* 4 (k 4))))        ; (1) continuation过程应用在单个值上
4

> (define member
    (lambda (x ls)
      (call/cc
        (lambda (break)                     ; break: continuation过程
          (do ([ls ls (cdr ls)])
            ((null? ls) #f)
            (when (equal? x (car ls))
              (break ls)))))))        ; nonlocal exit from loop
> (member 'd '(a b c))
#f
> (member 'b '(a b c))
(b c)
```


``` scheme
procedure: (dynamic-wind in body out)
returns: values resulting from the application of body
libraries: (rnrs base), (rnrs)
```

`dynamic-wind`为continuation调用提供保护(protection), 用于执行在控制进入或离开`body`(不管是正常的还是通过continuation应用)时必须执行的任务.

`in`、`body`、`out`必须是不接受参数的过程, 即必须是thunk. 
在应用`body`之前, 并且每次通过应用`body`中创建的continuation进入`body`, 则应用`in` thunk.
在从`body`正常退出时, 且每次通过应用在`body`外创建的continuation退出`body`, 则应用`out` thunk.

因此, 可以确保`in`至少被调用一次. 此外, 如果`body`返回, 则`out`至少被调用一次.

例:

```scheme
> (let ([p (open-input-file "C:/Program Files/Chez Scheme 9.5.8/bin/ta6nt/scheme.exe")])
    (dynamic-wind
    (lambda () (display "enter") (newline))
    (lambda () (display p) (newline))
    (lambda () (display "exit") (newline) (close-port p))))
enter
#<input port C:/Program Files/Chez Scheme 9.5.8/bin/ta6nt/scheme.exe>
exit
```

## 3.7 Delayed Evaluation


```scheme
syntax: (delay expr)
returns: a promise
procedure: (force promise)
returns: result of forcing promise
libraries: (rnrs r5rs)
```

句法形式`delay`和过程`force`可以用于实现惰性求值(lazy evaluation). 惰性求值的表达式在其值实际需要之前不会被求值, 一旦求值不会再次求值.

由`delay`创建的promise第一次被`force`应用时, 求值表达式`expr`, 并*记住*结果值. 之后, 每次promise被强制时, 返回记住的值而不是重新求值`expr`.

`delay`和`force`通常在没有副作用(例如赋值)时使用, 所以求值的顺序是不重要的.

使用`delay`和`force`的益处在于, 如果计算的结果在实际需要之前被延迟, 则一些计算可以避免. 延迟的求值可被用于构造无限的列表或流(stream).

例: 流, 一个promise, 被强制时返回pair, 该pair的cdr是一个流

```scheme
> (define stream-car
    (lambda (s)
    (car (force s))))
> (define stream-cdr
    (lambda (s)
    (cdr (force s))))
> (define counters
    (let next ([n 1])
    (delay (cons n (next (+ n 1))))))

> (stream-car counters)
1
> (stream-car (stream-cdr counters))
2

> (define stream-add
    (lambda (s1 s2)
    (delay (cons
            (+ (stream-car s1) (stream-car s2))
            (stream-add (stream-cdr s1) (stream-cdr s2))))))
> (define even-counters
    (stream-add counters counters))

> (stream-car even-counters)
2
> (stream-car (stream-cdr even-counters))
4
```

## 3.8 Multiple Values


``` scheme
procedure: (values obj ...)
returns: obj ...
libraries: (rnrs base), (rnrs)
```

`values`接受任意数量的实际参数, 简单的将这些参数传递/返回给它的continuation.

例:

```scheme
> (values)
> (values 1)
1
> (values 1 2 3)
1
2
3
> (define head&tail
    (lambda (ls)
    (values (car ls) (cdr ls))))
> (head&tail '(a b c))
a
(b c)
```

调用`values`的continuation不需要是调用`call-with-values`建立的.
`values`不一定返回给由`call-with-values`建立的continuation. 
通常`(values e)`与`e`是等价的表达式.


``` scheme
procedure: (call-with-values producer consumer)
returns: see below
libraries: (rnrs base), (rnrs)
```

`producer`和`consumer`必须是过程. `call-with-values`在不传递参数的调用`producer`返回的值上应用`consumer`.

例:

```scheme
> (call-with-values
    (lambda () (values 'bond 'james))
    (lambda (x y) (cons y x)))
(james . bond)

> (call-with-values values list)
()
```

## 3.9 Eval


``` scheme
procedure: (eval obj environment)
returns: values of the Scheme expression represented by obj in environment
libraries: (rnrs eval)
```

如果`obj`不表示一个句法有效的表达式, `eval`抛出状况类型`&syntax`的异常.
由`environment`、`scheme-report-environment`和`null-environment`返回的环境是不可变的(immutable).
如果表达式中出现了对环境中任意变量的赋值, `eval`抛出状况类型`&syntax`的异常.

例:

```scheme
> (define cons 'not-cons)
> (eval '(let ([x 3]) (cons x 4)) (environment '(rnrs)))
(3 . 4)
> (define lambda 'not-lambda)
> (eval '(lambda (x) x) (environment '(rnrs)))
#<procedure>
> (eval '(cons 3 4) (environment))
Exception: attempt to reference unbound identifier cons
> (cons 3 4)
Exception: attempt to apply non-procedure not-cons
```


``` scheme
procedure: (environment import-spec ...)
returns: an environment
libraries: (rnrs eval)
```

`environment`返回由导入描述符`import-spec ...`中绑定构成的环境.
每个`import-spec`必须是一个表示有效的导入描述符的s-表达式(s-expression).

例:

```scheme
> (define env (environment '(rnrs) '(prefix (rnrs lists) $)))
> (eval '($cons* 3 4 (* 5 8)) env)
(3 4 . 40)
```


``` scheme
procedure: (null-environment version)
procedure: (scheme-report-environment version)
returns: an R5RS compatibility environment
libraries: (rnrs r5rs)
```

`version`必须是精确整数5.

`null-environment`返回一个包含了R5RS定义的关键字的绑定、辅助关键字(`else`、`=>`、`...`、`_`)的绑定的环境.

`scheme-report-environment`返回一个包含了与`null-environment`返回的相同的关键字绑定、排除了不在R6RS中定义的(`load`、`interaction-environment`、`transcript-on`、`transcript-off`和`char-ready?`)绑定的环境.

```scheme
> (null-environment 5)
#<environment *r5rs-syntax*>
> (scheme-report-environment 5)
#<environment *r5rs*>
```


# 4 Operations on Objects

## 4.1 Constants and Quotation

``` scheme
syntax: constant
returns: constant
```

`constant`是一个自求值的(self-evaluating)常量, 即数值、布尔值、字符、字符串或字节向量.
常量是不可变的(immutable).

例:

```scheme
3.2 ;=> 3.2
f ;=> #f
\c ;=> #\c
"hi" ;=> "hi"
vu8(3 4 5) ;=> #vu8(3 4 5)
```

```scheme
syntax: (quote obj)
syntax: 'obj
returns: obj
libraries: (rnrs base), (rnrs)
```

`quote`抑制(inhibit)对`obj`的正常求值规则, 将`obj`视为数据.
尽管任意Scheme对象可以被引用(quoted), 对自求值常量的引用是不必要的.

被引用的自求值常量是不可变的. 程序中不应该通过`set-car!`、`string-set!`等修改常量, 具体实现可以在发现修改常量时抛出状况类型`&assertion`的异常. 如果没有检测到修改一个不可变对象的尝试, 程序的行为是未描述的.

具体实现可以选择在不同常量之间共享存储, 以节省空间.

例:

```scheme
(+ 2 3) ;=> 5
'(+ 2 3) ;=> (+ 2 3)
(quote (+ 2 3)) ;=> (+ 2 3)
'a ;=> a
'cons ;=> cons
'() ;=> ()
'7 ;=> 7
```

```scheme
syntax: (quasiquote obj ...)
syntax: `obj
syntax: (unquote obj ...)
syntax: ,obj
syntax: (unquote-splicing obj ...)
syntax: ,@obj
returns: see below
libraries: (rnrs base), (rnrs)
```

`quasiquote`与`quote`类似, 但允许被引用的文本中部分是未被引用的(unquoted). 
在`quasiquote`表达式中, `unquote`和`unquote-splicing`子形式被求值, 其它部分是被引用的, 即不被求值.
每个`unquote`子形式的值在输出中放置在`unquote`形式的位置, 每个`unquote-splicing`子形式的值被粘接(spliced)到外围列表或向量结构中.
`unquote`和`unquote-splicing`只在`quasiquote`表达式中有效.

`quasiquote`表达式也可以内嵌, 每个`quasiquote`引入一层引用, 每个`unquote`或`unquote-splicing`移除一层引用. 内嵌在n层`quasiquote`表达式中的表达式, 必须在n层`unquote`或`unquote-splicing`中被求值.

例:

```scheme
`(+ 2 3) ;=> (+ 2 3)

`(+ 2 ,(* 3 4)) ;=> (+ 2 12)
`(a b (,(+ 2 3) c) d) ;=> (a b (5 c) d)
`(a b ,(reverse '(c d e)) f g) ;=> (a b (e d c) f g)
(let ([a 1] [b 2])
  `(,a . ,b)) ;=> (1 . 2)

`(+ ,@(cdr '(* 2 3))) ;=> (+ 2 3)
`(a b ,@(reverse '(c d e)) f g) ;=> (a b e d c f g)
(let ([a 1] [b 2])
  `(,a ,@b)) ;=> (1 . 2)
`#(,@(list 1 2 3)) ;=> #(1 2 3)

'`,(cons 'a 'b) ;=> `,(cons 'a 'b)
`',(cons 'a 'b) ;=> '(a . b)
```

带零个或多个子形式的`unquote`和`unquote-splicing`形式只在粘接(列表或向量)上下文中有效.
`(unquote obj ...)`等价于`(unquote obj) ...`, `(unquote-splicing obj ...)`等价于`(unquote-splicing obj) ...`. 这些形式主要用于在`quasiquote`展开器(expander)的输出中作为中间形式.
它们支持一些有用的嵌套引用习语, 例如`,@,@`用在两层嵌套、两次求值的`quasiquote`表达式中时有两次间接粘接的效果.

例:

```scheme
`(a (unquote) b) ;=> (a b)
`(a (unquote (+ 3 3)) b) ;=> (a 6 b)
`(a (unquote (+ 3 3) (* 3 3)) b) ;=> (a 6 9 b)

(let ([x '(m n)]) ``(a ,@,@x f)) ;=> `(a (unquote-splicing m n) f)
(let ([x '(m n)])
  (eval `(let ([m '(b c)] [n '(d e)]) `(a ,@,@x f))
        (environment '(rnrs)))) ;=> (a b c d e f)
```


## 4.2 Generic Equivalence and Type Predicates

```scheme
procedure: (eq? obj1 obj2)
returns: #t if obj1 and obj2 are identical, #f otherwise
libraries: (rnrs base), (rnrs)
```

在大多数Scheme系统中, 如果两个对象在系统内部用相同的指针值(pointer value)表示, 则认为这两个对象是相同的(identical); 如果用不同的指针指表达式, 则是不相同的(distinct). 也存在其它诸如时间戳(time-stamping)的考虑.

尽管系统之间对对象标识(object identity)的规则存在不同, 但这些规则总是成立:

- 两个不同类型(布尔型、空列表、pair、数值类型、字符、字符串、向量、符号、过程)的对象是不相同的.
- 同一类型的两个对象, 具有不同的内容货值, 是不相同的.
- 布尔对象`#t`每次出现时与自身相同, `#f`每次出现时与自身相同, `#t`与`#f`是不相同的.
- 空列表`()`每次出现时与自身相同.
- 当且仅当有相同的名称(使用`string=?`)时, 两个符号是相同的.
- 常量pair、向量、字符串或字节向量与自身相同, 分别使用`cons`、`vector`、`string`、`make-bytevector`创建的pair、向量、字符串或字节向量与常量自身相同.
- 行为不同的两个过程是不相同的. 通过求值`lambda`表达式创建的过程与自身相同. 使用同一个`lambda`表达式或者相似的`lambda`表达式, 在不同时间创建的两个过程, 是或者不是相同的.

使用`eq?`不能可靠的比较数值和字符. 尽管不精确的数与精确的数是不相同的, 两个有相同值的精确的数、不精确的数、字符, 是或者不是相同的.

当在不同的不可变常量的相同部分上应用`eq?`时, 可以返回`#t`.

例:

```scheme
(eq? 'a 3) ;=> #f
(eq? #t 't) ;=> #f
(eq? "abc" 'abc) ;=> #f
(eq? "hi" '(hi)) ;=> #f
(eq? #f '()) ;=> #f

(eq? 9/2 7/2) ;=> #f
(eq? 3.4 53344) ;=> #f
(eq? 3 3.0) ;=> #f
(eq? 1/3 #i1/3) ;=> #f

(eq? 9/2 9/2) ;=> unspecified
(eq? 3.4 (+ 3.0 .4)) ;=> unspecified
(let ([x (* 12345678987654321 2)])
  (eq? x x)) ;=> unspecified

(eq? #\a #\b) ;=> #f
(eq? #\a #\a) ;=> unspecified
(let ([x (string-ref "hi" 0)])
  (eq? x x)) ;=> unspecified

(eq? #t #t) ;=> #t
(eq? #f #f) ;=> #t
(eq? #t #f) ;=> #f
(eq? (null? '()) #t) ;=> #t
(eq? (null? '(a)) #f) ;=> #t

(eq? (cdr '(a)) '()) ;=> #t

(eq? 'a 'a) ;=> #t
(eq? 'a 'b) ;=> #f
(eq? 'a (string->symbol "a")) ;=> #t

(eq? '(a) '(b)) ;=> #f
(eq? '(a) '(a)) ;=> unspecified
(let ([x '(a . b)]) (eq? x x)) ;=> #t
(let ([x (cons 'a 'b)])
  (eq? x x)) ;=> #t
(eq? (cons 'a 'b) (cons 'a 'b)) ;=> #f

(eq? "abc" "cba") ;=> #f
(eq? "abc" "abc") ;=> unspecified
(let ([x "hi"]) (eq? x x)) ;=> #t
(let ([x (string #\h #\i)]) (eq? x x)) ;=> #t
(eq? (string #\h #\i)
     (string #\h #\i)) ;=> #f

(eq? '#vu8(1) '#vu8(1)) ;=> unspecified
(eq? '#vu8(1) '#vu8(2)) ;=> #f
(let ([x (make-bytevector 10 0)])
  (eq? x x)) ;=> #t
(let ([x (make-bytevector 10 0)])
  (eq? x (make-bytevector 10 0))) ;=> #f

(eq? '#(a) '#(b)) ;=> #f
(eq? '#(a) '#(a)) ;=> unspecified
(let ([x '#(a)]) (eq? x x)) ;=> #t
(let ([x (vector 'a)])
  (eq? x x)) ;=> #t
(eq? (vector 'a) (vector 'a)) ;=> #f

(eq? car car) ;=> #t
(eq? car cdr) ;=> #f
(let ([f (lambda (x) x)])
  (eq? f f)) ;=> #t
(let ([f (lambda () (lambda (x) x))])
  (eq? (f) (f))) ;=> unspecified
(eq? (lambda (x) x) (lambda (y) y)) ;=> unspecified

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (eq? (f 0) (f 0))) ;=> #f
```

```scheme
procedure: (eqv? obj1 obj2)
returns: #t if obj1 and obj2 are equivalent, #f otherwise
libraries: (rnrs base), (rnrs)
```

`eqv?`与`eq?`类似, 但保证在这些情况下返回`#t`:

- 两个在`char=?`下视为相等的字符;
- 两个数 (a)在`=`下视为相等, 并且 (b)不能用`eq?`和`eqv?`之外的操作区分.

例:

```scheme
(eqv? 'a 3) ;=> #f
(eqv? #t 't) ;=> #f
(eqv? "abc" 'abc) ;=> #f
(eqv? "hi" '(hi)) ;=> #f
(eqv? #f '()) ;=> #f

(eqv? 9/2 7/2) ;=> #f
(eqv? 3.4 53344) ;=> #f
(eqv? 3 3.0) ;=> #f
(eqv? 1/3 #i1/3) ;=> #f

(eqv? 9/2 9/2) ;=> #t
(eqv? 3.4 (+ 3.0 .4)) ;=> #t
(let ([x (* 12345678987654321 2)])
  (eqv? x x)) ;=> #t

(eqv? #\a #\b) ;=> #f
(eqv? #\a #\a) ;=> #t
(let ([x (string-ref "hi" 0)])
  (eqv? x x)) ;=> #t

(eqv? #t #t) ;=> #t
(eqv? #f #f) ;=> #t
(eqv? #t #f) ;=> #f
(eqv? (null? '()) #t) ;=> #t
(eqv? (null? '(a)) #f) ;=> #t

(eqv? (cdr '(a)) '()) ;=> #t

(eqv? 'a 'a) ;=> #t
(eqv? 'a 'b) ;=> #f
(eqv? 'a (string->symbol "a")) ;=> #t

(eqv? '(a) '(b)) ;=> #f
(eqv? '(a) '(a)) ;=> unspecified
(let ([x '(a . b)]) (eqv? x x)) ;=> #t
(let ([x (cons 'a 'b)])
  (eqv? x x)) ;=> #t
(eqv? (cons 'a 'b) (cons 'a 'b)) ;=> #f

(eqv? "abc" "cba") ;=> #f
(eqv? "abc" "abc") ;=> unspecified
(let ([x "hi"]) (eqv? x x)) ;=> #t
(let ([x (string #\h #\i)]) (eqv? x x)) ;=> #t
(eqv? (string #\h #\i)
      (string #\h #\i)) ;=> #f

(eqv? '#vu8(1) '#vu8(1)) ;=> unspecified
(eqv? '#vu8(1) '#vu8(2)) ;=> #f
(let ([x (make-bytevector 10 0)])
  (eqv? x x)) ;=> #t
(let ([x (make-bytevector 10 0)])
  (eqv? x (make-bytevector 10 0))) ;=> #f

(eqv? '#(a) '#(b)) ;=> #f
(eqv? '#(a) '#(a)) ;=> unspecified
(let ([x '#(a)]) (eqv? x x)) ;=> #t
(let ([x (vector 'a)])
  (eqv? x x)) ;=> #t
(eqv? (vector 'a) (vector 'a)) ;=> #f

(eqv? car car) ;=> #t
(eqv? car cdr) ;=> #f
(let ([f (lambda (x) x)])
  (eqv? f f)) ;=> #t
(let ([f (lambda () (lambda (x) x))])
  (eqv? (f) (f))) ;=> unspecified
(eqv? (lambda (x) x) (lambda (y) y)) ;=> unspecified

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (eqv? (f 0) (f 0))) ;=> #f
```

```scheme
procedure: (equal? obj1 obj2)
returns: #t if obj1 and obj2 have the same structure and contents, #f otherwise
libraries: (rnrs base), (rnrs)
```

两个对象是相等的(equal), 如果在`eqv?`下等价、字符串在`string=?`下等价、字节向量在`bytevector=?`下等价、pair的car和cdr都是相等的(equal)、向量具有相同长度且对应元素是相等的(equal).

`equal?`要求甚至在出现循环参数时终止, 当且仅当参数展开成的树等价于排序的树.

本质上, 如果两个对象的结构无法使用pair或vector的访问函数以及使用`eqv?`、`string=?`、`bytevector=?`过程比较叶子上数据区分, 则两个对象在`equal?`下等价.

例:

```scheme
(equal? 'a 3) ;=> #f
(equal? #t 't) ;=> #f
(equal? "abc" 'abc) ;=> #f
(equal? "hi" '(hi)) ;=> #f
(equal? #f '()) ;=> #f

(equal? 9/2 7/2) ;=> #f
(equal? 3.4 53344) ;=> #f
(equal? 3 3.0) ;=> #f
(equal? 1/3 #i1/3) ;=> #f

(equal? 9/2 9/2) ;=> #t
(equal? 3.4 (+ 3.0 .4)) ;=> #t
(let ([x (* 12345678987654321 2)])
  (equal? x x)) ;=> #t

(equal? #\a #\b) ;=> #f
(equal? #\a #\a) ;=> #t
(let ([x (string-ref "hi" 0)])
  (equal? x x)) ;=> #t

(equal? #t #t) ;=> #t
(equal? #f #f) ;=> #t
(equal? #t #f) ;=> #f
(equal? (null? '()) #t) ;=> #t
(equal? (null? '(a)) #f) ;=> #t

(equal? (cdr '(a)) '()) ;=> #t

(equal? 'a 'a) ;=> #t
(equal? 'a 'b) ;=> #f
(equal? 'a (string->symbol "a")) ;=> #t

(equal? '(a) '(b)) ;=> #f
(equal? '(a) '(a)) ;=> #t
(let ([x '(a . b)]) (equal? x x)) ;=> #t
(let ([x (cons 'a 'b)])
  (equal? x x)) ;=> #t
(equal? (cons 'a 'b) (cons 'a 'b)) ;=> #t

(equal? "abc" "cba") ;=> #f
(equal? "abc" "abc") ;=> #t
(let ([x "hi"]) (equal? x x)) ;=> #t
(let ([x (string #\h #\i)]) (equal? x x)) ;=> #t
(equal? (string #\h #\i)
        (string #\h #\i)) ;=> #t

(equal? '#vu8(1) '#vu8(1)) ;=> #t
(equal? '#vu8(1) '#vu8(2)) ;=> #f
(let ([x (make-bytevector 10 0)])
  (equal? x x)) ;=> #t
(let ([x (make-bytevector 10 0)])
  (equal? x (make-bytevector 10 0))) ;=> #t

(equal? '#(a) '#(b)) ;=> #f
(equal? '#(a) '#(a)) ;=> #t
(let ([x '#(a)]) (equal? x x)) ;=> #t
(let ([x (vector 'a)])
  (equal? x x)) ;=> #t
(equal? (vector 'a) (vector 'a)) ;=> #t

(equal? car car) ;=> #t
(equal? car cdr) ;=> #f
(let ([f (lambda (x) x)])
  (equal? f f)) ;=> #t
(let ([f (lambda () (lambda (x) x))])
  (equal? (f) (f))) ;=> unspecified
(equal? (lambda (x) x) (lambda (y) y)) ;=> unspecified

(let ([f (lambda (x)
           (lambda ()
             (set! x (+ x 1))
             x))])
  (equal? (f 0) (f 0))) ;=> #f

(equal?
  (let ([x (cons 'x 'x)])
    (set-car! x x)
    (set-cdr! x x)
    x)
  (let ([x (cons 'x 'x)])
    (set-car! x x)
    (set-cdr! x x)
    (cons x x))) ;=> #t
```

```scheme
procedure: (boolean? obj)
returns: #t if obj is either #t or #f, #f otherwise
libraries: (rnrs base), (rnrs)
```

`boolean?`等价于 `lambda (x) (or (eq? x #t) (er? x #f)))`.

例:

```scheme
(boolean? #t) ;=> #t
(boolean? #f) ;=> #t
(or (boolean? 't) (boolean? '())) ;=> #f
```

```scheme
procedure: (null? obj)
returns: #t if obj is the empty list, #f otherwise
libraries: (rnrs base), (rnrs)
```

`null?`等价于`(lambda (x) (eq? x '()))`.

例:

```scheme
(null? '()) ;=> #t
(null? '(a)) ;=> #f
(null? (cdr '(a))) ;=> #t
(null? 3) ;=> #f
(null? #f) ;=> #f
```

```scheme
procedure: (pair? obj)
returns: #t if obj is a pair, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(pair? '(a b c)) ;=> #t
(pair? '(3 . 4)) ;=> #t
(pair? '()) ;=> #f
(pair? '#(a b)) ;=> #f
(pair? 3) ;=> #f
```


```scheme
procedure: (number? obj)
returns: #t if obj is a number object, #f otherwise
procedure: (complex? obj)
returns: #t if obj is a complex number object, #f otherwise
procedure: (real? obj)
returns: #t if obj is a real number object, #f otherwise
procedure: (rational? obj)
returns: #t if obj is a rational number object, #f otherwise
procedure: (integer? obj)
returns: #t if obj is an integer object, #f otherwise
libraries: (rnrs base), (rnrs)
```

这些谓词构成一个层次: 整数(integer)是有理数(rational), 有理数是实数(real), 实数是复数(complex), 复数是数(number). 
大多数实现不提供无理数的内部表示, 所有实数通常是有理数.

`real?`、`rational?`、`integer?`不将带不精确的零虚部的复数识别为实数、有理数或整数.

例:

```scheme
(integer? 1901) ;=> #t
(rational? 1901) ;=> #t
(real? 1901) ;=> #t
(complex? 1901) ;=> #t
(number? 1901) ;=> #t

(integer? -3.0) ;=> #t
(rational? -3.0) ;=> #t
(real? -3.0) ;=> #t
(complex? -3.0) ;=> #t
(number? -3.0) ;=> #t

(integer? 7+0i) ;=> #t
(rational? 7+0i) ;=> #t
(real? 7+0i) ;=> #t
(complex? 7+0i) ;=> #t
(number? 7+0i) ;=> #t

(integer? -2/3) ;=> #f
(rational? -2/3) ;=> #t
(real? -2/3) ;=> #t
(complex? -2/3) ;=> #t
(number? -2/3) ;=> #t

(integer? -2.345) ;=> #f
(rational? -2.345) ;=> #t
(real? -2.345) ;=> #t
(complex? -2.345) ;=> #t
(number? -2.345) ;=> #t

(integer? 7.0+0.0i) ;=> #f
(rational? 7.0+0.0i) ;=> #f
(real? 7.0+0.0i) ;=> #f
(complex? 7.0+0.0i) ;=> #t
(number? 7.0+0.0i) ;=> #t

(integer? 3.2-2.01i) ;=> #f
(rational? 3.2-2.01i) ;=> #f
(real? 3.2-2.01i) ;=> #f
(complex? 3.2-2.01i) ;=> #t
(number? 3.2-2.01i) ;=> #t

(integer? 'a) ;=> #f
(rational? '(a b c)) ;=> #f
(real? "3") ;=> #f
(complex? '#(1 2)) ;=> #f
(number? #\a) ;=> #f
```

```scheme
procedure: (real-valued? obj)
returns: #t if obj is a real number, #f otherwise
procedure: (rational-valued? obj)
returns: #t if obj is a rational number, #f otherwise
procedure: (integer-valued? obj)
returns: #t if obj is an integer, #f otherwise
libraries: (rnrs base), (rnrs)
```

这些谓词与 `real?`、`rational?`、`integer?`类似, 但将带不精确的零虚部的复数识别为实数、有理数或整数.

例:

```scheme
(integer-valued? 1901) ;=> #t
(rational-valued? 1901) ;=> #t
(real-valued? 1901) ;=> #t

(integer-valued? -3.0) ;=> #t
(rational-valued? -3.0) ;=> #t
(real-valued? -3.0) ;=> #t

(integer-valued? 7+0i) ;=> #t
(rational-valued? 7+0i) ;=> #t
(real-valued? 7+0i) ;=> #t

(integer-valued? -2/3) ;=> #f
(rational-valued? -2/3) ;=> #t
(real-valued? -2/3) ;=> #t

(integer-valued? -2.345) ;=> #f
(rational-valued? -2.345) ;=> #t
(real-valued? -2.345) ;=> #t

(integer-valued? 7.0+0.0i) ;=> #t
(rational-valued? 7.0+0.0i) ;=> #t
(real-valued? 7.0+0.0i) ;=> #t

(integer-valued? 3.2-2.01i) ;=> #f
(rational-valued? 3.2-2.01i) ;=> #f
(real-valued? 3.2-2.01i) ;=> #f

(integer-valued? 'a) ;=> #f
(rational-valued? '(a b c)) ;=> #f
(real-valued? "3") ;=> #f
```

```scheme
procedure: (char? obj)
returns: #t if obj is a character, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(char? 'a) ;=> #f
(char? 97) ;=> #f
(char? #\a) ;=> #t
(char? "a") ;=> #f
(char? (string-ref (make-string 1) 0)) ;=> #t
```

```scheme
procedure: (string? obj)
returns: #t if obj is a string, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(string? "hi") ;=> #t
(string? 'hi) ;=> #f
(string? #\h) ;=> #f
```

```scheme
procedure: (vector? obj)
returns: #t if obj is a vector, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(vector? '#()) ;=> #t
(vector? '#(a b c)) ;=> #t
(vector? (vector 'a 'b 'c)) ;=> #t
(vector? '()) ;=> #f
(vector? '(a b c)) ;=> #f
(vector? "abc") ;=> #f
```

```scheme
procedure: (symbol? obj)
returns: #t if obj is a symbol, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(symbol? 't) ;=> #t
(symbol? "t") ;=> #f
(symbol? '(t)) ;=> #f
(symbol? #\t) ;=> #f
(symbol? 3) ;=> #f
(symbol? #t) ;=> #f
```

```scheme
procedure: (procedure? obj)
returns: #t if obj is a procedure, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(procedure? car) ;=> #t
(procedure? 'car) ;=> #f
(procedure? (lambda (x) x)) ;=> #t
(procedure? '(lambda (x) x)) ;=> #f
(call/cc procedure?) ;=> #t
```

```scheme
procedure: (bytevector? obj)
returns: #t if obj is a bytevector, #f otherwise
libraries: (rnrs bytevectors), (rnrs)
```

例:

```scheme
(bytevector? #vu8()) ;=> #t
(bytevector? '#()) ;=> #f
(bytevector? "abc") ;=> #f
```

```scheme
procedure: (hashtable? obj)
returns: #t if obj is a hashtable, #f otherwise
libraries: (rnrs hashtables), (rnrs)
```

例:

```scheme
(hashtable? (make-eq-hashtable)) ;=> #t
(hashtable? '(not a hash table)) ;=> #f
```

## 4.3 Lists and Pairs

pair, 又称为cons单元(cell), 是Scheme结构化对象类型的基础. pair最常见的用途是构建列表(list), 列表是pair的有序序列, 各pair通过cdr字段与下一个pair连接. 列表的元素占用pair的car字段.
合式列表(proper list)的最后一个pair的cdr是空列表`()`, 非合式列表的最后一个cdr是除了`()`的任意对象.

pair也可用于构造二叉树(binary trees). 树结构中的每个pair是内部节点; 其car和cdr指向节点的子节点.

合式列表打印为包裹在括号`()`中的空白符分隔的一组对象. 方括号`[]`可用在括号`()`出现的位置上. 例如, `(1 2 3)`和`(a [nested list])`是合式列表. 空列表记为`()`.

非合式列表和树需要稍微复杂的语法. 单个pair记为空白符和点`.`分隔的两个对象, 例如`(a . b)`. 这种记法称为点对记法(dotted-pair notation).
非合式列表和树使用点对记法表示, `.`出现在必要的位置, 例如`(1 2 3. 4)`、`((1 . 2) . 3)`.
合式列表也可以使用点对记法表示, 例如`(1 2 3)`可以记为`(1 . (2 . (3 . ())))`.

通过使用`set-car!`或`set-cdr!`破坏性的(destructively)修改pair的car或cdr字段, 可以创建循环列表或循环图. 这些列表不是合式列表.

接受`list`参数的过程只在遍历列表足够远, 遇到(a)尝试在非列表的尾部上执行操作 或 (b) 因为存在环而无限循环时, 需要检测出列表是非合式的. 例如, `member`在找到预期元素时不需要检测列表是非合式的, `list-ref`从不检测环, 因为它的递归是受索引参数限制的.

```scheme
procedure: (cons obj1 obj2)
returns: a new pair whose car and cdr are obj1 and obj2
libraries: (rnrs base), (rnrs)
```

`cons`是pair的构造器过程. `obj1`成为新pair的car, `obj2`成为cdr.

例:

```scheme
(cons 'a '()) ;=> (a)
(cons 'a '(b c)) ;=> (a b c)      
(cons 3 4) ;=> (3 . 4)
```

```scheme
procedure: (car pair)
returns: the car of pair
libraries: (rnrs base), (rnrs)
```

空列表`()`不是pair, 所以`car`的参数不能是空列表.

例:

```scheme
(car '(a)) ;=> a
(car '(a b c)) ;=> a
(car (cons 3 4)) ;=> 3
```

```scheme
procedure: (cdr pair)
returns: the cdr of pair
libraries: (rnrs base), (rnrs)
```

空列表`()`不是pair, 所以`cdr`的参数不能是空列表.

例:

```scheme
(cdr '(a)) ;=> ()
(cdr '(a b c)) ;=> (b c)
(cdr (cons 3 4)) ;=> 4
```

```scheme
procedure: (set-car! pair obj)
returns: unspecified
libraries: (rnrs mutable-pairs)
```

`set-car!`将`pair`的car修改为`obj`.

例:

```scheme
(let ((x (list 'a 'b 'c))) 
  (set-car! x 1) x) ;=> (1 b c)
```

```scheme
procedure: (set-cdr! pair obj)
returns: unspecified
libraries: (rnrs mutable-pairs)
```

`set-cdr!`将`pair`的cdr修改为`obj`.

例:

```scheme
(let ((x (list 'a 'b 'c))) 
  (set-cdr! x 1) x) ;=> (a . 1)
```

```scheme
procedure: (caar pair)
procedure: (cadr pair)
procedure: (cddddr pair)
returns: the caar, cadr, ..., or cddddr of pair
libraries: (rnrs base), (rnrs)
```

这些过程定义为至多4个`car`和`cdr`的组合. `c`和`r`之间的`a`和`d`表示从右向左应用`car`和`cdr`. 
例如, 过程`cadr`等价于`(lambda (x) (car (cdr x)))`.

例:

```scheme
(caar '((a))) ;=> a
(cadr '(a b c)) ;=> b
(cdddr '(a b c d)) ;=> (d)
(cadadr '(a (b c))) ;=> c
```

```scheme
procedure: (list obj ...)
returns: a list of obj ...
libraries: (rnrs base), (rnrs)
```

`list`等价于`(lambda x x)`.

例:

```scheme
(list) ;=> ()
(list 1 2 3) ;=> (1 2 3)
(list 3 2 1) ;=> (3 2 1)
```

```scheme
procedure: (cons* obj ... final-obj)
returns: a list of obj ... terminated by final-obj
libraries: (rnrs lists), (rnrs)
```

如果省略了`obj ...`, 结果是`final-obj`. 否则, 按与`list`相同的方式构造列表`obj ...`, 除了最后一个cdr字段是`final-obj`而不是`()`. 如果`final-obj`不是一个列表, 则结果是一个非合式列表.

例:

```scheme
(cons* '()) ;=> ()
(cons* '(a b)) ;=> (a b)
(cons* 'a 'b  'c) ;=> (a b . c)
(cons* 'a 'b '(c d)) ;=> (a b c d)
```

```scheme
procedure: (list? obj)
returns: #t if obj is a proper list, #f otherwise
libraries: (rnrs base), (rnrs)
```

`list?`必须对所有非合式列表(包括循环列表)返回`#f`.

例:

```scheme
(list? '()) ;=> #t
(list? '(a b c)) ;=> #t
(list? 'a) ;=> #f
(list? '(3 . 4)) ;=> #f
(list? 3) ;=> #f
(let ((x (list 'a 'b 'c)))
  (set-cdr! (cddr x) x)
  (list? x)) ;=> #f
```

```scheme
procedure: (length list)
returns: the number of elements in list
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(length '()) ;=> 0
(length '(a b c)) ;=> 3
(length (let ((ls (list 'a 'b)))
          (set-car! (cdr ls) ls)
          ls)) ;=> 2
```

```scheme
procedure: (list-ref list n)
returns: the nth element (zero-based) of list
libraries: (rnrs base), (rnrs)
```

`n`必须是小于`list`的长度的一个精确的非负整数.

例:

```scheme
(list-ref '(a b c) 0) ;=> a
(list-ref '(a b c) 1) ;=> b
(list-ref '(a b c) 2) ;=> c
```

```scheme
procedure: (list-tail list n)
returns: the nth tail (zero-based) of list
libraries: (rnrs base), (rnrs)
```

`n`必须是小于等于`list`的长度的一个精确的非负整数. 结果不是一个拷贝(copy), 这个尾部与`list`的第`n`个cdr在`eq?`下等价(`n`为0时与`list`本身在`eq?`下等价).

例:

```scheme
(list-tail '(a b c) 0) ;=> (a b c)
(list-tail '(a b c) 2) ;=> (c)
(list-tail '(a b c) 3) ;=> ()
(list-tail '(a b c . d) 2) ;=> (c . d)
(list-tail '(a b c . d) 3) ;=> d
(let ((x (list 1 2 3))) 
  (eq? (list-tail x 2) (cddr x))) ;=> #t    
```

```scheme
procedure: (append)
procedure: (append list ... obj)
returns: the concatenation of the input lists
libraries: (rnrs base), (rnrs)
```

`append`返回一个新的列表, 首先是第一个列表中元素, 然后是第二个列表中元素, 以此类推.
返回的新列表使用除最后一个参数的新pair构造的; 最后一个参数(不需要是列表)放在新结构的尾部.

例:

```scheme
(append '(a b c) '()) ;=> (a b c)
(append '() '(a b c)) ;=> (a b c)
(append '(a b) '(c d)) ;=> (a b c d)
(append '(a b) 'c) ;=> (a b . c)
(let ((x (list 'b))) (eq? x (cdr (append '(a) x)))) ;=> #t
```

```scheme
procedure: (reverse list)
returns: a new list containing the elements of list in reverse order
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(reverse '()) ;=> ()
(reverse '(a b c)) ;=> (c b a)
```

```scheme
procedure: (memq obj list)
procedure: (memv obj list)
procedure: (member obj list)
returns: the first tail of list whose car is equivalent to obj, or #f
libraries: (rnrs lists), (rnrs)
```

这些过程按顺序遍历参数`list`, 将其元素与`obj`比较. 
如果找到等价于`obj`的元素, 返回包含该元素的列表尾部. 
如果列表中包含多个等价于`obe`的元素, 返回第一个列表尾部.
如果列表中不包含等价于`obj`的元素, 返回`#f`.

`memq`使用的等价性测试过程是`eq?`, `memv`使用`eqv?`, `member`使用`equal?`.

这些过程常用作谓词, 它们会返回一个有用的真值.

例:

```scheme
(memq 'a '(b c a d e)) ;=> (a d e)
(memq 'a '(b c d e g)) ;=> #f
(memq 'a '(b a c a d a)) ;=> (a c a d a)
(memv 3.4 '(1.2 2.3 3.4 4.5)) ;=> (3.4 4.5)
(memv 3.4 '(1.3 2.5 3.7 4.9)) ;=> #f
(let ((ls (list 'a 'b 'c))) (set-car! (memv 'b ls) 'z) ls) ;=> (a z c)
(member '(b) '((a) (b) (c))) ;=> ((b) (c))
(member '(d) '((a) (b) (c))) ;=> #f
(member "b" '("a" "b" "c")) ;=> ("b" "c")
```

```scheme
procedure: (memp procedure list)
returns: the first tail of list for whose car procedure returns true, or #f
libraries: (rnrs lists), (rnrs)
```

`procedure`应该接受单个参数并返回单个值, 不应该修改`list`.

例:

```scheme
(memp odd? '(1 2 3 4)) ;=> (1 2 3 4)
(memp even? '(1 2 3 4)) ;=> (2 3 4)
(let ((ls (list 1 2 3 4)))
  (eq? (memp odd? ls) ls)) ;=> #t
(let ((ls (list 1 2 3 4)))
  (eq? (memp even? ls) (cdr ls))) ;=> #t
(memp odd? '(2 4 6 8)) ;=> #f
```

```scheme
procedure: (remq obj list)
procedure: (remv obj list)
procedure: (remove obj list)
returns: a list containing the elements of list with all occurrences of obj removed
libraries: (rnrs lists), (rnrs)
```

这些过程遍历参数`list`, 移除任何等价于`obj`的元素. 输出列表中剩余的元素的顺序与它们在输入列表中的顺序相同.
如果`list`的尾部(包括`list`本身)不包含与`obj`等价的元素, 则结果列表中相应的尾部与输入列表相应的尾部在`eq?`下相同.

`remq`使用的等价性测试过程是`eq?`, `remv`使用`eqv?`, `remove`使用`equal?`.

例:

```scheme
(remq 'a '(a b a c a d)) ;=> (b c d)
(remq 'a '(b c d)) ;=> (b c d)
(remv 1/2 '(1.2 1/2 0.5 3/2 4)) ;=> (1.2 0.5 3/2 4)
(remove '(b) '((a) (b) (c))) ;=> ((a) (c))
```

```scheme
procedure: (remp procedure list)
returns: a list of the elements of list for which procedure returns #f
libraries: (rnrs lists), (rnrs)
```

`procedure`应该接受单个参数并返回单个值, 不应该修改`list`.

`remp`在`list`的每个元素上应用`procedure`, 返回`procedure`应用结果为`#f`对应的元素构成的新列表. 结果列表中元素的顺序与它们在原始列表中的顺序相同.

例:

```scheme
(remp odd? '(1 2 3 4)) ;=> (2 4)
(remp (lambda (x) 
        (and (> x 0) (< x 10))) 
      '(-5 15 3 14 -20 6 0 -9)) ;=> (-5 15 14 -20 0 -9)
```

```scheme
procedure: (filter procedure list)
returns: a list of the elements of list for which procedure returns true
libraries: (rnrs lists), (rnrs)
```

`procedure`应该接受一个参数并返回单个值, 不应该修改`list`.

`filter`在`list`的每个元素上应用`procedure`, 返回`procedure`应用结果为真对应的元素构成的新列表. 结果列表中元素的顺序与它们在原始列表中的顺序相同.

例:

```scheme
(filter odd? '(1 2 3 4)) ;=> (1 3)
(filter (lambda (x) 
          (and (> x 0) (< x 10))) 
        '(-5 15 3 14 -20 6 0 -9)) ;=> (3 6)
```

```scheme
procedure: (partition procedure list)
returns: see below
libraries: (rnrs lists), (rnrs)
```

`procedure`应该接受一个参数并返回单个值, 不应该修改`list`.

`partition`在`list`的每个元素上应用`procedure`, 返回两个值: (1) `procedure`应用结果为真对应的元素构成的新列表, (2) `procedure`应用结果为`#f`对应的元素构成的新列表. 返回的列表中元素的顺序与它们在原始列表中的顺序相同.

例:

```scheme
(let-values (((l1 l2) (partition odd? '(1 2 3 4)))) 
  (list l1 l2)) ;=> ((1 3) (2 4))
(let-values (((l1 l2) (partition (lambda (x) 
                                   (and (> x 0) (< x 10))) 
                                 '(-5 15 3 14 -20 6 0 -9)))) 
  (list l1 l2)) ;=> ((3 6) (-5 15 14 -20 0 -9))
```

```scheme
procedure: (find procedure list)
returns: the first element of list for which procedure returns true, or #f
libraries: (rnrs lists), (rnrs)
```

`procedure`应该接受一个参数并返回单个值, 不应该修改`list`.

`find`按顺序遍历`list`, 在每个元素上应用`procedure`. 如果对于一个元素`procedure`返回真, `find`返回该元素, 不对剩余的元素应用`procedure`. 如果`procedure`对每个元素返回`#f`, `find`返回`#f`.

如果程序中需要区分在列表中找到元素`#f`和没有找到元素, 应该使用`memp`.

例:

```scheme
(find odd? '(1 2 3 4)) ;=> 1
(find even? '(1 2 3 4)) ;=> 2
(find odd? '(2 4 6 8)) ;=> #f
(find not '(1 a #f 55)) ;=> #f
```

```scheme
procedure: (assq obj alist)
procedure: (assv obj alist)
procedure: (assoc obj alist)
returns: first element of alist whose car is equivalent to obj, or #f
libraries: (rnrs lists), (rnrs)
```

`alist`必须是一个关联列表(association list). 关联列表是合式列表, 其元素时形式为`(key . value)`的键值对. 这种关联常用户将信息(值)与特定对象(键)存储在一起.

这些过程遍历关联列表, 测试每个键与`obj`的等价性. 如果找到一个等价键, 返回相应的键值对. 否则, 返回`#f`.

`assq`使用的等价性测试过程是`eq?`, `assv`使用`eqv?`, `assoc`使用`equal?`.

例:

```scheme
(assq 'b '((a . 1) (b . 2))) ;=> (b . 2)
(cdr (assq 'b '((a . 1) (b . 2)))) ;=> 2
(assq 'c '((a . 1) (b . 2))) ;=> #f
(assv 2/3 '((1/3 . 1) (2/3 . 2))) ;=> (2/3 . 2)
(assv 2/3 '((1/3 . a) (3/4 . b))) ;=> #f
(assoc '(a) '(((a) . a) (-1 . b))) ;=> ((a) . a)
(assoc '(a) '(((b) . b) (a . c))) ;=> #f
(let ((alist (list (cons 2 'a) (cons 3 'b)))) 
  (set-cdr! (assv 3 alist) 'c) 
  alist) ;=> ((2 . a) (3 . c))      
```

```scheme
procedure: (assp procedure alist)
returns: first element of alist for whose car procedure returns true, or #f
libraries: (rnrs lists), (rnrs)
```

`alist`必须是一个关联列表. 
`procedure`应该接受一个参数并返回单个值, 不应该修改`alist`.

例:

```scheme
(assp odd? '((1 . a) (2 . b))) ;=> (1 . a)
(assp even? '((1 . a) (2 . b))) ;=> (2 . b)
(let ((ls (list (cons 1 'a) (cons 2 'b)))) (eq? (assp odd? ls) (car ls))) ;=> #t
(let ((ls (list (cons 1 'a) (cons 2 'b)))) (eq? (assp even? ls) (cadr ls))) ;=> #t
(assp odd? '((2 . b))) ;=> #f
```

```scheme
procedure: (list-sort predicate list)
returns: a list containing the elements of list sorted according to predicate
libraries: (rnrs sorting), (rnrs)
```

`predicate`应该是一个过程, 接受两个参数, 如果第一个参数在排序后的列表中在第二个参数之前出现, 返回`#t`.
即, `predicate`应用于两个元素`x`、`y`, 在输入列表中`x`在`y`之后出现, `predicate`只当在输出列表中`x`应该在`y`之前出现时返回真值. 如果满足了这个约束, `list-sort`执行一个稳定的排序(stable sort), 即两个元素只在必要的情况下根据`predicate`重排.
不删除重复的元素.
这个过程至多调用`predicate` nlogn次, n是`list`的长度.

例:

```scheme
(list-sort < '(3 4 1 2 5)) ;=> (1 2 3 4 5)
(list-sort > '(0.5 1/2)) ;=> (0.5 1/2)
(list-sort > '(1/2 0.5)) ;=> (1/2 0.5)
(list->string (list-sort char>? (string->list "hello"))) ;=> "ollhe"
```

### 4.3.1 Numbers

Scheme中数可以分类为整数(integers)、有理数(rational numbers)、实数(real numbers)、复数(complex numbers). 这个分类是层次性的, 所有整数是有理数, 所有有理数是实数, 所有实数是复数. 
使用谓词`integer?`、`rational?`、`real?`、`complex?`确定数所属的类别.

Scheme中数也可以分类为精确的(exact)和不精确的(inexact), 这依赖于用于得出数的操作和这些操作的输入的质量.
使用谓词`exact?`和`inexact?`确定数的精确性.
Scheme中数的操作大部分是精确性保持的(exactness preserving): 如果提供了精确的操作数, 返回精确的值; 如果提供了不精确的或混合了精确的、不精确的操作数, 返回不精确的值.

精确的整数和有理数算术支持任意精度, 整数的大小、比例(ratio)的分母(denominator)和分子(numerator)的大小是受系统存储限制的.
尽管存在其它方式方式, 不精确的数通常用主机硬件或系统软件支持的浮点数(floating-point numbers)表示.
复数通常表示为有序对`(real-part, imag-part)`, `real-part`、`imag-part`是精确的整数、精确的有理数或浮点数.

Scheme中数以一种与传统书写数方式没有多少不同的直接方式书写. 精确的整数通常写为一个可选的符号, 之后是数的序列. 例如, `3`、`+19`、`-100000`、`208423089237489374`都表示精确的整数.

精确的有理数通常写作可选的符号, 之后是按`/`分隔的两个数序列. 例如, `3/4`、`-6/5`、`1/1208203823`是精确的有理数. 比例在读取时被规约, 可能被规约为精确的整数.

非精确的实数通常用浮点或科学记数法书写. 
浮点记数法由可选的符号、数序列、小数点`.`、另一个数序列构成.
科学记数法由可选的符号、数序列、可选的小数点和另一个数序列、一个指数(记为字母`e`)、可选的符号、数序列构成.
例如, `1.0`、`-200.0`是有效的非精确的整数, `1.5`、`0.034`、`-10e-10`、`1.5e-5`是有效的非精确的有理数.
指数是10的幂, 例如`2e3`等价于`2000.0`.

尾部宽度(mantissa width)`|w`可以作为以浮点或科学记数法书写的实数或复数的实部的后缀出现. 尾部宽度`w`表示数的表示中有效位的数量. 尾部宽度默认为53 (正则化的IEEE双精度浮点数的有效位数量), 或者更大. 
对于非正则化的IEEE双精度浮点数, 尾部宽度小于53. 
如果一个实现不能使用指定的尾部宽度表示一个数, 则使用至少与请求的有效位数量相同的表示, 否则使用最大尾部宽度的表示.

精确的和非精确的实数写作精确的或非精确的整数或有理数, Scheme中没有提供无理数(irrational numbers)的语法.

复数可以写作直角坐标或极坐标形式.
在直角坐标形式中, 复数写作`x+yi`或`x-yi`, `x`是整数、有理数或实数, `y`是无符号整数、有理数或实数. 实数部分`x`可以省略, 省略时认为是0. 例如, `3+4i`、`3.2-3.4i`、`-3e-5i`是直角坐标形式的复数.
在极坐标形式中, 复数写作`x@y`, `x`、`y`是整数、有理数或实数. 例如, `1.1@1.764`、`-1@-1/2`是极坐标形式的复数.

语法`+inf.0`、`-inf.0`分别表示正、负无穷(infinity`)的非精确实数.
语法`+nan.0`、`-nan.0`表示非精确的非数值(NaN, not-a-number).
使用非精确的正值或负值除以非精确的零得到无穷值.
使用非精确的零除以非精确的零得到NaN.

数的表示的精确性可以使用在表示前添加`#e`或`#i`覆盖. `#e`将数转换为精确的, `#i`将数转换为非精确的.
例如, `1`、`#e1`、`1/1`、`#e1/1`、`#e1.0`、`#e1e0`表示精确整数`1`, `#3/10`、`0.3`、`#i0.3`、`3e-1``表示非精确的有理数`0.3`.

数默认使用基数10书写, 使用特殊的前缀`#b`、`#o`、`#d`、`#x`分别指定基数2、8、10、16.
对于基数16, 字符`a`到`f`或`A`到`F`表达数字值10到15. 例如, `#b10101`是$21_{10}$的二进制表示, `#o72`是$58_{10}$的八进制表示, `#xC7`是$199_{10}$的十六进制表示.
使用浮点和科学记数法书写的数总是使用基数10.

如果同时指定了基数和精确性, 它们可以按任意顺序放置.

Scheme实现对非精确量提供多个大小的内部表示. 指数标记(exponent markers) `s`(short)、`f`(single)、`d`(double)、`l`(long)可以替换默认的指数标记`e`, 以覆盖科学记数法中数的默认大小.
在支持多种表示的实现中, 默认大小的精度至少为双精度(double).

数可以使用不同的方式书写, 但系统打印机(printer, 通过`put-datum`、`write`、`display`调用)和`number->string`以紧凑的形式表达数, 使用必要的最少数量的数字, 保留当读取时打印出的数与原始数相同的属性.

记法约定: 下面过程中的数值参数名称

- `num`: 复数, 即所有数.
- `real`: 实数.
- `rat`: 有理数.
- `int`: 整数.
- `exint`: 精确的整数.

```scheme
procedure: (exact? num)
returns: #t if num is exact, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(exact? 1) ;=> #t
(exact? -15/16) ;=> #t
(exact? 2.01) ;=> #f
(exact? 77.0) ;=> #f
(exact? 0.6666666666666666) ;=> #f
(exact? 1.0-2.0i) ;=> #f
```

```scheme
procedure: (inexact? num)
returns: #t if num is inexact, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
;;; inexact?
(inexact? -123) ;=> #f
(inexact? 123.0) ;=> #t
(inexact? 1e23) ;=> #t
(inexact? 0+1i) ;=> #f
```

```scheme
procedure: (= num1 num2 num3 ...)
procedure: (< real1 real2 real3 ...)
procedure: (> real1 real2 real3 ...)
procedure: (<= real1 real2 real3 ...)
procedure: (>= real1 real2 real3 ...)
```

谓词`=`在实际参数相等(equal)时返回`#t`.
谓词`<`在实际参数单调递增(monotonically increasing)时返回`#t`.
谓词`>`在实际参数单调递减(monotonically decreasing)时返回`#t`.
谓词`<=`在实际参数单调非递减时返回`#t`.
谓词`>=`在实际参数单调非递增时返回`#t`.

如果两个复数的实部和虚部相等(equal), 则这两个复数相等(equal).
与NaN的比较总是返回`#f`.

例:

```scheme
(= 7 7) ;=> #t
(= 7 9) ;=> #f
(< 2000.0 300.0) ;=> #f
(<= 1 2 3 3 4 5) ;=> #t
(<= 1 2 3 4 5) ;=> #t
(> 1 2 2 3 3 4) ;=> #f
(>= 1 2 2 3 3 4) ;=> #f
(= -1/2 -0.5) ;=> #t
(= 2/3 0.667) ;=> #f
(= 7.2 7.2) ;=> #t
(= 7.2-3.0i 7) ;=> #f
(< 1/2 2/3 3/4) ;=> #t
(> 8 4.102 2/3 -5) ;=> #t
(let ((x 0.218723452)) (< 0.21 x 0.22)) ;=> #t
(let ((i 1) (v (vector (quote a) (quote b) (quote c)))) (< -1 i (vector-length v))) ;=> #t
(apply < (quote (1 2 3 4))) ;=> #t
(apply > (quote (4 3 3 2))) ;=> #f
(= +nan.0 +nan.0) ;=> #f
(< +nan.0 +nan.0) ;=> #f
(> +nan.0 +nan.0) ;=> #f
(>= +inf.0 +nan.0) ;=> #f
(>= +nan.0 -inf.0) ;=> #f
(> +nan.0 0.0) ;=> #f
```

```scheme
procedure: (+ num ...)
returns: the sum of the arguments num ...
libraries: (rnrs base), (rnrs)
```

当没有提供参数时, `+`返回0.

例:

```scheme
(+) ;=> 0
(+ 1 2) ;=> 3
(+ 1/2 2/3) ;=> 7/6
(+ 3 4 5) ;=> 12
(+ 3.0 4) ;=> 7.0
(+ 3+4i 4+3i) ;=> 7+7i
(apply + (quote (1 2 3 4 5))) ;=> 15
```

```scheme
procedure: (- num)
returns: the additive inverse of num
procedure: (- num1 num2 num3 ...)
returns: the difference between num1 and the sum of num2 num3 ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(- 3) ;=> -3
(- -2/3) ;=> 2/3
(- 4 3.0) ;=> 1.0
(- 3.25+4.25i 1/4+1/4i) ;=> 3.0+4.0i
(- 4 3 2 1) ;=> -2
```

```scheme
procedure: (* num ...)
returns: the product of the arguments num ...
libraries: (rnrs base), (rnrs)
```

当没有提供参数时, `*`返回1.

例:

```scheme
(*) ;=> 1
(* 3.4) ;=> 3.4
(* 1 1/2) ;=> 1/2
(* 3 4 5.5) ;=> 66.0
(* 1+2i 3+4i) ;=> -5+10i
(apply * (quote (1 2 3 4 5))) ;=> 120
```

```scheme
procedure: (/ num)
returns: the multiplicative inverse of num
procedure: (/ num1 num2 num3 ...)
returns: the result of dividing num1 by the product of num2 num3 ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(/ -17) ;=> -1/17
(/ 1/2) ;=> 2
(/ 0.5) ;=> 2.0
(/ 3 4) ;=> 3/4
(/ 3.0 4) ;=> 0.75
(/ -5+10i 3+4i) ;=> 1+2i
(/ 60 5 4 3 2) ;=> 1/2
```

```scheme
procedure: (zero? num)
returns: #t if num is zero, #f otherwise
libraries: (rnrs base), (rnrs)
```

`zero?`等价于`(lambda (x) (= x 0))`.

例:

```scheme
(zero? 0) ;=> #t
(zero? 1) ;=> #f
(zero? (- 3.0 3.0)) ;=> #t
(zero? (+ 1/2 1/2)) ;=> #f
(zero? 0) ;=> #t
(zero? 0.0-0.0i) ;=> #t
```

```scheme
procedure: (positive? real)
returns: #t if real is greater than zero, #f otherwise
libraries: (rnrs base), (rnrs)
```

`positive?`等价于`(lambda (x) (> x 0))`.

例:

```scheme
(positive? 128) ;=> #t
(positive? 0.0) ;=> #f
(positive? 1.8e-15) ;=> #t
(positive? -2/3) ;=> #f
```

```scheme
procedure: (negative? real)
returns: #t if real is less than zero, #f otherwise
libraries: (rnrs base), (rnrs)
```

`negative?`等价于`(lambda (x) (< x 0))`.

例:

```scheme
(negative? -65) ;=> #t
(negative? 0) ;=> #f
(negative? -0.0121) ;=> #t
(negative? 15/16) ;=> #f
```

```scheme
procedure: (even? int)
returns: #t if int is even, #f otherwise
procedure: (odd? int)
returns: #t if int is odd, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(even? 0) ;=> #t
(even? 1) ;=> #f
(even? 2.0) ;=> #t
(even? -120762398465) ;=> #f

(odd? 0) ;=> #f
(odd? 1) ;=> #t
(odd? 2.0) ;=> #f
(odd? -120762398465) ;=> #t
```

```scheme
procedure: (finite? real)
returns: #t if real is finite, #f otherwise
procedure: (infinite? real)
returns: #t if real is infinite, #f otherwise
procedure: (nan? real)
returns: #t if real is a NaN, #f otherwise
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(finite? 2/3) ;=> #t
(infinite? 2/3) ;=> #f
(nan? 2/3) ;=> #f

(finite? 3.1415) ;=> #t
(infinite? 3.1415) ;=> #f
(nan? 3.1415) ;=> #f

(finite? +inf.0) ;=> #f
(infinite? -inf.0) ;=> #t
(nan? -inf.0) ;=> #f

(finite? +nan.0) ;=> #f
(infinite? +nan.0) ;=> #f
(nan? +nan.0) ;=> #t
```

```scheme
procedure: (quotient int1 int2)
returns: the integer quotient of int1 and int2
procedure: (remainder int1 int2)
returns: the integer remainder of int1 and int2
procedure: (modulo int1 int2)
returns: the integer modulus of int1 and int2
libraries: (rnrs r5rs)
```

`remainder`的结果与`int1`的符号相同, `modulo`的结果与`int2`的符号相同.

例:

```scheme
(quotient 45 6) ;=> 7
(quotient 6.0 2.0) ;=> 3.0
(quotient 3.0 -2) ;=> -1.0

(remainder 16 4) ;=> 0
(remainder 5 2) ;=> 1
(remainder -45.0 7) ;=> -3.0
(remainder 10.0 -3.0) ;=> 1.0
(remainder -17 -9) ;=> -8

(modulo 16 4) ;=> 0
(modulo 5 2) ;=> 1
(modulo -45.0 7) ;=> 4.0
(modulo 10.0 -3.0) ;=> -2.0
(modulo -17 -9) ;=> -8
```

```scheme
procedure: (div x1 x2)
procedure: (mod x1 x2)
procedure: (div-and-mod x1 x2)
returns: see below
libraries: (rnrs base), (rnrs)
```

如果`x1`和`x2`是精确的, `x2`必须不为零. 这些过程实现数论中整数除法, `div`与`quotient`相关, `mod`与`remainder`或`modulo`相关, 但都支持处理实数.

`(div x1 x2)`的值`nd`是整数, `(mod x1 x2)`的值`xm`是实数, 满足`x1 = nd * x2 + xm`, 且`0 <= xm < |x2|`. 当实现不能将满足这些公式的数学结果表示为数值对象时, `div`和`mod`返回一个未描述的数, 或者抛出状况类型`&implementation-restriction`的异常.

`div-and-mod`过程定义为`(define (div-and-mod x1 x2) (values (div x1) (mod x1 x2)))`. 即, 除非抛出上述的异常, 返回两个值: 调用`div`的结果和调用`mod`的结果.

例:

```scheme
(div 17 3) ;=> 5
(mod 17 3) ;=> 2
(div -17 3) ;=> -6
(mod -17 3) ;=> 1
(div 17 -3) ;=> -5
(mod 17 -3) ;=> 2
(div -17 -3) ;=> 6
(mod -17 -3) ;=> 1
(let-values (((d m) (div-and-mod 17.5 3))) (list d m)) ;=> (5.0 2.5)
```

```scheme
procedure: (div0 x1 x2)
procedure: (mod0 x1 x2)
procedure: (div0-and-mod0 x1 x2)
returns: see below
libraries: (rnrs base), (rnrs)
```

如果`x1`和`x2`是精确的, `x2`必须不为零. 这些过程与`div`、`mod`和`div-and-mod`类似, 但约束取模的方式不同.
`(div0 x1 x2)`的值`nd`是整数, `(mod0 x1 x2)`的值`xm`是实数, 满足`x1 = nd * x2 + xm`, 且`-|x2/2| <= xm < |x2/2|`. 当实现不能将满足这些公式的数学结果表示为数值对象时, `div0`和`mod0`返回一个未描述的数, 或者抛出状况类型`&implementation-restriction`的异常.

`div0-and-mod0`过程定义为`(define (div0-and-mod0 x1 x2) (values (div0 x1) (mod0 x1 x2)))`. 即, 除非抛出上述的异常, 返回两个值: 调用`div0`的结果和调用`mod0`的结果.

例:

```scheme
(div0 17 3) ;=> 6
(mod0 17 3) ;=> -1
(div0 -17 3) ;=> -6
(mod0 -17 3) ;=> 1
(div0 17 -3) ;=> -6
(mod0 17 -3) ;=> -1
(div0 -17 -3) ;=> 6
(mod0 -17 -3) ;=> 1
(let-values (((d m) (div0-and-mod0 17.5 3))) (list d m)) ;=> (6.0 -0.5)
```

```scheme
procedure: (truncate real)
returns: the integer closest to real toward zero
libraries: (rnrs base), (rnrs)
```

如果`real`是无穷或NaN, `truncate`返回`real`.

例:

```scheme
(truncate 19) ;=> 19
(truncate 2/3) ;=> 0
(truncate -2/3) ;=> 0
(truncate 17.3) ;=> 17.0
(truncate -17/2) ;=> -8
```

```scheme
procedure: (floor real)
returns: the integer closest to real toward -∞
libraries: (rnrs base), (rnrs)
```

如果`real`是无穷或NaN, `floor`返回`real`.

例:

```scheme
(floor 19) ;=> 19
(floor 2/3) ;=> 0
(floor -2/3) ;=> -1
(floor 17.3) ;=> 17.0
(floor -17/2) ;=> -9
```

```scheme
procedure: (ceiling real)
returns: the integer closest to real toward +∞
libraries: (rnrs base), (rnrs)
```

如果`real`是无穷或NaN, `ceiling`返回`real`.

例:

```scheme
(ceiling 19) ;=> 19
(ceiling 2/3) ;=> 1
(ceiling -2/3) ;=> 0
(ceiling 17.3) ;=> 18.0
(ceiling -17/2) ;=> -8
```

```scheme
procedure: (round real)
returns: the integer closest to real
libraries: (rnrs base), (rnrs)
```

如果`real`在两个整数正中间, 则返回最接近的偶整数. 如果`real`是无穷或NaN, `round`返回`real`.

例:

```scheme
(round 19) ;=> 19
(round 2/3) ;=> 1
(round -2/3) ;=> -1
(round 17.3) ;=> 17.0
(round -17/2) ;=> -8
(round 2.5) ;=> 2.0
(round 3.5) ;=> 4.0
```

```scheme
procedure: (abs real)
returns: the absolute value of real
libraries: (rnrs base), (rnrs)
```

`abs`等价于`(lambda (x) (if (< x 0) (- x) x))`. 对于实数参数, `abs`和`magnitude`是相同的.

例:

```scheme
(abs 1) ;=> 1
(abs -3/4) ;=> 3/4
(abs 1.83) ;=> 1.83
(abs -0.093) ;=> 0.093
```

```scheme
procedure: (max real1 real2 ...)
returns: the maximum of real1 real2 ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(max 4 -7 2 0 -6) ;=> 4
(max 1/2 3/4 4/5 5/6 6/7) ;=> 6/7
(max 1.5 1.3 -0.3 0.4 2.0 1.8) ;=> 2.0
(max 5 2.0) ;=> 5.0
(max -5 -2.0) ;=> -2.0
(let ((ls '(7 3 5 2 9 8)))
  (apply max ls)) ;=> 9
```

```scheme
procedure: (min real1 real2 ...)
returns: the minimum of real1 real2 ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(min 4 -7 2 0 -6) ;=> -7
(min 1/2 3/4 4/5 5/6 6/7) ;=> 1/2
(min 1.5 1.3 -0.3 0.4 2.0 1.8) ;=> -0.3
(min 5 2.0) ;=> 2.0
(min -5 -2.0) ;=> -5.0
(let ((ls '(7 3 5 2 9 8)))
  (apply min ls)) ;=> 2
```

```scheme
procedure: (gcd int ...)
returns: the greatest common divisor of its arguments int ...
libraries: (rnrs base), (rnrs)
```

结果总是非负的, 即忽略`-1`的因子. 当不提供参数时, `gcd`返回0.

例:

```scheme
(gcd) ;=> 0
(gcd 34) ;=> 34
(gcd 33.0 15.0) ;=> 3.0
(gcd 70 -42 28) ;=> 14
```

```scheme
procedure: (lcm int ...)
returns: the least common multiple of its arguments int ...
libraries: (rnrs base), (rnrs)
```

结果总是非负的, 即忽略`-1`的公倍数. 当不提供参数时, `lcm`返回0. 如果一个或多个参数是0, `lcm`返回0.

例:

```scheme
(lcm) ;=> 1
(lcm 34) ;=> 34
(lcm 33.0 15.0) ;=> 165.0
(lcm 70 -42 28) ;=> 420
(lcm 17.0 0) ;=> 0.0
```

```scheme
procedure: (expt num1 num2)
returns: num1 raised to the num2 power
libraries: (rnrs base), (rnrs)
```

如果两个参数都是0, `expt`返回1.

例:

```scheme
(expt 2 10) ;=> 1024
(expt 2 -10) ;=> 1/1024
(expt 2 -10.0) ;=> 9.765625e-4
(expt -1/2 5) ;=> -1/32
(expt 3.0 3) ;=> 27.0
(expt 0+1i 2) ;=> -1
```

```scheme
procedure: (inexact num)
returns: an inexact representation of num
libraries: (rnrs base), (rnrs)
```

如果`num`已经是非精确的, 则直接返回`num`. 如果具体实现不支持`num`的非精确的表示, 抛出状况类型`&implementation-violation`的异常.
如果参数的量级(magnitude)超过了具体实现的非精确数表示的范围, `inexact`返回`+inf.0`或`-inf.0`.

例:

```scheme
(inexact 3) ;=> 3.0
(inexact 3.0) ;=> 3.0
(inexact -1/4) ;=> -0.25
(inexact 3+4i) ;=> 3.0+4.0i
(inexact (expt 10 20)) ;=> 1e20
```

```scheme
procedure: (exact num)
returns: an exact representation of num
libraries: (rnrs base), (rnrs)
```

如果`num`已经是精确的, 则直接返回`num`. 如果具体实现不支持`num`的精确的表示, 抛出状况类型`&implementation-violation`的异常.

例:

```scheme
(exact 3.0) ;=> 3
(exact 3) ;=> 3
(exact -0.25) ;=> -1/4
(exact 3.0+4.0i) ;=> 3+4i
(exact 1e20) ;=> 100000000000000000000
```

```scheme
procedure: (exact->inexact num)
returns: an inexact representation of num
procedure: (inexact->exact num)
returns: an exact representation of num
libraries: (rnrs r5rs)
```

这些过程是`inexact`和`exact`的别名, 以兼容R5RS.

```scheme
procedure: (rationalize real1 real2)
returns: see below
libraries: (rnrs base), (rnrs)
```

`rationalize`返回与`real1`相差不超过`real2`的最简单的有理数.
有理数`q1=n1/m1`比有理数`q2=n2/m2`简单, 如果`|n1| <= |n2|`, `|m1| <= |m2|`, 且`|n1| < |n2|`或者`|m1| < |m2|`.
    
例:

```scheme
(rationalize 3/10 1/10) ;=> 1/3
(rationalize 0.3 1/10) ;=> 0.3333333333333333
(eqv? (rationalize 0.3 1/10) 0.3333333333333333) ;=> #t
```

```scheme
procedure: (numerator rat)
returns: the numerator of rat
libraries: (rnrs base), (rnrs)
```

如果`rat`是整数, 则分子是`rat`.

例:

```scheme
(numerator 9) ;=> 9
(numerator 9.0) ;=> 9.0
(numerator 0.0) ;=> 0.0
(numerator 2/3) ;=> 2
(numerator -9/4) ;=> -9
(numerator -2.25) ;=> -9.0
```

```scheme
procedure: (denominator rat)
returns: the denominator of rat
libraries: (rnrs base), (rnrs)
```

如果`rat`是整数(包括0), 分母是1.

例:

```scheme
(denominator 9) ;=> 1
(denominator 9.0) ;=> 1.0
(denominator 0) ;=> 1
(denominator 0.0) ;=> 1.0
(denominator 2/3) ;=> 3
(denominator -9/4) ;=> 4
(denominator -2.25) ;=> 4.0
```

```scheme
procedure: (real-part num)
returns: the real component of num
libraries: (rnrs base), (rnrs)
```

如果`num`是实数, `real-part`返回`num`.

例:

```scheme
(real-part 3+4i) ;=> 3
(real-part -2.3+0.7i) ;=> -2.3
(real-part 0-1i) ;=> 0
(real-part 17.2) ;=> 17.2
(real-part -17/100) ;=> -17/100
```

```scheme
procedure: (imag-part num)
returns: the imaginary component of num
libraries: (rnrs base), (rnrs)
```

如果`num`是实数, `imag-part`返回精确的0.

例:

```scheme
(imag-part 3+4i) ;=> 4
(imag-part -2.3+0.7i) ;=> 0.7
(imag-part 0-1i) ;=> -1
(imag-part -2.5) ;=> 0
(imag-part -17/100) ;=> 0
```

```scheme
procedure: (make-rectangular real1 real2)
returns: a complex number with real component real1 and imaginary component real2
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(make-rectangular -2 7) ;=> -2+7i
(make-rectangular 2/3 -1/2) ;=> 2/3-1/2i
(make-rectangular 3.2 5.3) ;=> 3.2+5.3i
```

```scheme
procedure: (make-polar real1 real2)
returns: a complex number with magnitude real1 and angle real2
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(make-polar 2 0) ;=> 2
(make-polar 2.0 0.0) ;=> 2.0+0.0i
(make-polar 1.0 (asin -1.0)) ;=> 6.123233995736766e-17-1.0i
(eqv? (make-polar 7.2 -0.588) 5.990772517368266-3.9938258155739703i) ;=> #t
```

```scheme
procedure: (angle num)
returns: the angle part of the polar representation of num
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(angle -2.681439725442999e-5+7.299999999950752i) ;=> 1.5708
(angle 5.2) ;=> 0.0
```

```scheme
procedure: (magnitude num)
returns: the magnitude of num
libraries: (rnrs base), (rnrs)
```

对于实数参数, `magnitude`与`abs`是相同的. 复数`x+yi`的模(magnitude)是$+\sqrt{x^{2} + y^{2}}$.

例:

```scheme
(magnitude 1) ;=> 1
(magnitude -3/4) ;=> 3/4
(magnitude 1.83) ;=> 1.83
(magnitude -0.093) ;=> 0.093
(magnitude 3+4i) ;=> 5
(magnitude -2.663073699926266e-5+7.24999999995109i) ;=> 7.249999999999999
```

```scheme
procedure: (sqrt num)
returns: the principal square root of num
libraries: (rnrs base), (rnrs)
```

鼓励但不要求具体实现返回对应于精确的实际参数的精确结果.

例:

```scheme
(sqrt 16) ;=> 4
(sqrt 1/4) ;=> 1/2
(sqrt 4.84) ;=> 2.2
(sqrt -4.84) ;=> 0.0+2.2i
(sqrt 3+4i) ;=> 2+1i
(sqrt -3.0-4.0i) ;=> 1.0-2.0i
```

```scheme
procedure: (exact-integer-sqrt n)
returns: see below
libraries: (rnrs base), (rnrs)
```

返回两个非负的精确的整数`s`和`r`, 满足$n=s^{2}$且$n < (s+1)^{2}$.

例:

```scheme
(let-values (((s r) (exact-integer-sqrt 0))) (list s r)) ;=> (0 0)
(let-values (((s r) (exact-integer-sqrt 9))) (list s r)) ;=> (3 0)
(let-values (((s r) (exact-integer-sqrt 19))) (list s r)) ;=> (4 3)
```

```scheme
procedure: (exp num)
returns: e to the num power
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(exp 0.0) ;=> 1.0
(exp 1.0) ;=> 2.718281828459045
(exp -0.5) ;=> 0.6065306597126334
```

```scheme
procedure: (log num)
returns: the natural logarithm of num
procedure: (log num1 num2)
returns: the base-num2 logarithm of num1
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(log 1.0) ;=> 0.0
(log (exp 1.0)) ;=> 1.0
(/ (log 100) (log 10)) ;=> 2.0
(log (make-polar (exp 2.0) 1.0)) ;=> 2.0+0.9999999999999999i

(log 100.0 10.0) ;=> 2.0
(log 0.125 2.0) ;=> -3.0
```

```scheme
procedure: (sin num)
procedure: (cos num)
procedure: (tan num)
returns: the sine, cosine, or tangent of num
libraries: (rnrs base), (rnrs)
```

参数是弧度(radian).

例:

```scheme
(sin 0.0) ;=> 0.0
(cos 0.0) ;=> 1.0
(tan 0.0) ;=> 0.0
```

```scheme
procedure: (asin num)
procedure: (acos num)
returns: the arc sine or the arc cosine of num
libraries: (rnrs base), (rnrs)
```

结果是弧度(radian). 复数的反正弦(arc sine)和反余弦(arc cosine): 
$\texttt{sin}^{-1}(z) = -i \log(iz + \sqrt{1 - z^{2}})$ <br/>
$\texttt{cos}^{-1}(z) = \pi / 2 - \texttt{sin}^{-1}(z)$

例:

```scheme
(let ([pi (* (asin 1) 2)])
    (= (* (acos 0) 2) pi)) ;=> #t
```

```scheme
procedure: (atan num)            ; (1)
procedure: (atan real1 real2)    ; (2)
returns: see below
libraries: (rnrs base), (rnrs)
```

形式(1)中`num`为复数时, `atan`返回`num`的反正切(arc tangent). 复数的反正切: $\texttt{tan}^{-1}(z) = \frac{\log(1+iz) - \log(1-iz)}{2i}$.

形式(2)中, `atan`等价于`(lambda (y x) (angle (make-rectangular x y)))`.

例:

```scheme
(let ([pi (* (atan 1) 4)])
    (= (* (atan 1.0 0.0) 2) pi)) ;=> #t
```

```scheme
procedure: (bitwise-not exint)
returns: the bitwise not of exint
procedure: (bitwise-and exint ...)
returns: the bitwise and of exint ...
procedure: (bitwise-ior exint ...)
returns: the bitwise inclusive or of exint ...
procedure: (bitwise-xor exint ...)
returns: the bitwise exclusive or of exint ...
libraries: (rnrs arithmetic bitwise), (rnrs)
```

将参数视为2的补码形式表示.

例:

```scheme
(bitwise-not 0) ;=> -1
(bitwise-not 3) ;=> -4

(bitwise-and #b01101 #b00111) ;=> #b00101
(bitwise-ior #b01101 #b00111) ;=> #b01111
(bitwise-xor #b01101 #b00111) ;=> #b01010
```

```scheme
procedure: (bitwise-if exint1 exint2 exint3)
returns: the bitwise "if" of its arguments
libraries: (rnrs arithmetic bitwise), (rnrs)
```

将参数视为2的补码形式表示.

对于`exint1`中设置了的每个位, 结果中的相应位从`exint2`中获取; 对于`exint1`中没有设置的每个位, 结果中的相应位从`exint3`中获取.

例:

```scheme
(bitwise-if #b101010 #b111000 #b001100) ;=> #b101100
```

```scheme
procedure: (bitwise-bit-count exint)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

对于非负的参数, `bitwise-bit-count`返回`exint`的2的补码表示中设置了的位的数量.
对于负的参数, 返回一个负数, 其量等于`exint`的2的补码表示中未设置的位的数量+1, 等价于`(bitwise-not (bitwise-bit-count (bitwise-not exint)))`.

例:

```scheme
(bitwise-bit-count #b00000) ;=> 0
(bitwise-bit-count #b00001) ;=> 1
(bitwise-bit-count #b00100) ;=> 1
(bitwise-bit-count #b10101) ;=> 3

(bitwise-bit-count -1) ;=> -1
(bitwise-bit-count -2) ;=> -2
(bitwise-bit-count -4) ;=> -3
```

```scheme
procedure: (bitwise-length exint)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

返回`exint`的最小的2的补码表示的位的数量, 不包含负数的符号位. 对于0, `bitwise-length`返回0.

例:

```scheme
(bitwise-length #b00000) ;=> 0
(bitwise-length #b00001) ;=> 1
(bitwise-length #b00100) ;=> 3
(bitwise-length #b00110) ;=> 3

(bitwise-length -1) ;=> 0
(bitwise-length -6) ;=> 3
(bitwise-length -9) ;=> 4
```

```scheme
procedure: (bitwise-first-bit-set exint)
returns: the index of the least significant bit set in exint
libraries: (rnrs arithmetic bitwise), (rnrs)
```

将参数视为2的补码形式表示.
如果`exint`是0, `bitwise-first-bit`返回-1.

例:

```scheme
(bitwise-first-bit-set #b00000) ;=> -1
(bitwise-first-bit-set #b00001) ;=> 0
(bitwise-first-bit-set #b01100) ;=> 2

(bitwise-first-bit-set -1) ;=> 0
(bitwise-first-bit-set -2) ;=> 1
(bitwise-first-bit-set -3) ;=> 0
```

```scheme
procedure: (bitwise-bit-set? exint1 exint2)
returns: #t if bit exint2 of exint1 is set, #f otherwise
libraries: (rnrs arithmetic bitwise), (rnrs)
```

使用`exint2`作为`exint`的2的补码表示中从零开始的位索引值.
非负数的2的补码表示, 使用0向左(向着最大有效位)填充; 负数的2的补码表示, 使用1向左填充. 
因此, 精确的整数可以用于表示任意大的集(set), 0是空集, -1是全集, 使用`bitwise-bit-set?`测试成员关系.

例:

```scheme
(bitwise-bit-set? #b01011 0) ;=> #t
(bitwise-bit-set? #b01011 2) ;=> #f

(bitwise-bit-set? -1 0) ;=> #t
(bitwise-bit-set? -1 20) ;=> #t
(bitwise-bit-set? -3 1) ;=> #f

(bitwise-bit-set? 0 5000) ;=> #f
(bitwise-bit-set? -1 5000) ;=> #t
```

```scheme
procedure: (bitwise-copy-bit exint1 exint2 exint3)
returns: exint1 with bit exint2 replaced by exint3
libraries: (rnrs arithmetic bitwise), (rnrs)
```

使用`exint2`作为`exint`的2的补码表示中从零开始的位索引值. `exint3`必须是0或1.
这个过程根据`exint3`的值清除或者设置相应的位. `exint1`视为2的补码的表示.

例:

```scheme
(bitwise-copy-bit #b01110 0 1) ;=> #b01111
(bitwise-copy-bit #b01110 2 0) ;=> #b01010
```

```scheme
procedure: (bitwise-bit-field exint1 exint2 exint3)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

`exint2`和`exint3`必须是非负的, `exint2`必须不大于`exint3`.
返回从`exint1`中`exint2`开始(包含)到`exint3`结束(不包含)的位序列表示的数.
`exint1`视为2的补码的表示.

例:

```scheme
(bitwise-bit-field #b10110 0 3) ;=> #b00110
(bitwise-bit-field #b10110 1 3) ;=> #b00011
(bitwise-bit-field #b10110 2 3) ;=> #b00001
(bitwise-bit-field #b10110 3 3) ;=> #b00000
```

```scheme
procedure: (bitwise-copy-bit-field exint1 exint2 exint3 exint4)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

`exint2`和`exint3`必须是非负的, `exint2`必须不大于`exint3`.
返回将`exint1`中`exint2`开始(包含)到`exint3`结束(不包含)的`n`位序列替换为`exint4`中低端`n`位后的`exint1`.
`exint1`和`exint4`视为2的补码的表示.

例:

```scheme
(bitwise-copy-bit-field #b10000 0 3 #b10101) ;=> #b10101
(bitwise-copy-bit-field #b10000 1 3 #b10101) ;=> #b10010
(bitwise-copy-bit-field #b10000 2 3 #b10101) ;=> #b10100
(bitwise-copy-bit-field #b10000 3 3 #b10101) ;=> #b10000
```

```scheme
procedure: (bitwise-arithmetic-shift-right exint1 exint2)
returns: exint1 arithmetically shifted right by exint2 bits
procedure: (bitwise-arithmetic-shift-left exint1 exint2)
returns: exint1 shifted left by exint2 bits
libraries: (rnrs arithmetic bitwise), (rnrs)
```

`exint2`必须是非负的. `exint1`视为2的补码的表示.

例:

```scheme
(bitwise-arithmetic-shift-right #b10000 3) ;=> #b00010
(bitwise-arithmetic-shift-right -1 1) ;=> -1
(bitwise-arithmetic-shift-right -64 3) ;=> -8

(bitwise-arithmetic-shift-left #b00010 2) ;=> #b01000
(bitwise-arithmetic-shift-left -1 2) ;=> -4
```

```scheme
procedure: (bitwise-arithmetic-shift exint1 exint2)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

如果`exint2`是负值, `bitwise-arithmetic-shift`返回将`exint1`算术右移`-exint2`位的结果. 
否则, 返回将`exint1`左移`exint2`位的结果.
`exint1`视为2的补码的表示.

例:

```scheme
(bitwise-arithmetic-shift #b10000 -3) ;=> #b00010
(bitwise-arithmetic-shift -1 -1) ;=> -1
(bitwise-arithmetic-shift -64 -3) ;=> -8
(bitwise-arithmetic-shift #b00010 2) ;=> #b01000
(bitwise-arithmetic-shift -1 2) ;=> -4
```

```scheme
procedure: (bitwise-rotate-bit-field exint1 exint2 exint3 exint4)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

`exint2`、`exint3`和`exint4`必须是非负的, `exint2`必须不大于`exint3`.
将`exint1`中从`exint2`开始(包含)到`exint3`结束(不包含)左移`(mod exint4 (- exint3 exint2))`位, 移除范围的位插入范围的尾部, 这时返回`exint1`.    
`exint1`视为2的补码的表示.

例:

```scheme
(bitwise-rotate-bit-field #b00011010 0 5 3) ;=> #b00010110
(bitwise-rotate-bit-field #b01101011 2 7 3) ;=> #b01011011
```

```scheme
procedure: (bitwise-reverse-bit-field exint1 exint2 exint3)
returns: see below
libraries: (rnrs arithmetic bitwise), (rnrs)
```

`exint2`和`exint3`必须是非负的, `exint2`必须不大于`exint3`.
将`exint1`中从`exint2`开始(包含)到`exint3`结束(不包含)的位翻转, 这时返回`exint1`.
`exint1`视为2的补码的表示.

例:

```scheme
(bitwise-reverse-bit-field #b00011010 0 5) ;=> #b00001011
(bitwise-reverse-bit-field #b01101011 2 7) ;=> #b00101111
```

```scheme
procedure: (string->number string)
procedure: (string->number string radix)
returns: the number represented by string, or #f
libraries: (rnrs base), (rnrs)
```

如果`string`是一个数的有效表示, 返回这个数, 否则返回`#f`. 这个数的基数是`radix`, `radix`必须是取值为2、8、10、16的精确的整数, 默认值为10.
`string`中的基数描述符覆盖`radix`参数.

例:

```scheme
(string->number "0") ;=> 0
(string->number "3.4e3") ;=> 3400.0
(string->number "#x#e-2e2") ;=> -738
(string->number "#e-2e2" 16) ;=> -738
(string->number "#i15/16") ;=> 0.9375
(string->number "10" 16) ;=> 16
```

```scheme
procedure: (number->string num)
procedure: (number->string num radix)
procedure: (number->string num radix precision)
returns: an external representation of num as a string
libraries: (rnrs base), (rnrs)
```

`num`用基数`radix`表示, `radix`必须是取值为2、8、10、16的精确的整数, 默认值为10.
在结果字符串中不会出现基数描述符.

使用`string->number`将外部表示转换回数时, 结果数值等价于`num`. 即`(eqv? (string->number (number->string num radix) radix) num)`返回`#t`. 如果违背了这个约束, 抛出状况类型`&implementation-restriction`的异常.

如果指定了`precision`, 它必须是一个精确的正整数, `num`必须是非精确的, `radix`必须是10. 这种情况下, 数的实部(如果有的话)、虚部都使用显式的尾部宽度(mantissa width)`m`打印出, `m`是使得满足前述约束的大于或等于`precison`的最小值.

如果`radix`是10, `num`的非精确值使用在不违背前述约束前提下最少数量的有效数字表示.

例:

```scheme
(number->string 3.4) ;=> "3.4"
(number->string 1e2) ;=> "100.0"
(number->string 1e-23) ;=> "1e-23"
(number->string -7/2) ;=> "-7/2"
(number->string 220/9 16) ;=> "DC/9"
```


## 4.4 Fixnums

fixnums表示**固定范围内的精确整数**, 这个范围是个封闭区间$[-2^{w-1}, 2^{w-1} - 1]$, fixnum宽度`w`至少是24.
使用过程`fixnum-width`确定具体实现使用的`w`, 使用过程`least-fixnum`和`greatest-fixnum`确定这个固定范围的边界.

只操作fixnums的算术过程有前缀`fx`. 要求是fixnums的过程参数命名为`fx`.

除非特别说明, fixnums特定的过程的结果值是fixnums.
如果一个fixnum操作的结果值应该是一个fixnum, 但这个数学结果在fixnum的范围外, 抛出状况类型`&implementation-restriction`的异常.

fixnums上的位操作和移位操作使用2的补码(two's complement)表示, 尽管内部不一定使用这种表示.

```scheme
procedure: (fixnum? obj)
returns: #t if obj is a fixnum, #f otherwise
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fixnum? 0) ;=> #t
(fixnum? -1) ;=> #t
(fixnum? (- (expt 2 23))) ;=> #t
(fixnum? (- (expt 2 23) 1)) ;=> #t
```

```scheme
procedure: (least-fixnum)
returns: the least (most negative) fixnum supported by the implementation
procedure: (greatest-fixnum)
returns: the greatest (most positive) fixnum supported by the implementation
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fixnum? (- (least-fixnum) 1)) ;=> #f
(fixnum? (least-fixnum)) ;=> #t
(fixnum? (greatest-fixnum)) ;=> #t
(fixnum? (+ (greatest-fixnum) 1)) ;=> #f
```

```scheme
procedure: (fixnum-width)
returns: the implementation-dependent fixnum width
libraries: (rnrs arithmetic fixnums), (rnrs)
```

fixnum的宽度确定了fixnum范围的到校, 必须至少是24.

例:

```scheme
(define w (fixnum-width))
(= (least-fixnum) (- (expt 2 (- w 1)))) ;=> #t     
(= (greatest-fixnum) (- (expt 2 (- w 1)) 1)) ;=> #t
(>= w 24) ;=> #t
```

```scheme
procedure: (fx=? fx1 fx2 fx3 ...)
procedure: (fx<? fx1 fx2 fx3 ...)
procedure: (fx>? fx1 fx2 fx3 ...)
procedure: (fx<=? fx1 fx2 fx3 ...)
procedure: (fx>=? fx1 fx2 fx3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs arithmetic fixnums), (rnrs)
```

谓词`fx=?`在参数相等(equal)时返回`#t`.
谓词`fx<?`在参数单调递增(monotonically increasing)时返回`#t`.
谓词`fx>?`在参数单调递减(monotonically decreasing)时返回`#t`.
谓词`fx<=?`在参数单调非递减时返回`#t`.
谓词`fx>=?`在参数单调非递增时返回`#t`.
    
例:

```scheme
(fx=? 0 0) ;=> #t
(fx=? -1 1) ;=> #f
(fx<? (least-fixnum) 0 (greatest-fixnum)) ;=> #t
(let ((x 3)) (fx<=? 0 x 9)) ;=> #t
(fx>? 5 4 3 2 1) ;=> #t
(fx<=? 1 3 2) ;=> #f
(fx>=? 0 0 (least-fixnum)) ;=> #t
```

```scheme
procedure: (fxzero? fx)
returns: #t if fx is zero, #f otherwise
procedure: (fxpositive? fx)
returns: #t if fx is greater than zero, #f otherwise
procedure: (fxnegative? fx)
returns: #t if fx is less than zero, #f otherwise
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fxzero?`等价于`(lambda (x) (fx=? x 0))`.
`fxpositive?`等价于`(lambda (x) (fx>? x 0))`.
`fxnegative?`等价于`(lambda (x) (fx<? x 0))`.

例:

```scheme
(fxzero? 0) ;=> #t
(fxzero? 1) ;=> #f
(fxpositive? 128) ;=> #t
(fxpositive? 0) ;=> #f
(fxpositive? -1) ;=> #f
(fxnegative? -65) ;=> #t
(fxnegative? 0) ;=> #f
(fxnegative? 1) ;=> #f
```

```scheme
procedure: (fxeven? fx)
returns: #t if fx is even, #f otherwise
procedure: (fxodd? fx)
returns: #t if fx is odd, #f otherwise
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fxeven? 0) ;=> #t
(fxeven? 1) ;=> #f
(fxeven? -1) ;=> #f
(fxeven? -10) ;=> #t

(fxodd? 0) ;=> #f
(fxodd? 1) ;=> #t
(fxodd? -1) ;=> #t
(fxodd? -10) ;=> #f
```

```scheme
procedure: (fxmin fx1 fx2 ...)
returns: the minimum of fx1 fx2 ...
procedure: (fxmax fx1 fx2 ...)
returns: the maximum of fx1 fx2 ...
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fxmin 4 -7 2 0 -6) ;=> -7
(let ((ls (quote (7 3 5 2 9 8))))
  (apply fxmin ls)) ;=> 2
(fxmax 4 -7 2 0 -6) ;=> 4
(let ((ls (quote (7 3 5 2 9 8))))
  (apply fxmax ls)) ;=> 9
```

```scheme
procedure: (fx+ fx1 fx2)
returns: the sum of fx1 and fx2
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fx+ -3 4) ;=> 1
```

```scheme
procedure: (fx- fx)
returns: the additive inverse of fx
procedure: (fx- fx1 fx2)
returns: the difference between fx1 and fx2
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fx- 3) ;=> -3
(fx- -3 4) ;=> -7
```

```scheme
procedure: (fx* fx1 fx2)
returns: the product of fx1 and fx2
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fx* -3 4) ;=> -12
```

```scheme
procedure: (fxdiv fx1 fx2)
procedure: (fxmod fx1 fx2)
procedure: (fxdiv-and-mod fx1 fx2)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

fx2必须不为零. 这些过程是通用的`div`、`mod`和`div-and-mod`的fixnum特定版本.

例:

```scheme
(fxdiv 17 3) ;=> 5
(fxmod 17 3) ;=> 2
(fxdiv -17 3) ;=> -6
(fxmod -17 3) ;=> 1
(fxdiv 17 -3) ;=> -5
(fxmod 17 -3) ;=> 2
(fxdiv -17 -3) ;=> 6
(fxmod -17 -3) ;=> 1
(let-values (((d m) (fxdiv-and-mod 17 3)))
  (list d m)) ;=> (5 2)
```

```scheme
procedure: (fxdiv0 fx1 fx2)
procedure: (fxmod0 fx1 fx2)
procedure: (fxdiv0-and-mod0 fx1 fx2)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

fx2必须不为零. 这些过程是通用的`div0`、`mod0`和`div0-and-mod0`的fixnum特定版本.

例:

```scheme
(fxdiv0 17 3) ;=> 6
(fxmod0 17 3) ;=> -1
(fxdiv0 -17 3) ;=> -6
(fxmod0 -17 3) ;=> 1
(fxdiv0 17 -3) ;=> -6
(fxmod0 17 -3) ;=> -1
(fxdiv0 -17 -3) ;=> 6
(fxmod0 -17 -3) ;=> 1
(let-values (((d m) (fxdiv0-and-mod0 17 3))) 
  (list d m)) ;=> (6 -1)
```

```scheme
procedure: (fx+/carry fx1 fx2 fx3)
procedure: (fx-/carry fx1 fx2 fx3)
procedure: (fx*/carry fx1 fx2 fx3)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

当常规的fixnum加法、减法、乘法操作溢出(overflow)时, 抛出一个异常. 这些过程不抛出异常, 而是返回一个进位(carry), 并将进位传播到下一个操作. 这些过程用于实现可移植的多个精度算术的代码.

这些过程返回依据下面计算的两个fixnum值.
    
```scheme
; fx+/carry
(let* ([s (+ fx1 fx2 fx3)]
       [s0 (mod0 s (expt 2 (fixnum-width)))]
       [s1 (div0 s (expt 2 (fixnum-width)))])
  (values s0 s1))

; fx-/carry
(let* ([d (- fx1 fx2 fx3)]
       [d0 (mod0 d (expt 2 (fixnum-width)))]
       [d1 (div0 d (expt 2 (fixnum-width)))])
  (values d0 d1))

; fx*/carry
(let* ([s (+ (* fx1 fx2) fx3)] ; why not fx* ???
       [s0 (mod0 s (expt 2 (fixnum-width)))]
       [s1 (div0 s (expt 2 (fixnum-width)))])
  (values s0 s1))
```

```scheme
procedure: (fxnot fx)
returns: the bitwise not of fx
procedure: (fxand fx ...)
returns: the bitwise and of fx ...
procedure: (fxior fx ...)
returns: the bitwise inclusive or of fx ...
procedure: (fxxor fx ...)
returns: the bitwise exclusive or of fx ...
libraries: (rnrs arithmetic fixnums), (rnrs)
```

例:

```scheme
(fxnot 0) ;=> -1
(fxnot 3) ;=> -4

(fxand 13 7) ;=> 5
(fxior 13 7) ;=> 15
(fxxor 13 7) ;=> 10
```

```scheme
procedure: (fxif fx1 fx2 fx3)
returns: the bitwise "if" of its arguments
libraries: (rnrs arithmetic fixnums), (rnrs)
```

对`fx1`中每个设置了的位, 结果中相应的位从`fx2`中获得; 对`fx1`中每个没有设置的位, 结果中相应的位从`fx3`中获得.

例:

```scheme
(fxif #b101010 #b111000 #b001100) ;=> #b101100
```

```scheme
procedure: (fxbit-count fx)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

对于非负参数, `fxbit-count`返回`fx`的2的补码表示中设置了的位的数量.
对于负参数, 返回一个负数, 它的量是`fx`中未设置的位的数量+1, 等价于`(fxnot (fxbit-count (fxnot fx)))`.

例:

```scheme
(fxbit-count #b00000) ;=> 0
(fxbit-count #b00001) ;=> 1
(fxbit-count #b00100) ;=> 1
(fxbit-count #b10101) ;=> 3

(fxbit-count -1) ;=> -1
(fxbit-count -2) ;=> -2
(fxbit-count -4) ;=> -3
```

```scheme
procedure: (fxlength fx)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fxlength`返回`fx`的最小的2的补码表示中位的数量, 不包括负数的符号位. `(fxlength 0)`返回0.

例:

```scheme
(fxlength #b00000) ;=> 0
(fxlength #b00001) ;=> 1
(fxlength #b00100) ;=> 3
(fxlength #b00110) ;=> 3

(fxlength -1) ;=> 0
(fxlength -6) ;=> 3
(fxlength -9) ;=> 4
```

```scheme
procedure: (fxfirst-bit-set fx)
returns: the index of the least significant bit set in fx
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`(fxfirst-bit-set 0)`返回-1.

例:

```scheme
(fxfirst-bit-set #b00000) ;=> -1
(fxfirst-bit-set #b00001) ;=> 0
(fxfirst-bit-set #b01100) ;=> 2

(fxfirst-bit-set -1) ;=> 0
(fxfirst-bit-set -2) ;=> 1
(fxfirst-bit-set -3) ;=> 0
```

```scheme
procedure: (fxbit-set? fx1 fx2)
returns: #t if bit fx2 of fx1 is set, #f otherwise
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`必须是非负的, 它被用作`fx1`的2的补码表示中从0开始的索引, 其中符号位向左复制填充.
    
例:

```scheme
(fxbit-set? #b01011 0) ;=> #t
(fxbit-set? #b01011 2) ;=> #f

(fxbit-set? -1 0) ;=> #t
(fxbit-set? -1 20) ;=> #t
(fxbit-set? -3 1) ;=> #f
(fxbit-set? 0 (- (fixnum-width) 1)) ;=> #f
(fxbit-set? -1 (- (fixnum-width) 1)) ;=> #t
```

```scheme
procedure: (fxcopy-bit fx1 fx2 fx3)
returns: fx1 with bit fx2 replaced by fx3
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`必须是非负的, 且小于`(- (fixnum-width) 1)`.
`fx3`必须是0或1.
`fxcopy-bit`依据`fx3`的值, 清除或设置指定的位.
    
例:

```scheme
(fxcopy-bit #b01110 0 1) ;=> #b01111
(fxcopy-bit #b01110 2 0) ;=> #b01010
```

```scheme
procedure: (fxbit-field fx1 fx2 fx3)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`和`fx3`必须是非负数, 且小于`(fixnum-width)`, `fx2`必须不大于`fx3`.
`fxbit-field`返回从`fx1`中提取的从`fx2`(包含)到`fx3`(不包含)的位序列表示的数.

例:

```scheme
(fxbit-field #b10110 0 3) ;=> #b00110
(fxbit-field #b10110 1 3) ;=> #b00011
(fxbit-field #b10110 2 3) ;=> #b00001
(fxbit-field #b10110 3 3) ;=> #b00000
```

```scheme
procedure: (fxcopy-bit-field fx1 fx2 fx3 fx4)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`和`fx3`必须是非负的, 且小于`(fixnum-width)`, `fx2`必须不大于`fx3`. 
`fxcopy-bit-field`将`fx1`中从`fx2`(包含)到`fx3`(不包含)的n位替换为`fx4`中低端的n位, 返回`fx1`.

例:

```scheme
(fxcopy-bit-field #b10000 0 3 #b10101) ;=> #b10101
(fxcopy-bit-field #b10000 1 3 #b10101) ;=> #b10010
(fxcopy-bit-field #b10000 2 3 #b10101) ;=> #b10100
(fxcopy-bit-field #b10000 3 3 #b10101) ;=> #b10000
```

```scheme
procedure: (fxarithmetic-shift-right fx1 fx2)
returns: fx1 arithmetically shifted right by fx2 bits
procedure: (fxarithmetic-shift-left fx1 fx2)
returns: fx1 shifted left by fx2 bits
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`必须是非负的, 且小于`(fixnum-width)`.

例:

```scheme
(fxarithmetic-shift-right #b10000 3) ;=> #b00010
(fxarithmetic-shift-right -1 1) ;=> -1
(fxarithmetic-shift-right -64 3) ;=> -8

(fxarithmetic-shift-left #b00010 2) ;=> #b01000
(fxarithmetic-shift-left -1 2) ;=> -4
```

```scheme
procedure: (fxarithmetic-shift fx1 fx2)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`的绝对值必须小于`(fixnum-width)`.
如果`fx2`是负值, `fxarithmetic-shift`返回将`fx1`算术右移`fx2`位的结果; 否则, 返回将`fx1`左移`fx2`位的结果.

例:

```scheme
(fxarithmetic-shift #b10000 -3) ;=> #b00010
(fxarithmetic-shift -1 -1) ;=> -1
(fxarithmetic-shift -64 -3) ;=> -8
(fxarithmetic-shift #b00010 2) ;=> #b01000
(fxarithmetic-shift -1 2) ;=> -4
```

```scheme
    procedure: (fxrotate-bit-field fx1 fx2 fx3 fx4)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`、`fx3`和`fx4`必须是非负的, 且小于`(fixnum-width)`, `fx2`必须不大于`fx3`, `fx4`必须不大于`fx3`与`fx2`的差值.

`fxrotate-bit-field`将`fx1`中从`fx2`(包含)到`fx3`(不包含)左移`fx4`位, 将移出范围的位插入范围的尾部后, 返回`fx1`.        

例:

```scheme
(fxrotate-bit-field #b00011010 0 5 3) ;=> #b00010110
(fxrotate-bit-field #b01101011 2 7 3) ;=> #b01011011
```

```scheme
procedure: (fxreverse-bit-field fx1 fx2 fx3)
returns: see below
libraries: (rnrs arithmetic fixnums), (rnrs)
```

`fx2`和`fx3`必须是非负的, 且小于`(fixnum-width)`, `fx2`必须不大于`fx3`.

这个过程将`fx1`中从`fx2`(包含)到`fx3`(不包含)的位翻转后返回`fx1`.

例:

```scheme
(fxreverse-bit-field #b00011010 0 5) ;=> #b00001011
(fxreverse-bit-field #b01101011 2 7) ;=> #b00101111
```

## 4.5 Flonums

Introduction:

flonums表示**非精确的实数**.
具体实现需要将任意词法不包含`|`(vertical bar)和除`e`之外的指数标记的非精确实数表示为flonum.

实现通常为flonum使用IEEE双精度浮点数表示, 但实现不要求这样做, 甚至不要求使用浮点数表示.

flonum特定的过程的名称有前缀`fl`. 要求是flonums的过程参数命名为`fl`.

除非特别说明, flonum特定过程的结果值是flonum.

```scheme
procedure: (flonum? obj)
returns: #t if obj is a flonum, otherwise #f
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flonum? 0) ;=> #f
(flonum? 3/4) ;=> #f
(flonum? 3.5) ;=> #t
(flonum? 0.02) ;=> #t
(flonum? 1e10) ;=> #t
(flonum? 3.0+0.0i) ;=> #f
```

```scheme
procedure: (fl=? fl1 fl2 fl3 ...)
procedure: (fl<? fl1 fl2 fl3 ...)
procedure: (fl>? fl1 fl2 fl3 ...)
procedure: (fl<=? fl1 fl2 fl3 ...)
procedure: (fl>=? fl1 fl2 fl3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

谓词`fl=?`在参数相等(equal)时返回`#t`.
谓词`fl<?`在参数单调递增(monotonically increasing)时返回`#t`.
谓词`fl>?`在参数单调递减(monotonically decreasing)时返回`#t`.
谓词`fl<=?`在参数单调非递减时返回`#t`.
谓词`fl>=?`在参数单调非递增时返回`#t`.

与NaN的比较总是返回`#f`.

例:

```scheme
(fl=? 0.0 0.0) ;=> #t
(fl<? -1.0 0.0 1.0) ;=> #t        
(fl>? -1.0 0.0 1.0) ;=> #f        
(fl<=? 0.0 3.0 3.0) ;=> #t        
(fl>=? 4.0 3.0 3.0) ;=> #t        
(fl<? 7.0 +inf.0) ;=> #t
(fl=? +nan.0 0.0) ;=> #f
(fl=? +nan.0 +nan.0) ;=> #f       
(fl<? +nan.0 +nan.0) ;=> #f       
(fl<=? +nan.0 +inf.0) ;=> #f      
(fl>=? +nan.0 +inf.0) ;=> #f
```

```scheme
procedure: (flzero? fl)
returns: #t if fl is zero, #f otherwise
procedure: (flpositive? fl)
returns: #t if fl is greater than zero, #f otherwise
procedure: (flnegative? fl)
returns: #t if fl is less than zero, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

`flzero?`等价于`(lambda (x) (fl=? x 0))`.
`flpositive?`等价于`(lambda (x) (fl>? x 0))`.
`flnegative?`等价于`(lambda (x) (fl<? x 0))`.

例:

```scheme
(flzero? 0.0) ;=> #t
(flzero? 1.0) ;=> #f

(flpositive? 128.0) ;=> #t
(flpositive? 0.0) ;=> #f
(flpositive? -1.0) ;=> #f

(flnegative? -65.0) ;=> #t
(flnegative? 0.0) ;=> #f
(flnegative? 1.0) ;=> #f

(flzero? -0.0) ;=> #t
(flnegative? -0.0) ;=> #f

(flnegative? +nan.0) ;=> #f
(flzero? +nan.0) ;=> #f
(flpositive? +nan.0) ;=> #f

(flnegative? +inf.0) ;=> #f
(flnegative? -inf.0) ;=> #t
```

```scheme
procedure: (flinteger? fl)
returns: #t if fl is integer, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flinteger? 0.0) ;=> #t
(flinteger? -17.0) ;=> #t
(flinteger? +nan.0) ;=> #f
(flinteger? +inf.0) ;=> #f
```

```scheme
procedure: (flfinite? fl)
returns: #t if fl is finite, #f otherwise
procedure: (flinfinite? fl)
returns: #t if fl is infinite, #f otherwise
procedure: (flnan? fl)
returns: #t if fl is a NaN, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flfinite? 3.1415) ;=> #t
(flinfinite? 3.1415) ;=> #f
(flnan? 3.1415) ;=> #f

(flfinite? +inf.0) ;=> #f
(flinfinite? -inf.0) ;=> #t
(flnan? -inf.0) ;=> #f

(flfinite? +nan.0) ;=> #f
(flinfinite? +nan.0) ;=> #f
(flnan? +nan.0) ;=> #t
```

```scheme
procedure: (fleven? fl-int)
returns: #t if fl-int is even, #f otherwise
procedure: (flodd? fl-int)
returns: #t if fl-int is odd, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

`fl-int`必须是整数值的flonum.

例:

```scheme
(fleven? 0.0) ;=> #t
(fleven? 1.0) ;=> #f
(fleven? -1.0) ;=> #f
(fleven? -10.0) ;=> #t
(flodd? 0.0) ;=> #f
(flodd? 1.0) ;=> #t
(flodd? -1.0) ;=> #t
(flodd? -10.0) ;=> #f
```

```scheme
procedure: (flmin fl1 fl2 ...)
returns: the minimum of fl1 fl2 ...
procedure: (flmax fl1 fl2 ...)
returns: the maximum of fl1 fl2 ...
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flmin 4.2 -7.5 2.0 0.0 -6.4) ;=> -7.5

(let ((ls (quote (7.1 3.5 5.0 2.6 2.6 8.0)))) 
  (apply flmin ls)) ;=> 2.6

(flmax 4.2 -7.5 2.0 0.0 -6.4) ;=> 4.2

(let ((ls (quote (7.1 3.5 5.0 2.6 2.6 8.0)))) 
  (apply flmax ls)) ;=> 8.0
```

```scheme
procedure: (fl+ fl ...)
returns: the sum of the arguments fl ...
libraries: (rnrs arithmetic flonums), (rnrs)
```

`(fl+)`返回0.0.

例:

```scheme
(fl+) ;=> 0.0
(fl+ 1.0 2.5) ;=> 3.5
(fl+ 3.0 4.25 5.0) ;=> 12.25
(apply fl+ (quote (1.0 2.0 3.0 4.0 5.0))) ;=> 15.0
```

```scheme
procedure: (fl- fl)
returns: the additive inverse of fl
procedure: (fl- fl1 fl2 fl3 ...)
returns: the difference between fl1 and the sum of fl2 fl3 ...
libraries: (rnrs arithmetic flonums), (rnrs)
```

使用IEEE浮点数表示的flonum, 单个参数的`fl-`等价于`(lambda (x) (fl* -1.0 x))`或`(lambda (x) (fl- -0.0 x))`; 但不等价于`(lambda (x) (fl- 0.0 x))`, 因为对于0.0, 应该返回-0.0, 而不是这种表示返回的0.0.

例:

```scheme
(fl- 0.0) ;=> -0.0
(fl- 3.0) ;=> -3.0
(fl- 4.0 3.0) ;=> 1.0
(fl- 4.0 3.0 2.0 1.0) ;=> -2.0
```

```scheme
procedure: (fl* fl ...)
returns: the product of the arguments fl ...
libraries: (rnrs arithmetic flonums), (rnrs)
```

`(fl*)`返回1.0.

例:

```scheme
(fl*) ;=> 1.0
(fl* 1.5 2.5) ;=> 3.75
(fl* 3.0 -4.0 5.0) ;=> -60.0
(apply fl* (quote (1.0 -2.0 3.0 -4.0 5.0))) ;=> 120.0
```

```scheme
procedure: (fl/ fl)
returns: the multiplicative inverse of fl
procedure: (fl/ fl1 fl2 fl3 ...)
returns: the result of dividing fl1 by the product of fl2 fl3 ...
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(fl/ -4.0) ;=> -0.25
(fl/ 8.0 -2.0) ;=> -4.0
(fl/ -9.0 2.0) ;=> -4.5
(fl/ 60.0 5.0 3.0 2.0) ;=> 2.0
```

```scheme
procedure: (fldiv fl1 fl2)
procedure: (flmod fl1 fl2)
procedure: (fldiv-and-mod fl1 fl2)
returns: see below
libraries: (rnrs arithmetic flonums), (rnrs)
```

这些过程是通用的`div`、`mod`和`div-and-mod`的flonum特定版本.

例:

```scheme
(fldiv 17.0 3.0) ;=> 5.0
(flmod 17.0 3.0) ;=> 2.0
(fldiv -17.0 3.0) ;=> -6.0
(flmod -17.0 3.0) ;=> 1.0
(fldiv 17.0 -3.0) ;=> -5.0
(flmod 17.0 -3.0) ;=> 2.0
(fldiv -17.0 -3.0) ;=> 6.0
(flmod -17.0 -3.0) ;=> 1.0
(let-values (((d m) (fldiv-and-mod 17.5 3.75))) 
  (list d m)) ;=> (4.0 2.5)
```

```scheme
procedure: (fldiv0 fl1 fl2)
procedure: (flmod0 fl1 fl2)
procedure: (fldiv0-and-mod0 fl1 fl2)
returns: see below
libraries: (rnrs arithmetic flonums), (rnrs)
```

这些过程是通用的`div0`、`mod0`和`div0-and-mod0`的flonum特定版本.

例:

```scheme
(fldiv0 17.0 3.0) ;=> 6.0
(flmod0 17.0 3.0) ;=> -1.0
(fldiv0 -17.0 3.0) ;=> -6.0
(flmod0 -17.0 3.0) ;=> 1.0
(fldiv0 17.0 -3.0) ;=> -6.0
(flmod0 17.0 -3.0) ;=> -1.0
(fldiv0 -17.0 -3.0) ;=> 6.0
(flmod0 -17.0 -3.0) ;=> 1.0
(let-values (((d m) (fldiv0-and-mod0 17.5 3.75))) 
  (list d m)) ;=> (5.0 -1.25)
```

```scheme
procedure: (flround fl)
returns: the integer closest to fl
procedure: (fltruncate fl)
returns: the integer closest to fl toward zero
procedure: (flfloor fl)
returns: the integer closest to fl toward -∞
procedure: (flceiling fl)
returns: the integer closest to fl toward +∞
libraries: (rnrs arithmetic flonums), (rnrs)
```

如果`fl`是整数、NaN或无穷, 这些过程返回`fl`.
如果`fl`正好在两个整数中间, `flround`返回最接近的偶整数.

例:

```scheme
(flround 17.3) ;=> 17.0
(flround -17.3) ;=> -17.0
(flround 2.5) ;=> 2.0
(flround 3.5) ;=> 4.0
(fltruncate 17.3) ;=> 17.0
(fltruncate -17.3) ;=> -17.0
(flfloor 17.3) ;=> 17.0
(flfloor -17.3) ;=> -18.0
(flceiling 17.3) ;=> 18.0
(flceiling -17.3) ;=> -17.0
```

```scheme
procedure: (flnumerator fl)
returns: the numerator of fl
procedure: (fldenominator fl)
returns: the denominator of fl
libraries: (rnrs arithmetic flonums), (rnrs)
```

如果`fl`是整数(包括0.0)或无穷, 分子是`fl`, 分母是1.0.

例:

```scheme
(flnumerator -9.0) ;=> -9.0
(fldenominator -9.0) ;=> 1.0
(flnumerator 0.0) ;=> 0.0
(fldenominator 0.0) ;=> 1.0
(flnumerator -inf.0) ;=> -inf.0
(fldenominator -inf.0) ;=> 1.0
```

下面对IEEE浮点数成立, 不要求其它flonum表示也如此处理.

```scheme
(flnumerator 3.5) ;=> 7.0
(fldenominator 3.5) ;=> 2.0
```

```scheme
procedure: (flabs fl)
returns: absolute value of fl
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flabs 3.2) ;=> 3.2
(flabs -2e-20) ;=> 2e-20
```

```scheme
procedure: (flexp fl)
returns: e to the fl power
procedure: (fllog fl)
returns: the natural logarithm of fl
procedure: (fllog fl1 fl2)
returns: the base-fl2 logarithm of fl1
libraries: (rnrs arithmetic flonums), (rnrs)
```

例:

```scheme
(flexp 0.0) ;=> 1.0
(flexp 1.0) ;=> 2.718281828459045

(fllog 1.0) ;=> 0.0
(fllog (exp 1.0)) ;=> 1.0
(fl/ (fllog 100.0) (fllog 10.0)) ;=> 2.0

(fllog 100.0 10.0) ;=> 2.0
(fllog 0.125 2.0) ;=> -3.0
```

```scheme
procedure: (flsin fl)
returns: the sine of fl
procedure: (flcos fl)
returns: the cosine of fl
procedure: (fltan fl)
returns: the tangent of fl
libraries: (rnrs arithmetic flonums), (rnrs)
```

```scheme
procedure: (flasin fl)
returns: the arc sine of fl
procedure: (flacos fl)
returns: the arc cosine of fl
procedure: (flatan fl)
returns: the arc tangent of fl
procedure: (flatan fl1 fl2)
returns: the arc tangent of fl1/fl2
libraries: (rnrs arithmetic flonums), (rnrs)
```

```scheme
procedure: (flsqrt fl)
returns: the principal square root of fl
libraries: (rnrs arithmetic flonums), (rnrs)
```

返回`fl`的主方根(principal square root).
`(flsqrt -0.0)`返回-0.0. 其它负数的结果可以是NaN或其它未描述的flonum.

例:

```scheme
(flsqrt 4.0) ;=> 2.0
(flsqrt 0.0) ;=> 0.0
(flsqrt -0.0) ;=> -0.0
```

```scheme
procedure: (flexpt fl1 fl2)
returns: fl1 raised to the fl2 power
libraries: (rnrs arithmetic flonums), (rnrs)
```

如果`fl1`是负值, `fl2`不是一个整数, 结果可以是NaN或其它未描述的flonum.
如果`fl1`和`fl2`都为零, 结果为1.0.
如果`fl1`为零, `fl2`是正值, 结果为零.
其它情况下, 如果`fl1`为零, 结果可以是NaN或其它未描述的flonum.

例:

```scheme
(flexpt 3.0 2.0) ;=> 9.0
(flexpt 0.0 +inf.0) ;=> 0.0
```

```scheme
procedure: (fixnum->flonum fx)
returns: the flonum representation closest to fx
procedure: (real->flonum real)
returns: the flonum representation closest to real
libraries: (rnrs arithmetic flonums), (rnrs)
```

`fixnum->flonum`是`inexact`受限的变体.
当参数是精确的实数时, `real->flonum`是`inexact`受限的变体; 当参数是非精确的非flonum的实数时, 将参数转换为最接近的flonum.

例:

```scheme
(fixnum->flonum 0) ;=> 0.0
(fixnum->flonum 13) ;=> 13.0
(real->flonum -1/2) ;=> -0.5
(real->flonum 1000.0) ;=> 1000.0
```

## 4.6 Characters

Introduction:

字符是原子对象(atomic objects), 表示字母(letter)、数字(digit)、诸如`$`或`-`的特殊符号(symbol)、诸如空白或换行的非图形化控制字符(nongraphic control character).
字符使用前缀`#\`书写. 对于大部分字符, 前缀之后是字符本身. 字母`A`的书写形式是`#\A`.
换行、空格、制表字符可以使用相同的方式书写, 但也可以使用`#\newline`、`#\space`、`#\tab`清晰的书写出.
Unicode字符使用语法`#\xn`书写, `n`由一个或多个表示有效的Unicode标量值的十六进制数字构成.

```scheme
procedure: (char=? char1 char2 char3 ...)
procedure: (char<? char1 char2 char3 ...)
procedure: (char>? char1 char2 char3 ...)
procedure: (char<=? char1 char2 char3 ...)
procedure: (char>=? char1 char2 char3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs base), (rnrs)
```

这些谓词的行为与数值谓词`=`、`<`、`>`、`<=`、`>=`类似. 例如, `char=?`在其参数是等价的字符时返回`#t`, `char<?`在其参数是单调递增字符值(Unicode标量值)时返回`#t`.

例:

```scheme
(char>? #\a #\b) ;=> #f
(char<? #\a #\b) ;=> #t
(char<? #\a #\b #\c) ;=> #t
(let ([c #\r])
(char<=? #\a c #\z)) ;=> #t
(char<=? #\Z #\W) ;=> #f
(char=? #\+ #\+) ;=> #t
```

```scheme
procedure: (char-ci=? char1 char2 char3 ...)
procedure: (char-ci<? char1 char2 char3 ...)
procedure: (char-ci>? char1 char2 char3 ...)
procedure: (char-ci<=? char1 char2 char3 ...)
procedure: (char-ci>=? char1 char2 char3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs unicode), (rnrs)
```

这些谓词与`char=?`、`char<?`、`char>?`、`char<=?`、char>=?`等同, 除了是大小写不敏感的(case-insensitive), 即, 比较其参数的大小折叠的(case-folded)版本. 例如, `char=?`将`#\a`和`#\A`视为不同的值, 而`char-ci=?`不会.

例:

```scheme
(char-ci<? #\a #\B) ;=> #t
(char-ci=? #\W #\w) ;=> #t
(char-ci=? #\= #\+) ;=> #f
(let ([c #\R])
(list (char<=? #\a c #\z)
        (char-ci<=? #\a c #\z))) ;=> (#f #t)
```

```scheme
procedure: (char-alphabetic? char)
returns: #t if char is a letter, #f otherwise
procedure: (char-numeric? char)
returns: #t if char is a digit, #f otherwise
procedure: (char-whitespace? char)
returns: #t if char is whitespace, #f otherwise
libraries: (rnrs unicode), (rnrs)
```

一个字符是字母(alphabetic), 仅当它有Unicode Alphabetic属性;
一个字符是数字(numeric), 仅当它有Unicode Numeric属性;
一个字符是空白(whitespace), 仅当它有Unicode White_Space属性.

例:

```scheme
(char-alphabetic? #\a) ;=> #t
(char-alphabetic? #\T) ;=> #t
(char-alphabetic? #\8) ;=> #f
(char-alphabetic? #\$) ;=> #f 

(char-numeric? #\7) ;=> #t
(char-numeric? #\2) ;=> #t
(char-numeric? #\X) ;=> #f
(char-numeric? #\space) ;=> #f 

(char-whitespace? #\space) ;=> #t
(char-whitespace? #\newline) ;=> #t
(char-whitespace? #\Z) ;=> #f
```

```scheme
procedure: (char-lower-case? char)
returns: #t if char is lower case, #f otherwise
procedure: (char-upper-case? char)
returns: #t if char is upper case, #f otherwise
procedure: (char-title-case? char)
returns: #t if char is title case, #f otherwise
libraries: (rnrs unicode), (rnrs)
```

一个字符是大写的(upper-case), 仅当它有Unicode Uppercase属性;
一个字符是小写的(lower-case), 仅当它有Unicode Lowercase属性;
一个字符是标题大小写的(title-case), 仅当它属于Lt通用类别(general category).

例:

```scheme
(char-lower-case? #\r) ;=> #t
(char-lower-case? #\R) ;=> #f 

(char-upper-case? #\r) ;=> #f
(char-upper-case? #\R) ;=> #t 

(char-title-case? #\I) ;=> #f
(char-title-case? #\x01C5) ;=> #t
```

```scheme
procedure: (char-general-category char)
returns: a symbol representing the Unicode general category of char
libraries: (rnrs unicode), (rnrs)
```

返回值是这些符号中的一个: `Lu`、`Ll`、`Lt`、`Lm`、`Lo`、`Mn`、`Mc`、`Me`、`Nd`、`Nl`、`No`、`Ps`、`Pe`、`Pi`、`Pf`、`Pd`、`Pc`、`Po`、`Sc`、`Sm`、`Sk`、`So`、`Zs`、`Zp`、`Zl`、`Cc`、`Cf`、`Cs`、`Co`、`Cn`.

例:

```scheme
(char-general-category #\a) ;=> Ll
(char-general-category #\space) ;=> Zs
(char-general-category #\x10FFFF) ;=> Cn  
```

```scheme
procedure: (char-upcase char)
returns: the upper-case character counterpart of char
libraries: (rnrs unicode), (rnrs)
```

如果`char`是小写或标题大小写的字符, 有单个对应的大写字符, 则`char-upcase`返回这个大写字符; 否则, 返回`char`.

例:

```scheme
(char-upcase #\g) ;=> #\G
(char-upcase #\G) ;=> #\G
(char-upcase #\7) ;=> #\7
(char-upcase #\ς) ;=> #\Σ
```

```scheme
procedure: (char-downcase char)
returns: the lower-case character equivalent of char
libraries: (rnrs unicode), (rnrs)
```

如果`char`是大写或标题大小写的字符, 有单个对应的小写字符, 则`char-upcase`返回这个小写字符; 否则, 返回`char`.

例:

```scheme
(char-downcase #\g) ;=> #\g
(char-downcase #\G) ;=> #\g
(char-downcase #\7) ;=> #\7
(char-downcase #\ς) ;=> #\ς
```

```scheme
procedure: (char-titlecase char)
returns: the title-case character equivalent of char
libraries: (rnrs unicode), (rnrs)
```

如果`char`是大写或小写的字符, 有单个对应的标题大小写的字符, 则`char-upcase`返回这个标题大小写的字符; 
否则, 如果`char`不是一个标题大小写的字符, 没有单个标题大小写的字符, 但有单个对应的大写字符, 则返回这个大写字符;
否则, 返回`char`.

例:

```scheme
(char-titlecase #\g) ;=> #\G
(char-titlecase #\G) ;=> #\G
(char-titlecase #\7) ;=> #\7
(char-titlecase #\ς) ;=> #\Σ
```

```scheme
procedure: (char-foldcase char)
returns: the case-folded character equivalent of char
libraries: (rnrs unicode), (rnrs)
```

如果`char`有一个对应的大小写折叠的字符, `char-foldcase`返回这个字符; 否则, 返回`char.
对于大多数字符, `(char-foldcase char)`等价于`(char-downcase (char-upcase char))`.

例:

```scheme
(char-foldcase #\g) ;=> #\g
(char-foldcase #\G) ;=> #\g
(char-foldcase #\7) ;=> #\7
(char-foldcase #\ς) ;=> #\σ
```

```scheme
procedure: (char->integer char)
returns: the Unicode scalar value of char as an exact integer
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(char->integer #\newline) ;=> 10
(char->integer #\space) ;=> 32
(- (char->integer #\Z) (char->integer #\A)) ;=> 25
```

```scheme
procedure: (integer->char n)
returns: the character corresponding to the Unicode scalar value n
libraries: (rnrs base), (rnrs)
```

`n`必须是一个精确的整数和一个有效的Unicode标量值, 即 $0 \le n \le #xD7FF$ 或 $#xE000 \le n \le 10FFFF$.

例:

```scheme
(integer->char 48) ;=> #\0
(integer->char #x3BB) ;=> #\λ
```

## 4.7 Strings

??? quote "Introduction"

字符串是字符序列.

字符串写作包裹在一对双引号`""`内的字符序列, 例如`"hi there"`.
在字符串中使用反斜杠`\`引入双引号`"`, 例如`"tow \"quotes\" within"`.
反斜杠之前也可以有反斜杠, 例如`"a \\slash"`.
多个特殊字符可以书写为两个字符的序列, 例如 `\n`表示换行、`\r`表示回车、`\t`表示制表符.
Unicode字符使用语法`\xn`, `n`由一个或多个表示有效的Unicode标量值的十六进制数字构成.

字符串由精确的非负整数索引, 第一个元素的索引为0, 最大的有效索引是其长度-1.

```scheme
procedure: (string=? string1 string2 string3 ...)
procedure: (string<? string1 string2 string3 ...)
procedure: (string>? string1 string2 string3 ...)
procedure: (string<=? string1 string2 string3 ...)
procedure: (string>=? string1 string2 string3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs base), (rnrs)
```

与数值谓词`=`、`<`、`>`、`<=`、`>=`类似, 这些谓词表达其参数之间的关系. 例如, `string>?`确定其参数的词典序(lexicographic ordering)是否是单调递减的.

这些比较是基于字符谓词`char=?`和`char<?`的.
两个字符串是词典序等价的(lexicographically equivalent), 仅当它们有相同的长度且由`char=?`意义下相同的字符序列构成.
如果两个字符串仅是长度不同, 较短的字符串被视为词典序上小于较长的字符串.
否则, 在第一个`char=?`意义上不同的字符位置, 由`char<?`比较的结果给出字符串的词典序.

例:

```scheme
(string=? "mom" "mom") ;=> #t
(string<? "mom" "mommy") ;=> #t
(string>? "Dad" "Dad") ;=> #f
(string=? "Mom and Dad" "mom and dad") ;=> #f
(string<? "a" "b" "c") ;=> #t
```

```scheme
procedure: (string-ci=? string1 string2 string3 ...)
procedure: (string-ci<? string1 string2 string3 ...)
procedure: (string-ci>? string1 string2 string3 ...)
procedure: (string-ci<=? string1 string2 string3 ...)
procedure: (string-ci>=? string1 string2 string3 ...)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs unicode), (rnrs)
```

这些谓词等同与`string=?`、`string<?`、`string>?`、`string<=?`、`string>=?`, 除了它们是大小写不敏感的, 即比较其参数的大小写折叠的版本.

例:

```scheme
(string-ci=? "Mom and Dad" "mom and dad") ;=> #t
(string-ci<=? "say what" "Say What!?") ;=> #t
(string-ci>? "N" "m" "L" "k") ;=> #t
(string-ci=? "Straße" "Strasse") ;=> #t
```

```scheme
procedure: (string char ...)
returns: a string containing the characters char ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(string) ;=> ""
(string #\a #\b #\c) ;=> "abc"
(string #\H #\E #\Y #\!) ;=> "HEY!"
```

```scheme
procedure: (make-string n)
procedure: (make-string n char)
returns: a string of length n
libraries: (rnrs base), (rnrs)
```

`n`必须是一个精确的非负整数. 如果提供了`char`参数, 返回由`n`个`char`构成的字符串; 否则, 字符串中的字符是未描述的.

例:

```scheme
(make-string 0) ;=> ""
(make-string 0 #\x) ;=> ""
(make-string 5 #\x) ;=> "xxxxx"
```

```scheme
procedure: (string-length string)
returns: the number of characters in string
libraries: (rnrs base), (rnrs)
```

字符串的长度总是一个精确的非负整数.

例:

```scheme
(string-length "abc") ;=> 3
(string-length "") ;=> 0
(string-length "hi there") ;=> 8
(string-length (make-string 1000000)) ;=> 1000000
```

```scheme
procedure: (string-ref string n)
returns: the nth character (zero-based) of string
libraries: (rnrs base), (rnrs)
```

`n`必须是一个小于`string`长度的精确的非负整数.

例:

```scheme
(string-ref "hi there" 0) ;=> #\h
(string-ref "hi there" 5) ;=> #\e
```

```scheme
procedure: (string-set! string n char)
returns: unspecified
libraries: (rnrs mutable-strings)
```

`n`必须是一个小于`string`长度的精确的非负整数.
`string-set!`将`string`的第`n`个元素设置为`char`.

例:

```scheme
(let ([str (string-copy "hi three")])
  (string-set! str 5 #\e)
  (string-set! str 6 #\r)
  str) ;=> "hi there"
```

```scheme
procedure: (string-copy string)
returns: a new copy of string
libraries: (rnrs base), (rnrs)
```

`string-copy`创建一个与`string`有相同长度和相同内容的新字符串.

例:

```scheme
(string-copy "abc") ;=> "abc" 

(let ([str "abc"])
  (eq? str (string-copy str))) ;=> #f
```

```scheme
procedure: (string-append string ...)
returns: a new string formed by concatenating the strings string ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(string-append) ;=> ""
(string-append "abc" "def") ;=> "abcdef"
(string-append "Hey " "you " "there!") ;=> "Hey you there!"
```

```scheme
procedure: (substring string start end)
returns: a copy of string from start (inclusive) to end (exclusive)
libraries: (rnrs base), (rnrs)
```

`start`和`end`必须是精确的非负整数, `start`必须小于等于`end`, `end`必须小于等于`string`的长度.
如果`end`等于`start`, 返回长度为0的字符串.

例:

```scheme
(substring "hi there" 0 1) ;=> "h"
(substring "hi there" 3 6) ;=> "the"
(substring "hi there" 5 5) ;=> "" 

(let ([str "hi there"])
(let ([end (string-length str)])
  (substring str 0 end))) ;=> "hi there"
```

```scheme
procedure: (string-fill! string char)
returns: unspecified
libraries: (rnrs mutable-strings)
```

`string-fill!`将`string`中的每个字符设置为`char`.

例:

```scheme
(let ([str (string-copy "sleepy")])
  (string-fill! str #\Z)
  str) ;=> "ZZZZZZ"
```

```scheme
procedure: (string-upcase string)
returns: the upper-case equivalent of string
procedure: (string-downcase string)
returns: the lower-case equivalent of string
procedure: (string-foldcase string)
returns: the case-folded equivalent of string
procedure: (string-titlecase string)
returns: the title-case equivalent of string
libraries: (rnrs unicode), (rnrs)
```

这些实现Unicode的地区独立的(locale-independent)从标量值序列到另一个标量值序列的大小写映射(case mapping).
这些映射并不总是将单个字符映射为单个字符, 所以结果字符串的长度可能与`string`的长度不同.
如果结果字符串在`string=?`意义上与`string`相同, 返回`string`或`string`的一个拷贝; 否则, 总是返回一个新分配的字符串.

`string-titlecase`将将每个单词(word)的首个字符转换为其对应的标题大小写的字符, 将其它字符传唤为其对应的小写字符.
单词边界的识别见Unicode标准Annex #29.

例:

```scheme
(string-upcase "Hi") ;=> "HI"
(string-downcase "Hi") ;=> "hi"
(string-foldcase "Hi") ;=> "hi" 

(string-upcase "Straße") ;=> "STRASSE"
(string-downcase "Straße") ;=> "straße"
(string-foldcase "Straße") ;=> "strasse"
(string-downcase "STRASSE")  ;=> "strasse" 

(string-downcase "Σ") ;=> "σ"

(string-titlecase "kNock KNoCK") ;=> "Knock Knock"
(string-titlecase "who's there?") ;=> "Who's There?"
(string-titlecase "r6rs") ;=> "R6rs"
(string-titlecase "R6RS") ;=> "R6rs"
```

```scheme
procedure: (string-normalize-nfd string)
returns: the Unicode normalized form D of string
procedure: (string-normalize-nfkd string)
returns: the Unicode normalized form KD of string
procedure: (string-normalize-nfc string)
returns: the Unicode normalized form C of string
procedure: (string-normalize-nfkc string)
returns: the Unicode normalized form KC of string
libraries: (rnrs unicode), (rnrs)
```

如果结果字符串在`string=?`意义上与`string`相同, 则返回`string`或`string`的一个拷贝. 否则, 返回一个新分配的字符串.

例:

```scheme
(string-normalize-nfd "\xE9;") ;=> "e\x301;"
(string-normalize-nfc "\xE9;") ;=> "\xE9;"
(string-normalize-nfd "\x65;\x301;") ;=> "e\x301;"
(string-normalize-nfc "\x65;\x301;") ;=> "\xE9;"
```

```scheme
procedure: (string->list string)
returns: a list of the characters in string
libraries: (rnrs base), (rnrs)
```

`string->list`将一个字符串转换为一个列表, 从而Scheme的列表处理操作可以应用于字符串处理.

例:

```scheme
(string->list "") ;=> ()
(string->list "abc") ;=> (#\a #\b #\c)
(apply char<? (string->list "abc")) ;=> #t
(map char-upcase (string->list "abc")) ;=> (#\A #\B #\C)
```

```scheme
procedure: (list->string list)
returns: a string of the characters in list
libraries: (rnrs base), (rnrs)
```

`list`必须全部由字符构成.

`list->string`是`string->list`的逆过程. 程序中可以同时使用这两个过程, 首先将字符串转换为列表, 在这个列表上操作产生一个新的列表, 最终将新列表转换回字符串.

例:

```scheme
(list->string '()) ;=> ""
(list->string '(#\a #\b #\c)) ;=> "abc"
(list->string
(map char-upcase
  (string->list "abc"))) ;=> "ABC"
```

## 4.8 Vectors

Introduction

访问列表(list)中任意元素需要线性遍历, 而访问向量(vector)中元素可以在常量时间内完成.
向量的长度是其包含的元素的数量.
向量由精确的非负整数索引, 第一个元素的索引为0, 最大的有效索引是其长度-1.

与列表相同, 向量中元素可以是任意类型, 单个向量中可以持有多个类型的对象.

向量写作`#(`和`)`包裹的空白符分隔的对象序列. 例如, 由`a`、`b`、`c`组成的向量写作`#(a b c)`.

```scheme
procedure: (vector obj ...)
returns: a vector of the objects obj ...
libraries: (rnrs base), (rnrs)
```

例:

```scheme
(vector) ;=> #()
(vector 'a 'b 'c) ;=> #(a b c)
```

```scheme
procedure: (make-vector n)
procedure: (make-vector n obj)
returns: a vector of length n
libraries: (rnrs base), (rnrs)
```

`n`必须是一个精确的非负整数. 如果提供了`ob`参数, 返回由`n`个`obj`构成的向量; 否则结果向量中元素是未描述的.

例:

```scheme
(make-vector 0) ;=> #()
(make-vector 0 '#(a)) ;=> #()
(make-vector 5 '#(a)) ;=> #(#(a) #(a) #(a) #(a) #(a))
```

```scheme
procedure: (vector-length vector)
returns: the number of elements in vector
libraries: (rnrs base), (rnrs)
```

向量的长度总是一个精确的非负整数.

例:

```scheme
(vector-length '#()) ;=> 0
(vector-length '#(a b c)) ;=> 3
(vector-length (vector 1 '(2) 3 '#(4 5))) ;=> 4
(vector-length (make-vector 300)) ;=> 300
```

```scheme
procedure: (vector-ref vector n)
returns: the nth element (zero-based) of vector
libraries: (rnrs base), (rnrs)
```

`n`必须是一个小于`vector`长度的精确的非负整数.

例:

```scheme
(vector-ref '#(a b c) 0) ;=> a
(vector-ref '#(a b c) 1) ;=> b
(vector-ref '#(x y z w) 3) ;=> w
```

```scheme
procedure: (vector-set! vector n obj)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`n`必须是一个小于`vector`长度的精确的非负整数.
`vector-set!`将`vector`的第`n`个元素设置为`ob`.

例:

```scheme
(let ([v (vector 'a 'b 'c 'd 'e)])
  (vector-set! v 2 'x)
  v) ;=> #(a b x d e)
```

```scheme
procedure: (vector-fill! vector obj)
returns: unspecified
libraries: (rnrs base), (rnrs)
```

`vector-fill`将`vector`中每个元素设置为`ob`.

例:

```scheme
(let ([v (vector 1 2 3)])
  (vector-fill! v 0)
  v) ;=> #(0 0 0)
```

```scheme
procedure: (vector->list vector)
returns: a list of the elements of vector
libraries: (rnrs base), (rnrs)
```

`vector->list`提供了在向量上应用列表处理操作的便利方法.

例:

```scheme
(vector->list (vector)) ;=> ()
(vector->list '#(a b c)) ;=> (a b c) 

(let ((v '#(1 2 3 4 5)))
  (apply * (vector->list v))) ;=> 120
```

```scheme
procedure: (list->vector list)
returns: a vector of the elements of list
libraries: (rnrs base), (rnrs)
```

`list->vector`是`vector->list`的逆过程. 
组合使用这两个过程可以利用列表处理操作. 先用`vector->list`将向量转换为列表, 使用列表处理操作产生一个新列表, 最后用`list->vector`将新列表转换回向量.

例:

```scheme
(list->vector '()) ;=> #()
(list->vector '(a b c)) ;=> #(a b c) 

(let ([v '#(1 2 3 4 5)])
  (let ([ls (vector->list v)])
    (list->vector (map * ls ls)))) ;=> #(1 4 9 16 25)
```

```scheme
procedure: (vector-sort predicate vector)
returns: a vector containing the elements of vector, sorted according to predicate
procedure: (vector-sort! predicate vector)
returns: unspecified
libraries: (rnrs sorting), (rnrs)
```

`predicate`应该是一个接受两个参数的过程, 在第一个参数在已排序的向量中位于第二个参数之前时返回`#t`.
即, 在两个元素`x`和`y`上应用`predicate`, 在输入向量中`x`在`y`之后出现, 仅当在输出向量中`x`应该在`y`之前出现时, `predicate`返回真.
如果满足这个约束, `vector-sort`执行一个稳定的排序(stable sort), 即, 两个元素仅在必要时根据`predicate`重排.
不移除重复的元素.
`predicate`不应该有任何副作用(side effect).

`vector-sort`最多调用`predicate` $n \log n$次, `n`是`vector`的长度; 而`vector-sort!`最多调用`predicate` $n^{2}$次.
`vector`sort!`上宽松的边界允许具体实现使用一个快排(quicksort)算法, 在某些情况中可能比有紧凑的 $n \log n$边界的算法更快.

例:

```scheme
(vector-sort < '#(3 4 2 1 2 5)) ;=> #(1 2 2 3 4 5)
(vector-sort > '#(0.5 1/2)) ;=> #(0.5 1/2)
(vector-sort > '#(1/2 0.5)) ;=> #(1/2 0.5) 

(let ([v (vector 3 4 2 1 2 5)])
  (vector-sort! < v)
  v) ;=> #(1 2 2 3 4 5)
```

## 4.9 Bytevectors

字节向量(bytevector)是原始二进制数据(raw binary data)的向量.
尽管表面上被组织为精确的无符号的8位整数的序列, 但字节向量可以被解释为精确的带符号的8位整数序列、精确的带符号/无符号的16位/32位/64位/任意位的整数序列、IEEE单精度/双精度数序列, 或者前述方式的组合.

字节向量的长度是其存储的8位字节的数量, 字节向量中索引总是有字节偏移量. 任意数据元素可以在任意字节偏移量处对齐, 不管底层硬件的对齐需求(alignment requirements), 同时也可以使用与底层硬件不同的字节序(endianness).
通常为使用本地格式(native format)的16位/32位/64位整数和单精度/双精度浮点数提供较为搞笑的操作符, 本地格式是指, 字节序与底层硬件相同, 数据元素存储在整数或浮点数字节大小倍数的位置.

多字节数据值的字节序决定了它的内存布局. 在大尾端(big-endian)格式中, 将值的最高有效字节存储在低索引上; 而在小尾端(little-endian)格式中, 将值的最高有效字节存储在高索引上.
当字节向量过程接受一个字节序参数时, 符号`big`表示大尾端格式, `little`表示小尾端格式. 具体实现可以扩展这些过程, 以接受其它字节序符号. 使用过程`native-endianness`获得实现的本地字节序.

字节向量写作`#vu8(`和`)`包裹的8位无符号精确的整数序列, 例如`#vu8(1 2 3)`. 
同字符串一样, 字节向量也是自求值的.

```scheme
syntax: (endianness symbol)
returns: symbol
libraries: (rnrs bytevectors), (rnrs)
```

`symbol`必须是符号`little`、符号`big`或其它被具体实现识别为字节序的符号.
如果`symbol`不是一个符号或不能被具体实现识别的字节序符号, 是一个语法错误.

例:

```scheme
(endianness little) ;=> little
(endianness big) ;=> big
(endianness "spam") ;=> exception
```

```scheme
procedure: (native-endianness)
returns: a symbol naming the implementation's native endianness
libraries: (rnrs bytevectors), (rnrs)
```

返回值是符号`little`、符号`big`或其它被具体实现识别的字节序符号. 它通常反映底层硬件的字节序.

例:

```scheme
(symbol? (native-endianness)) ;=> #t
```

```scheme
procedure: (make-bytevector n)
procedure: (make-bytevector n fill)
returns: a new bytevector of length n
libraries: (rnrs bytevectors), (rnrs)
```

如果提供了`fill`参数, 结果字节向量的每个元素被初始化为`fill`; 否则, 其元素是未描述的.
`fill`的值必须是有符号的或无符号的8位值, 即值的范围属于-128到255(均包含). 负的`fill`值被视为2的补码.

例:

```scheme
(make-bytevector 0) ;=> #vu8()
(make-bytevector 0 7) ;=> #vu8()
(make-bytevector 5 7) ;=> #vu8(7 7 7 7 7)
(make-bytevector 5 -7) ;=> #vu8(249 249 249 249 249)
```

```scheme
procedure: (bytevector-length bytevector)
returns: the length of bytevector in 8-bit bytes
libraries: (rnrs bytevectors), (rnrs)
```

例:

```scheme
(bytevector-length #vu8()) ;=> 0
(bytevector-length #vu8(1 2 3)) ;=> 3
(bytevector-length (make-bytevector 300)) ;=> 300
```

```scheme
procedure: (bytevector=? bytevector1 bytevector2)
returns: #t if the relation holds, #f otherwise
libraries: (rnrs bytevectors), (rnrs)
```

两个字节向量在`bytevector=?`下相等(equal), 当且仅当他们有相同的长度和相同的内容.

例:

```scheme
(bytevector=? #vu8() #vu8()) ;=> #t
(bytevector=? (make-bytevector 3 0) #vu8(0 0 0)) ;=> #t
(bytevector=? (make-bytevector 5 0) #vu8(0 0 0)) ;=> #f
(bytevector=? #vu8(1 127 128 255) #vu8(255 128 127 1)) ;=> #f
```

```scheme
procedure: (bytevector-fill! bytevector fill)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`fill`的值必须是有符号的或无符号的8位值, 即值的范围属于-128到255(均包含). 负的`fill`值被视为2的补码.

`bytevector-fill!`将`bytevector`的每个元素设置为`fill`.

例:

```scheme
(let ([v (make-bytevector 6)])
  (bytevector-fill! v 255)
  v) ;=> #vu8(255 255 255 255 255 255) 

(let ([v (make-bytevector 6)])
  (bytevector-fill! v -128)
  v) ;=> #vu8(128 128 128 128 128 128)
```

```scheme
procedure: (bytevector-copy bytevector)
returns: a new bytevector that is a copy of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`bytevector`创建一个与`bytevector`具备相同长度和相同内容的新字节向量.

例:

```scheme
(bytevector-copy #vu8(1 127 128 255)) ;=> #vu8(1 127 128 255) 

(let ([v #vu8(1 127 128 255)])
  (eq? v (bytevector-copy v))) ;=> #f
```

```scheme
procedure: (bytevector-copy! src src-start dst dst-start n)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`src`和`dst`必须是字节向量. `src-start`、`dst-start`和`n`必须是精确的非负整数.
`src-start`和`n`的和必须不能超过`src`的长度, `dst-start`和`n`的和必须不能超过`dst`的长度.

`bytevector-copy!`将`dst`中从`dst-start`开始的`n`字节替换为`src`中从`src-start`开始的n个字节.
这在`dst`与`src`是同一个字节向量、源和目标位置重叠时也可以工作. 即, 目标位置用在操作开始之前的源位置上字节填充.

例:

```scheme
(define v1 #vu8(31 63 95 127 159 191 223 255))
(define v2 (make-bytevector 10 0)) 

(bytevector-copy! v1 2 v2 1 4)
v2 ;=> #vu8(0 95 127 159 191 0 0 0 0 0)

(bytevector-copy! v1 5 v2 7 3)
v2 ;=> #vu8(0 95 127 159 191 0 0 191 223 255)

(bytevector-copy! v2 3 v2 0 6)
v2 ;=> #vu8(159 191 0 0 191 223 0 191 223 255)

(bytevector-copy! v2 0 v2 1 9)
v2 ;=> #vu8(159 159 191 0 0 191 223 0 191 223)
```

```scheme
procedure: (bytevector-u8-ref bytevector n)
returns: the 8-bit unsigned byte at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是一个小于`bytevector`长度的精确的非负整数.

返回值是一个精确的8位无符号整数, 即值的范围在0到255(均包含).

例:

```scheme
(bytevector-u8-ref #vu8(1 127 128 255) 0) ;=> 1
(bytevector-u8-ref #vu8(1 127 128 255) 2) ;=> 128
(bytevector-u8-ref #vu8(1 127 128 255) 3) ;=> 255
```

```scheme
procedure: (bytevector-s8-ref bytevector n)
returns: the 8-bit signed byte at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是一个小于`bytevector`长度的精确的非负整数.

返回值是一个精确的8位有符号整数, 即值的范围在-128到127(均包含), 值被视为2的补码.

例:

```scheme
(bytevector-s8-ref #vu8(1 127 128 255) 0) ;=> 1
(bytevector-s8-ref #vu8(1 127 128 255) 1) ;=> 127
(bytevector-s8-ref #vu8(1 127 128 255) 2) ;=> -128
(bytevector-s8-ref #vu8(1 127 128 255) 3) ;=> -1
```

```scheme
procedure: (bytevector-u8-set! bytevector n u8)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是一个小于`bytevector`长度的精确的非负整数. 
`u8`必须是一个8位无符号值, 即值的范围在0到255(均包含).

`bytevector-u8-set!`将`bytevector`中索引`n`(从0开始)的8位值替换为`u8`.

例:

```scheme
(let ([v (make-bytevector 5 -1)])
  (bytevector-u8-set! v 2 128)
  v) ;=> #vu8(255 255 128 255 255)
```

```scheme
procedure: (bytevector-s8-set! bytevector n s8)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是一个小于`bytevector`长度的精确的非负整数. 
`s8`必须是一个8位有符号值, 即值的范围在-128到127(均包含).

`bytevector-s8-set!`将`bytevector`中索引`n`(从0开始)的8位值替换为`s8`的2的补码.

例:

```scheme
(let ([v (make-bytevector 4 0)])
  (bytevector-s8-set! v 1 100)
  (bytevector-s8-set! v 2 -100)
  v) ;=> #vu8(0 100 156 0)
```

```scheme
procedure: (bytevector->u8-list bytevector)
returns: a list of the 8-bit unsigned elements of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

例:

```scheme
(bytevector->u8-list (make-bytevector 0)) ;=> ()
(bytevector->u8-list #vu8(1 127 128 255)) ;=> (1 127 128 255) 

(let ([v #vu8(1 2 3 255)])
  (apply * (bytevector->u8-list v))) ;=> 1530
```

```scheme
procedure: (u8-list->bytevector list)
returns: a new bytevector of the elements of list
libraries: (rnrs bytevectors), (rnrs)
```

`list`必须由精确的8位无符号整数构成, 即值的返回在0到255(均包含).

例:

```scheme
(u8-list->bytevector '()) ;=> #vu8()
(u8-list->bytevector '(1 127 128 255)) ;=> #vu8(1 127 128 255) 

(let ([v #vu8(1 2 3 4 5)])
(let ([ls (bytevector->u8-list v)])
    (u8-list->bytevector (map * ls ls)))) ;=> #vu8(1 4 9 16 25)
```

```scheme
procedure: (bytevector-u16-native-ref bytevector n)
returns: the 16-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s16-native-ref bytevector n)
returns: the 16-bit signed integer at index n (zero-based) of bytevector
procedure: (bytevector-u32-native-ref bytevector n)
returns: the 32-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s32-native-ref bytevector n)
returns: the 32-bit signed integer at index n (zero-based) of bytevector
procedure: (bytevector-u64-native-ref bytevector n)
returns: the 64-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s64-native-ref bytevector n)
returns: the 64-bit signed integer at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引, 必须是值占用的字节数量的倍数: 16位值为2、32位值为4、64位值为8.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
使用本地字节序.

返回值是一个精确的整数, 在值占用的字节数量代表的范围内.
有符号值被视为2的补码值.

例:

```scheme
(define v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98))

; big
(bytevector-u16-native-ref v 2) ;=> #xfe56
(bytevector-s16-native-ref v 2) ;=> #x-1aa
(bytevector-s16-native-ref v 6) ;=> #x7898 

(bytevector-u32-native-ref v 0) ;=> #x1234fe56
(bytevector-s32-native-ref v 0) ;=> #x1234fe56
(bytevector-s32-native-ref v 4) ;=> #x-23458768 

(bytevector-u64-native-ref v 0) ;=> #x1234fe56dcba7898
(bytevector-s64-native-ref v 0) ;=> #x1234fe56dcba7898

; little
(bytevector-u16-native-ref v 2) ;=> #x56fe
(bytevector-s16-native-ref v 2) ;=> #x56fe
(bytevector-s16-native-ref v 6) ;=> #x-6788 

(bytevector-u32-native-ref v 0) ;=> #x56fe3412
(bytevector-s32-native-ref v 0) ;=> #x56fe3412
(bytevector-s32-native-ref v 4) ;=> #x-67874524 

(bytevector-u64-native-ref v 0) ;=> #x9878badc56fe3412
(bytevector-s64-native-ref v 0) ;=> #x-67874523a901cbee
```

```scheme
procedure: (bytevector-u16-native-set! bytevector n u16)
procedure: (bytevector-s16-native-set! bytevector n s16)
procedure: (bytevector-u32-native-set! bytevector n u32)
procedure: (bytevector-s32-native-set! bytevector n s32)
procedure: (bytevector-u64-native-set! bytevector n u64)
procedure: (bytevector-s64-native-set! bytevector n s64)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引, 必须是值占用的字节数量的倍数: 16位值为2、32位值为4、64位值为8.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
`u16`必须是16位无符号值, 即值的范围在0到$2^{16}-1$(均包含).
`s16`必须是16位有符号值, 即值的范围在$-2^{15}$到$2^{15}-1$(均包含).
`u32`必须是32位无符号值, 即值的范围在0到$2^{32}-1$(均包含).
`s32`必须是32位有符号值, 即值的范围在$-2^{31}$到$2^{31}-1$(均包含).
`u64`必须是64位无符号值, 即值的范围在0到$2^{64}-1$(均包含).
`s64`必须是64位有符号值, 即值的范围在$-2^{63}$到$2^{63}-1$(均包含).
使用本地字节序.

这些过程将值存储在`bytevector`中索引`n`(从0开始)处的2、4或8个字节中. 负值存储为2的补码.

例:

```scheme
(define v (make-bytevector 8 0))
(bytevector-u16-native-set! v 0 #xfe56)
(bytevector-s16-native-set! v 2 #x-1aa)
(bytevector-s16-native-set! v 4 #x7898)
; big
v ;=> #vu8(#xfe #x56 #xfe #x56 #x78 #x98 #x00 #x00)
; little
v ;=> #vu8(#x56 #xfe #x56 #xfe #x98 #x78 #x00 #x00)

(define v (make-bytevector 16 0))
(bytevector-u32-native-set! v 0 #x1234fe56)
(bytevector-s32-native-set! v 4 #x1234fe56)
(bytevector-s32-native-set! v 8 #x-23458768)
; big
v ;=> #vu8(#x12 #x34 #xfe #x56 #x12 #x34 #xfe #x56
        #xdc #xba #x78 #x98 #x00 #x00 #x00 #x00)
; little
v ;=> #vu8(#x56 #xfe #x34 #x12 #x56 #xfe #x34 #x12
        #x98 #x78 #xba #xdc #x00 #x00 #x00 #x00)

(define v (make-bytevector 24 0))
(bytevector-u64-native-set! v 0 #x1234fe56dcba7898)
(bytevector-s64-native-set! v 8 #x1234fe56dcba7898)
(bytevector-s64-native-set! v 16 #x-67874523a901cbee)
; big
v ;=> #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98
        #x12 #x34 #xfe #x56 #xdc #xba #x78 #x98
        #x98 #x78 #xba #xdc #x56 #xfe #x34 #x12)
; little
v ;=> #vu8(#x98 #x78 #xba #xdc #x56 #xfe #x34 #x12
        #x98 #x78 #xba #xdc #x56 #xfe #x34 #x12
        #x12 #x34 #xfe #x56 #xdc #xba #x78 #x98)
```

```scheme
procedure: (bytevector-u16-ref bytevector n eness)
returns: the 16-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s16-ref bytevector n eness)
returns: the 16-bit signed integer at index n (zero-based) of bytevector
procedure: (bytevector-u32-ref bytevector n eness)
returns: the 32-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s32-ref bytevector n eness)
returns: the 32-bit signed integer at index n (zero-based) of bytevector
procedure: (bytevector-u64-ref bytevector n eness)
returns: the 64-bit unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-s64-ref bytevector n eness)
returns: the 64-bit signed integer at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是一个精确的非负整数, 作为值的起始字节的索引.
`n`和值占用的字节数量(16位值为2、32位值为4、64位值为8)的和必须不能超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`eness`必须是命名了字节序的有效符号.

返回值是一个精确的整数, 在值占用的字节数量代表的范围内.
有符号值被视为2的补码值.

例:

```scheme
(define v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98 #x9a #x76))
(bytevector-u16-ref v 0 (endianness big)) ;=> #x1234
(bytevector-s16-ref v 1 (endianness big)) ;=> #x34fe
(bytevector-s16-ref v 5 (endianness big)) ;=> #x-4588 

(bytevector-u32-ref v 2 'big) ;=> #xfe56dcba
(bytevector-s32-ref v 3 'big) ;=> #x56dcba78
(bytevector-s32-ref v 4 'big) ;=> #x-23458768 

(bytevector-u64-ref v 0 'big) ;=> #x1234fe56dcba7898
(bytevector-s64-ref v 1 'big) ;=> #x34fe56dcba78989a 

(bytevector-u16-ref v 0 (endianness little)) ;=> #x3412
(bytevector-s16-ref v 1 (endianness little)) ;=> #x-1cc
(bytevector-s16-ref v 5 (endianness little)) ;=> #x78ba 

(bytevector-u32-ref v 2 'little) ;=> #xbadc56fe
(bytevector-s32-ref v 3 'little) ;=> #x78badc56
(bytevector-s32-ref v 4 'little) ;=> #x-67874524 

(bytevector-u64-ref v 0 'little) ;=> #x9878badc56fe3412
(bytevector-s64-ref v 1 'little) ;=> #x-6567874523a901cc
```

```scheme
procedure: (bytevector-u16-set! bytevector n u16 eness)
procedure: (bytevector-s16-set! bytevector n s16 eness)
procedure: (bytevector-u32-set! bytevector n u32 eness)
procedure: (bytevector-s32-set! bytevector n s32 eness)
procedure: (bytevector-u64-set! bytevector n u64 eness)
procedure: (bytevector-s64-set! bytevector n s64 eness)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数, 作为值的起始字节的索引.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`u16`必须是16位无符号值, 即值的范围在0到$2^{16}-1$(均包含).
`s16`必须是16位有符号值, 即值的范围在$-2^{15}$到$2^{15}-1$(均包含).
`u32`必须是32位无符号值, 即值的范围在0到$2^{32}-1$(均包含).
`s32`必须是32位有符号值, 即值的范围在$-2^{31}$到$2^{31}-1$(均包含).
`u64`必须是64位无符号值, 即值的范围在0到$2^{64}-1$(均包含).
`s64`必须是64位有符号值, 即值的范围在$-2^{63}$到$2^{63}-1$(均包含).
`eness`必须是命名了字节序的有效符号.

这些过程将值存储在`bytevector`中索引`n`(从0开始)处的2、4或8个字节中. 负值存储为2的补码.

例:

```scheme
(define v (make-bytevector 8 0))
(bytevector-u16-set! v 0 #xfe56 (endianness big))
(bytevector-s16-set! v 3 #x-1aa (endianness little))
(bytevector-s16-set! v 5 #x7898 (endianness big))
v ;=> #vu8(#xfe #x56 #x0 #x56 #xfe #x78 #x98 #x0) 

(define v (make-bytevector 16 0))
(bytevector-u32-set! v 0 #x1234fe56 'little)
(bytevector-s32-set! v 6 #x1234fe56 'big)
(bytevector-s32-set! v 11 #x-23458768 'little)
v ;=> #vu8(#x56 #xfe #x34 #x12 #x0 #x0
        #x12 #x34 #xfe #x56 #x0
        #x98 #x78 #xba #xdc #x0) 

(define v (make-bytevector 28 0))
(bytevector-u64-set! v 0 #x1234fe56dcba7898 'little)
(bytevector-s64-set! v 10 #x1234fe56dcba7898 'big)
(bytevector-s64-set! v 19 #x-67874523a901cbee 'big)
v ;=> #vu8(#x98 #x78 #xba #xdc #x56 #xfe #x34 #x12 #x0 #x0
        #x12 #x34 #xfe #x56 #xdc #xba #x78 #x98 #x0
        #x98 #x78 #xba #xdc #x56 #xfe #x34 #x12 #x0)
```

```scheme
procedure: (bytevector-uint-ref bytevector n eness size)
returns: the size-byte unsigned integer at index n (zero-based) of bytevector
procedure: (bytevector-sint-ref bytevector n eness size)
returns: the size-byte signed integer at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数, 作为值的起始字节的索引.
`size`必须是精确的正整数, 指定了值占用的字节数量.
`n`和`size`的和必须不能超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`eness`必须是命名了字节序的有效符号.

返回值是一个精确的整数, 在值占用的字节数量代表的范围内.
有符号值被视为2的补码值.

例:

```scheme
(define v #vu8(#x12 #x34 #xfe #x56 #xdc #xba #x78 #x98 #x9a #x76)) 

(bytevector-uint-ref v 0 'big 1) ;=> #x12
(bytevector-uint-ref v 0 'little 1) ;=> #x12
(bytevector-uint-ref v 1 'big 3) ;=> #x34fe56
(bytevector-uint-ref v 2 'little 7) ;=> #x9a9878badc56fe 

(bytevector-sint-ref v 2 'big 1) ;=> #x-02
(bytevector-sint-ref v 1 'little 6) ;=> #x78badc56fe34
(bytevector-sint-ref v 2 'little 7) ;=> #x-6567874523a902 

(bytevector-sint-ref (make-bytevector 1000 -1) 0 'big 1000) ;=> -1
```

```scheme
procedure: (bytevector-uint-set! bytevector n uint eness size)
procedure: (bytevector-sint-set! bytevector n sint eness size)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数, 作为值的起始字节的索引.
`size`必须是精确的正整数, 指定了值占用的字节数量.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`uint`必须是一个精确的整数, 范围在0到$2^{size*8}-1$(均包含).
`uint`必须是一个精确的整数, 范围在$-2^{size*8-1}$到$2^{size*8-1}-1$(均包含).
`eness`必须是命名了字节序的有效符号.

这些过程将值存储在`bytevector`中索引`n`(从0开始)处的`size`个字节中. 负值存储为2的补码.

例:

```scheme
(define v (make-bytevector 5 0))
(bytevector-uint-set! v 1 #x123456 (endianness big) 3)
v ;=> #vu8(0 #x12 #x34 #x56 0) 

(define v (make-bytevector 7 -1))
(bytevector-sint-set! v 1 #x-8000000000 (endianness little) 5)
v ;=> #vu8(#xff 0 0 0 0 #x80 #xff)
```

```scheme
procedure: (bytevector->uint-list bytevector eness size)
returns: a new list of the size-byte unsigned elements of bytevector
procedure: (bytevector->sint-list bytevector eness size)
returns: a new list of the size-byte signed elements of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`eness`必须是命名了字节序的有效符号.
`size`必须是精确的正整数, 指定了值占用的字节数量. 它必须是一个能整除`bytevector`长度的值.

例:

```scheme
(bytevector->uint-list (make-bytevector 0) 'little 3) ;=> () 

(let ([v #vu8(1 2 3 4 5 6)])
(bytevector->uint-list v 'big 3)) ;=> (#x010203 #x040506) 

(let ([v (make-bytevector 80 -1)])
(bytevector->sint-list v 'big 20)) ;=> (-1 -1 -1 -1)
```

```scheme
procedure: (uint-list->bytevector list eness size)
procedure: (sint-list->bytevector list eness size)
returns: a new bytevector of the elements of list
libraries: (rnrs bytevectors), (rnrs)
```

`eness`必须是命名了字节序的有效符号.
`size`必须是精确的正整数, 指定了值占用的字节数量.
对于`uint-list->bytevector`, `list`必须由`size`个字节的精确的无符号整数(即值的范围在0到$2^{size*8}-1$(均包含))构成.
对于`sint-list->bytevector`, `list`必须由`size`个字节的精确的有符号整数(即值的范围在$-2^{size*8-1}$到$2^{size*8-1}-1$(均包含))构成.
结果字节向量中每个值占用`size`个字节, 它的长度是`size`乘以`list`的长度.

例:

```scheme
(uint-list->bytevector '() 'big 25) ;=> #vu8()
(sint-list->bytevector '(0 -1) 'big 3) ;=> #vu8(0 0 0 #xff #xff #xff) 

(define (f size)
(let ([ls (list (- (expt 2 (- (* 8 size) 1)))
                (- (expt 2 (- (* 8 size) 1)) 1))])
    (sint-list->bytevector ls 'little size)))
(f 6) ;=> #vu8(#x00 #x00 #x00 #x00 #x00 #x80
            #xff #xff #xff #xff #xff #x7f)
```

```scheme
procedure: (bytevector-ieee-single-native-ref bytevector n)
returns: the single floating-point value at index n (zero-based) of bytevector
procedure: (bytevector-ieee-double-native-ref bytevector n)
returns: the double floating-point value at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引, 必须是值占用的字节数量的倍数: 16位值为2、32位值为4、64位值为8.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
使用本地字节序.

返回值是一个非精确的实数.

```scheme
procedure: (bytevector-ieee-single-native-set! bytevector n x)
procedure: (bytevector-ieee-double-native-set! bytevector n x)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引, 必须是值占用的字节数量的倍数: 16位值为2、32位值为4、64位值为8.
`n`和值占用的字节数量的和必须不超过`bytevector`的长度.
使用本地字节序.

这些过程将指定值作为IEEE-754单精度或双精度浮点值存储在`bytevector`中索引`n`(从0开始)处.

例:

```scheme
(define v (make-bytevector 8 0))
(bytevector-ieee-single-native-set! v 0 .125)
(bytevector-ieee-single-native-set! v 4 -3/2)
(list
  (bytevector-ieee-single-native-ref v 0)
  (bytevector-ieee-single-native-ref v 4)) ;=> (0.125 -1.5) 

(bytevector-ieee-double-native-set! v 0 1e23)
(bytevector-ieee-double-native-ref v 0) ;=> 1e23
```

```scheme
procedure: (bytevector-ieee-single-ref bytevector n eness)
returns: the single floating-point value at index n (zero-based) of bytevector
procedure: (bytevector-ieee-double-ref bytevector n eness)
returns: the double floating-point value at index n (zero-based) of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引.
`n`和值占用的字节数量(单精度为4、双精度为8)的和必须不超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`eness`必须是命名了字节序的有效符号.

返回值是一个非精确的实数.

```scheme
procedure: (bytevector-ieee-single-set! bytevector n x eness)
procedure: (bytevector-ieee-double-set! bytevector n x eness)
returns: unspecified
libraries: (rnrs bytevectors), (rnrs)
```

`n`必须是精确的非负整数. `n`作为值的起始字节的索引, 必须是值占用的字节数量的倍数: 16位值为2、32位值为4、64位值为8.
`n`和值占用的字节数量(单精度为4、双精度为8)的和必须不超过`bytevector`的长度.
`n`不需要是值占用的字节数量的倍数.
`eness`必须是命名了字节序的有效符号.

这些过程将指定值作为IEEE-754单精度或双精度浮点值存储在`bytevector`中索引`n`(从0开始)处.

例:

```scheme
(define v (make-bytevector 10 #xc7))
(bytevector-ieee-single-set! v 1 .125 'little)
(bytevector-ieee-single-set! v 6 -3/2 'big)
(list
  (bytevector-ieee-single-ref v 1 'little)
  (bytevector-ieee-single-ref v 6 'big)) ;=> (0.125 -1.5)
v ;=> #vu8(#xc7 #x0 #x0 #x0 #x3e #xc7 #xbf #xc0 #x0 #x0) 

(bytevector-ieee-double-set! v 1 1e23 'big)
(bytevector-ieee-double-ref v 1 'big) ;=> 1e23
```


## 4.10 Symbols

有相同名称的两个符号在`eq?`下相同. 原因是Scheme读取器(reader, 通过`get-datum`和`read`调用)和过程`string->symbol`将符号存储在一个内部符号表中, 在遇到相同的名称时总是返回同一个符号.

```scheme
procedure: (symbol=? symbol1 symbol2)
returns: #t if the two symbols are the same, #f otherwise
libraries: (rnrs base), (rnrs)
```

也可以使用`eq?`比较符号, 它通常比`symbol=?`更高效.

例:

```scheme
(symbol=? 'a 'a) ;=> #t
(symbol=? 'a (string->symbol "a")) ;=> #t
(symbol=? 'a 'b) ;=> #f
```

```scheme
procedure: (string->symbol string)
returns: a symbol whose name is string
libraries: (rnrs base), (rnrs)
```

`string->symbol`将其创建的所有符号记录在一个内部表(internal table)中, 这个表也会被系统读取器(system reader)使用.
如果一个符号的名称与表中已经存在的一个字符串在`string=?`下等价, 直接返回这个符号. 否则, 创建一个以`string`作为名称的新符号, 并将符号添加到表中, 返回这个符号.

在将一个字符串作为`string->symbol`的参数使用之后修改这个字符串的行为是未描述的.

例:

```scheme
(string->symbol "x") ;=> x 

(eq? (string->symbol "x") 'x) ;=> #t
(eq? (string->symbol "X") 'x) ;=> #f 

(eq? (string->symbol "x")
    (string->symbol "x")) ;=> #t 

(string->symbol "()") ;=> \x28;\x29;
```

```scheme
procedure: (symbol->string symbol)
returns: a string, the name of symbol
libraries: (rnrs base), (rnrs)
```

`symbol->string`返回的字符串应该被视为不可修改的(immutable).
使用`string-set!`等过程修改已经传递给`string->symbol`的字符串, 导致不可预期的行为.

例:

```scheme
(symbol->string 'xyz) ;=> "xyz"
(symbol->string 'Hi) ;=> "Hi"
(symbol->string (string->symbol "()")) ;=> "()"
```

## 4.11 Booleans

在条件上下文中, 每个Scheme对象有一个真值, 除了`#f`之外的对象均视为真. 
Scheme也提供了一个专用的真值`#t`, 用在只需要表示为真的场景.

```scheme
procedure: (boolean=? boolean1 boolean2)
returns: #t if the two booleans are the same, #f otherwise
libraries: (rnrs base), (rnrs)
```

也可以使用`eq?`比较布尔值`#t`和`#f`, 它通常比`boolean=?`更高效.

例:

```scheme
(boolean=? #t #t) ;=> #t
(boolean=? #t #f) ;=> #f
(boolean=? #t (< 3 4)) ;=> #t
```

## 4.12 Hashtables

Introduction:

哈希表(hashtable)表示任意Scheme值之间的关联(association)的集(sets).

哈希表本质上提供与关联列表(association list)相同的功能, 但在存在大量关联时运行较快.

```scheme
procedure: (make-eq-hashtable)
procedure: (make-eq-hashtable size)
returns: a new mutable eq hashtable
libraries: (rnrs hashtables), (rnrs)
```

如果提供了`size`参数, 它必须是一个非负的精确的整数, 它指定了哈希表应该初始持有的近似元素数量.
哈希表会按序增长, 但增长时通常序号重新哈希已有的元素.
提供一个不为0的`size`可以帮助限制在表初始生成时重新哈希的次数.

eq哈希表使用`eq?`过程比较键, 通常使用基于对象地址的哈希函数.
它的哈希(hash)和等价性(equivalence)函数适用于任何Scheme对象.

例:

```scheme
(define ht1 (make-eq-hashtable))
(define ht2 (make-eq-hashtable 32))
```

```scheme
procedure: (make-eqv-hashtable)
procedure: (make-eqv-hashtable size)
returns: a new mutable eqv hashtable
libraries: (rnrs hashtables), (rnrs)
```

如果提供了`size`参数, 它必须是一个非负的精确的整数, 它指定了哈希表应该初始持有的近似元素数量.
哈希表会按序增长, 但增长时通常序号重新哈希已有的元素.
提供一个不为0的`size`可以帮助限制在表初始生成时重新哈希的次数.

eqv哈希表使用`eqv?`过程比较键, 通常使用基于可通过`eq?`确定(identifiable)的对象的对象地址的哈希函数.
它的哈希(hash)和等价性(equivalence)函数适用于任何Scheme对象.

```scheme
procedure: (make-hashtable hash equiv?)
procedure: (make-hashtable hash equiv? size)
returns: a new mutable hashtable
libraries: (rnrs hashtables), (rnrs)
```

`hash`和`equiv?`必须是过程. 如果提供了`size`参数, 它必须是一个非负的精确的整数, 它指定了哈希表应该初始持有的近似元素数量.
哈希表会按序增长, 但增长时通常序号重新哈希已有的元素.
提供一个不为0的`size`可以帮助限制在表初始生成时重新哈希的次数.

返回的新哈希表使用`hash`计算哈希值, 使用`equiv?`比较键, 这两个过程均不能修改哈希表.
`equiv?`应该比较两个键, 仅当两个键应该被区分时返回假.
`hash`应该接受一个键作为参数, 返回一个非负的精确的整数值, 并且该值与使用`equiv?`无法区分的参数调用的结果值相等.
当哈希表只用于它们接受的键时, `hash`和`equiv?`过程不需要接受任意输入, 这两个过程通常假设只要键没有被修改且在表中有关联的存储时, 键是不可变的.
哈希表操作可以调用`hash`和`equiv?`仅一次、不调用、每个哈希表操作调用一次.
例:

```scheme
(define ht (make-hashtable string-hash string=?))
```

```scheme
procedure: (hashtable-mutable? hashtable)
returns: #t if hashtable is mutable, #f otherwise
libraries: (rnrs hashtables), (rnrs)
```

通过上面的创建过程返回的哈希表是可变的(mutable), 通过`hashtable-copy`创建的哈希表可以是不可变的(immutable).
不可变的哈希表上不能使用过程`hashtable-set!`、`hashtable-update!`、`hashtable-delete!`或`hashtable-clear!`.

例:

```scheme
(hashtable-mutable? (make-eq-hashtable)) ;=> #t
(hashtable-mutable? (hashtable-copy (make-eq-hashtable))) ;=> #f
```

```scheme
procedure: (hashtable-hash-function hashtable)
returns: the hash function associated with hashtable
procedure: (hashtable-equivalence-function hashtable)
returns: the equivalence function associated with hashtable
libraries: (rnrs hashtables), (rnrs)
```

`hashtable-hash-function`对于eq哈希表和eqv哈希表返回`#f`.

例:

```scheme
(define ht (make-eq-hashtable))
(hashtable-hash-function ht) ;=> #f
(eq? (hashtable-equivalence-function ht) eq?) ;=> #t

(define ht (make-hashtable string-hash string=?))
(eq? (hashtable-hash-function ht) string-hash) ;=> #t
(eq? (hashtable-equivalence-function ht) string=?) ;=> #t
```

```scheme
procedure: (equal-hash obj)
procedure: (string-hash string)
procedure: (string-ci-hash string)
procedure: (symbol-hash symbol)
returns: an exact nonnegative integer hash value
libraries: (rnrs hashtables), (rnrs)
```

这些过程是适用于同Scheme谓词一起使用的哈希函数: `equal-hash`与`equal?`、`string-hash`与`string=?`、`string-ci-hash`与`string-ci=?`、`symbol-hash`与`symbol=?`或`eq?`.
`equal-hash`、`string-hash`、`string-ci-hash`通常依赖于输入值的当前结构和内容, 因而在键已在哈希表中存在关联后修改键时是不适用的.

```scheme
procedure: (hashtable-set! hashtable key obj)
returns: unspecified
libraries: (rnrs hashtables), (rnrs)
```

`hashtable`必须是一个可变的哈希表.
`key`应该是对于哈希表的哈希函数和等价性函数而言恰当的键.
`obj`可以是任意Scheme对象.

`hashtable-set!`在`hashtable`中将`key`与`obj`关联(associate), 可能替换已存在的关联.

例:

```scheme
(define ht (make-eq-hashtable))
(hashtable-set! ht 'a 73)
```

```scheme
procedure: (hashtable-ref hashtable key default)
returns: see below
libraries: (rnrs hashtables), (rnrs)
```

`key`应该是对于哈希表的哈希函数和等价性函数而言恰当的键.
`default`可以是任意Scheme对象.

`hashtable-ref`返回`hashtable`中与`key`关联的值. 如果`hashtable`中没有值与`key`关联, 返回`default`.

例:

```scheme
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))

(define eqht (make-eq-hashtable))
(hashtable-set! eqht p1 73)
(hashtable-ref eqht p1 55) ;=> 73
(hashtable-ref eqht p2 55) ;=> 55

(define equalht (make-hashtable equal-hash equal?))
(hashtable-set! equalht p1 73)
(hashtable-ref equalht p1 55) ;=> 73
(hashtable-ref equalht p2 55) ;=> 73
```

```scheme
procedure: (hashtable-contains? hashtable key)
returns: #t if an association for key exists in hashtable, #f otherwise
libraries: (rnrs hashtables), (rnrs)
```

`key`应该是对于哈希表的哈希函数和等价性函数而言恰当的键.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 73)
(hashtable-contains? ht p1) ;=> #t
(hashtable-contains? ht p2) ;=> #f
```

```scheme
procedure: (hashtable-update! hashtable key procedure default)
returns: unspecified
libraries: (rnrs hashtables), (rnrs)
```

`hashtable`必须是一个可变的哈希表.
`key`应该是对于哈希表的哈希函数和等价性函数而言恰当的键.
`default`可以是任意Scheme对象.
`procedure`应该接受单个参数, 并返回单个值, 不应该修改`hashtable`.

`hashtable-update!`应用在`hashtable`中与`key`关联的值或者`hashtable`中没有与`key`关联的值时`default`上.
如果`procedure`返回, `hashtable-update!`将`key`与`procedure`返回的值关联, 可能替换旧的关联.

例:

```scheme
(define ht (make-eq-hashtable))
(hashtable-update! ht 'a
  (lambda (x) (* x 2))
  55)
(hashtable-ref ht 'a 0) ;=> 110
(hashtable-update! ht 'a
  (lambda (x) (* x 2))
  0)
(hashtable-ref ht 'a 0) ;=> 220
```

```scheme
procedure: (hashtable-delete! hashtable key)
returns: unspecified
libraries: (rnrs hashtables), (rnrs)
```

`hashtable`必须是一个可变的哈希表.
`key`应该是对于哈希表的哈希函数和等价性函数而言恰当的键.

`hashtable-delete!`从`hashtable`中移除任何与`key`的关联.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 73)
(hashtable-contains? ht p1) ;=> #t
(hashtable-delete! ht p1)
(hashtable-contains? ht p1) ;=> #f
(hashtable-contains? ht p2) ;=> #f
(hashtable-delete! ht p2)
```

```scheme
procedure: (hashtable-size hashtable)
returns: number of entries in hashtable
libraries: (rnrs hashtables), (rnrs)
```

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-size ht) ;=> 0
(hashtable-set! ht p1 73)
(hashtable-size ht) ;=> 1
(hashtable-delete! ht p1)
(hashtable-size ht) ;=> 0
```

```scheme
procedure: (hashtable-copy hashtable)
procedure: (hashtable-copy hashtable mutable?)
returns: a new hashtable containing the same entries as hashtable
libraries: (rnrs hashtables), (rnrs)
```

如果提供了`mutable?`参数且值不为假, 返回的拷贝是可变的; 否则, 返回的拷贝是不可变的.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(hashtable-set! ht p1 "c")
(define ht-copy (hashtable-copy ht))
(hashtable-mutable? ht-copy) ;=> #f
(hashtable-delete! ht p1)
(hashtable-ref ht p1 #f) ;=> #f
(hashtable-delete! ht-copy p1) ;=> exception: not mutable
(hashtable-ref ht-copy p1 #f) ;=> "c"
```

```scheme
procedure: (hashtable-clear! hashtable)
procedure: (hashtable-clear! hashtable size)
returns: unspecified
libraries: (rnrs hashtables), (rnrs)
```

`hashtable`必须是一个可变的哈希表. 如果提供了`size`参数, 它必须是一个非负的精确的整数.

`hashtable-clear`移除`hashtable`中所有项(entry). 如果提供了`size`参数, 将该哈希表的大小重置为`size`, 就像使用带大小参数`size`的哈希表创建过程新创建的哈希表.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 "first")
(hashtable-set! ht p2 "second")
(hashtable-size ht) ;=> 2
(hashtable-clear! ht)
(hashtable-size ht) ;=> 0
(hashtable-ref ht p1 #f) ;=> #f
```

```scheme
procedure: (hashtable-keys hashtable)
returns: a vector containing the keys in hashtable
libraries: (rnrs hashtables), (rnrs)
```

返回的键可以在返回的向量中以任意顺序出现.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 "one")
(hashtable-set! ht p2 "two")
(hashtable-set! ht 'q "three")
(hashtable-keys ht) ;=> #((a . b) q (a . b))
```

```scheme
procedure: (hashtable-entries hashtable)
returns: two vectors: one of keys and a second of values
libraries: (rnrs hashtables), (rnrs)
```

`hashtable-entries`返回两个值: 第一个是包含`hashtable`中键的向量, 第二个是包含相应值的向量.
键和值的顺序可以是任意的, 但键与相应值的相对顺序是相同的.

例:

```scheme
(define ht (make-eq-hashtable))
(define p1 (cons 'a 'b))
(define p2 (cons 'a 'b))
(hashtable-set! ht p1 "one")
(hashtable-set! ht p2 "two")
(hashtable-set! ht 'q "three")
(hashtable-entries ht) ;=> #((a . b) q (a . b))
                        #("two" "three" "one")
```


## 4.13 Enumerations

Introduction:

枚举(enumeration)是符号的有序集, 通常用于命名和操作选项(options), 例如创建文件时指定缓冲模式和文件选项.

```scheme
syntax: (define-enumeration name (symbol ...) constructor)
libraries: (rnrs enums), (rnrs)
```

`define-enumeration`形式是一个定义, 可以在任何定义可以出现的地方出现.

`define-enumeration`语法用构成枚举全域(universe)以特定顺序指定的符号序列, 创建一个新的枚举集(enumeration set).
它定义了一个命名为`name`的新句法形式, 可用于验证一个符号是否在全域中. 
如果`x`在全域中, `(name x)`求值为`x`; 如果`x`不在全域中, 是一个语法错误.

`define-enumeration`也定义了一个命名为`constructor`的新句法形式, 可用于创建枚举类型(type)的子集(subset).
如果`x ...`每个均在全域中, `(constructor x ...)`求值为一个包含`x ...`的枚举集; 否则, 是一个语法错误.
同一个符号可以在`x ...`出现多次, 但结果集中只包含这个符号一次.

例:

```scheme
(define-enumeration weather-element
  (hot warm cold sunny rainy snowy windy)
  weather)

(weather-element hot) ;=> hot
(weather-element fun) ;=> syntax violation
(weather hot sunny windy) ;=> #<enum-set>
(enum-set->list (weather rainy cold rainy)) ;=> (cold rainy)
```

```scheme
procedure: (make-enumeration symbol-list)
returns: an enumeration set
libraries: (rnrs enums), (rnrs)
```

这个过程创建一个新的枚举类型, 它的全域由`symbol-list`中元素构成, `symbol-list`必须是一个符号列表, 全域中元素的顺序依据该符号列表中符号首次出现的顺序指定.
将新枚举类型的全域作为一个枚举集返回.

例:

```scheme
(define positions (make-enumeration '(top bottom above top beside)))
(enum-set->list positions) ;=> (top bottom above beside)
```

```scheme
procedure: (enum-set-constructor enum-set)
returns: an enumeration-set construction procedure
libraries: (rnrs enums), (rnrs)
```

这个过程返回一个过程`p`, 可用于创建`enum-set`的全域的子集.
`p`必须传入一个符号列表, 并且列表中每个元素是`enum-set`的全域中的元素.
`p`返回的值可以包含在`enum-set`的全域中但不在`enum-set`中的元素.

例:

```scheme
(define e1 (make-enumeration '(one two three four)))
(define p1 (enum-set-constructor e1))
(define e2 (p1 '(one three)))
(enum-set->list e2) ;=> (one three)
(define p2 (enum-set-constructor e2))
(define e3 (p2 '(one two four)))
(enum-set->list e3) ;=> (one two four)
```

```scheme
procedure: (enum-set-universe enum-set)
returns: the universe of enum-set, as an enumeration set
libraries: (rnrs enums), (rnrs)
```

例:

```scheme
(define e1 (make-enumeration '(a b c a b c d)))
(enum-set->list (enum-set-universe e1)) ;=> (a b c d)
(define e2 ((enum-set-constructor e1) '(c)))
(enum-set->list (enum-set-universe e2)) ;=> (a b c d)
```

```scheme
procedure: (enum-set->list enum-set)
returns: a list of the elements of enum-set
libraries: (rnrs enums), (rnrs)
```

结果列表中的符号的顺序依据创建`enum-set`的枚举类型指定的顺序.

例:

```scheme
(define e1 (make-enumeration '(a b c a b c d)))
(enum-set->list e1) ;=> (a b c d)
(define e2 ((enum-set-constructor e1) '(d c a b)))
(enum-set->list e2) ;=> (a b c d)
```

```scheme
procedure: (enum-set-subset? enum-set1 enum-set2)
returns: #t if enum-set1 is a subset of enum-set2, #f otherwise
libraries: (rnrs enums), (rnrs)
```

一个枚举集`enum-set1`是另一个枚举集`enum-set2`的子集, 当且仅当`enum-set1`的全域是`enum-set2`的全域的子集, 且`enum-set1`中每个元素也是`enum-set2`的元素.

例:

```scheme
(define e1 (make-enumeration '(a b c)))
(define e2 (make-enumeration '(a b c d e)))
(enum-set-subset? e1 e2) ;=> #t
(enum-set-subset? e2 e1) ;=> #f
(define e3 ((enum-set-constructor e2) '(a c)))
(enum-set-subset? e3 e1) ;=> #f
(enum-set-subset? e3 e2) ;=> #t
```

```scheme
procedure: (enum-set=? enum-set1 enum-set2)
returns: #t if enum-set1 and enum-set2 are equivalent, #f otherwise
libraries: (rnrs enums), (rnrs)
```

如果两个枚举集均是对方的子集, 则这两个枚举集等价(equivalent).

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(define e2 (make-enumeration '(b d c a)))
(enum-set=? e1 e2) ;=> #t
(define e3 ((enum-set-constructor e1) '(a c)))
(define e4 ((enum-set-constructor e2) '(a c)))
(enum-set=? e3 e4) ;=> #t
(enum-set=? e3 e2) ;=> #f
```

```scheme
procedure: (enum-set-member? symbol enum-set)
returns: #t if symbol is an element of enum-set, #f otherwise
libraries: (rnrs enums), (rnrs)
```

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(define e2 (make-enumeration '(b d c a)))
(enum-set=? e1 e2) ;=> #t
(define e3 ((enum-set-constructor e1) '(a c)))
(define e4 ((enum-set-constructor e2) '(a c)))
(enum-set=? e3 e4) ;=> #t
(enum-set=? e3 e2) ;=> #f
```

```scheme
procedure: (enum-set-union enum-set1 enum-set2)
returns: the union of enum-set1 and enum-set2
procedure: (enum-set-intersection enum-set1 enum-set2)
returns: the intersection of enum-set1 and enum-set2
procedure: (enum-set-difference enum-set1 enum-set2)
returns: the difference of enum-set1 and enum-set2
libraries: (rnrs enums), (rnrs)
```

`enum-set1`和`enum-set2`必须有相同的枚举类型.
每个过程返回表示两个集的并(union)、交(intersection)或差(difference)的新枚举集.

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(define e2 (make-enumeration '(b d c a)))
(enum-set=? e1 e2) ;=> #t
(define e3 ((enum-set-constructor e1) '(a c)))
(define e4 ((enum-set-constructor e2) '(a c)))
(enum-set=? e3 e4) ;=> #t
(enum-set=? e3 e2) ;=> #f
```

```scheme
procedure: (enum-set-complement enum-set)
returns: the complement of enum-set relative to its universe
libraries: (rnrs enums), (rnrs)
```

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(enum-set->list (enum-set-complement e1)) ;=> ()
(define e2 ((enum-set-constructor e1) '(a c)))
(enum-set->list (enum-set-complement e2)) ;=> (b d)
```

```scheme
procedure: (enum-set-projection enum-set1 enum-set2)
returns: the projection of enum-set1 into the universe of enum-set2
libraries: (rnrs enums), (rnrs)
```

移除`enum-set1`中所有不在`enum-set2`的全域中出现的元素.
结果的枚举类型与`enum-set2`相同.

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(define e2 (make-enumeration '(a b c d e f g)))
(define e3 ((enum-set-constructor e1) '(a d)))
(define e4 ((enum-set-constructor e2) '(a c e g)))
(enum-set->list (enum-set-projection e4 e3)) ;=> (a c)
(enum-set->list
  (enum-set-union e3
    (enum-set-projection e4 e3))) ;=> (a c d)
```

```scheme
procedure: (enum-set-indexer enum-set)
returns: a procedure that returns the index of a symbol in the universe of enum-set
libraries: (rnrs enums), (rnrs)
```

`enum-set-indexer`返回一个过程`p`, 将`p`应用在`enum-set`的全域中一个符号上时, 返回符号在构成全域的有序符号集中的索引(从0开始).
如果应用在不在全域中的符号上, `p`返回`#f`.

例:

```scheme
(define e1 (make-enumeration '(a b c d)))
(define e2 ((enum-set-constructor e1) '(a d)))
(define p (enum-set-indexer e2))
(list (p 'a) (p 'c) (p 'e)) ;=> (0 2 #f)
```

# 5 Input and Output

Introduction:

所有输入和输出操作是通过**端口(port)**执行的. 端口是一个指向数据(通常是一个文件)的(可能是无限的)流, 通过它, 程序可以从流中提取字节或字符, 或者将字节或字符填入流中. 端口可以是输入端口、输出端口或者输入输出端口.

端口在Scheme中是一等对象(first-class objects). 与过程类似, 端口没有一个可打印的表示. 初始时有3个端口: *当前输入端口(current input port)*、*当前输出端口(current output port)*和*当前错误端口(current error port)*, 它们是连接到进程的标准输入、标准输出和标准错误流的文本的端口(textual ports). Scheme中提供了打开新端口的几种方式.

输入端口通常指向一个有限的流, 例如存储在磁盘上的一个输入文件. 如果在已到达有限流末尾的端口上使用`get-u8`、`get-char`或`get-datum`等输出操作, 这些操作返回一个特殊的eof(end of file)对象. 使用谓词`eof-object?`确定这些过程返回的值是否是eof对象.

端口可以是*文本的(textual)*或*二进制的(binary)*. 二进制的端口允许程序在底层底层流上读取或者写入8位的无符号字节. 文本的端口允许程序读取或者写入字符.

在多种场景中, 底层的流被组织为字节的序列, 但这些字节应该被视为字符的编码. 这时, 可以使用**变码器(transcoder)**创建一个文本的端口, 将输入字节解码为字符, 将输出字符编码为字节.
变码器封装了一个**编解码器(codec)**, 编解码器确定了字符如何表示为字节. 提供了3个标准的编解码器: `latin-1`、`utf-8`和`uft-16`. 对于`latin-1`, 每个字符表示为一个字节; 对于`utf-8`, 每个字符表示为1到4个字节; 对于`utf-16`, 每个字符表示为2或4个字节.

变码器也封装了一个eol风格(style), 它确定如何识别行结束(line endings). 如果eol风格是`none`, 则不会识别任何行结束. 6个标准的行结束如下:

- `lf`: line-feed character,
- `cr`: carriage-return character,
- `nel`: Unicode next-line character,
- `ls`: Unicode line-seprator character,
- `crlf`: carriage return followed by line feed,
- `crnel`: carriage return followed by next line.

eol风格以不同的方式影响输入和输出操作. 
对于输入, 除了`none`之外的eol风格将每个行结尾字符或两字符序列转换为单个line-feed字符.
对于输出, 除了`none`之外的eol风格将line-feed字符转换为对应的单个字符或两字符序列.
在输入方向上, 除了`none`之外的eol风格之间等价; 在输出方向上, `none`与`lf`等价.

在编解码器和eol风格之外, 变码器封装了一个错误处理模式(error-handling mode), 它用于确定编码错误或解码错误时应该执行那些操作, 这些错误发生在在输入方向上不能使用封装的编解码器将一个字节序列转换为一个字符、在输出方向上不能使用封装的编解码器将一个字符转换为一个字节序列时.
错误处理模式的取值是`ignore`、`raise`、`replace`.
如果错误处理模式是`ignore`, 忽略相应的字节序列或字符.
如果错误处理模式是`raise`, 抛出状况类型为`io-decoding`或`i/o-encoding`的异常; 在输入方向上, 将端口中位置(position)移过相应的字节序列.
如果错误处理模式是`replace`, 生成替换字符或字符编码; 在输入方向上, 替换字符是U+FFFD, 在输出方向上, 对于`utf-8`和`utf-16`编解码器, 替换为U+FFFD的编码, 对于`latin-1`编解码器, 替换为问号字符(`?`)的编码.

端口可以是缓冲的(buffered), 以消除为每个字节或字符的操作系统调用成本. 支持3个标准的缓冲模式(buffer mode): `block`、`line`和`none`.
在块缓冲模式中, 以依赖于具体实现的大小从流中提取块, 将块填入流中.
在行缓冲模式中, 缓冲是以逐行的方式或者依赖于具体实现的方式执行. 只对于文本的输出端口, 行缓冲模式与块缓冲模式是可区分的; 在二进制的端口中没有行分界线(line divisons), 在流可用时从中提取输入.
在无缓冲模式中, 不执行缓冲, 从而输入立即写入流中, 只在需要时从流中提取输入.

## 5.1 Transcoders

??? quote "Introduction"

变码器(transcoder)封装了3个值: 编解码器(codec)、eol风格和错误处理模式(error-handling mode).

```scheme
procedure: (make-transcoder codec)
procedure: (make-transcoder codec eol-style)
procedure: (make-transcoder codec eol-style error-handling-mode)
returns: a transcoder encapsulating codec, eol-style, and error-handling-mode
libraries: (rnrs io ports), (rnrs)
```

`eol-style`必须是一个有效的eol风格符号(`lf`、`cr`、`nel`、`ls`、`crnel`、`none`); 默认为平台的本地eol风格.
`error-handling-mode`必须是一个有效的错误处理模式符号(`ignore`、`raise`、`replace`), 默认为`replace`.

```scheme
procedure: (transcoder-codec transcoder)
returns: the codec encapsulated in transcoder
procedure: (transcoder-eol-style transcoder)
returns: the eol-style symbol encapsulated in transcoder
procedure: (transcoder-error-handling-mode transcoder)
returns: the error-handling-mode symbol encapsulated in transcoder
libraries: (rnrs io ports), (rnrs)
```

```scheme
procedure: (native-transcoder)
returns: the native transcoder
libraries: (rnrs io ports), (rnrs)
```

本地变码器是依赖于具体实现的, 可能因平台或地区(locale)而不同.


```scheme
procedure: (latin-1-codec)
returns: a codec for ISO 8859-1 (Latin 1) character encodings
procedure: (utf-8-codec)
returns: a codec for Unicode UTF-8 character encodings
procedure: (utf-16-codec)
returns: a codec for Unicode UTF-16 character encodings
libraries: (rnrs io ports), (rnrs)
```

```scheme
syntax: (eol-style symbol)
returns: symbol
libraries: (rnrs io ports), (rnrs)
```

`symbol`必须是这些符号中的一个: `lf`、`cr`、`nel`、`ls`、`crnel`、`none`.
表达式`(eol-style symbol)`等价于表达式`(quote symbol)`, 除了前者在展开时(expansion time)检查`symbol`是否是eol风格符号中的一个.
`eol-style`语法也提供了一个有用的文档.

例:

```scheme
(eol-style crlf) ;=> crlf
(eol-style lfcr) ;=> syntax violation
```

```scheme
procedure: (native-eol-style)
returns: the native eol style
libraries: (rnrs io ports), (rnrs)
```

本地的eol风格是依赖于实现的, 可能因平台或地区(locale)而不同.

```scheme
syntax: (error-handling-mode symbol)
returns: symbol
libraries: (rnrs io ports), (rnrs)
```

`symbol`必须是这戏符号中的一个: `ignore`、`raise`、`replace`.
表达式`(error-handling-mode symbol)`等价于表达式`(quote symbol)`, 除了前者在展开时(expansion time)检查`symbol`是否是错误处理模式符号中的一个.
`error-handling-mode`语法也提供了一个有用的文档.

例:

```scheme
(error-handling-mode replace) ;=> replace
(error-handling-mode relpace) ;=> syntax violation
```

## 5.2 Open Files

??? quote "Introduction"

每个打开文件操作接受一个`path`参数, 该参数命名了需要打开的文件. 它必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.

一些打开文件过程接受可选的`options`、`b-mode`和`?transcoder`参数.
`options`参数必须是一个由有效的文件选项(file options)构成的枚举集, 默认为`(file-options)`.
`b-mode`必须是一个有效的缓冲模式, 默认为`block`.
`?transcoder`必须是一个变码器或`#f`. 如果是一个变码器, 打开操作返回底层二进制文件变码后的端口; 如果是`#f`(默认情况), 打开操作返回一个二进制的端口.

下面的过程创建的二进制的端口支持`port-postion`和`set-port-position!`操作. 下面的过程创建的文本的端口是否支持这些操作是依赖于具体实现的.

```scheme
syntax: (file-options symbol ...)
returns: a file-options enumeration set
libraries: (rnrs io ports), (rnrs)
```

文件选项枚举集可以作为参数传入打开文件操作中, 以控制打开操作.
有3个标准的文件选项: `no-create`、`no-fail`、`no-truncate`, 只影响创建输出端口(包括输入输出端口)的打开文件操作.

使用默认的文件选项, 即`(file-options)`, 当程序尝试打开文件用于输出时, 如果文件已存在则抛出状况类型`i/o-file-already-exists`的异常, 如果文件不存在则创建该文件.
如果包含了`no-fail`选项, 文件已存在时不抛出异常, 而是打开文件并将长度截断为0.
如果包含了`no-create`选项, 文件不存在时不会创建文件, 而是抛出状况类型`i/o-file-does-not-exist`的异常.
`no-create`选项蕴含了`no-faile`选项.
`no-truncate`选项只在`no-fail`选项被包含或因蕴含而被包含时适用, 适用时如果打开一个已存在的文件, 不会截断文件, 而是仍将端口的位置设置为文件的开始处. 

具体实现可以提供额外的文件选项符号.

```scheme
syntax: (buffer-mode symbol)
returns: symbol
libraries: (rnrs io ports), (rnrs)
```

`symbol`必须是这些符号中的一个: `block`、`line`、`none`.
表达式`(buffer-mode symbol)`等价于表达式`(quote symbol)`, 除了前者在展开时(expansion time)检查`symbol`是否是缓冲模式符号中的一个.
`buffer-mode`语法也提供了一个有用的文档.

例:

```scheme
(buffer-mode block) ;=> block
(buffer-mode cushion) ;=> syntax violation
```

```scheme
syntax: (buffer-mode? obj)
returns: #t if obj is a valid buffer mode, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

例:

```scheme
(buffer-mode? 'block) ;=> #t
(buffer-mode? 'line) ;=> #t
(buffer-mode? 'none) ;=> #t
(buffer-mode? 'something-else) ;=> #f
```

```scheme
procedure: (open-file-input-port path)
procedure: (open-file-input-port path options)
procedure: (open-file-input-port path options b-mode)
procedure: (open-file-input-port path options b-mode ?transcoder)
returns: a new input port for the named file
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, 这个过程返回一个变码器为`?transcoder`的文本的输入端口.
否则, 返回一个二进制的输入端口.

```scheme
procedure: (open-file-output-port path)
procedure: (open-file-output-port path options)
procedure: (open-file-output-port path options b-mode)
procedure: (open-file-output-port path options b-mode ?transcoder)
returns: a new output port for the named file
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, 这个过程返回一个变码器为`?transcoder`的文本的输出端口.
否则, 返回一个二进制的输出端口.

```scheme
procedure: (open-file-input/output-port path)
procedure: (open-file-input/output-port path options)
procedure: (open-file-input/output-port path options b-mode)
procedure: (open-file-input/output-port path options b-mode ?transcoder)
returns: a new input/output port for the named file
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, 这个过程返回一个变码器为`?transcoder`的文本的输入输出端口.
否则, 返回一个二进制的输入输出端口.

## 5.3 Standard Ports

```scheme
procedure: (current-input-port)
returns: the current input port
procedure: (current-output-port)
returns: the current output port
procedure: (current-error-port)
returns: the current error port
libraries: (rnrs io ports), (rnrs io simple), (rnrs)
```

分别返回初始时与进程的标准输入、标准输出和标准错误流关联的预建立的文本的端口.

`current-input-port`和`current-output-port`返回的值可以用便利I/O过程`with-input-from-file`和`with-output-to-file`临时性的改变.

```scheme
procedure: (standard-input-port)
returns: a fresh binary input port connected to the standard input stream
procedure: (standard-output-port)
returns: a fresh binary output port connected to the standard output stream
procedure: (standard-error-port)
returns: a fresh binary output port connected to the standard error stream
libraries: (rnrs io ports), (rnrs)
```

因为端口可以是缓冲的, 在附加到进程的标准流上的多个端口上的操作存在干扰时(interleaved), 会导致混乱(confusion).
这些过程通常只在程序不再需要任何已附加到进程的标准流上的端口时适用.

## 5.4 String and Bytevector Ports

??? quote "Introduction"

下面的过程创建的二进制的端口支持`port-postion`和`set-port-position!`操作. 下面的过程创建的文本的端口是否支持这些操作是依赖于具体实现的.

```scheme
procedure: (open-bytevector-input-port bytevector)
procedure: (open-bytevector-input-port bytevector ?transcoder)
returns: a new input port that draws input from bytevector
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, 这个过程返回一个变码器为`?transcoder`的文本的输入端口.
否则, 返回一个二进制的输入端口.

在调用这个过程之后修改`bytevector`的作用(effect)是未描述的.

不需要关闭一个字节向量端口, 它的存储与其它对象一样在不再需要时被自动回收(reclaimed automatically), 一个打开的字节向量端口不会占用(tie up)任何操作系统资源.

例:

```scheme
(let ([ip (open-bytevector-input-port #vu8(1 2))])
  (let* ([x1 (get-u8 ip)] [x2 (get-u8 ip)] [x3 (get-u8 ip)])
    (list x1 x2 (eof-object? x3)))) ;=> (1 2 #t)
```

```scheme
procedure: (open-string-input-port string)
returns: a new textual input port that draws input from string
libraries: (rnrs io ports), (rnrs)
```

在调用这个过程之后修改`string`的作用(effect)是未描述的.
返回的新端口可以有也可以没有一个变码器. 如果有变码器, 则该变码器是依赖于具体实现的.
尽管不是必须的, 鼓励具体实现支持字符串端口上的`port-postion`和`set-port-position!`操作.

不需要关闭一个字符串端口, 它的存储与其它对象一样在不再需要时被自动回收(reclaimed automatically), 一个打开的字符串端口不会占用(tie up)任何操作系统资源.

例:

```scheme
(get-line (open-string-input-port "hi.\nwhat's up?\n")) ;=> "hi."
```

```scheme
procedure: (open-bytevector-output-port)
procedure: (open-bytevector-output-port ?transcoder)
returns: two values, a new output port and an extraction procedure
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, 这个过程返回一个变码器为`?transcoder`的文本的输出端口.
否则, 返回一个二进制的输出端口.

提取过程(extraction procedure), 不使用参数调用时, 创建一个包含了端口中累积的(accumulated)字节的字节向量, 清空端口中累积的字节, 将端口的位置重置为0, 返回这个字节向量.
累积的字节包含任何超过当前位置末尾写入的字节(如果已将位置从最大值设置回当前的位置).

不需要关闭一个字节向量端口, 它的存储与其它对象一样在不再需要时被自动回收(reclaimed automatically), 一个打开的字节向量端口不会占用(tie up)任何操作系统资源.

例:

```scheme
(let-values ([(op g) (open-bytevector-output-port)])
  (put-u8 op 15)
  (put-u8 op 73)
  (put-u8 op 115)
  (set-port-position! op 2)
  (let ([bv1 (g)])
    (put-u8 op 27)
    (list bv1 (g)))) ;=> (#vu8(15 73 115) #vu8(27))
```

```scheme
procedure: (open-string-output-port)
returns: two values, a new textual output port and an extraction procedure
libraries: (rnrs io ports), (rnrs)
```

提取过程(extraction procedure), 不使用参数调用时, 创建一个包含了端口中累积的(accumulated)字符的字符串, 清空端口中累积的字符, 将端口的位置重置为0, 返回这个字符串.
累积的字符包含任何超过当前位置末尾写入的字符(如果已将位置从最大值设置回当前的位置).
尽管不是必须的, 鼓励具体实现支持字符串端口上的`port-postion`和`set-port-position!`操作.

不需要关闭一个字符串端口, 它的存储与其它对象一样在不再需要时被自动回收(reclaimed automatically), 一个打开的字符串端口不会占用(tie up)任何操作系统资源.

例:

```scheme
(let-values ([(op g) (open-string-output-port)])
  (put-string op "some data")
  (let ([str1 (g)])
    (put-string op "new stuff")
    (list str1 (g)))) ;=> ("some data" "new stuff")
```

```scheme
procedure: (call-with-bytevector-output-port procedure)
procedure: (call-with-bytevector-output-port procedure ?transcoder)
returns: a bytevector containing the accumulated bytes
libraries: (rnrs io ports), (rnrs)
```

如果提供了`?transcoder`参数, 且其值不为`#f`, 它必须是一个变码器, `procedure`的参数是一个其变码器是`?transcoder`的文本的字节向量输出端口; 否则, `procedure`的参数是一个二进制的字节向量输出端口.
如果`procedure`返回, 创建一个包含了端口中累积的字节的字节向量, 清空端口中累积的字节, 将端口的位置重置为0, 最终返回该字节向量. 如果`procedure`因调用在`procedure`活跃时创建的continuation而返回多次, 这些动作在每次`procedure`返回时发生.

例:

```scheme
(let ([tx (make-transcoder (latin-1-codec) (eol-style lf)
            (error-handling-mode replace))])
  (call-with-bytevector-output-port
    (lambda (p) (put-string p "abc"))
    tx)) ;=> #vu8(97 98 99)
```

```scheme
procedure: (call-with-string-output-port procedure)
returns: a string containing the accumulated characters
libraries: (rnrs io ports), (rnrs)
```

`procedure`接受单个字符串输出端口参数. 如果`procedure`返回, 创建一个包含了端口中累积的字符的字符串, 清空端口中累积的字符, 将端口的位置重置为0, 最终返回该字符串. 如果`procedure`因调用在`procedure`活跃时创建的continuation而返回多次, 这些动作在每次`procedure`返回时发生.

`call-with-string-output-port`可以与`put-datum`一起使用, 来定义过程`object->string`, 返回一个包含了对象打印表示的字符串.

例:

```scheme
(define (object->string x)
  (call-with-string-output-port
    (lambda (p) (put-datum p x))))

(object->string (cons 'a '(b c))) ;=> "(a b c)"
```

## 5.5 Open Custom Ports

```scheme
procedure: (make-custom-binary-input-port id r! gp sp! close)
returns: a new custom binary input port
procedure: (make-custom-binary-output-port id w! gp sp! close)
returns: a new custom binary output port
procedure: (make-custom-binary-input/output-port id r! w! gp sp! close)
returns: a new custom binary input/output port
libraries: (rnrs io ports), (rnrs)
```

这些过程允许程序从任意字节流上创建端口.
`id`必须是命名了新端口的字符串, 这个名称只用于信息意图(informational purpose), 具体实现可以选择讲他包含在打印语法中.
`r!`和`w!`必须是过程, `gp`、`sp!`和`close`必须是过程或`#f`.

`r!` 用于从自定义端口中提取输入, 例如为支持`get-u8`或`get-bytevector-n`. 它接受3个参数: `bytevector`、`start`和`n`.
`start`是一个非负的精确的整数, `n`是一个精确的正整数, `start`和`n`的和不能超过`bytevector`的长度.
如果字节流处于文件末尾处, `r!`应该返回精确的0; 否则, 它应该从流中读取至少1个至多`n`个字节, 将这些字节存储在`bytevector`中从`start`开始的连续位置中, 并返回一个表示实际读取字节数量的精确的正整数.

`w!` 用于将输出写入端口, 例如为支持`put-u8`或`put-bytevector`. 它接受3个参数: `bytevector`、`start`和`n`.
`start`和`n`必须是非负的精确的整数, `sum`和`n`的和不能超过`bytevector`的长度.
`w!`应该最多将`bytevector`中从`start`开始的连续`n`个字节写入端口, 返回一个表示实际写入字节数量的精确的非负整数.

`gp` 用于查询端口的位置. 如果为`#f`, 该端口不支持`port-postion`. 如果不为`#f`, 它接受零个参数, 将从字节流开始处到当前位置的字节偏移量(displacement)作为一个精确的非负整数返回.

`sp!` 用于设置端口的位置. 如果为`#f`, 该端口不支持`set-port-position!`. 如果不为`#f`, 它接受单个参数, 一个表示从字节流开始处到新位置的字节偏移量的精确的非负整数, 并将端口的位置设置为该值.

`close` 用于关闭字节流. 如果为`#f`, 当该端口关闭时, 不执行动作以关闭字节流. 如果不为`#f`, 它接受零个参数, 并指定任何关闭字节流所需的动作.

如果返回的端口时一个输入输出端口, 且没有提供`gp`或`sp!`过程, 如果一个输出操作在一个输入操作之后发生, 具体实现可能无法恰当的设置端口的位置, 这是因为必须有输入缓冲以支持`lookahead-u8`、处于效率考虑通常会支持输入缓冲. 
同样的原因, 如果没有提供`sp!`过程, 在一个输入操作后调用`port-position`不能返回正确的位置.
因此, 创建自定义二进制的输入输出端口的程序, 通常应该同时提供`gp`和`sp!`过程.

```scheme
procedure: (make-custom-textual-input-port id r! gp sp! close)
returns: a new custom textual input port
procedure: (make-custom-textual-output-port id w! gp sp! close)
returns: a new custom textual output port
procedure: (make-custom-textual-input/output-port id r! w! gp sp! close)
returns: a new custom textual input/output port
libraries: (rnrs io ports), (rnrs)
```

这些过程允许程序从任意字符流上创建端口.
`id`必须是命名了新端口的字符串, 这个名称只用于信息意图(informational purpose), 具体实现可以选择讲他包含在打印语法中.
`r!`和`w!`必须是过程, `gp`、`sp!`和`close`必须是过程或`#f`.

`r!` 用于从自定义端口中提取输入, 例如为支持`get-char`或`get-string-n`. 它接受3个参数: `string`、`start`和`n`.
`start`是一个非负的精确的整数, `n`是一个精确的正整数, `start`和`n`的和不能超过`string`的长度.
如果字符流处于文件末尾处, `r!`应该返回精确的0; 否则, 它应该从流中读取至少1个至多`n`个字符, 将这些字符存储在`string`中从`start`开始的连续位置中, 并返回一个表示实际读取字符数量的精确的正整数.

`w!` 用于将输出写入端口, 例如为支持`put-char`或`put-string`. 它接受3个参数: `string`、`start`和`n`.
`start`和`n`必须是非负的精确的整数, `sum`和`n`的和不能超过`string`的长度.
`w!`应该最多将`string`中从`start`开始的连续`n`个字符写入端口, 返回一个表示实际写入字符数量的精确的非负整数.

`gp` 用于查询端口的位置. 如果为`#f`, 该端口不支持`port-postion`. 如果不为`#f`, 它接受零个参数, 返回当前位置(可以是任意值).

`sp!` 用于设置端口的位置. 如果为`#f`, 该端口不支持`set-port-position!`. 如果不为`#f`, 它接受单个参数`pos`, 一个表示新位置的值. 如果`pos`是之前对`gp`调用的结果, `sp!`将位置设置为`pos`.

`close` 用于关闭字符流. 如果为`#f`, 当该端口关闭时, 不执行动作以关闭字符流. 如果不为`#f`, 它接受零个参数, 并指定任何关闭字符流所需的动作.

如果返回的端口时一个输入输出端口, 甚至在已提供`gp`或`sp!`过程的情况下, 如果一个输出操作在一个输入操作之后发生, 具体实现可能无法恰当的设置端口的位置, 这是因为必须有输入缓冲以支持`lookahead-char`、处于效率考虑通常会支持输入缓冲. 由于端口位置的表示是未描述的, 具体实现不能调整`gp`的返回值以考虑缓冲的字符的数量.
同样的原因, 甚至在已提供`sp!`过程的情况下, 如果没有提供`sp!`过程, 在一个输入操作后调用`port-position`不能返回正确的位置.

总是应该可以在读取之后, 将位置重置为开始位置, 再可靠的执行输出.
因此, 创建自定义文本的输入输出端口的程序, 应该同时提供`gp`和`sp!`过程, 使用这些端口的代码应该在任意输入操作之前通过`port-postion`获取开始位置, 并在任意输出操作之前重置位置回开始位置.

## 5.6 Port Operations

```scheme
procedure: (port? obj)
returns: #t if obj is a port, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

```scheme
procedure: (input-port? obj)
returns: #t if obj is an input or input/output port, #f otherwise
procedure: (output-port? obj)
returns: #t if obj is an output or input/output port, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs)
```

```scheme
procedure: (binary-port? obj)
returns: #t if obj is a binary port, #f otherwise
procedure: (textual-port? obj)
returns: #t if obj is a textual port, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

```scheme
procedure: (close-port port)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

如果`port`没有关闭, `close-port`关闭它, 如果该端口是一个输出端口, 首先将缓冲的字节或字符刷出(flush).
一旦端口已关闭, 不可以在该端口上执行输入或输出操作.
因为操作系统可能限制同时打开的文件端口的数量或限制对一个已打开文件的访问, 将不再使用的文件端口关闭是一个好的实践.
如果该端口是一个输出端口, 显式的关闭该端口可以确保缓冲的数据写入底层流中.
一些Scheme实现在程序中文件端口变为不可达时或Scheme程序退出时, 自动关闭该文件端口, 但最好是显式的关闭文件端口.
关闭一个已经关闭的端口没有任何作用(effect).

```scheme
procedure: (transcoded-port binary-port transcoder)
returns: a new textual port with the same byte stream as binary-port
libraries: (rnrs io ports), (rnrs)
```

这个过程返回一个新的文本的端口, 该端口有变码器`transcoder`, 有与`binary-port`相同的底层字节流, 其位置在`binary-port`的当前位置.

作为创建该文本的端口的副作用, `binary-port`被关闭以避免`binary-port`上的读或写操作与该文本的端口上的读和写操作相干扰(interfering).
底层的字节流仍保持打开, 直到该文本的端口被关闭.

```scheme
procedure: (port-transcoder port)
returns: the transcoder associated with port if any, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

这个过程对于二进制的端口总是返回`#f`, 对于一些文本的端口返回`#f`.

```scheme
procedure: (port-position port)
returns: the port's current position
procedure: (port-has-port-position? port)
returns: #t if the port supports port-position, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

一个端口允许查询其在底层字节或字符流中的当前位置.
如果是这样, `port-has-port-position?`返回`#t`, `port-position`返回当前位置.
对于二进制的端口, 这个位置总是一个精确的非负整数, 表示从字节流开始处的偏移量(displacement).
对于文本的端口, 位置的表示是未描述的; 它可以不是一个精确的非负整数, 甚至它是时, 不表示在底层流中的字节或字符偏移量.
在端口支持`set-port-position!`时, 这个位置可以后续用来重置位置.
如果在不支持`port-position`的端口上调用它, 抛出状况类型`&assertion`的异常.

```scheme
procedure: (set-port-position! port pos)
returns: unspecified
procedure: (port-has-set-port-position!? port)
returns: #t if the port supports set-port-position!, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

一个端口允许直接将其当前位置移动到底层字节或字符流中的一个不同位置.
如果是这样, `port-has-set-port-position!?`返回`#t`, `set-port-position!`修改当前位置.
对于二进制的端口, 位置`pos`必须是一个精确的非负整数, 表示从字节流开始处的偏移量.
对于文本的端口, 位置的表示是未描述的, 但`pos`必须是一个恰当的位置, 这仅在`pos`是从同一个端口调用`port-position`获得时成立.
如果在不支持`set-port-position!`的端口上调用它, 抛出状况类型`&assertion`的异常.

如果`port`是一个二进制的输出端口, 将位置设置为越过底层流中数据的当前末尾, 这个流在新的数据写入该位置之前不会扩展.
如果在该位置写入了新数据, 每个中间位置上的内容是未描述的.
使用`open-file-output-port`和`open-file-input/output-port`创建的二进制的端口, 总是可以在底层操作系统的限制下以上述的行为扩展.
在其它情况下, 尝试端口的位置设置为越过在底层对象的当前数据末尾, 可能导致状况类型`&i/o-invalid-position`的异常.

```scheme
procedure: (call-with-port port procedure)
returns: the values returned by procedure
libraries: (rnrs io ports), (rnrs)
```

`call-with-port`以`port`作为唯一的参数调用`procedure`. 如果`procedure`返回, `call-with-port`关闭端口, 并将`procedure`的返回值作为返回值返回.

如果一个在`procedure`外部创建的continuation被调用, `call-with-port`不会自动关闭端口, 这是因为在`procedure`内部创建的另一个continuation会在稍后调用, 将控制转到`procedure`中. 如果`procedure`不会返回, 具体实现可以自由的仅在可以证明输出端口不在可访问时关闭端口.

例:

```scheme
(call-with-port (open-file-input-port "infile" (file-options)
                  (buffer-mode block) (native-transcoder))
  (lambda (ip)
    (call-with-port (open-file-output-port "outfile"
                      (file-options no-fail)
                      (buffer-mode block)
                      (native-transcoder)) 
      (lambda (op)
        (do ([c (get-char ip) (get-char ip)])
            ((eof-object? c))
          (put-char op c))))))
```

```scheme
procedure: (output-port-buffer-mode port)
returns: the symbol representing the buffer mode of port
libraries: (rnrs io ports), (rnrs)
```

## 5.7 Input Operations

```scheme
procedure: (eof-object? obj)
returns: #t if obj is an eof object, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs)
```

当输入端口已到达输入末尾时, 诸如`get-datum`的输入操作返回end-of-file对象.

```scheme
procedure: (eof-object)
returns: the eof object
libraries: (rnrs io ports), (rnrs io simple), (rnrs)
```

例:

```scheme
(eof-object? (eof-object)) ;=> #t
```

```scheme
procedure: (get-u8 binary-input-port)
returns: the next byte from binary-input-port, or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`binary-input-port`在文件末尾, 返回eof对象. 否则, 将下一个可用字节作为无符号的8位量返回, 即一个精确的无符号整数(小于等于255), 端口的位置向前移动一个字节.

```scheme
procedure: (lookahead-u8 binary-input-port)
returns: the next byte from binary-input-port, or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`binary-input-port`在文件末尾, 返回eof对象. 否则, 将下一个可用字节作为无符号的8位量返回, 即一个精确的无符号整数(小于等于255). 
与`get-u8`不同, `lookahead-u8`不消耗它从端口读取的字节, 从而在该端口上后续调用`lookahead-u8`或`get-u8`, 返回相同的字节.

```scheme
procedure: (get-bytevector-n binary-input-port n)
returns: a nonempty bytevector containing up to n bytes, or the eof object
libraries: (rnrs io ports), (rnrs)
```

`n`必须是一个精确的非负整数.
如果`binary-input-port`在文件末尾, 返回eof对象. 否则, `get-bytevector-n`在文件端口在文件末尾之前最多读取`n`个可用字节, 返回包含这些字节的一个新字节向量.
端口的位置向前移动过这些读取的字节.

```scheme
procedure: (get-bytevector-n! binary-input-port bytevector start n)
returns: the count of bytes read or the eof object
libraries: (rnrs io ports), (rnrs)
```

`start`和`n`必须是精确的非负整数, `start`和`n`的和不能超过`bytevector`的长度.

如果`binary-input-port`在文件末尾, 返回eof对象. 否则, `get-bytevector-n!`在文件端口在文件末尾之前最多读取`n`个可用字节, 将这些字节存储在`bytevector`中从`start`开始的连续位置中, 将读取的字节数量作为一个精确的正整数返回.
端口的位置向前移动过这些读取的字节.

```scheme
procedure: (get-bytevector-some binary-input-port)
returns: a nonempty bytevector or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`binary-input-port`在文件末尾, 返回eof对象. 否则, `get-bytevector-some`至少读取一个字节或更多, 返回一个包含这些字节的字节向量.
端口的位置向前移动过这些读取的字节.
这个操作能够读取的字节最大数量是依赖于具体实现的.

```scheme
procedure: (get-bytevector-all binary-input-port)
returns: a nonempty bytevector or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`binary-input-port`在文件末尾, 返回eof对象. 否则, `get-bytevector-all`读取在端口位于文件末尾之前的所有字节, 返回一个包含这些字节的字节向量.
端口的位置向前移动过这些读取的字节.

```scheme
procedure: (get-char textual-input-port)
returns: the next character from textual-input-port, or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`textual-input-port`在文件末尾, 返回eof对象. 否则, 返回下一个可用的字符, 端口的位置向前移动一个字符.
如果`textual-input-port`是一个被变码的端口, 底层字节流中的位置可能向前移动超过一个字节.

```scheme
procedure: (lookahead-char textual-input-port)
returns: the next character from textual-input-port, or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`textual-input-port`在文件末尾, 返回eof对象. 否则, 返回下一个可用的字符. 
与`get-char`不同, `lookahead-char`不消耗它从端口读取的字符, 从而在该端口上后续调用`lookahead-char`或`get-char`, 返回相同的字符.

例:

```scheme
(define get-word
  (lambda (p)
    (list->string
      (let f ()
        (let ([c (lookahead-char p)])
          (cond
            [(eof-object? c) '()]
            [(char-alphabetic? c) (get-char p) (cons c (f))]
            [else '()]))))))
```

```scheme
procedure: (get-string-n textual-input-port n)
returns: a nonempty string containing up to n characters, or the eof object
libraries: (rnrs io ports), (rnrs)
```

`n`必须是一个精确的非负整数.
如果`textual-input-port`在文件末尾, 返回eof对象. 否则, `get-string-n`在文件端口在文件末尾之前最多读取`n`个可用字符, 返回包含这些字符的一个新字符串.
端口的位置向前移动过这些读取的字符.

```scheme
procedure: (get-string-n! textual-input-port string start n)
returns: the count of characters read or the eof object
libraries: (rnrs io ports), (rnrs)
```

`start`和`n`必须是精确的非负整数, `start`和`n`的和不能超过`string`的长度.

如果`textual-input-port`在文件末尾, 返回eof对象. 否则, `get-string-n!`在文件端口在文件末尾之前最多读取`n`个可用字符, 将这些字符存储在`string`中从`start`开始的连续位置中, 将读取的字符数量作为一个精确的正整数返回.
端口的位置向前移动过这些读取的字符.

例:

```scheme
(define string-set!
  (lambda (s i c)
    (let ([sip (open-string-input-port (string c))])
      (get-string-n! sip s i 1)
     ; return unspecified values:
      (if #f #f))))

(define string-fill!
  (lambda (s c)
    (let ([n (string-length s)])
      (let ([sip (open-string-input-port (make-string n c))])
        (get-string-n! sip s 0 n)
       ; return unspecified values:
        (if #f #f)))))

(let ([x (make-string 3)])
  (string-fill! x #\-)
  (string-set! x 2 #\))
  (string-set! x 0 #\;)
  x) ;=> ";-)"
```

```scheme
procedure: (get-string-all textual-input-port)
returns: a nonempty string or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`textual-input-port`在文件末尾, 返回eof对象. 否则, `get-string-all`在端口在文件末尾之前读取所有字符, 返回一个包含这些字符的字符串.
端口的位置向前移动过这些读取的字符.

```scheme
procedure: (get-line textual-input-port)
returns: a string or the eof object
libraries: (rnrs io ports), (rnrs)
```

如果`textual-input-port`在文件末尾, 返回eof对象. 否则, `get-line`在端口在文件末尾或读到一个line-feed字符之前读取到的所有字符, 将除line-feed字符之外所有读取到的字符作为一个字符串返回.
端口的位置向前移动过这些读取的字符.

例:

```scheme
(let ([sip (open-string-input-port "one\ntwo\n")])
  (let* ([s1 (get-line sip)] [s2 (get-line sip)])
    (list s1 s2 (port-eof? sip)))) ;=> ("one" "two" #t)

(let ([sip (open-string-input-port "one\ntwo")])
  (let* ([s1 (get-line sip)] [s2 (get-line sip)])
    (list s1 s2 (port-eof? sip)))) ;=> ("one" "two" #t)
```

```scheme
procedure: (get-datum textual-input-port)
returns: a Scheme datum object or the eof object
libraries: (rnrs io ports), (rnrs)
```

这个过程扫描时忽略空白和注释, 以找到一个数据项(datum)的外部表示的起始处.
如果`textual-input-port`在找到一个数据项的外部表示的起始处之前达到文件末尾, 返回eof对象.

否则, `get-datum`读取必要数量的字符, 解析单个数据项, 返回一个新分配的对象, 它的结构由该外部表示确定.
端口的位置向前移动过这些读取的字符.
如果在数据项的完整外部表示之前遇到end-of-file, 或者读到一个不符合预期的字符, 抛出状况类型`&lexical`和`&i/o-read`的异常.

例:

```scheme
(let ([sip (open-string-input-port "; a\n\n one (two)\n")])
  (let* ([x1 (get-datum sip)]
         [c1 (lookahead-char sip)]
         [x2 (get-datum sip)])
    (list x1 c1 x2 (port-eof? sip)))) ;=> (one #\space (two) #f)
```

```scheme
procedure: (port-eof? input-port)
returns: #t if input-port is at end-of-file, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

这个过程与二进制的端口上`lookahead-u8`或文本的端口上`lookahead-char`类似, 但它不是返回下一个字节/字符或eof对象, 而是返回一个表明该值是否是一个eof对象的布尔值.

## 5.8 Output Operations

```scheme
procedure: (put-u8 binary-output-port octet)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

`octet`必须是一个精确的非负整数(小于等于255).
这个过程将`octet`写入`binary-output-port`, 将端口的位置向前移动一个字节.

```scheme
procedure: (put-bytevector binary-output-port bytevector)
procedure: (put-bytevector binary-output-port bytevector start)
procedure: (put-bytevector binary-output-port bytevector start n)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

`start`和`n`必须是精确的非负整数, `start`和`n`的和不能超过`bytevector`的长度.
如果没有提供, `start`的默认值为0, `n`的默认值是`bytevector`的长度与`start`的差值.

这个过程将`bytevector`中从`start`开始的`n`个字节写入端口, 并将端口的位置向前移动越过写入的字节.

```scheme
procedure: (put-char textual-output-port char)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

这个过程将`char`写入`textual-output-port`, 将端口的位置向前移动一个字符.
如果`textual-output-port`是一个被变码的端口, 底层字节流中的位置可能向前移动超过一个字节.

```scheme
procedure: (put-string textual-output-port string)
procedure: (put-string textual-output-port string start)
procedure: (put-string textual-output-port string start n)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

`start`和`n`必须是精确的非负整数, `start`和`n`的和不能超过`string`的长度.
如果没有提供, `start`的默认值为0, `n`的默认值是`string`的长度与`start`的差值.

这个过程将`string`中从`start`开始的`n`个字符写入端口, 将端口的位置向前移动越过写入的字符.

```scheme
procedure: (put-datum textual-output-port obj)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

这个过程将`obj`的外部表示写入`textual-output-port`.
如果`obj`没有一个作为数据项的外部表示, 其行为是未描述的.
精确的外部表示是依赖于具体实现的, 但当`obj`有一个作为数据项的外部表示实现时, `put-datum`应该生成一个字符序列, 这个字符序列后续被`get-datum`读取生成一个在`equal?`下与`obj`等价的对象.
例:

```scheme
procedure: (flush-output-port output-port)
returns: unspecified
libraries: (rnrs io ports), (rnrs)
```

这个过程强制将与`output-port`关联的缓冲中任意字节或字符立即传入底层的流中.

## 5.9 Convenience I/O

??? quote "Introduction"

下面的便利的输入输出过程中可以通过传入或不传入一个显式的端口参数. 如果没有传入显式的端口参数, 则使用当前的输入或输出端口. 例如, `(read-char)`和`(read-char (current-input-port))`均返回从当前输入端口读取的下一个字符.

```scheme
procedure: (open-input-file path)
returns: a new input port
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`open-input-file`为`path`命名的文件创建一个新的文本的输入端口, 就像使用默认选项、依赖于具体实现的缓冲模式和变码器调用`open-file-input-port`.

例:

```scheme
(let ([p (open-input-file "myfile.ss")])
  (let f ([x (read p)])
    (if (eof-object? x)
        (begin
          (close-port p)
          '())
        (cons x (f (read p))))))
```

```scheme
procedure: (open-output-file path)
returns: a new output port
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`open-output-file`为`path`命名的文件创建一个新的文本的输出端口, 就像使用默认选项、依赖于具体实现的缓冲模式和变码器调用`open-file-output-port`.

例:

```scheme
(let ([p (open-output-file "myfile.ss")])
  (let f ([ls list-to-be-printed])
    (if (not (null? ls))
        (begin
          (write (car ls) p)
          (newline p)
          (f (cdr ls)))))
  (close-port p))
```

```scheme
procedure: (call-with-input-file path procedure)
returns: the values returned by procedure
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`procedure`必须接受单个参数.

`call-with-input-file`为`path`命名的文件创建一个新的输入端口, 就像调用了`open-input-file`, 并将该端口传递给`procedure`.
如果`procedure`返回, `call-with-input-file`关闭这个输入端口, 将`procedure`的返回值作为返回值返回.

如果一个在`procedure`外部创建的continuation被调用, `call-with-input-file`不会自动关闭端口, 这是因为在`procedure`内部创建的另一个continuation会在稍后调用, 将控制转到`procedure`中. 如果`procedure`不会返回, 具体实现可以自由的仅在可以证明输出端口不在可访问时关闭端口.
使用`dynamic-wind`可以确保如果一个在`procedure`外部创建的continuation被调用, 该端口被关闭.

例:

```scheme
(call-with-input-file "myfile.ss"
  (lambda (p)
    (let f ([x (read p)])
      (if (eof-object? x)
          '()
          (cons x (f (read p)))))))
```

```scheme
procedure: (call-with-output-file path procedure)
returns: the values returned by procedure
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`procedure`必须接受单个参数.

`call-with-output-file`为`path`命名的文件创建一个新的输出端口, 就像调用了`open-output-file`, 并将该端口传递给`procedure`.
如果`procedure`返回, `call-with-input-file`关闭这个输入端口, 将`procedure`的返回值作为返回值返回.

如果一个在`procedure`外部创建的continuation被调用, `call-with-output-file`不会自动关闭端口, 这是因为在`procedure`内部创建的另一个continuation会在稍后调用, 将控制转到`procedure`中. 如果`procedure`不会返回, 具体实现可以自由的仅在可以证明输出端口不在可访问时关闭端口.
使用`dynamic-wind`可以确保如果一个在`procedure`外部创建的continuation被调用, 该端口被关闭.

例:

```scheme
(call-with-output-file "myfile.ss"
  (lambda (p)
    (let f ([ls list-to-be-printed])
      (unless (null? ls)
        (write (car ls) p)
        (newline p)
        (f (cdr ls))))))
```

```scheme
procedure: (with-input-from-file path thunk)
returns: the values returned by thunk
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`thunk`必须是一个不接受任何参数的过程.

`with-input-from-file`在应用`thunk`期间, 临时的将当前输入端口修改为打开由`path`命名的文件创建的端口, 就像调用了`open-input-file`. 如果`thunk`返回, 该端口被关闭, 当前输入端口被恢复为旧值.

如果一个在`thunk`外部创建的continuation在`thunk`返回之前被调用, `with-input-from-file`的行为是未描述的. 具体实现可以关闭该端口, 并将当前输入端口恢复为旧值.

```scheme
procedure: (with-output-to-file path thunk)
returns: the values returned by thunk
libraries: (rnrs io simple), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`thunk`必须是一个不接受任何参数的过程.

`with-output-from-file`在应用`thunk`期间, 临时的将当前输出端口修改为打开由`path`命名的文件创建的端口, 就像调用了`open-output-file`. 如果`thunk`返回, 该端口被关闭, 当前输出端口被恢复为旧值.

如果一个在`thunk`外部创建的continuation在`thunk`返回之前被调用, `with-output-from-file`的行为是未描述的. 具体实现可以关闭该端口, 并将当前输出端口恢复为旧值.

```scheme
procedure: (read)
procedure: (read textual-input-port)
returns: a Scheme datum object or the eof object
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-input-port`参数, 使用的是当前输入端口.
除此之外, 该过程与`get-datum`等同.

```scheme
procedure: (read-char)
procedure: (read-char textual-input-port)
returns: the next character from textual-input-port
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-input-port`参数, 使用的是当前输入端口.
除此之外, 该过程与`get-char`等同.

```scheme
procedure: (peek-char)
procedure: (peek-char textual-input-port)
returns: the next character from textual-input-port
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-input-port`参数, 使用的是当前输入端口.
除此之外, 该过程与`lookahead-char`等同.

```scheme
procedure: (write obj)
procedure: (write obj textual-output-port)
returns: unspecified
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-output-port`参数, 使用的是当前输出端口.
除此之外, 该过程与使用相反的参数顺序调用`put-datum`等同.

```scheme
procedure: (display obj)
procedure: (display obj textual-output-port)
returns: unspecified
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-output-port`参数, 使用的是当前输出端口.

`display`与`write`、`put-datum`类似, 但直接打印`obj`中的字符和字符串.
打印出的字符串没有引号标记或特殊转移字符(就像`put-string`), 打印出的字符没有`#\`记号(就像`put-char`).
使用`display`时, 三元素的列表`(a b c)`和两元素的列表`("a b" c)`, 均打印出`(a b c)`.
因此, 不应该使用`display`打印预期被`read`读取的对象.
`display`通常用于打印消息, 这时的`obj`通常是一个字符串.

```scheme
procedure: (write-char char)
procedure: (write-char char textual-output-port)
returns: unspecified
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-output-port`参数, 使用的是当前输出端口.
除此之外, 该过程与使用相反的参数顺序调用`put-char`等同.

```scheme
procedure: (newline)
procedure: (newline textual-output-port)
returns: unspecified
libraries: (rnrs io simple), (rnrs)
```

如果没有提供`textual-output-port`参数, 使用的是当前输出端口.
`newline`将一个line-feed字符写入端口.

```scheme
procedure: (close-input-port input-port)
procedure: (close-output-port output-port)
returns: unspecified
libraries: (rnrs io simple), (rnrs)
```

`close-input-port`关闭一个输入端口, `close-output-port`关闭一个输出端口.
这两个过程是为了兼容R5RS, 并不比`close-port`方便.

## 5.10 Filesystem Operations

```scheme
procedure: (file-exists? path)
returns: #t if the file named by path exists, #f otherwise
libraries: (rnrs files), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
`file-exists?`是否跟随符号链接(symbolic links), 是未描述的.

```scheme
procedure: (delete-file path)
returns: unspecified
libraries: (rnrs files), (rnrs)
```

`path`必须是一个字符串或其它依赖于具体实现的命名了一个文件的值.
如果由`path`命名的文件存在且可以被删除, `delete-file`删除该文件; 否则抛出状况类型`&i/o-filename`的异常.
`delete-file`是否跟随符号链接(symbolic links), 是未描述的.

## 5.11 Bytevector/String Conversions

```scheme
procedure: (bytevector->string bytevector transcoder)
returns: a string containing the characters encoded in bytevector
libraries: (rnrs io ports), (rnrs)
```

这个过程实际上会使用提供的`transcoder`创建一个字节向量输入端口, 就像使用`get-string-all`那样读取端口中所有可用字符, 并将这些字符放置在结果字符串中.

例:

```scheme
(let ([tx (make-transcoder (utf-8-codec) (eol-style lf)
            (error-handling-mode replace))])
  (bytevector->string #vu8(97 98 99) tx)) ;=> "abc"
```

```scheme
procedure: (string->bytevector string transcoder)
returns: a bytevector containing the encodings of the characters in string
libraries: (rnrs io ports), (rnrs)
```

这个过程实际上会使用提供的`transcoder`创建一个子集向量输出端口, 写入`string`中所有字符, 然后从累积的字节中提取结果字节向量.

例:

```scheme
(let ([tx (make-transcoder (utf-8-codec) (eol-style none)
            (error-handling-mode raise))])
  (string->bytevector "abc" tx)) ;=> #vu8(97 98 99)
```

```scheme
procedure: (string->utf8 string)
returns: a bytevector containing the UTF-8 encoding of string
libraries: (rnrs bytevectors), (rnrs)
```

```scheme
procedure: (string->utf16 string)
procedure: (string->utf16 string endianness)
procedure: (string->utf32 string)
procedure: (string->utf32 string endianness)
returns: a bytevector containing the specified encoding of string
libraries: (rnrs bytevectors), (rnrs)
```

`endianness`必须是符号`big`或`little`中的一个.
如果没有提供`endianness`参数或者`endianness`是`big`, `string->utf16`返回`string`的UTF-16BE编码, `string->utf32`返回`string`的UTF-32BE编码.
如果`endianness`是`little`, `string->utf16`返回`string`的UTF-16LE编码, `string->utf32`返回`string`的UTF-32LE编码.
编码中没有字节序标记(byte-order mark, BOM).

```scheme
procedure: (utf8->string bytevector)
returns: a string containing the UTF-8 decoding of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

```scheme
procedure: (utf16->string bytevector endianness)
procedure: (utf16->string bytevector endianness endianness-mandatory?)
procedure: (utf32->string bytevector endianness)
procedure: (utf32->string bytevector endianness endianness-mandatory?)
returns: a string containing the specified decoding of bytevector
libraries: (rnrs bytevectors), (rnrs)
```

`endianness`必须是符号`big`或`little`中的一个.
这些过程使用`endianness`参数或字节序标记(byte-order mark, BOM)确定的字节序, 返回`bytevector`的UTF-16或UTF-32`解码.
如果没有提供`endianness-mandatory?`参数或其值为`#f`, 字节序由`bytevector`中起始的BOM确定, 或者没有BOM时由`endianness`参数确定.
如果`endianness-mandatory?`的值为`#t`, 字节序由`endianness`确定; 如果`bytevector`的起始处有BOM, 它被视为普通的字符编码.

UTF-16 BOM, 对于`big`字节序是`#xFE #xFF`的两字节序列, 对于`little`是`#xFF #xFE`.
UTF-32 BOM, 对于`big`字节序是`#x00 #x00 #xFE #xFF`的四字节序列, 对于`little`是`#xFF #xFE #x00 #x00`.


# 6 Syntactic Extension


Introduction:

**句法扩展(syntactic extension)/宏(macro)** 用于简化和正规化程序中的重复模式、引入带新的求值规则的句法形式、执行使程序更为高效的转换.

句法扩展通常使用形式`(keyword subform ...)`, 关键字`keyword`是命名了句法扩展的标识符. 每个`subform`的语法在各句法扩展之间存在不同. 句法扩展也可以使用 *非合式列表(improper list)* 或 *单例标识符(singleton identifier)* 的形式.

新的句法扩展通过将关键字与转换过程(transformer)关联来定义.
使用`define-syntax`形式或使用`let-syntax`/`letrec-syntax`定义句法扩展.
可以使用`syntax-rules`创建transformer, 这允许执行简单的基于模式的转换(pattern-based transformation).
transformer也可以是常规过程, 该过程接受单个参数, 可以执行任何计算. 这时, 通常使用`syntax-case`解构(destructure)输入, 使用`syntax`构造(construct)输出.
`identifier-syntax`形式和`make-variable-transformer`过程可用于创建匹配单例标识符和对这些标识符的赋值(assignment)的transformer, 前者只能用于诸如`syntax-rules`的简单模式中, 后者支持执行任何计算.

语法展开器(syntax expander)在求值开始时(在编译或解释之前), 将句法形式展开为核心形式(core forms).
如果展开器遇到一个句法扩展, 它调用相应的transformer来展开该句法形式, 然后在transformer返回的形式上重复执行展开过程.
如果展开器遇到一个核心句法形式(core syntactic form), 它递归的处理该句法形式的子形式, 并使用展开的子形式构造(结果)形式.
在展开过程中维护标识符绑定(identifier bindings)相关信息, 以实施变量和关键字的词法作用域(lexical scoping)约束.

这里描述的句法扩展机制是syntax-case系统的一部分, 该系统的动机和实现的描述见 *Syntactic Abstraction in Scheme*. 额外的尚未标准化的特性, 包括`modules`、局部`import`和元定义(meta definitions), 在 *Chez Scheme User's Guide* 中描述.

## 6.1 Keyword Bindings

Introduction:

可以使用`define-syntax`在顶层程序或库中, 以及使用`define-syntax`、`let-syntax`和`letrec-syntax`在局部作用域中, 建立关键字绑定(keyword bindings).

``` scheme
syntax: (define-syntax keyword expr)
libraries: (rnrs base), (rnrs)
```

`expr`必须求值为transformer.

例:

```scheme
; specify the transformer with syntax-rules.
(define-syntax let*
  (syntax-rules ()
    [(_ () b1 b2 ...) (let () b1 b2 ...)]
    [(_ ((i1 e1) (i2 e2) ...) b1 b2 ...)
     (let ([i1 e1])
       (let* ([i2 e2] ...) b1 b2 ...))]))
```

所有由一组内部定义(internal definitions)建立的绑定, 不管这些定义是关键字或变量定义, 该绑定在直接包裹体(immediately enclosing body)中(包括这些定义本身)可见.

例:

```scheme
(let ()
  (define even?
    (lambda (x)
      (or (= x 0) (odd? (- x 1)))))
  (define-syntax odd?
    (syntax-rules ()
      [(_ x) (not (even? x))]))
  (even? 10)) ;=> #t
```

展开器 *从左向右* 的处理`library`、`lambda`或其它体中的初始形式(initial forms).
如果它遇到一个变量定义, 记录所定义的标识符是一个变量的事实, 但推迟(defer)展开RHS(right-hand-side)表达式, 直到已经处理完所有定义.
如果它遇到一个关键字定义, 展开并求值RHS表达式, 并将该关键字绑定到结果transformer.
如果它遇到一个表达式, 完全展开所有被推迟的RHS当前和剩余体表达式.

从左向右的处理顺序的蕴含了一个内部定义是否影响后续的定义形式.

例: 不管`let`表达式外部的任何对`bind-to-zero`的绑定

```scheme
(let ()
  (define-syntax bind-to-zero
    (syntax-rules ()
      [(_ id) (define id 0)]))
  (bind-to-zero x)
  x) ;=> 0
```    

``` scheme
syntax: (let-syntax ((keyword expr) ...) form1 form2 ...)
syntax: (letrec-syntax ((keyword expr) ...) form1 form2 ...)
returns: see below
libraries: (rnrs base), (rnrs)
```

每个`expr`必须求值为transformer. 
每个`keyword`在形式`form1 form2 ...`中是绑定的(bound). 
对于`letrec-syntax`, 绑定作用域也包括每个`expr`.

`let-syntax`或`letrec-syntax`形式可以在表达式允许出现的位置展开为一个或多个表达式, 这种情况下, 结果表达式被视为包裹在一个`begin`表达式中.
也可以在定义允许出现的位置展开为零个或多个定义, 这种情况下, 这些定义被视为出现在`let-syntax`或`letrec-syntax`形式的位置上.

例:

```scheme
(let ([f (lambda (x) (+ x 1))])
  (let-syntax ([f (syntax-rules ()
                       [(_ x) x])]
               [g (syntax-rules ()
                       [(_ x) (f x)])])
    (list (f 1) (g 1)))) ;=> (1 2)

(let ([f (lambda (x) (+ x 1))])
  (letrec-syntax ([f (syntax-rules ()
                       [(_ x) x])]
                  [g (syntax-rules ()
                       [(_ x) (f x)])])
    (list (f 1) (g 1)))) ;=> (1 1)
```

在第一个表达式中, 在`g`中出现的`f`引用`let`绑定的变量`f`; 在第二个表达式中, 它引用由`letrec-syntax`形式建立绑定的关键字`f`.

## 6.2 Syntax-Rules Transformers

??? quote "Introduction"

`syntax-rules`形式以简便的方式描述简单的transformer, 足够用于定义一些常见的句法扩展.

``` scheme
syntax: (syntax-rules (literal ...) clause ...)
returns: a transformer
libraries: (rnrs base), (rnrs)
```

每个字面量`literal`必须是除了下划线(underscore)`_`或省略号(ellipsis)`...`之外的标识符.
每个子句`clause`有形式:

```scheme
(pattern template)
```

每个模式`pattern`描述了输入形式的语法, 相应的模板`template`描述了输出的形式.

**模式(pattern)** 由列表结构(list structure)、向量结构(vector structure)、标识符(identifier)和常量(constant)构成.
模式中每个标识符可以是`literal`、模式变量(pattern variable)、`_`、`...`.
如果标识符在字面量列表`(literal ...)`中出现, 且不是`_`或`...`, 则它是一个 *字面量(literal)*; 否则, 它是一个 *模式变量(pattern variable)*.
字面量用作辅助关键字(auxiliary keyword), 例如`case`和`cond`表达式中的`else`.
模式中的列表结构和向量结构描述了输入形式所需的基本结构,  `_`和模式变量描述了任意的子结构(substructure), 字面量和常量描述了必须精确匹配的原子片段(atomic piece).
`...`描述了在它之前的子模式(subpattern)的重复出现.

一个输入形式F匹配(match)一个模式P, 当且仅当:

- (1) P是`_`或模式变量;
- (2) P是标识符 <br/>
F是由谓词`free-identifier=?`确定具有相同绑定的标识符;
- (3) P有形式`(P1 ... Pn)` <br/>
F是有n个元素的列表, 其元素分别匹配P1到Pn;
- (4) P有形式`(P1 ... Pn . Px)` <br/>
F是拥有n个或更多元素的列表或非合式列表, 列表中头n个元素分别匹配P1到Pn, 第n个cdr匹配Px;
- (5) P有形式`(P1 ... Pk Pe ellipsis Pm+1 ... Pn)`, `ellipsis`是标识符`...` <br/>
F是拥有n个元素的合式列表, 列表中头k个元素分别匹配P1到Pk, 之后的m-k个元素分别匹配Pe, 余下的n-m个元素分别匹配Pm+1到Pn;
- (6) P有形式`(P1 ... Pk Pe ellipsis Pm+1 ... Pn . Px)` <br/>
F是拥有n个或更多元素的列表或非合式列表, 列表中头k个元素分别匹配P1到Pk, 之后的m-k个元素分别匹配Pe, 后面的n-m个元素分别匹配Pm+1到Pn, 第n个cdr匹配Px;
- (7) P有形式`#(P1 ... Pn)` <br/>
F是有n个元素的向量, 分别匹配P1到Pn;
- (8) P有形式`#(P1 ... Pk Pe ellipsie Pm+1 ... Pn)` <br/>
F是有n个或更多元素的向量, 向量中头k个元素分别匹配P1到Pk, 之后的m-k个元素分别匹配Pe, 余下的n-m个元素分别匹配Pm+1到Pn;
- (9) P是模式数据项(pattern datum, 即任意的非列表、非向量、非符号的对象) <br/>
F在`equal?`含义下等价于P.

`syntax-rules`中`pattern`的最外层结构必须是上述的列表结构形式中的一个, 而模式中的子模式可以是上述的任一形式. 
最外层模式的首元素总是被认为是命名了句法形式的关键字, 故而总被忽略. (这些陈述对`syntax-case`不适用.)

如果传递给`syntax-rules`生成的transformer的输入形式匹配某一子句中的模式, 则接受该子句, 根据子句中的模板转换(transform)该输入形式.
转换发生时, 模式中的模式变量被绑定到相应的输入子形式. 后接一个或多个`...`的子模式中的模式变量被绑定到零个或多个输入子形式构成的一个或多个序列.

**模板(template)** 可以是一个模式变量、一个不是模式变量的标识符、一个模式数据项、子模板列表`(S1 ... Sn)`、非合式的子模板列表`(S1 S2 ... Sn . T)`、子模板向量`#(S1 ... Sn)`.
每个子模板Si是一个后接零个或多个`...`的模板.
非合式子模板列表中最后一个元素`T`是一个模板.

在输出时, 模板中模式变量用其绑定的输入子形式替换(replace).
模式数据和不是模式变量的标识符被直接插入到输出中.
模板中列表和向量结构在输出中保持列表和向量结构.
后接一个`...`的子模板展开为零个或多个子模板. 子模板中必须至少包含一个出现在后接一个`...`的子模式的模式变量(否则, 展开器不能确定子形式应该在输出中应该重复多少次).
在后接一个或多个`...`的子模式中出现的模式变量, 只能出现在后接(至少)同样数量的`...`的子模板中. 在输出中, 这些模式变量用它们各自绑定的输入子形式替换.
如果一个模式变量在模板中后接`...`的数量多于在相应的模式中后接`...`的数量, 则(在输出中)按需复制输入形式.

形式为`(... template)`的模板等同于`template`, 除了模板中的`...`没有特殊的含义. 即, `template`中包含的`...`被视为普通标识符. 
模板`(... ...)`产生单个`...`. 
这允许句法扩展被展开为包含`...`的形式, 包括`syntax-rules`或`syntax-case`模式和模板.

例: 使用`syntax-rules`定义`or`

```scheme
(define-syntax or
  (syntax-rules ()
    [(_) #f]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (let ([t e1]) (if t t (or e2 e3 ...)))]))
```

输入模式说明了输入必须由关键字和零个或多个子表达式构成. 下划线`_`是一个匹配任意输入的特殊模式符号, 通常用在关键字的位置, 提醒程序员或阅读定义的人员关键字位置上总是有预期的关键字从而不需要匹配. (`syntax-rules`忽略关键字位置上的项.)
如果存在两个或多个子表达式(第3个子句), 展开后的代码测试第一个子表达式的值, 在值不为假时返回该子表达式的值.
为避免求值这个表达式两次, 这个transformer引入了一个对临时变量`t`的绑定.

*展开算法* 通过必要时重命名局部标识符自动的维护词法作用域约束. 因此, 由transformer引入的对`t`的绑定, 只在transformer引入的代码中可见, 在输入的子形式中不可见. 
类似的, 对标识符`let`和`if`的引用不受输入的上下文中存在的绑定影响.
    
例: 维护词法作用域约束. 
`if1`、`t1`和`t2`表示原始表达式中的`if`和`t`, 以及`or`展开后形式中`t`重命名后的标识符.

```scheme
(let ([if #f])
  (let ([t 'okay])
    (or if t))) ;=> okay

; transform to

((lambda (if1)
   ((lambda (t1)
      ((lambda (t2)
         (if t2 t2 t1))
       if1))
    'okay))
 #f) ;=> okay
```

例: 辅助关键字`else`
    
```scheme
(define-syntax cond
  (syntax-rules (else)
    [(_ (else e1 e2 ...)) (begin e1 e2 ...)]
    [(_ (e0 e1 e2 ...)) (if e0 (begin e1 e2 ...))]
    [(_ (e0 e1 e2 ...) c1 c2 ...)
     (if e0 (begin e1 e2 ...) (cond c1 c2 ...))]))
```

``` scheme
syntax: _
syntax: ...
libraries: (rnrs base), (rnrs syntax-case), (rnrs)
```

这些标识符是`syntax-rules`、`identifier-syntax`和`syntax-case`的辅助关键字.
`...`也是`syntax`和`quasisyntax`的辅助关键字.
如果在它们被识别为辅助关键字的上下文之外引用这些表达式, 是一个语法错误.

``` scheme
syntax: (identifier-syntax tmpl)
syntax: (identifier-syntax (id1 tmpl1) ((set! id2 e2) tmpl2))
returns: a transformer
libraries: (rnrs base), (rnrs)
```

当一个关键字绑定到由`identifier-syntax`的第一种形式生成的transformer时, 在该绑定的作用域内对该关键字的引用被替换为`tmpl`. 使用`set!`对相应的关键字进行赋值是一个语法错误.

例:

```scheme
(let ()
  (define-syntax a (identifier-syntax car))
  (list (a '(1 2 3)) a)) ;=> (1 #<procedure>)
```

`identifier-syntax`的第二种形式, 支持在transformer中描述如何处理使用`set!`对关键字的赋值.

例:

```scheme
(let ([ls (list 0)])
  (define-syntax a
    (identifier-syntax
      [id (car ls)]
      [(set! id e) (set-car! ls e)])) ; assignment 
  (let ([before a])
    (set! a 1)
    (list before a ls))) ;=> (0 1 (1))
```

## 6.3 Syntax-Case Transformers

??? quote "Introduction"

`syntax-case`是`syntax-rules`的泛化版本. 这种创建transformer的机制支持描述任意复杂的转换, 包括以受控的方式修改(bend)词法作用域约束, 支持定义更为广泛的一类句法扩展.

使用这种机制时, transformer是一个单参数的过程. 
该参数是表示要处理的形式的 **语法对象(syntax object)**. 
其返回值是表示输出形式的语法对象.

语法对象可以是:

- 一个非对(nonpair)、非向量(nonvector)、非符号(nonsymbol)的值;
- 语法对象的对;
- 语法对象的向量;
- 被包裹的对象(wrapped object).

被包裹的语法对象上的包裹(wrap)中包含了一个形式的上下文信息(contextual information).
展开器使用上下文信息维护词法作用域约束. 
包裹中也可以包含被具体实现用于关联源代码和对象代码的信息, 例如, 通过展开和编译过程跟踪文件、行和字符信息.

所有标识符的上下文信息必须存在, 这就是上面的语法对象的定义中没有包含符号(除非它们被包裹)的原因.
表示一个标识符的语法对象本身也被作为一个标识符被引用, 因此 *标识符* 的含义是, 句法实体(符号、变量、关键字), 或者是作为语法对象的句法实体的具体表示.

transformer通常用`syntax-case`解构(destructure)其输入, 用`syntax`重建(rebuild)其输出.
使用这两个形式足够定义许多句法扩展, 包括可以用`syntax-rules`定义的句法扩展.

``` scheme
syntax: (syntax-case expr (literal ...) clause ...)
returns: see below
libraries: (rnrs syntax-case), (rnrs)
```

每个`literal`必须是一个标识符. 每个子句`clause`必须是这两个形式中的一个形式:

```scheme
(pattern output-expression)
(pattern fender output-expression)
```

`syntax-case`的模式`pattern`与`syntax-rules`中模式相同.

`syntax-case`首先求值`expr`, 然后尝试将该结果值与其第一个`clause`中的模式匹配. 这个结果值可以是任意Scheme对象.
如果该值匹配这个模式, 且子句中没有`fender`, 则求值`output-expression`, 将它的值作为`syntax-case`表达式的结果值 **返回**.
如果该值不匹配这个模式, 将该值与下一个子句匹配, 依次类推.
如果该值不与任何模式匹配, 是一个语法错误.

如果可选的`fender`存在, 它作为接受子句的额外约束.
如果`syntax-case`中`expr`的值匹配某一子句中模式, 则求值相应的`fender`.
如果`fender`求值为真值, 则接受该子句; 否则, 就像输入不匹配模式那样拒绝该子句.
逻辑上fender是匹配过程中的一部分, 即它们在表达式的基本结构之外添加了额外的匹配约束.

一个子句的`pattern`中的模式变量, 在该子句的`fender`(如果存在)和`output-expression`中, 被绑定到输入值中的相应部分.
模式变量与程序变量和关键字共享同一个名称空间(namespace), 使用`syntax-case`创建的模式变量绑定可以遮盖(或被遮盖)程序变量和关键字绑定, 以及其它模式变量绑定.
模式变量只能在`syntax`表达式中被引用.

``` scheme
syntax: (syntax template)
syntax: #'template
returns: see below
libraries: (rnrs syntax-case), (rnrs)
```

`#'template`等价于`(syntax template)`.

`syntax`表达式与`quote`表达式类似, 除了在`template`中出现的模式变量的值被插入`template`中, 与输入关联和与模板关联的上下文信息在输出中被保留, 以支持词法作用域约束.
`syntax`中的`template`等同于`syntax-rules`中的`template`.

模板中的列表和向量结构, 成为真正的列表和向量(可被`map`或`vector-ref`等直接应用的列表或向量), 必须将列表或向量的结构拷贝以插入模式变量的值, 空列表从不被包裹. 例如, 如果`x`、`a`、`b`和`c`是模式变量, `#'(x ...)`、`#'(a b c)`、`#'()`都是列表.

例: 使用`syntax-case`定义`or`

```scheme
(define-syntax or
  (lambda (x)
    (syntax-case x ()
      [(_) #'#f]
      [(_ e) #'e]
      [(_ e1 e2 e3 ...)
       #'(let ([t e1]) (if t t (or e2 e3 ...)))])))
```

在这个版本中, 生成transformer的`lambda`表达式是显式的, 每个子句的输出部分中的`syntax`形式是显式的.
任何`syntax-rules`形式可以通过将`lambda`表达式和`syntax`表达式显式化的用`syntax-case`表示.

```scheme
(define-syntax syntax-rules
  (lambda (x)
    (syntax-case x ()
      [(_ (i ...) ((keyword . pattern) template) ...)
       #'(lambda (x)
           (syntax-case x (i ...)
             [(_ . pattern) #'template] ...))])))
```

因为`lambda`的`syntax`表达式在`syntax-rules`形式中是隐式的, 使用`syntax-rules`表示的定义通常比使用`syntax-case`表示的等价定义短些.

``` scheme
procedure: (identifier? obj)
returns: #t if obj is an identifier, #f otherwise
libraries: (rnrs syntax-case), (rnrs)
```

`identifier?`常用在`fender`中, 以检查输入形式的特定子形式是否是标识符.

例: 使用`identifier?`检查输入子形式是否是标识符

```scheme
(define-syntax let
  (lambda (x)
    (define ids?
      (lambda (ls)
        (or (null? ls)
            (and (identifier? (car ls))
                 (ids? (cdr ls))))))
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (ids? #'(i ...))
       #'((lambda (i ...) b1 b2 ...) e ...)])))
```

句法扩展通常采用形式`(keyword subform ...)`, 但`syntax-case`系统支持句法扩展采用 **单例标识符(singleton identifier)** 的形式.

例: 关键字`pcar`可以用作一个标识符(展开为调用`car`), 或者一个结构的形式(展开为调用`set-car!`). 
使用fender `(identifier? x)`识别单例标识符的情况.

```scheme
(let ([p (cons 0 #f)])
  (define-syntax pcar
    (lambda (x)
      (syntax-case x ()
        [_ (identifier? x) #'(car p)] ; singleton identifier
        [(_ e) #'(set-car! p e)])))
  (let ([a pcar])
    (pcar 1)
    (list a pcar))) ;=> (0 1)
```

``` scheme
procedure: (free-identifier=? identifier1 identifier2)
procedure: (bound-identifier=? identifier1 identifier2)
returns: see below
libraries: (rnrs syntax-case), (rnrs)
```

单独的符号名称(symbolic names)不区分标识符, 除非标识符被用作符号数据(symbolic data).
`free-identifier=?`和`bound-identifier=?`用于在特定上下文中, 根据标识符的预期用途(intended use), 是用作自由的引用(free references)还是绑定的标识符(bounded identifiers), 来比较标识符.

`free-identifier=?`用于确定在tansformer的输出中作为 *自由标识符* 出现的两个标识符是否等价.
由于标识符引用(identifier references)是受词法作用域约束限制的, 这意味着`(free-identifier=? id1 id2)`为真, 当且仅当, 标识符`id1`和`id2`引用了同一个绑定(binding). (对于这个比较, 两个名称相同的标识符如果均没有绑定, 则假设它们有相同的绑定.)
在`syntax-case`的模式中出现的字面量标识符(辅助关键字), 例如`case`和`cond`中的`else`, 是用`free-identifier=?`匹配的.

类似的, `bound-identifier=?`用于确定在transformer的输出中作为 *绑定的标识符* 出现的两个标识符是否等价.
即, 如果`bound-identifier=?`对两个标识符返回真, 则对其中一个标识符的绑定会在其作用域内捕获对另一个标识符的引用.
通常, 使用`bound-identifier=?`比较的两个标识符, 都出现在原始程序中, 或者都是用同一个transformer应用(可能是隐式的, 见`datum->syntax`)引入的.
`bound-identifier=?`可用于在绑定构造(binding construct)中检测重复的标识符, 或者用于需要检测绑定标识符的实例的绑定构造的预处理(preprocessing)中.

例: 显式调用`free-identifier=?`识别`cond`中的辅助关键字`else`

```scheme
(define-syntax cond
  (lambda (x)
    (syntax-case x ()
      [(_ (e0 e1 e2 ...))
       (and (identifier? #'e0) (free-identifier=? #'e0 #'else))
       #'(begin e1 e2 ...)]
      [(_ (e0 e1 e2 ...)) #'(if e0 (begin e1 e2 ...))]
      [(_ (e0 e1 e2 ...) c1 c2 ...)
       #'(if e0 (begin e1 e2 ...) (cond c1 c2 ...))])))
```

有了这个定义, 如果外围中存在`else`的词法绑定, 则`else`不会被识别为辅助关键字. 例如:

```scheme
(let ([else #f])
  (cond [else (write "oops")])) ; does not write "oops"
```

因为`else`已被词法绑定, 它与在`cond`的定义中出现的`else`不同.

例: 使用`bound-identifier=?`检测重复的标识符

```scheme
(define-syntax let
  (lambda (x)
    (define ids?
      (lambda (ls)
        (or (null? ls)
            (and (identifier? (car ls)) (ids? (cdr ls))))))
    (define unique-ids?
      (lambda (ls)
        (or (null? ls)
            (and (not (memp
                        (lambda (x) (bound-identifier=? x (car ls)))
                        (cdr ls)))
                 (unique-ids? (cdr ls))))))
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (and (ids? #'(i ...)) (unique-ids? #'(i ...))) ; fender
       #'((lambda (i ...) b1 b2 ...) e ...)])))
```

有个这个定义, 表达式`(let ([a 3] [a 4]) (+ a a))`是个语法错误, 而

```scheme
; pr and prs are helper methods for display objects
(let ([a 0])
  (let-syntax ([dolet (lambda (x)
                        (syntax-case x ()
                          [(_ b)
                           #'(let ([a 3] [b 4]) (pr a) (pr b) (+ a b))]))])    ; introduce a
    (prs (dolet a) (dolet c))))

; (dolet a) ;=> a ;=> 3
; a ;=> 4
; 7
; (dolet c) ;=> a ;=> 3
; c ;=> 4
; 7
```

这是因为由`dolet`引入的标识符`a`与从输入形式中提取的标识符`a`, `bound-identifier=?`的结果不为真.

两个`free-identifier=?`(的结果)为真的标识符, 可能`bound-identifier=?`(的结果)为假.
一个由transformer引入的标识符可以与未被transformer引入的标识符引用相同的外部绑定(enclosing binding), 但对其中一个引入的绑定, 不会捕获对另一个的引用.
另一方面, `bound-identifier=?`的标识符是`free-identifier=?`的, 只要在比较的上下文中这些标识符有有效的绑定.

``` scheme
syntax: (with-syntax ((pattern expr) ...) body1 body2 ...)
returns: the values of the final body expression
libraries: (rnrs syntax-case), (rnrs)
```

有时通过分别构造出transformer输出的片段(piece), 再将这些片段组合起来是比较有用的. `with-syntax`通过允许创建局部模式绑定(local pattern binding)对此提供支持.

`pattern`与`syntax-case`中模式的形式等同.
每个`expr`被求值, 并根据相应的`pattern`被解构, 在体`body1 body2 ...`中, `pattern`中的模式变量被绑定恰当的值(像`syntax-case`中一样), 以与`lambda`体相同的方式处理和求值该体.

`with-syntax`可以用`syntax-case`定义为一个句法扩展:

```scheme
(define-syntax with-syntax
  (lambda (x)
    (syntax-case x ()
      [(_ ((p e) ...) b1 b2 ...)
       #'(syntax-case (list e ...) ()
           [(p ...) (let () b1 b2 ...)])])))
```    

例: 完整的`cond`定义, 使用`with-syntax`以支持transformer利用内部的递归来构造输出

```scheme
(define-syntax cond
  (lambda (x)
    (syntax-case x ()
      [(_ c1 c2 ...)
       (let f ([c1 #'c1] [cmore #'(c2 ...)])                 ; named let 
         (if (null? cmore)
             (syntax-case c1 (else =>)
               [(else e1 e2 ...) #'(begin e1 e2 ...)]
               [(e0) #'(let ([t e0]) (if t t))]
               [(e0 => e1) #'(let ([t e0]) (if t (e1 t)))]
               [(e0 e1 e2 ...) #'(if e0 (begin e1 e2 ...))])
             (with-syntax ([rest (f (car cmore) (cdr cmore))])
               (syntax-case c1 (=>)
                 [(e0) #'(let ([t e0]) (if t t rest))]
                 [(e0 => e1) #'(let ([t e0]) (if t (e1 t) rest))]
                 [(e0 e1 e2 ...)
                  #'(if e0 (begin e1 e2 ...) rest)]))))])))
```

``` scheme
syntax: (quasisyntax template ...)
syntax: #`template
syntax: (unsyntax template ...)
syntax: #,template
syntax: (unsyntax-splicing template ...)
syntax: #,@template
returns: see below
libraries: (rnrs syntax-case), (rnrs)
```

``` #`template ```等价于`(quasisyntax template)`,
`#,template`等价于`(unsyntax template)`,
`#,@template`等价于`(unsyntax-splicing template)`.

`quasisyntax`与`syntax`类似, 但它允许被引用的文本(quoted text)中部分被求值, 行为与`quasiquote`类似.

在`quasisyntax`的`template`中, `unsyntax`和`unsyntax-splicing`子形式被求值, 其它部分被视为普通的模板部分(就像在`syntax`中).
每个`unsyntax`子形式的值被插入该`unsyntax`子形式的位置, 而`unsyntax-splicing`子形式的值被粘接到(splice)外围的列表或向量结构中.
`unsyntax`和`unsyntax-splicing`只在`quasisyntax`表达式中有效.

`quasisyntax`表达式可以嵌套, 每个`quasisyntax`引入一层语法引用(syntax quotation), 每个`unsyntax`或`unsyntax-splicing`移除一层引用.
内嵌在n个`quasisyntax`表达式中的表达式, 必须在内嵌n个`unsyntax`或`unsyntax-splicing`表达式中被求值.

`quasisyntax`可以在多种情况下替代`with-syntax`.

例: 使用`quasisyntax`构造输出

```scheme
(define-syntax case
  (lambda (x)
    (syntax-case x ()
      [(_ e c1 c2 ...)
       #`(let ([t e])
           #,(let f ([c1 #'c1] [cmore #'(c2 ...)])
               (if (null? cmore)
                   (syntax-case c1 (else)
                     [(else e1 e2 ...) #'(begin e1 e2 ...)]
                     [((k ...) e1 e2 ...)
                      #'(if (memv t '(k ...)) (begin e1 e2 ...))])
                   (syntax-case c1 ()
                     [((k ...) e1 e2 ...)
                      #`(if (memv t '(k ...))
                            (begin e1 e2 ...)
                            #,(f (car cmore) (cdr cmore)))]))))])))
```

包含零个或多个子形式的`unsyntax`和`unsyntax-splicing`形式在在粘接(列表或向量)上下文中有效.
`(unsyntax template ...)`等价于`(unsyntax template) ...`, 
`(unsyntax-splicing template ...)`等价于`(unsyntax-splicing template) ...`.
这些形式主要用作`quasisyntax`展开器输出中的中间形式(intermediate forms). 
它们支持一些有用的引用习语, 例如`#,@#,@`在双层嵌套和双层求值的`quasisyntax`表达式中有双层间接粘接的作用.

`unsyntax`和`unsyntax-splicing`是`quasisyntax`的辅助关键字.
在它们被视为辅助关键字的上下文之外引用这些标识符, 是一个语法错误.

``` scheme
procedure: (make-variable-transformer procedure)
returns: a variable transformer
libraries: (rnrs syntax-case), (rnrs)
```

传递给transformer的形式通常表示一个带括号的形式(parenthesized form), 其第一个子形式是绑定到transformer的关键字或者是关键字本身.
`make-variable-transformer`可用于将一个过程转换为一类特殊的transformer, 展开器也传入`set!`形式, 其中关键字直接出现在`set!`关键字之后, 就像它是一个被赋值的变量那样.
这允许程序员控制关键字在这种上下文中如何处理. `procedure`应该接受单个参数.

例:

```scheme
(let ([ls (list 0)])
  (define-syntax a
    (make-variable-transformer
      (lambda (x)
        (syntax-case x ()
          [id (identifier? #'id) #'(car ls)]
          [(set! _ e) #'(set-car! ls e)]
          [(_ e ...) #'((car ls) e ...)]))))
  (let ([before a])
    (set! a 1)
    (list before a ls))) ;=> (0 1 (1))
```

这种句法抽象可以用`identifier-syntax`更为简洁的定义出, 但`make-variable-transformer`可用于创建执行任意计算的transformer, 而`identifier-syntax`只能用于简单的项重写(term rewriting), 就像`syntax-rules`那样.

可以使用`make-variable-transformer`定义`identifier-syntax`:

```scheme
(define-syntax identifier-syntax
  (lambda (x)
    (syntax-case x (set!)
      [(_ e)
       #'(lambda (x)
           (syntax-case x ()
             [id (identifier? #'id) #'e]
             [(_ x (... ...)) #'(e x (... ...))]))]
      [(_ (id exp1) ((set! var val) exp2))
       (and (identifier? #'id) (identifier? #'var))
       #'(make-variable-transformer
           (lambda (x)
             (syntax-case x (set!)
               [(set! var val) #'exp2]
               [(id x (... ...)) #'(exp1 x (... ...))]
               [id (identifier? #'id) #'exp1])))])))
```

``` scheme
procedure: (syntax->datum obj)
returns: obj stripped of syntactic information
libraries: (rnrs syntax-case), (rnrs)
```

过程`syntax->datum`从一个语法对象上剥去(strip)所有句法信息(syntactic information), 返回相应的Scheme数据项(datum).
按这种方式剥去后的标识符被转换为其符号名称(symbolic name), 可以通过`eq?`比较.
因此, 谓词`symbolic-identifier=?`可以定义为:

```scheme
(define symbolic-identifier=?
  (lambda (x y)
    (eq? (syntax->datum x)
         (syntax->datum y))))
```

两个`free-identifier=?`的标识符不需要是`symbolic-identifier=?`的: 两个引用相同绑定的标识符通常有相同的名称, 但库的`import`形式中`rename`和`prefix`子形式可以导致两个标识符有不同的名称但有相同的绑定.

``` scheme
procedure: (datum->syntax template-identifier obj)
returns: a syntax object
libraries: (rnrs syntax-case), (rnrs)
```

`datum->syntax`从包含与模板标识符`template-identifier`相同上下文信息的`obj`中构造语法对象, 该语法对象表现为当`template-identifier`被引入时该语法对象被引入代码中.
模板标识符通常是输入形式的关键字, 被从形式中提取出, `obj`通常是命名了要构造的标识符的符号.

`datum->syntax`允许transformer修改(bend)词法作用域规则, 修改方式是创建隐式标识符, 就像这些标识符在输入形式中存在一样, 从而允许在句法扩展的定义中引入这些不在输入形式中显式出现的标识符的可见绑定或引用.

例: `loop`表达式在体中绑定变量`break`到逃逸过程(escape procedure)

```scheme
(define-syntax loop
  (lambda (x)
    (syntax-case x ()
      [(k e ...)
       (with-syntax ([break (datum->syntax #'k 'break)])
         #'(call/cc
             (lambda (break)
               (let f () e ... (f)))))])))

(let ([n 3] [ls '()])
  (loop
    (if (= n 0) (break ls))
    (set! ls (cons 'a ls))
    (set! n (- n 1)))) ;=> (a a a)
```

而使用如下定义, 变量`break`在`e ...`中不可见:

```scheme
(define-syntax loop
  (lambda (x)
    (syntax-case x ()
      [(_ e ...)
       #'(call/cc
           (lambda (break)
             (let f () e ... (f))))])))
```

例: `obj`表示任意的Scheme形式. `(include "filename")`展开为包含了文件`filename`中形式的`begin`表达式.

```scheme
(define-syntax include
  (lambda (x)
    (define read-file
      (lambda (fn k)
        (let ([p (open-input-file fn)])
          (let f ([x (read p)])                ; x is next form
            (if (eof-object? x)
                (begin (close-port p) '())
                (cons (datum->syntax k x) (f (read p)))))))) ;;;
    (syntax-case x ()
      [(k filename)
       (let ([fn (syntax->datum #'filename)])
         (with-syntax ([(expr ...) (read-file fn #'k)])
           #'(begin expr ...)))])))

; f-def.ss
(define f (lambda () x))

(let ([x "okay"])
  (include "f-def.ss")
  (f)) ;=> okay
```

`include`的定义中使用`datum->syntax`将从文件中读取的对象转换为在恰当词法上下文中的语法对象, 从而, 这些表达式中的标识符引用和定义的作用域与`include`形式出现的作用域相同.

``` scheme
procedure: (generate-temporaries list)
returns: a list of distinct generated identifiers
libraries: (rnrs syntax-case), (rnrs)
```

transformer可以通过命名每个标识符在输出中引入固定数量的标识符.
在一些情况中, 被引入的标识符的数量依赖于输入表达式的某些特征.
例如, 一个直接定义的`letrec`, 需要与输入表达式中绑定对数量相同的临时标识符(temporary identifier).
过程`generate-temporaries`用于构造临时标识符的列表.

`list`可以是任何列表, 它的内容不重要. 所生成的临时标识符的数量与`list`中元素数量相同. 
每个临时标识符保证与所有其它标识符不同.

例: 使用`generate-temporaries`定义`letrec`

```scheme
(define-syntax letrec
  (lambda (x)
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (with-syntax ([(t ...) (generate-temporaries #'(i ...))])
         #'(let ([i #f] ...)
             (let ([t e] ...)
               (set! i t)
               ...
               (let () b1 b2 ...))))])))
```

以这种方式使用`generate-temporaries`的transformer, 可以不用`generate-temporaries`重写, 尽管有些不简洁.
技巧是使用一个递归定义的中间形式在每个展开步中来生成一个临时标识符, 在已经生成足够数量的临时标识符后结束展开.

例: 不使用`generate-temporaries`生成临时标识符的`let-values`定义

```scheme
(define-syntax let-values
  (syntax-rules ()
    [(_ () f1 f2 ...)
     (let () f1 f2 ...)]
    [(_ ((fmls1 expr1) (fmls2 expr2) ...) f1 f2 ...)
     (lvhelp fmls1 () () expr1 ((fmls2 expr2) ...) (f1 f2 ...))]))

(define-syntax lvhelp
  (syntax-rules ()
    [(_ (x1 . fmls) (x ...) (t ...) e m b)
     (lvhelp fmls (x ... x1) (t ... tmp) e m b)]
    [(_ () (x ...) (t ...) e m b)
     (call-with-values
       (lambda () e)
       (lambda (t ...)
         (let-values m (let ([x t] ...) . b))))]
    [(_ xr (x ...) (t ...) e m b)
     (call-with-values
       (lambda () e)
       (lambda (t ... . tmpr)
         (let-values m (let ([x t] ... [xr tmpr]) . b))))]))
```

实现`lvhelp`的复杂性在于需要在创建任何绑定之前求值所有的RHS(right-hand-site)表达式, 以及在于需要支持非合式的参数列表.


# 7 Records

rtd, rcd:
- rtd: record type descriptor.
- rcd: record constructor descriptor.

记录类型(record types), 彼此之间不同, 一个记录类型确定了它的每个实例(instance)的字段(field)的数量和名称.

记录类型用`define-record-type`形式或`make-record-type-descriptor`过程定义.


## 7.1 Define Records


```scheme
syntax: (define-record-type record-name clause ...)                    ; (1)
syntax: (define-record-type (record-name constructor pred) clause ...) ; (2)
libraries: (rnrs records syntactic), (rnrs)

syntax: fields
syntax: mutable
syntax: immutable
syntax: parent
syntax: protocol
syntax: sealed
syntax: opaque
syntax: nongenerative
syntax: parent-rtd
libraries: (rnrs records syntactic), (rnrs)
```

`define-record-type`形式/ **记录定义(record definition)** , 是一个可以出现在其它定义能够出现的任何位置的定义.
它定义了一个由`record-name`标识的记录类型, 以及这个记录类型的一个谓词(predicate)、构造器(constructor)、访问函数(accessors)、修改函数(mutators).
如果使用形式(1), 则构造器和谓词的名称从`record-name`衍生获得: 构造器是`make-record-name`、谓词是`record-name?`.
如果使用形式(2), 则构造器是`constructor`、谓词是`pred`.
由一个记录定义定义的所有名称的作用域被限制为这个记录定义出现的地方.

记录定义的子句`clause ...`确定了记录类型的字段(fields)、字段的访问函数(accessor)和修改函数(mutator)的名称、它的父类型(如果有的话)、它的构造协议(construction protocol), 以及是否是非生成性的(nongenerative)(如果是它的uid是否指定)、是否是封闭的(sealed)、是否是不透明的(opaque).

这些子句都是可选的, 最简单的记录定义`(define-record-type record-name)`定义了一个新的、生成性的(generative)、非封闭的、透明的记录类型, 它没有父类型、没有字段, 有一个无参构造器和一个谓词.

下面的各种子句分别最多只能在子句集合中出现一次, 如果有了`parent`子句, 则不能有`parent-rtd`子句. 
子句可以按任意顺序放置.

**fields子句** `(fields field-spec ...)`子句声明了记录类型中的字段. `field-spec`的形式可以是:

``` scheme
field-name                                        ; (1)
(immutable field-name)                            ; (2)
(mutable field-name)                              ; (3)
(immutable field-name accessor-name)              ; (4)
(mutable field-name accessor-name mutator-name)   ; (5)
```

其中, `field-name`、`accessor-name`、`mutator-name`是标识符. 
形式(1)等价于形式(2). 声明为不可变的(immutable)字段的值不能修改, 也没有相应的修改函数.
对于形式(1)(2)(3), 访问函数的名称是`rname-fname`, 其中`rname`是记录名称, `fname`是字段名称.
对于形式(3), 修改函数的名称是`rname-fname-set!`.
形式(4)(5)显式声明了访问函数和修改函数的名称.

如果没有`fields`子句或`field-spec ...`为空, 则该记录类型没有字段(如果有父类型, 则有父类型中字段).

**parent子句** `(parent parent-name)`子句声明了父记录类型, `parent-name`必须是一个之前通过`define-record-type`定义的非封闭的记录类型. 
一个记录类型的实例被视为它的父类型的实例, 拥有自身通过`fields`子句声明的字段和它的父类型中的所有字段.

**nongenerative子句** 一个`nongenerative`子句的形式可以是:

``` scheme
(nongenerative)        ; (1)
(nongenerative uid)    ; (2)
```

其中, `uid`是一个符号. 形式(1)等价于形式(2), 使用具体实现在宏展开期间生成的uid. 
当求值带非生成性的子句的`define-record-type`形式时, 当且仅当它的uid不与已存在的记录类型的uid相同时, 创建一个新的类型.

如果是一个已存在的记录类型的uid, 则父类型、字段名称、封闭属性和不透明属性必须匹配如下:

- 如果指定了父类型, 已存在的记录类型必须有相同的父rtd(`eqv?`等价). 如果没有指定父类型, 已存在的记录类型必须没有父类型.
- 必须提供相同数量的字段, 每个字段的名称、出现顺序以及可修改性必须相同.
- 如果有`(sealed #t)`子句, 已存在的记录类型必须是封闭的. 否则, 已存在的记录类型必须是非封闭的.
- 如果有`(opaque #t)`子句, 已存在的记录类型必须是不透明的. 否则, 当且仅当指定了不透明的父类型, 已存在的记录类型必须是不透明的.
 
如果满足上面的这些约束, 不会创建新的记录类型, 其它记录类型定义的产出物(构造器、谓词、访问函数和修改函数)在已存在类型的记录上操作. 
如果不满足这些约束, 具体实现可以将其视为语法错误, 或者抛出状况类型`&assertion`的运行时异常.

使用形式(1)时, 仅当相同的定义被执行多次时, 生成的uid可以是一个已存在的记录类型的uid, 即它出现在一个被多次调用的过程的体中.

如果`uid`不是一个已存在的记录类型的uid, 或者不存在`nongenerative`子句, 则创建一个新的记录类型.

**protocol子句** `(protocol expression)`子句确定了生成的构造器用于构造记录类型实例的的协议. 
它必须求值为一个过程, 并且这个过程必须是记录类型的恰当协议.

没有父类型的记录类型的默认的协议(protocol)等价于 `(lambda (new) new)`, 有父类型的记录类型的默认协议等价于:

``` scheme
(lambda (pargs->new)
  (lambda (x1...xn y1...ym)
    ((pargs->new x1...xn) y1...ym)))
```
    
其中, n是父记录(包括祖先记录)中字段数量, m是子记录中字段数量.

**sealed子句** `(sealed #t)`形式声明记录类型是封闭的. 这意味着它不能被扩展, 即不能用作另一个记录定义或`make-record-type-descriptor`调用中的父类型. 
如果不存在`sealed`子句或使用了`(sealed #f)`形式, 则记录类型不是封闭的.

**opaque子句** `(opaque #t)`形式声明记录类型是不透明的. 
不透明的记录类型的实例不被`record?`谓词、rtd提取过程`record-rtd`视为记录. 因此, 代码中不能访问或修改不透明的记录类型中的字段.
如果一个记录类型的父类型是不透明的, 则它也是不透明的. 
如果不存在`opaque`子句或者使用了`(opaque #f)`子句, 并且如果有父类型且父类型是透明的, 则该记录类型是透明的.

**parent-rtd子句** `(parent-rtd a-parent-rtd a-parent-rcd)`子句是使用`parent`子句之外指定父记录类型的一种方式, 带有一个父记录构造器描述符(record constructor descriptor). 用于分别使用`make-record-type-descriptor`和`make-record-constructor-descriptor`获得父rtd和rcd的场景.

`a-parent-rtd`必须求值为一个rtd或`#f`. 如果求值为`#f`, `a-parent-rcd`必须求值为`#f`; 否则, `a-parent-rcd`必须求值为一个rcd或`#f`.
如果`a-parent-rcd`求值为一个rcd, 则它必须封装了一个等价于`a-parent-rtd`值的rtd(`eqv`等价). 如果`a-parent-rcd`求值为`#f`, 则它被视为带默认协议的`a-parent-rtd`的值对应的rcd.

`define-record-type`形式被设计用于编译器能够确定所定义的记录类型的形状, 包括所有字段的偏移量. 但使用`parent-rtd`子句时, 因为父rtd直到运行时才可确定, 无法确保这一点. 
因此, 相比于`parent-rtd`子句, 如果`parent`子句已经够用时, 则优先使用`parent`子句.

`fields` ... `parent-rtd`这些标识符是`define-record-type`的辅助关键字.
在它们被视为辅助关键字的上下文之外引用这些标识符是语法错误的.

例:

```scheme
(define-record-type point
  (fields x y d)
  (protocol
    (lambda (new)
      (lambda (x y)
        (new x y (sqrt (+ (* x x) (* y y))))))))

(define-record-type cpoint
  (parent point)
  (fields color)
  (protocol
    (lambda (pargs->new)
      (lambda (c x y)
        ((pargs->new x y) c)))))

(define p (make-point 3 4))
(point-x p) ;=> 3
(point-y p) ;=> 4
(point-d p) ;=> 5
(define cp (make-cpoint 'red 3 4))
(point-x cp) ;=> 3
(point-y cp) ;=> 4
(point-d cp) ;=> 5
(cpoint-color cp) ;=> red
```

## 7.2 Procedure Interface


```scheme
procedure: (make-record-type-descriptor name parent uid sealed? opaque? fields)
returns: a record-type descriptor (rtd) for a new or existing record type
libraries: (rnrs records procedural), (rnrs)
```

`name`必须是一个符号, 
`parent`必须是`#f`或一个非封闭的记录类型的rtd,
`uid`必须是`#f`或一个符号,
`fields`必须是一个向量, 每个元素是形式`(mutable field-name)`或`(immutable field-name)`的两元素列表. 字段名称`field-name ...`必须是符号, 彼此之间不需要是不同的.

如果`uid`是`#f`或不是一个已存在的记录类型的uid, 这个过程创建一个新的记录类型, 返回该新类型的记录类型描述符(record-type descriptor, rtd).
这个新类型有`parent`描述的父类型(如果不为假), 有`uid`指定的uid(如果不为假), 有`fields`指定的字段.
如果`sealed?`不为假, 它是封闭的.
如果`opaque?`不为假, 或者指定的父类型是不透明的, 它是不透明的.
这个新记录类型的名称是`name`, 其字段的名称是`field-name ...`.

如果`uid`不为假, 且是一个已存在的记录类型的uid, 则`parent`、`fields`、`sealed?`和`opaque?`参数必须与这个已存在记录类型的相应特征匹配.
即, `parent`必须相同(`eqv?`等价); 
字段的数量必须相同, 字段的名称相同, 字段的出现顺序相同, 字段的可变性相同; 
当且仅当这个已存在的记录类型是封闭的, `sealed?`必须为假; 
如果没有指定父类型或者指定的父类型是透明的, 当且仅当这个已存在的记录类型是不透明的, `opaque?`必须为假.
如果是这样, `make-record-type-descriptor`返回这个已存在的记录类型的rtd; 否则, 抛出状况类型`&assertion`的异常.

使用`make-record-type-descriptor`返回的rtd, 程序可以动态的创建构造器、类型谓词、字段访问函数和字段修改函数.

例: 使用过程性结构创建`point`记录类型

```scheme
(define point-rtd (make-record-type-descriptor 'point #f #f #f #f
                '#((mutable x) (immutable y))))
(define point-rcd (make-record-constructor-descriptor point-rtd
                    #f #f))
(define make-point (record-constructor point-rcd))
(define point? (record-predicate point-rtd))
(define point-x (record-accessor point-rtd 0))
(define point-y (record-accessor point-rtd 1))
(define point-x-set! (record-mutator point-rtd 0))
```

例: 创建父和子记录类型、谓词、访问函数、修改函数和构造器

```scheme
(define rtd/parent
  (make-record-type-descriptor 'parent #f #f #f #f
    '#((mutable x))))

(record-type-descriptor? rtd/parent) ;=> #t
(define parent? (record-predicate rtd/parent))
(define parent-x (record-accessor rtd/parent 0))
(define set-parent-x! (record-mutator rtd/parent 0))

(define rtd/child
  (make-record-type-descriptor 'child rtd/parent #f #f #f
    '#((mutable x) (immutable y))))

(define child? (record-predicate rtd/child))
(define child-x (record-accessor rtd/child 0))
(define set-child-x! (record-mutator rtd/child 0))
(define child-y (record-accessor rtd/child 1))

(record-mutator rtd/child 1) ;=> exception: immutable field

(define rcd/parent
  (make-record-constructor-descriptor rtd/parent #f
    (lambda (new) (lambda (x) (new (* x x))))))

(record-type-descriptor? rcd/parent) ;=> #f

(define make-parent (record-constructor rcd/parent))

(define p (make-parent 10))
(parent? p) ;=> #t
(parent-x p) ;=> 100
(set-parent-x! p 150)
(parent-x p) ;=> 150

(define rcd/child
  (make-record-constructor-descriptor rtd/child rcd/parent
    (lambda (pargs->new)
      (lambda (x y)
        ((pargs->new x) (+ x 5) y)))))

(define make-child (record-constructor rcd/child))
(define c (make-child 10 'cc))
(parent? c) ;=> #t
(child? c) ;=> #t
(child? p) ;=> #f

(parent-x c) ;=> 100
(child-x c) ;=> 15
(child-y c) ;=> cc

(child-x p) ;=> exception: invalid argument type
```

```scheme
procedure: (record-type-descriptor? obj)
returns: #f if obj is a record-type descriptor, otherwise #f
libraries: (rnrs records procedural), (rnrs)
```


```scheme
procedure: (make-record-constructor-descriptor rtd parent-rcd protocol)
returns: a record-constructor descriptor (rcd)
libraries: (rnrs records procedural), (rnrs)
```

单独使用rtd足够可以创建谓词、访问函数和修改函数.
然后, 要创建构造器, 首先需要创建记录类型的记录构造器描述符(record-constructor descriptor, rcd).
rcd封装了三个信息: 相应的记录类型的rtd、父rcd(如果有的话)和协议.

`parent-rcd`必须是一个rcd或`#f`.
如果`parent-rcd`是一个rcd, `rtd`必须有父rtd, 并且该父rtd必须与`parent-rcd`封装的rtd相同.
如果`parent-rcd`为假, 则`rtd`没有父rtd, 或者认为`parent-rcd`是一个带默认协议的rcd.

`protocol`必须是一个过程或`#f`. 如果为`#f`, 则认为`protocol`是默认的协议.


```scheme
syntax: (record-type-descriptor record-name)
returns: the rtd for the record type identified by record-name
syntax: (record-constructor-descriptor record-name)
returns: the rcd for the record type identified by record-name
libraries: (rnrs records syntactic), (rnrs)
```

每个记录定义创建了所定义的记录类型的rtd和rcd.
这些过程用于获取rtd和rcd.
`record-name`必须是之前通过`define-record-type`定义的记录类型的名称.


```scheme
procedure: (record-constructor rcd)
returns: a record constructor for the record type encapsulated within rcd
libraries: (rnrs records procedural), (rnrs)
```

记录构造器的行为, 由`rcd`封装的协议和父rcd(如果有的话)确定.


```scheme
procedure: (record-predicate rtd)
returns: a predicate for rtd
libraries: (rnrs records procedural), (rnrs)
```

这个过程返回一个谓词, 该谓词接受单个参数, 在其参数时`rtd`描述的记录类型的实例时返回`#t`, 否则返回`#f`.


```scheme
procedure: (record-accessor rtd idx)
returns: an accessor for the field of rtd specified by idx
libraries: (rnrs records procedural), (rnrs)
```

`idx`必须是一个小于`rtd`中字段数量(不计入父类型中字段)的非负整数.
`idx`为0, 指定了创建记录类型的`define-record-type`形式或`make-record-type-descriptor`调用中给定的第一个字段; 1指定第二个, 依次类推.

子rtd不能直接用于创建父类型中字段的访问函数. 要创建父类型中字段的访问函数, 必须使用父rtd.


```scheme
procedure: (record-mutator rtd idx)
returns: a mutator for the field of rtd specified by idx
libraries: (rnrs records procedural), (rnrs)
```

`idx`必须是一个小于`rtd`中字段数量(不计入父类型中字段)的非负整数.
`idx`为0, 指定了创建记录类型的`define-record-type`形式或`make-record-type-descriptor`调用中给定的第一个字段; 1指定第二个, 依次类推.
被指定的字段必须是可变的, 否则抛出状况类型`&assertion`的异常.

子rtd不能直接用于创建父类型中字段的修改函数. 要创建父类型中字段的修改函数, 必须使用父rtd.

## 7.3 Inspection

rtd不能从一个不透明的记录类型的实例上提取, 这是区分不透明和透明的记录类型的特性.


```scheme
procedure: (record-type-name rtd)
returns: the name associated with rtd
libraries: (rnrs records inspection), (rnrs)
```

例:

```scheme
(define record->name
  (lambda (x)
    (and (record? x) (record-type-name (record-rtd x)))))

(define-record-type dim (fields w l h))
(record->name (make-dim 10 15 6)) ;=> dim

(define-record-type dim (fields w l h) (opaque #t))
(record->name (make-dim 10 15 6)) ;=> #f
```


```scheme
procedure: (record-type-parent rtd)
returns: the parent of rtd, or #f if it has no parent
libraries: (rnrs records inspection), (rnrs)
```

例:

```scheme
(define-record-type point (fields x y))
(define-record-type cpoint (parent point) (fields color))
(record-type-parent (record-type-descriptor point)) ;=> #f
(record-type-parent (record-type-descriptor cpoint)) ;=> #<rtd>
```


```scheme
procedure: (record-type-uid rtd)
returns: the uid of rtd, or #f if it has no uid
libraries: (rnrs records inspection), (rnrs)
```

没有使用程序员提供的uid创建的记录类型, 实际上有一个由具体实现提供的uid.
例:

```scheme
(define-record-type point (fields x y))
(define-record-type cpoint
  (parent point)
  (fields color)
  (nongenerative e40cc926-8cf4-4559-a47c-cac636630314))
(record-type-uid (record-type-descriptor point)) ;=> #{point g1ep2t1ixob13hwvkuwf8s0dx-0}
(record-type-uid (record-type-descriptor cpoint)) ;=>
                             e40cc926-8cf4-4559-a47c-cac636630314
```


```scheme
procedure: (record-type-generative? rtd)
returns: #t if the record type described by rtd is generative, #f otherwise
procedure: (record-type-sealed? rtd)
returns: #t if the record type described by rtd is sealed, #f otherwise
procedure: (record-type-opaque? rtd)
returns: #t if the record type described by rtd is opaque, #f otherwise
libraries: (rnrs records inspection), (rnrs)
```

例:

```scheme
(define-record-type table
  (fields keys vals)
  (opaque #t))
(define rtd (record-type-descriptor table))
(record-type-generative? rtd) ;=> #t
(record-type-sealed? rtd) ;=> #f
(record-type-opaque? rtd) ;=> #t

(define-record-type cache-table
  (parent table)
  (fields key val)
  (nongenerative))
(define rtd (record-type-descriptor cache-table))
(record-type-generative? rtd) ;=> #f
(record-type-sealed? rtd) ;=> #f
(record-type-opaque? rtd) ;=> #t
```


```scheme
procedure: (record-type-field-names rtd)
returns: a vector containing the names of the fields of the type described by rtd
libraries: (rnrs records inspection), (rnrs)
```

这个过程返回的向量是不可变的: 修改rtd的结果是未描述的.
这个向量不包含父字段名称.
向量中名称的顺序与使用`define-record-type`形式或`make-record-type-descriptor`调用创建记录类型时指定的字段顺序相同.

例:

```scheme
(define-record-type point (fields x y))
(define-record-type cpoint (parent point) (fields color))
(record-type-field-names
  (record-type-descriptor point)) ;=> #(x y)
(record-type-field-names
  (record-type-descriptor cpoint)) ;=> #(color)
```


```scheme
procedure: (record-field-mutable? rtd idx)
returns: #t if the specified field of rtd is mutable, #f otherwise
libraries: (rnrs records inspection), (rnrs)
```

`idx`必须是一个小于`rtd`中字段数量(不计入父类型中字段)的非负整数.
`idx`为0, 指定了创建记录类型的`define-record-type`形式或`make-record-type-descriptor`调用中给定的第一个字段; 1指定第二个, 依次类推.

例:

```scheme
(define-record-type point (fields (mutable x) (mutable y)))
(define-record-type cpoint (parent point) (fields color))

(record-field-mutable? (record-type-descriptor point) 0) ;=> #t
(record-field-mutable? (record-type-descriptor cpoint) 0) ;=> #f
```


```scheme
procedure: (record? obj)
returns: #t if obj is a non-opaque record instance, #f otherwise
libraries: (rnrs records inspection), (rnrs)
```

当`obj`是一个不透明记录类型的实例时, `record?`返回`#f`.
尽管一个不透明的记录类型的实例本质上是一个记录, 透明性(opacity)的含义是在程序中不应该访问表示信息的部分隐藏这些表示信息, 而这包括了一个对象是否是一个记录.
这个谓词的主要用途是在程序中检查是否可以通过`record-rtd`过程从参数中获取rtd.

例:

```scheme
(define-record-type statement (fields str))
(define q (make-statement "He's dead, Jim"))
(statement? q) ;=> #t
(record? q) ;=> #t

(define-record-type opaque-statement (fields str) (opaque #t))
(define q (make-opaque-statement "He's moved on, Jim"))
(opaque-statement? q) ;=> #t
(record? q) ;=> #f
```


```scheme
procedure: (record-rtd record)
returns: the record-type descriptor (rtd) of record
libraries: (rnrs records inspection), (rnrs)
```

`record`必须是一个透明的记录类型的实例.
与上面描述的一些过程组合使用, `record-rtd`支持在实例的类型未知时, 內省(inspection)和修改记录实例.

例: `print-fields`接受一个记录参数, 输出记录中每个字段的名称和值

```scheme
(define print-fields
  (lambda (r)
    (unless (record? r)
      (assertion-violation 'print-fields "not a record" r))
    (let loop ([rtd (record-rtd r)])
      (let ([prtd (record-type-parent rtd)])
        (when prtd (loop prtd)))
      (let* ([v (record-type-field-names rtd)]
             [n (vector-length v)])
        (do ([i 0 (+ i 1)])
            ((= i n))
          (write (vector-ref v i))
          (display "=")
          (write ((record-accessor rtd i) r))
          (newline))))))

(define-record-type point (fields x y))
(define-record-type cpoint (parent point) (fields color))

(print-fields (make-cpoint -3 7 'blue)) ;=> x=-3
                                            y=7
                                            color=blue
```


# 8 Libraries and Top-Level Programs

## 8.1 Standard Libraries


```scheme
(rnrs base (6))

(rnrs arithmetic bitwise (6))
(rnrs arithmetic fixnums (6))
(rnrs arithmetic flonums (6))
(rnrs bytevectors (6))
(rnrs conditions (6))
(rnrs control (6))
(rnrs enums (6))
(rnrs eval (6))
(rnrs exceptions (6))
(rnrs files (6))
(rnrs hashtables (6))
(rnrs io ports (6))
(rnrs io simple (6))
(rnrs lists (6))
(rnrs mutable-pairs (6))
(rnrs mutable-strings (6))
(rnrs programs (6))
(rnrs r5rs (6))
(rnrs records procedural (6))
(rnrs records syntactic (6))
(rnrs records inspection (6))
(rnrs sorting (6))
(rnrs syntax-case (6))
(rnrs unicode (6))
```

A composite library `(rnrs (6))` exports all of the `(rnrs base (6))` bindings along with those libraries listed above, excepte: `(rnrs eval (6))`, `(rnrs mutable-pairs (6))`, `(rnrs mutable-strings (6))` and `(rnrs r5rs (6))`.

## 8.2 Defining New Libraries


```scheme
;;; 定义新库
(library library-name
  (export export-spec ...) ; 命名了外部可见的名称
  (import import-spec ...) ; 命名了新库依赖的其它库, 以及导入的标识符集合
  library-body)
```

- `library-name`

```scheme
;;; library-name
;;; 描述库的名称和版本, 有两个形式:
(identifier identifier ...)             ; 将不带version的库名称视为带空version ()的库名称.
(identifier identifier ... version)

;;; version
(subversion ...) ; 每个subversion表示精确的非负整数
```

- `export`

```scheme
;;; export-spec
identifier
(rename (internal-name export-name) ...) ; internal-name, export-name: 标识符
```

- `import`

```scheme
;;; import-spec
import-set
(for import-set import-level ...)   ; 声明何时导入的绑定可用

;;; import-set
library-spec                        ; base
(only import-set identifier ...)    ; restrict to the ones listed
(except import-set identifier ...)  ; restrict to the ones not list
(prefix import-set prefix)          ; add a prefix to then indentifiers
                                    ; the latter prefix: 标识符.
(rename import-set                  ; specify internal names, leave others unchanged
  (import-name internal-name) ...)  ; import-name, internal-name: 标识符

;;; library-spec
library-reference
(library library-reference)

;;; library-reference
(identifier identifier ...)
(identifier identifier ... version-reference)

;;; version-reference
(subversion-rederence ... subversion-reference)
(and version-reference ...)
(or version-reference ...)
(not version-reference)

;;; subversion-reference
subversion
(>= subversion)
(<= subversion)
(and subversion-reference ...)
(or subversion-reference ...)
(not subversion-reference)

;;; import-level
run           ; 导入的绑定在新库的运行时表达式中可用:
              ; define RHS expressions, intialization expressions
              ; 等价于(meta 0)
expand        ; 导入的绑定在新库的transformer表达式中可用:
              ; define-syntax, let-syntax, letrec-syntax RHS expressions
              ; 等价于(meta 1)
(meta level)  ; level表示精确整数.
              ; (meta 2): 导入的绑定在新库中出现在transformer表达式中的transformer表达式中可用.
```

Example: 在新库中使用`set:union`和`set:diff`

```scheme
; import-set
(prefix
  (only
    (rename (list-tools setops) (difference diff))
    union
    diff)
  set:)
```

Example: 库有两个版本`(1 2)`和`(1 3 1)`

```scheme
; version-reference
()                              ; match both
(1)                             ; match both
(1 2)                           ; match (1 2)
(1 3)                           ; match (1 3 1)
(1 (>= 2))                      ; match both
(and (1 (>= 3)) (not (1 3 1)))  ; match neither
```

- `library-body`

`library-body`中包含导出标识符的定义、不期望导出的标识符的定义、初始化表达式, 由一组定义(可能为空)、后继的一组初始化表达式(可能为空)构成.

当`begin`、`let-syntax`、`letrec-syntax`形式在`library-body`中第一个表达式之前出现时, 它们被*粘接*(splice)到库体中. 体中形式可以通过句法扩展(syntactic extendsion)生成, 包括定义、前述被粘接的形式、初始化表达式.

库体按与`lambda`或其它体相同的方式展开, 并展开为等价的一个`letrec*`形式, 体中定义和初始化形式*从左向右*被求值.

在库的`export`形式中的每个导出, 必须是从其它库导入的或者是定义在`library-body`中; 如果导出名称与内部名称不同, 使用内部名称.

每个导入库中的标识符或者库中定义的标识符, 必须有且仅有一个*绑定*(binding).
如果是导入库中的标识符, 必须不能在库体中定义; 如果是库体中定义的标识符, 必须只定义一次.
如果(一个标识符)是从两个库中导出的, 必须由相同的绑定; 这只会在这些情况下发生: (1)初始绑定在一个库中, 在另一个库中重新导出; (2) 初始绑定在第三个库中, 在这两个库中均重新导出.

定义在库中但没有导出的标识符在库外面的代码中不可见. 定义在库中的语法扩展的展开可以包含对这个标识符的引用, 这被称为**间接导出**(indirect export).

库中(显式或隐式)导出的变量在库中和库外部均是**不可变的**(immutable).
如果一个显式导出的变量出现在`set!`表达式的LHS(left-hand side), 是一个语法错误.
同样的, 一个隐式导出的变量出现在`set!`表达式的LHS, 是一个语法错误.

> "library's transformer expression, library's body expression"
    
  >> 库的转换表达式(transformer expression)是库体中出现在`define-syntax`形式RHS(right-hand side)的表达式.
    
  >> 库的体表达式(body expression)是库体中出现在`define`形式RHS的表达式, 以及初始化表达式.

具体实现依据库之间的导入关系, 按需加载库和求值库中包含的代码.
库的转换表达式的求值时间可以与库的体表达式的求值时间不同.
至少, 在展开一个库或顶层程序时遇到一个对另一个库的导出关键字的引用, 则该关键字相应的库的转换表达式必须求值.
至少, 在求值一个库的导出变量的引用时, 则该变量相应的库的体表达式必须求值; 这可以是这些情况: (1) 使用该库的程序运行时, (2) 展开另一个库或顶层程序时, 兵器展开过程中调用的转换过程求值该引用.

具体实现可以在展开其它库的过程中, 求值一个库的转换表达式和体表达式多次. 通常, 在不需要时不求值这些表达式, 求值一次, 或者在展开的每个元层次中求值一次.

通常在求值库的转换表达式或体表达式时包含外部可见的副作用(externally visible side effects), 例如弹出窗口, 不是一个好的实践, 因为这些副作用发生的时间是未描述的. 只影响库的初始化的局部作用, 例如创建库中使用的表, 通常是可以的.

## 8.3 Top-Level Programs


顶层程序不是句法形式, 而是一组用于标记文件边界的形式. 顶层程序体中定义和表达式可以混合出现:

```scheme
(import import-spec ...)
definition-or-expression
...
```


```scheme
procedure: (command-line)
returns: a list of strings representing command-line arguments
libraries: (rnrs programs), (rnrs)
```

用在顶层程序中, 获取传递给程序的命令行参数列表.


```scheme
syntax: (exit)
syntax: (exit obj)
returns: does not return; exit from a top-level program to the operating system
libraries: (rnrs programs), (rnrs)
```

用于从顶层程序中退出. 
如果没有指定`obj`, 返回给操作系统的退出值应该表明正常退出.
如果`obj`求值为假, 返回给操作系统的退出值应该表明异常退出; 否则`obj`被转换为操作系统对应的退出值.


# 9 Exceptions and Conditions

Introduction:

**异常(exceptions)**和**状况(conditions)**, 为系统和用户代码提供了一种在程序运行时发出错误信号(signal)、检测错误(detect)和从错误中恢复(recover)的方法.

标准的句法形式和过程在多种场景下抛出异常(raise exceptions), 例如, 给过程传递了错误数量的实际参数、传递给`eval`的表达式的语法不正确, 或者某个文件打开过程不能打开一个文件. 在这些情况中, 异常以标准状况类型(condition type)抛出.

用户代码中使用`raise`或`raise-continuable`过程也可以抛出异常. 这种情况下, 异常以一个标准状况类型、用户定义的标准状况类型的子类型(使用`define-condition-type`)或者任意不是状况类型的Scheme值抛出.

在程序执行的任一点, 单个异常处理器(exception handler)负责处理抛出的所有异常, 这个异常处理器称为当前的异常处理器(current exception handler). 
默认情况下, 当前的异常处理器是由具体实现提供的. 
默认的异常处理器通常输出一个描述异常抛出时的状况或其它值的消息, 对任意严重的状况(serious condition), 结束程序. 在交互式系统中, 这通常意味着重置REPL.

用户代码中使用`guard`语法或`with-exception-handler`过程建立一个新的当前的异常处理器. 
用户代码可以处理所有异常, 或者按抛出异常时的状况或其它值, 只处理一部分, 将剩余的交给旧的当前的异常处理器处理. 
通过动态的嵌套对`guard`形式和`with-exception-handler`的调用, 可以建立异常处理器的链(chain), 每个异常处理器可以将异常推迟给链中下一个处理.

## 9.1 Raise and Handle Exceptions


``` scheme
procedure: (raise obj)
procedure: (raise-continuable obj)
returns: see below
libraries: (rnrs exceptions), (rnrs)
```

这两个过程抛出异常, 会将`obj`作为唯一的参数来调用当前异常处理器.
对于`raise`, 这个异常是 **不可持续的(non-continuable)** , 对于`raise-continuable`, 这个异常是 **可持续的(continuable)** .
异常处理器可以返回(零个或多个值)给一个continuable异常的continuation.
如果异常处理器尝试返回到一个non-continuable异常的continuation, 抛出状况类型`&non-continuable`的新异常.
因此, `raise`从不返回, 而`raise-continuable`依赖于异常处理器, 可以返回零个或多个值.

如果当前异常处理器p, 是通过`guard`形式或`with-exception-handler`调用建立的, 当前异常处理器被重置为在`raise`或`raise-continuable`调用p之前建立p时的 *当前异常处理器*.
这允许p可以通过简单的重新抛出异常给已经存在的异常处理器, 也可以避免当一个异常处理器错误的导致抛出一个新异常时无限的回归(infinite regression).
如果p返回, 并且异常是continuable的, p被重新设置为当前异常处理器.

例:

```scheme
(raise
  (condition
    (make-error)
    (make-message-condition "no go"))) ;=> error: no go
(raise-continuable
  (condition
    (make-violation)
    (make-message-condition "oops"))) ;=> violation: oops
(list
  (call/cc
    (lambda (k)
      (vector
        (with-exception-handler
          (lambda (x) (k (+ x 5)))
          (lambda () (+ (raise 17) 8))))))) ;=> (22)
(list
  (vector
    (with-exception-handler
      (lambda (x) (+ x 5))
      (lambda () (+ (raise-continuable 17) 8))))) ;=> (#(30))
(list
  (vector
    (with-exception-handler
      (lambda (x) (+ x 5))
      (lambda () (+ (raise 17) 8))))) ;=> violation: non-continuable
```


``` scheme
procedure: (error who msg irritant ...)
procedure: (assertion-violation who msg irritant ...)
libraries: (rnrs base), (rnrs)
```

`error`抛出一个状况类型`&error`的non-continuable异常, 应该被用于描述`&error`状况类型是合适的场景, 通常是包含程序与外界交互的场景.
`assertion-violation`抛出状况类型`&assertion`的non-continuable异常, 应用被用于描述`&assertion`状况类型是合适的场景, 通常是给过程传递了非法参数或句法形式中子表达式的值非法的场景.

异常被抛出时的continuation对象, 也包含一个`&who`状况(在`who`不是`#f`时who字段为`who`), 一个`&message`状况(message字段是`msg)和一个`&irritants`状况(irritants字段是`(irritant ...)`).

`who`必须是一个字符串、一个符号或`#f`, 表明了报告异常的过程或句法形式. 它最好是表明程序员已经调用的过程, 而不是程序员可能未注意的执行操作中调用的其它过程.
`msg`必须是一个字符串, 应该描述异常场景. 
irritants可以是任意Scheme对象, 应该包含在异常场景中导致异常或在异常中被包含的值.


``` scheme
syntax: (assert expression)
returns: see below
libraries: (rnrs base), (rnrs)
```

`assert`求值`expression`, 在`expression`的值不是`#f`时返回该值.
如果该值是`#f`, `assert`抛出一个状况类型`&assertion`和`&message`的non-continuable异常, message字段值是由具体实现提供的.
鼓励具体实现尽可能的在状况中包含`assert`调用时的位置信息.


``` scheme
procedure: (syntax-violation who msg form)
procedure: (syntax-violation who msg form subform)
returns: does not return
libraries: (rnrs syntax-case), (rnrs)
```

这个过程抛出一个状况类型`&syntax`的non-continuable异常.
它应该被用于在句法扩展中transformer报告检测到语法错误.
这个状况的form字段值是`form`, 它的subform字段的值是`subform`, 如果没有提供`subform`, 值为`#f`.

异常被抛出时的continuation对象, 也包含一个`&who`状况(在`who`不是`#f`时who字段为`who`), 一个`&message`状况(message字段是`msg).

`who`必须是一个字符串、一个符号或`#f`.
如果`who`为`#f`, 则在`form`是一个标识符时, `who`为`form`的符号名称; 在`form`是一个列表结构的形式且其第一个子形式是一个标识符时, `who`为`form`的第一个子形式的符号名称.
`msg`必须是一个字符串, 应该描述异常场景. 
`form`应该是语法错误发生处句法形式的语法对象(syntax object)或数据项(datum)表示, `subform`如果不是`#f`, 则应该是错误中更具体的子项的语法对象或数据项的表示. 例如, 如果在`lambda`表达式中存在重复的形式参数, `form`是该`lambda`表达式, `subform`是重复的参数.

一些具体实现在语法对象上附加源代码信息, 例如文件中形式的行、字符和文件名, 在这种情况下, 这些信息也可以作为依赖于具体实现的状况类型在状况对象中出现.


``` scheme
procedure: (with-exception-handler procedure thunk)
returns: see below
libraries: (rnrs exceptions), (rnrs)
```

这个过程将`procedure`建立为当前异常处理器, 替换旧的当前处理器old-proc, `procedure`接受单个参数; 不带参数的调用`thunk`.
如果`thunk`调用返回, old-porc被重新设置为当前异常处理器, 将`thunk`返回的值作为返回值返回.
如果控制(control)通过对使用`call/cc`获取的continuation的调用离开或者后续重新进入对`thunk`的调用中, 当该continuation被捕获时的当前异常处理器被设置为当前异常处理器.

例:

```scheme
(define (try thunk)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (x) (if (error? x) (k #f) (raise x)))
        thunk))))
(try (lambda () 17)) ;=> 17
(try (lambda () (raise (make-error)))) ;=> #f
(try (lambda () (raise (make-violation)))) ;=> violation
(with-exception-handler
  (lambda (x)
    (raise
      (apply condition
        (make-message-condition "oops")
        (simple-conditions x))))
  (lambda ()
    (try (lambda () (raise (make-violation)))))) ;=> violation: oops
```


``` scheme
syntax: (guard (var clause1 clause2 ...) b1 b2 ...)
returns: see below
libraries: (rnrs exceptions), (rnrs)
```

`guard`表达式将一个过程procedure建立为新的当前异常处理器, 替换旧的当前异常处理器old-proc, 求值体`b1 b2 ...`.
如果这个体返回, `guard`重新建立old-proc为当前异常处理器.
如果控制(control)通过对使用`call/cc`获取的continuation的调用离开或者后续重新进入对`thunk`的调用中, 当该continuation被捕获时的当前异常处理器被设置为当前异常处理器.

过程procedure将`var`绑定到其接受的值, 在这个绑定的作用域内, 依次处理子句`clause1 clause2 ...`, 就像它们被包含在一个隐式的`cond`表达式中那样.
在`guard`表达式的continuation中, 使用old-proc作为当前异常处理器, 求值这个隐式的`cond`表达式.

如果没有提供`else`子句, `guard`在调用procedure的continuation中, 使用old-proc作为当前异常处理器, 提供一个重新抛出(使用`raise-continuable`)具有相同值的异常.
例:

```scheme
(guard (x [else x]) (raise "oops")) ;=> "oops"

(guard (x [#f #f]) (raise (make-error))) ;=>  error

(define-syntax try
  (syntax-rules ()
    [(_ e1 e2 ...)
     (guard (x [(error? x) #f]) e1 e2 ...)]))
(define open-one
  (lambda fn*
    (let loop ([ls fn*])
      (if (null? ls)
          (error 'open-one "all open attempts failed" fn*)
          (or (try (open-input-file (car ls)))
              (loop (cdr ls)))))))
; say bar.ss exists but not foo.ss:
(open-one "foo.ss" "bar.ss") ;=> #<input port bar.ss>
```

## 9.2 Define Condition Types


尽管程序中可以给`raise`或`raise-continuable`传递任意Scheme对象, 描述异常场景的最好方式通常是创建和穿衣状况对象(condition object).
R6RS要求具体实现中传递给当前异常处理器的值总是一个属于一个或多个标准状况类型(conditon type)的状况对象.
用户代码中可以创建属于一个或多个标准状况类型的状况对象, 或者创建扩展的状况类型的对象.

状况类型与记录类型类似, 但状况对象可以是两个或多个状况类型的实例, 这些状况类型之间可以不存在父子类型关系.
一个状况是多个类型的实例时, 称它为 **复合状况(compound conditon)** .
复合状况用于给异常处理器传递关于异常的多种信息.
不是复合状况的状况称为 **简单状况(simple condition)** .
在大多数情况下, 这种区分是不重要的. 一个简单状况被视为将它本身作为唯一的简单状况的复合状况.


```scheme
syntax: &condition
libraries: (rnrs conditions), (rnrs)
```

`&condition`是记录类型名称, 是状况类型层次的根.
所有简单状况类型是该类型的扩展, 所有状况都是该类型的实例.


```scheme
procedure: (condition? obj)
returns: #t if obj is a condition object, otherwise #f
libraries: (rnrs conditions), (rnrs)
```

一个状况对象是`&condition`的子类型的实例, 或是一个复合状况, 可能是用户代码中使用`condition`创建的.

例:

```scheme
(condition? 'stable) ;=> #f
(condition? (make-error)) ;=> #t
(condition? (make-message-condition "oops")) ;=> #t
(condition?
  (condition
    (make-error)
    (make-message-condition "no such element"))) ;=> #t
```


```scheme
procedure: (condition condition ...)
returns: a condition, possibly compound
libraries: (rnrs conditions), (rnrs)
```

使用`condition`创建由多个简单状况构成的状况对象.
每个`a-condition`可以是简单的或复合的, 如果是简单的, 它被视为将它本身作为唯一的简单状况的复合状况.
结果状况中的简单状况是`a-condition`参数中的简单状况, 它们被保留顺序的放置在一个列表中.

如果这个列表只有一个元素, 则结果状况是简单或复合的; 否则是复合的.
如果使用`define-record-type`而不是`define-condition-type`扩展已存在的状况类型, 可以通过`define-record-type`定义的谓词检测出简单和复合状况之前的区别.

例:

```scheme
(condition) ;=> #<condition>
(condition
  (make-error)
  (make-message-condition "oops")) ;=> #<condition>

(define-record-type (&xcond make-xcond xcond?) (parent &condition))
(xcond? (make-xcond)) ;=> #t
(xcond? (condition (make-xcond))) ;=> #t or #f
(xcond? (condition)) ;=> #f
(xcond? (condition (make-error) (make-xcond))) ;=> #f
```


```scheme
procedure: (simple-conditions condition)
returns: a list of the simple conditions of condition
libraries: (rnrs conditions), (rnrs)
```

例:

```scheme
(simple-conditions (condition)) ;=> '()
(simple-conditions (make-error)) ;=> (#<condition &error>)
(simple-conditions (condition (make-error))) ;=> (#<condition &error>)
(simple-conditions
  (condition
    (make-error)
    (make-message-condition
      "oops"))) ;=> (#<condition &error> #<condition &message>)

(let ([c1 (make-error)]
      [c2 (make-who-condition "f")]
      [c3 (make-message-condition "invalid argument")]
      [c4 (make-message-condition
            "error occurred while reading from file")]
      [c5 (make-irritants-condition '("a.ss"))])
  (equal?
    (simple-conditions
      (condition
        (condition (condition c1 c2) c3)
        (condition c4 (condition c5))))
    (list c1 c2 c3 c4 c5))) ;=> #t
```


```scheme
syntax: (define-condition-type name parent constructor pred field ...)
libraries: (rnrs conditions), (rnrs)
```

`define-condition-type`形式是一个定义, 可以出现在其它定义可以出现的位置.
它被用于创建新的简单状况类型.

子形式`name`、`parent`、`constructor`、`pred`必须是标识符. 
每个`field`的形式为`(field-name accessor-name)`, 其中 `file-name`和`accessor-name`是标识符.

`define-condition-type`将`name`定义为一个新记录类型, 它的父记录类型是`parent`、构造器名称是`constructor`、谓词名称时`pred`、字段是`field-name ...`、字段访问函数是`accessor-name ...`.

除了谓词和字段访问函数, `define-condition-type`本质上是一个普通的记录定义, 等价于:

```scheme
(define-record-type (name constructor pred)
  (parent parent)
  (fields ((immutable field-name accessor-name) ...)))
```
    
谓词与`define-record-type`生成的谓词不同之处在于, 它会在参数是新类型的实例时返回`#t`, 也会在参数是其简单状况中包含了新类型的实例的复合状况时返回`#t`.
类似的, 字段访问函数接受新类型的实例的同时, 也接受其简单状况中至少包含了新记录类型的一个实例的复合状况.
如果字段访问函数接受到的复合状况中简单状况列表中包含一个或多个新类型的实例, 它在列表中的 *第一个* (新类型的)实例执行操作.

例:

```scheme
(define-condition-type &mistake &condition make-mistake mistake?
  (type mistake-type))

(mistake? 'booboo) ;=> #f

(define c1 (make-mistake 'spelling))
(mistake? c1) ;=> #t
(mistake-type c1) ;=> spelling

(define c2 (condition c1 (make-irritants-condition '(eggregius))))
(mistake? c2) ;=> #t
(mistake-type c2) ;=> spelling
(irritants-condition? c2) ;=> #t
(condition-irritants c2) ;=> (eggregius)
```


```scheme
procedure: (condition-predicate rtd)
returns: a condition predicate
procedure: (condition-accessor rtd procedure)
returns: a condition accessor
libraries: (rnrs conditions), (rnrs)
```

这些过程用于从一个简单状况类型或其它从简单状况类型导出的类型的记录类型描述符rtd, 创建与`define-record-type`创建的相同类别的特殊谓词和访问函数.

`rtd`必须是`&condition`子类型的记录类型描述符.
`procedure`应该接受单个参数.

`condition-predicate`返回的谓词接受单个参数, 这个参数可以是任意Scheme值.
如果这个值是一个属于`rtd`描述的类型的状况, 即一个rtd`(或它的子类型)描述的类型的实例, 或者是一个其简单状况包含一个`rtd`描述的类型的实例的复合状况, 该谓词返回`#t`; 否则返回`#f`.

`condition-accessor`返回的访问函数接受单个参数c, 它必须是一个属于`rtd`描述的类型的状况.
访问函数应用`procedure`到单个参数上, 即c的简单状况列表中第一个属于`rtd`描述的类型的实例(如果c是简单状况则是c本身), 返回应用的结果.
在大多数情况下, `procedure`是`rtd`描述的类型中一个字段的记录访问函数.

例:

```scheme
(define-record-type (&mistake make-mistake $mistake?)
  (parent &condition)
  (fields (immutable type $mistake-type)))

; define predicate and accessor as if we'd used define-condition-type
(define rtd (record-type-descriptor &mistake))
(define mistake? (condition-predicate rtd))
(define mistake-type (condition-accessor rtd $mistake-type))

(define c1 (make-mistake 'spelling))
(define c2 (condition c1 (make-irritants-condition '(eggregius))))
(list (mistake? c1) (mistake? c2)) ;=> (#t #t)
(list ($mistake? c1) ($mistake? c2)) ;=> (#t #f)
(mistake-type c1) ;=> spelling
($mistake-type c1) ;=> spelling
(mistake-type c2) ;=> spelling
($mistake-type c2) ;=> violation
```

## 9.3 Standard Condition Types


```scheme
syntax: &serious
procedure: (make-serious-condition)
returns: a condition of type &serious
procedure: (serious-condition? obj)
returns: #t if obj is a condition of type &serious, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明严重状况, 如果未被捕获, 通常会导致程序执行的终止.
这种类型的状况通常作为更特定的子类型`&error`或`&violation`出现.

```scheme
(define-condition-type &serious &condition
  make-serious-condition serious-condition?)
```


```scheme
syntax: &violation
procedure: (make-violation)
returns: a condition of type &violation
procedure: (violation? obj)
returns: #t if obj is a condition of type &violation, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明程序违背了一些需求, 通常是程序中的缺陷.

```scheme
(define-condition-type &violation &serious
  make-violation violation?)
```


```scheme
syntax: &assertion
procedure: (make-assertion-violation)
returns: a condition of type &assertion
procedure: (assertion-violation? obj)
returns: #t if obj is a condition of type &assertion, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这个状况类型表明程序给一个过程传递了错误数量或类型的参数.

```scheme
(define-condition-type &assertion &violation
  make-assertion-violation assertion-violation?)
```


```scheme
syntax: &error
procedure: (make-error)
returns: a condition of type &error
procedure: (error? obj)
returns: #t if obj is a condition of type &error, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明程序在与其操作环境交互时发生了错误, 例如打开文件失败.
它不被用于描述程序中检测到错误的场景.

```scheme
(define-condition-type &error &serious
  make-error error?)
```


```scheme
syntax: &warning
procedure: (make-warning)
returns: a condition of type &warning
procedure: (warning? obj)
returns: #t if obj is a condition of type &warning, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

警告状况表明不会组织程序继续实现, 但在一些情况下可能导致后面出现更严重的问题的场景. 例如, 编译器可以使用这种类型的状况表明它处理了一个使用错误数量的参数对标准过程的调用, 这不会成为一个严重问题, 除非这个调用后续被实际执行.

```scheme
(define-condition-type &warning &condition
  make-warning warning?)
```


```scheme
syntax: &message
procedure: (make-message-condition message)
returns: a condition of type &message
procedure: (message-condition? obj)
returns: #t if obj is a condition of type &message, #f otherwise
procedure: (condition-message condition)
returns: the contents of condition's message field
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况通常与`&warning`状况或`&serious`子类型状况一起使用, 提供异常场景更特定的描述.
`message`可以是任意Scheme对象, 但通常是一个字符串.

```scheme
(define-condition-type &message &condition
  make-message-condition message-condition?
  (message condition-message))
```


```scheme
syntax: &irritants
procedure: (make-irritants-condition irritants)
returns: a condition of type &irritants
procedure: (irritants-condition? obj)
returns: #t if obj is a condition of type &irritants, #f otherwise
procedure: (condition-irritants condition)
returns: the contents of condition's irritants field
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况通常与`&message`状况一起使用, 提供导致异常场景或在异常场景中包含的Scheme值的信息. 例如, 一个过程接受到错误类型的参数, 它可以抛出由一个assertion状况, 命名了该过程的who状况, 一个指出接受到错误类型参数的message状况, 列举了参数的irritants状况.
`irritants`应该是一个列表.

```scheme
(define-condition-type &irritants &condition
  make-irritants-condition irritants-condition?
  (irritants condition-irritants))
```


```scheme
syntax: &who
procedure: (make-who-condition who)
returns: a condition of type &who
procedure: (who-condition? obj)
returns: #t if obj is a condition of type &who, #f otherwise
procedure: (condition-who condition)
returns: the contents of condition's who field
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况通常与`&message`状况一起使用, 以表明检测到错误的句法形式或过程.
`who`应该是一个符号或字符串.

```scheme
(define-condition-type &who &condition
  make-who-condition who-condition?
  (who condition-who))
```


```scheme
syntax: &non-continuable
procedure: (make-non-continuable-violation)
returns: a condition of type &non-continuable
procedure: (non-continuable-violation? obj)
returns: #t if obj is a condition of type &non-continuable, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明发生了non-continuable错误.
如果当前异常处理器返回, `raise`抛出这种类型的异常.

```scheme
(define-condition-type &non-continuable &violation
  make-non-continuable-violation
  non-continuable-violation?)
```


```scheme
syntax: &implementation-restriction
procedure: (make-implementation-restriction-violation)
returns: a condition of type &implementation-restriction
procedure: (implementation-restriction-violation? obj)
returns: #t if obj is a condition of type &implementation-restriction, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

实现限制的状况表明程序超出了实现中的显式, 例如, fixnum的加操作的值超出实现中fixnum的范围.
它通常不是表明具体实现中的不足, 而是表明程序尝试做的与具体实现能提供的存在失配.
在大多数情况下, 具体实现中限制是由底层硬件支配的.

```scheme
(define-condition-type &implementation-restriction &violation
  make-implementation-restriction-violation
  implementation-restriction-violation?)
```


```scheme
syntax: &lexical
procedure: (make-lexical-violation)
returns: a condition of type &lexical
procedure: (lexical-violation? obj)
returns: #t if obj is a condition of type &lexical, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明在解析Scheme程序或数据项(datum)时发生词法错误, 例如失配的括号或在数值常量中出现了非法字符.

```scheme
(define-condition-type &lexical &violation
  make-lexical-violation lexical-violation?)
```


```scheme
syntax: &syntax
procedure: (make-syntax-violation form subform)
returns: a condition of type &syntax
procedure: (syntax-violation? obj)
returns: #t if obj is a condition of type &syntax, #f otherwise
procedure: (syntax-violation-form condition)
returns: the contents of condition's form field
procedure: (syntax-violation-subform condition)
returns: the contents of condition's subform field
libraries: (rnrs conditions), (rnrs)
```

这种类型的状况表明在解析Scheme程序时发生语法错误.
在大多数实现中, 语法错误是由宏展开器检测的.
每个`form`和`subform`应该是一个语法对象或数据项, 前者表示包含的形式, 后者表示特定的子形式. 例如, 如果在`lambda`表达式中遇到重复的形式参数, `form`是该`lambda`表达式, `subform`是重复的参数.
如果不需要指定子形式, `subform`应该是`#f`.

```scheme
(define-condition-type &syntax &violation
  make-syntax-violation syntax-violation?
  (form syntax-violation-form)
  (subform syntax-violation-subform))
```


```scheme
syntax: &undefined
procedure: (make-undefined-violation)
returns: a condition of type &undefined
procedure: (undefined-violation? obj)
returns: #t if obj is a condition of type &undefined, #f otherwise
libraries: (rnrs conditions), (rnrs)
```

未定义状况表明尝试引用一个未绑定的变量.

```scheme
(define-condition-type &undefined &violation
  make-undefined-violation undefined-violation?)
```

## 9.4 NaN or Infinity Condition Types


```scheme
syntax: &no-infinities
procedure: (make-no-infinities-violation)
returns: a condition of type &no-infinities
procedure: (no-infinities-violation? obj)
returns: #t if obj is a condition of type &no-infinities, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

这个状况表明实现没有无穷(infinity)的表示.

```scheme
(define-condition-type &no-infinities &implementation-restriction
  make-no-infinities-violation
  no-infinities-violation?)
```


```scheme
syntax: &no-nans
procedure: (make-no-nans-violation)
returns: a condition of type &no-nans
procedure: (no-nans-violation? obj)
returns: #t if obj is a condition of type &no-nans, #f otherwise
libraries: (rnrs arithmetic flonums), (rnrs)
```

这种状况表明实现没有NaN的表示.

```scheme
(define-condition-type &no-nans &implementation-restriction
  make-no-nans-violation no-nans-violation?)
```

## 9.5 Standard I/O Condition Types


```scheme
syntax: &i/o
procedure: (make-i/o-error)
returns: a condition of type &i/o
procedure: (i/o-error? obj)
returns: #t if obj is a condition of type &i/o, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)    
```

这种状况表明发生了输入/输出错误, 通常作为下面的子类型出现.    

```scheme
(define-condition-type &i/o &error
  make-i/o-error i/o-error?)
```


```scheme
syntax: &i/o-read
procedure: (make-i/o-read-error)
returns: a condition of type &i/o-read
procedure: (i/o-read-error? obj)
returns: #t if obj is a condition of type &i/o-read, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明从端口读时发生错误.

```scheme
(define-condition-type &i/o-read &i/o
  make-i/o-read-error i/o-read-error?)
```


```scheme
syntax: &i/o-write
procedure: (make-i/o-write-error)
returns: a condition of type &i/o-write
procedure: (i/o-write-error? obj)
returns: #t if obj is a condition of type &i/o-write, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明写入端口时发生错误.

```scheme
(define-condition-type &i/o-write &i/o
  make-i/o-write-error i/o-write-error?)
```


```scheme
syntax: &i/o-invalid-position
procedure: (make-i/o-invalid-position-error position)
returns: a condition of type &i/o-invalid-position
procedure: (i/o-invalid-position-error? obj)
returns: #t if obj is a condition of type &i/o-invalid-position, #f otherwise
procedure: (i/o-error-position condition)
returns: the contents of condition's position field
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明尝试将端口中位置设置为超过底层文件或其它对象的范围. 
`position`应该是一个非法位置.

```scheme
(define-condition-type &i/o-invalid-position &i/o
  make-i/o-invalid-position-error
  i/o-invalid-position-error?
  (position i/o-error-position))
```


```scheme
syntax: &i/o-filename
procedure: (make-i/o-filename-error filename)
returns: a condition of type &i/o-filename
procedure: (i/o-filename-error? obj)
returns: #t if obj is a condition of type &i/o-filename, #f otherwise
procedure: (i/o-error-filename condition)
returns: the contents of condition's filename field
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明操作文件时发生输入/输出错误.
`filename`应该是文件的名称.

```scheme
(define-condition-type &i/o-filename &i/o
  make-i/o-filename-error i/o-filename-error?
  (filename i/o-error-filename))
```


```scheme
syntax: &i/o-file-protection
procedure: (make-i/o-file-protection-error filename)
returns: a condition of type &i/o-file-protection
procedure: (i/o-file-protection-error? obj)
returns: #t if obj is a condition of type &i/o-file-protection, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明尝试在程序没有合适权限的文件上执行输入/输出操作.

```scheme
(define-condition-type &i/o-file-protection &i/o-filename
  make-i/o-file-protection-error
  i/o-file-protection-error?)
```


```scheme
syntax: &i/o-file-is-read-only
procedure: (make-i/o-file-is-read-only-error filename)
returns: a condition of type &i/o-file-is-read-only
procedure: (i/o-file-is-read-only-error? obj)
returns: #t if obj is a condition of type &i/o-file-is-read-only, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明尝试写入一个只读文件.

```scheme
(define-condition-type &i/o-file-is-read-only &i/o-file-protection
  make-i/o-file-is-read-only-error
  i/o-file-is-read-only-error?)
```


```scheme
syntax: &i/o-file-already-exists
procedure: (make-i/o-file-already-exists-error filename)
returns: a condition of type &i/o-file-already-exists
procedure: (i/o-file-already-exists-error? obj)
returns: #t if obj is a condition of type &i/o-file-already-exists, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明文件操作因为文件已存在而失败, 即尝试不带`no-fail`文件选项的打开一个已存在文件用于输出.

```scheme
(define-condition-type &i/o-file-already-exists &i/o-filename
  make-i/o-file-already-exists-error
  i/o-file-already-exists-error?)
```


```scheme
syntax: &i/o-file-does-not-exist
procedure: (make-i/o-file-does-not-exist-error filename)
returns: a condition of type &i/o-file-does-not-exist
procedure: (i/o-file-does-not-exist-error? obj)
returns: #t if obj is a condition of type &i/o-file-does-not-exist, #f otherwise
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况表明文件操作因文件不存在而失败, 即尝试打开一个不存在的文件只用于输入.

```scheme
(define-condition-type &i/o-file-does-not-exist &i/o-filename
  make-i/o-file-does-not-exist-error
  i/o-file-does-not-exist-error?)
```


```scheme
syntax: &i/o-port
procedure: (make-i/o-port-error pobj)
returns: a condition of type &i/o-port
procedure: (i/o-port-error? obj)
returns: #t if obj is a condition of type &i/o-port, #f otherwise
procedure: (i/o-error-port condition)
returns: the contents of condition's pobj field
libraries: (rnrs io ports), (rnrs io simple), (rnrs files), (rnrs)
```

这种状况通常与其它`&i/o`子类型状况一起使用, 指出异常场景中涉及的端口.
`pobj`应该是一个端口.

```scheme
(define-condition-type &i/o-port &i/o
  make-i/o-port-error i/o-port-error?
  (pobj i/o-error-port))
```


```scheme
syntax: &i/o-decoding
procedure: (make-i/o-decoding-error pobj)
returns: a condition of type &i/o-decoding
procedure: (i/o-decoding-error? obj)
returns: #t if obj is a condition of type &i/o-decoding, #f otherwise
libraries: (rnrs io ports), (rnrs)
```

这种状况表明在将字节转换为字符时发生解码错误.
`pobj`应该是涉及的端口. 端口中位置应该被移过非法编码部分.

```scheme
(define-condition-type &i/o-decoding &i/o-port
  make-i/o-decoding-error i/o-decoding-error?)
```


```scheme
syntax: &i/o-encoding
procedure: (make-i/o-encoding-error pobj cobj)
returns: a condition of type &i/o-encoding
procedure: (i/o-encoding-error? obj)
returns: #t if obj is a condition of type &i/o-encoding, #f otherwise
procedure: (i/o-encoding-error-char condition)
returns: the contents of condition's cobj field
libraries: (rnrs io ports), (rnrs)
```

这种状况表明在将字符转换为字节时发生编码错误.
`pobj`应该是设计的端口.
`cobj`应该是编码失败的字符.

```scheme
(define-condition-type &i/o-encoding &i/o-port
  make-i/o-encoding-error i/o-encoding-error?
  (cobj i/o-encoding-error-char))
```
