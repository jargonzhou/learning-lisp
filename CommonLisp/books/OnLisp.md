# On Lisp

Lisp is a programmable programming language.

bottom-up design: instead of just writing your program in Lisp, you can write your own language **on Lisp**, and write your program in that.

- 2,3,4,5, 6: functions
- 7,8,9,10: tutorial on macros
- 11,12,13,14,15,16,17,18: abstractions build with macros
- 19,20,21,22,23,24: embedded langauges
- 25: CLOS

# 1 The Extensible Language

Lisp itself is a Lisp program, and Lisp programs can be expresses as lists, which are Lisp data structures.

## 1.1 Design by Evolution

## 1.2 Programming Bottom-Up

## 1.3 Extensible Software

## 1.4 Extending Lisp

2 ways to add new operators to Lisp: functions, macros.

## 1.5 Why Lisp (or When)

Lisp features
- dynamic storage allocation, garbage collection
- runtime typing
- functions as objects
- a built-in parse which generates lists
- a compiler which accepts programs expressed as lists
- an interactive environment
- ...
# 2 Functions

## 2.1 Functions as Data

do with functions
- create new ones at runtime
- store them in variables and in structures
- pass them as arguments to other functions
- return them as result

## 2.2 Defining Functions

```lisp
defun
#' ; function
lambda

symbol-value
symbol-function
```

a lambda-expression can be considered as the name of a function.

`defun`: set the `symbol-function` of its first argument to a function constructed from the remaining arguments.

build a function and associate it with a name are two seperate operations.

## 2.3 Functional Arguments

```lisp
apply

funcall
```

## 2.4 Functions as Properties

```lisp
; method in OO
(funcall (get animal 'behavior))
(setf (get 'dog 'behavior) ...)
```

## 2.5 Scope

Common Lisp is a lexically scoped Lisp.

## 2.6 Closures

closures are functions with local state.

## 2.7 Local Functions

```lisp
(labels ((<name> <parameters> <body>)))
```

the body of a function `f` defined in a `labels` expression may refer to any other function defined there, including `f` itself.

## 2.8 Tail-Recursion

a function which is not tail-recursive can often be transformed into one that is by embedding in it a local function which uses an **accumulator**.

```lisp
;;; top of file
(proclaim '(optimize speed)) ; do tail-recursion optimization
```

## 2.9 Compilation

```lisp
compiled-function-p

(defun foo (x) (1+ x))
(compile 'foo)
(compile nil '(lambda (x) (+ x 2)))

compile-file

;;; inline functions
(proclaim '(inline <function-name>))
```

## 2.10 Functions from Lists

in Common Lisp, functions are no longer made of lists, good implementations compile them into native machine code.

# 3 Functional Programming

## 3.1 Functional Design

```lisp
reverse
nreverse

nconc

sort
remove
substitute
```

```lisp
; tax
set setq setf psetf psetq incf decf push pop pushnew
rplaca rplacd rotatef shiftf remf remprop remhash
let*
```

multiple values
```lisp
multiple-value-bind
```

## 3.2 Imperative Outside-In

a functional program tells you what it wants; an impreative program tells you what to do.

## 3.3 Functional Interfaces

## 3.4 Interactive Programming

# 4 Utility Functions

## 4.1 Birth of a Utility

```lisp
mapcan
```

## 4.2 Invest in Abstraction

## 4.3 Operations on Lists

## 4.4 Search

## 4.5 Mapping

## 4.6 I/O

## 4.7 Symbols and Strings

## 4.8 Density

# 5 Returning Functions

## 5.1 Common Lisp Evolves

## 5.2 Orthogonality

## 5.3 Memoizing

## 5.4 Composing Functions

## 5.5 Recursion on Cdrs

## 5.6 Recursion on Subtrees

## 5.7 When to Build Functions

# 6 Functions as Representation

## 6.1 Networks

## 6.2 Compiling Networks

## 6.3 Looking Forward

# 7 Macros

The definition of a macro is essentially a **function** that generates Lisp code: a program that write programs.

## 7.1 How Macros Work

a function produces results, but a macro produces **expressions**, which when evaluated, produce results.

## 7.2 Backquote

backquote <code>`</code> is a special version of quote `'` which can be used to create templates for Lisp expressions.
```lisp
;;; affixed to an expression: behave just like quote '
`(a b c) ; '(a b c)

;;; a backquoted list
`(a b c)` ; (list 'a 'b 'c)
```

comma `,`: in backquote, turn off the quoting
- a comma surrounded by n commas must be surround by at least n+1 backquotes
```lisp
`(a ,b c ,d) ; (list 'a b 'c d)

;;; error in toplevel
,x
`(a ,,b c)
`(a ,(b ,c) d)
`(,,`a)
```

comma-at `,@`: behave like comma, with one difference: instead of merely inserting the value of the expression to which it is affixed as comma does, comma-at **splices** it.
- in order for its arguments to be spliced, `,@` must occur within a sequence.
- the object to be spliced must be a list, unless it occurs last.

operators for grouping code into blocks: ofen implicit hidden by macros
```lisp
block
tagbody
progn   ; let, cond, when
```

```lisp
`(a ,@b c)
;;; equals to
(cons 'a (append b (list 'c)))
```

backquote has a life of its own, seperate from its role in macros.

## 7.3 Defining Simple Macros

method
- begin with a typical call to the macro you want to define. `(memq x choices)`
- below it write down the expression into which it ought to expand. `(member x choices :test #'eq)`
- from the macro call, construct the parameter list for your macro, making up some parameter name for each of the arguments `(defmacro memq (obj lst)`
- for each argument in the macro call, draw a line connecting it with the place it appears in the expansion below.
- to write the body of the macro, start the body with a backquote: whenever you find a parenthesis that isn't part of an argument in the macro call, put one in the macro definition. ```(defmacro memq (obj lst) `()```
	- for each expression in the expansion:
	- if no line connecting it with the macro call: write down the expression itself
	- if a line connection to one of the arguments in the macro: write down the symbol which occurs in the corresponding position in the macro parameter, preceded by a comma `,`
	- ```(defmacro memq () `(member ,obj ,lst :test #'eq))```
```lisp
;;; call
(memq x choices)
;;; expansion
(member x choices :test #'eq) ; member default :test is eql
```

some body of code: `&rest` or `&body` - ex: `while`
- for each expression in the expansion:
	- if there is a connection from a series of expression in the expansion to a series of the arguments in the macro call, write down the corresponding `&rest` or `&body` parameter, preceded by a comma-at `,@`.

## 7.4 Testing Macroexpansion

```lisp
macroexpand
macroexpand-1
```

## 7.5 Destructuring in Parameter Lists

```lisp
 destructuring-bind
```

## 7.6 A Model of Macros

skeleton impl

## 7.7 Macros as Programs

The most general approach to writing macros is to think about the sort of expression you want to be able to use, what you want it to expand into, and then write the **program** that will transfrom the first form into the second.

```lisp
do
psetq
```

## 7.8 Macro Style

2 kinds of code associated with a macro definition:
- **expander code**: favor clarity over efficiency
- **expansion code**: favor efficiency over clarity

## 7.9 Dependence on Macros

**redefine a function**: other functions which call it will automatically get the new verison.

a function `f` definition contains a macro call `(m ...)`: when `f` is compiled, `(m ...)` is replaced by its expansion
- **redefine** `m` after `f` is compiled: the expansion within `f` cannot be updated.
a macro `m1` definition coantins another macro call `(m2 ...)`
- **refefine** `m2` after `m` is compiled: the expansion within `m` cannot be updated.

principles
- define macro before function or macros which call them
- when a macro is redefined, also recompile all the funcions or macros which call it(directly or via other macros).

## 7.10 Macros from Functions

## 7.11 Symbol Macros

# 8 When to Use Macros

## 8.1 When Nothing Else Will Do

When you do need a macro, what do you need from it?
- Macros can **control or prevent the evaluation of their arguments**, and
	- 1. Transformation: `(setf (car x) 'a)`
	- 2. Binding: `setq`, `do`
	- 3. Conditional evaluation: `when`
	- 4. Multiple evaluation: `do`
	- inline expansion of macros
		- 5. Using the calling environment: [[#5.20 Continuations]], [[#5.23 Parsing with ATNs]]
		- 6. Wrapping a new environment
		- 7. Saving function calls.
- **the arguments are expanded right into the calling context**.

## 8.2 Macro or Function?

THE PROS
- 1. Computation at compile-time
- 2. Integration with Lisp: [[#5.19 A Query Compiler]]
- 3. Saving function calls

THE CONS
- 4. Functions are data, while macros are more like instructions to the compiler.
- 5. Clarity of source code
- 6. Clarity at runtime
- 7. Recursion

## 8.3 Applications for Macros

# 9 Variable Capture

Variable capture occurs when macro expansion causes a name clash: when some symbol ends up referring to a variable from another context.

intentional variable capture: [[#5.14 Anaphoric Macros]]

## 9.1 Macro Argument Capture

Instances of variable capture can be traced to the two situations:
- macro argument capture,
- free symbol capture.

## 9.2 Free Symbol Capture

## 9.3 When Capture Occurs

Concepts:
- **Free**: a symbol `s` occurs free in an expression when it is used as a variable in that expression, but the expression does not create a binding for it.
- **Skeleton**: the skeleton of a macro expansion is the whole expansion, minus anything which as part of an argument in the macro call.
```lisp
(defmacro foo (x y)
  `(/ (+ ,x 1) ,y))

(foo (- 5 2) 6)
; macro expansion
(/ (+ (- 5 2) 1) 6)
; skeleton
(/ (+         1)  )
```
- **Capturable**: a symbol is capturable in some macro expansion if
	- (a) it *occurs free in the skeleton* of the macro expansion, or
	- (b) it is *bound by a part of the skeleton* in which arguments passed to the macro are either *bound*(b.1) or *evaluated*(b.2).
```lisp
; (a)
(defmacro cap1 ()
  `(+ x 1))
```
```lisp
; (b.1)
(defmacro cap2 (var)
  `(let ((x ...)
         (,var ...))
      ...))

(defmacro cap3 (var)
  `(let ((x ...))
     (let ((,var ...))
       ...)))
(defmacro cap3 (var)
  `(let ((,var ...))
     (let ((x ...))
       ...)))
```
If there is no context in which the binding of `x` and the variable passed as an argument will both be visible, then `x` won't be capturable.
```lisp
(defmacro safe1 (var)
  `(progn (let ((x 1))
            (print x))
          (let ((,var 1))
            (print ,var))))
```
```lisp
; (b.2)
(defmacro cap5 (&body body)
  `(let ((x ...))
     ,@body))

(defmacro safe2 (expr)
  `(let ((x ,expr))
     (cons x 1)))
; it's only the binding of skeletal variables we have to worry about
(defmacro safe3 (var &body body)
  `(let ((,var ...))
     ,@body))
```

```lisp
(defmacro for ((var start stop) &body body) ; wrong
  `(do ((,var ,start (1+ ,var))
        (limit ,stop))
       ((> ,var limit))
     ,@body))
; (b.1): as argument
(for (limit 1 5)
  (princ limit))
; (b.2): occur in the body
(let ((limit 0))
  (for (x 1 10)
    (incf limit x))
  limit)
```

## 9.4 Avoiding Capture with Better Names

## 9.5 Avoiding Capture by Prior Evaluation

## 9.6 Avoiding Capture with Gensyms

## 9.7 Avoiding Capture with Packages

## 9.8 Capture in Other Name-Spaces

## 9.9 Why Bother?

# 10 Other Macro Pitfalls

## 10.1 Number of Evaluations/求值次数

## 10.2 Order of Evaluation/求值顺序

## 10.3 Non-functional Expanders/非函数式展开器

## 10.4 Recursion/递归

# 11 Classic Macros/经典宏

## 11.1 Creating Context/创建上下文

## 11.2 The with- Macro/资源清理宏

## 11.3 Conditional Evaluation/条件求值

## 11.4 Iteration/迭代

## 11.5 Iteration with Multiple Values/多值迭代

## 11.6 Need for Macros

# 12 Generalized Variables/泛化的变量 `setf`宏

## 12.1 The Concept

## 12.2 The Multiple Evaluation Problem

## 12.3 New Utilities

## 12.4 More Complex Utilities

## 12.5 Defining Inversions

# 13 Computation at Compile-Time/编译时计算

## 13.1 New Utilities

## 13.2 Example: Bezier Curves

## 13.3 Applications

# 14 Anaphoric Macros/指代宏
- anaphoric: 指代前项的/回指的, 隐喻

## 14.1 Anaphoric Variants

## 14.2 Failure

## 14.3 Referential Transparency

# 15 Macros Returning Functions/返回函数的宏

## 15.1 Building Functions

```lisp
(fn (operator . arguments))
;;; operator: name of a function or macro, or `compose`
;;; arguments: names of functions or macros of one argument, or expressions that could be arguments to fn
```

## 15.2 Recursion on Cdrs

## 15.3 Recursion on Subtrees

## 15.4 Lazy Evaluation

# 16 Macro-Defining Macros/定义宏的宏

## 16.1 Abbreviations/缩写

## 16.2 Properties/属性访问

## 16.3 Anaphoric Macros/指代宏

# 17 Read-Macros/读取器宏

## 17.1 Macro Characters/宏字符
- function `set-macro-character`
- `read`

## 17.2 Dispatching Macro Characters/分发宏字符
- `make-dispatch-macro-character`: define your own dispatching macro characters.
	- `#`
	- complete list: Common Lisp- The Language P.531.
- `set-dispatch-macro-character`: define new dispatching macro character combinations.
	- `#?`

## 17.3 Delimiters/分隔符
- `#[`
- `read-delimited-list`

## 17.4 When What Happens

# 18 Destructuring/解构

## 18.1 Destructuring on Lists

## 18.2 Other Structures

## 18.3 Reference

## 18.4 Matching

# 19 A Query Compiler/一个查询编译器

## 19.1 The Database

## 19.2 Pattern-Matching Queries

## 19.3 A Query Interpreter

## 19.4 Restrictions on Binding

## 19.5 A Query Compiler

# 20 Continuations/延续

## 20.1 Scheme Continuations

## 20.2 Continuation-Passing Macros

## 20.3 Code-Walkers and CPS Conversion

# 21 Multiple Processes/多进程

## 21.1 The Process Abstraction

## 21.2 Implementation

## 21.3 The Less-than-Rapid Prototype

# 22 Nondeterminism/不确定的

## 22.1 The Concept

## 22.2 Search

## 22.3 Scheme Implementation

## 22.4 Common Lisp Implementation

## 22.5 Cuts

## 22.6 True Nondeterminism

# 23 Parsing with ATNs/使用扩充转移网络(Augmented Transition Networks)解析

## 23.1 Background

## 23.2 The Formalism

## 23.3 Nondeterminism

## 23.4 An ATN Compiler

## 23.5 A Sample ATN

# 24 Prolog/Prolog嵌入式语言

## 24.1 Concepts

## 24.2 An Interpreter

## 24.3 Rules

## 24.4 The Need for Nondeterminism

## 24.5 New Implementation

## 24.6 Adding Prolog Features

## 24.7 Examples

## 24.8 The Senses of Compile

# 25 Object-Oriented Lisp/面向对象的Lisp

## 25.1 Plus ca Change

## 25.2 Objects in Plain Lisp

## 25.3 Classes and Instances

## 25.4 Methods

## 25.5 Auxiliary Methods and Combination

## 25.6 CLOS and Lisp

## 25.7 When to Object

# See Also
* [ATN(Augmented Transition Network) - wikipedia](https://en.wikipedia.org/wiki/Augmented_transition_network)
