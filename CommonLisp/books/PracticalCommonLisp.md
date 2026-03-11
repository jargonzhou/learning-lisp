# Practical Common Lisp


# 1 Introduction: Why Lisp?

- Why Lisp?

- Where It Began

LISt Processing
- [[book.Common Lisp- The Language]]
- [[book.ANSI Common Lisp]]

- Who This Book Is For

# 2 Lather, Rinse, Repeat: A Tour of the REPL

- Lisp in a Box
- SLIME: a Common Lisp development environment built on top of Emacs.

- Choosing a Lisp Implementation

- Allegro on GNU/Linux

- Getting Up and Running with Lisp in a Box

> SKIP

- Free Your Mind: Interactive Programming

REPL: read-eval-print loop.
- top-level, top-level listener, Lisp listener

- Experimenting in the REPL

```lisp
10

(+ 2 3)
```

- "Hello, World," Lisp Style

```lisp
"hello, world"

(format t "hello, world")
(write-line "hello, world")
(print "hello, world")
```
- `FORMAT` function
	- return `NIL`
- `t`

every expression in Lisp evaluates to some result.

function: `DEFUN`
```lisp
(defun hello-world () (format t "hello, world"))

(hello-world)
```

functions in Common Lisp automatically return the value of the last expression evaluated.

- Saving Your Work

file extension: `.lisp`, `.cl`.

Unlike Java or Python, Common Lisp does not throw an exception and unwinding the stack, instead drops user into the **debugger**.

load file: `LOAD`
```lisp
(load "hello.lisp")
```
compile file: `COMPILE-FILE` output FASL file(fast-load file) `*.fasl`
```lisp
(load (compile-file "hello.lisp"))
```

Lisp image

# 3 Practical: A Simple Database
- [ ] Practical: A Simple Database
- CDs and Records

- Filing CDs

- Looking at the Database Contents

- Improving the User Interaction

- Saving and Loading the Database

- Querying the Database

- function `REMOVE-IF-NOT`: take a predicate and a list, return a list containing only the elements of the original list that match the predicate.
	- predicate function `EVENP`

- Updating Existing Records - Another User for `where`

- Removing Duplication and Winning Big

- Wrapping Up

# 4 Syntax and Semantics

- What's with All the Parentheses?

extensive use of parentheses and prefix notation.
M-expressions by John McCarthy

- Breaking Open the Black Box

interpreter, compiler:
- a lexical analyzer
- a parser
- an evaluator

Common Lisp defines tow black boxes:
- the **reader**: transform text into Lisp objects called **s-expressions**.
- the **evaluator**: implement the semantics of the language in terms of the Lisp objects.
	- define a syntax of Lisp **forms** that can be built out of s-expressions.

- S-expressions

- lists
- atoms
	- numbers
	- strings
	- names: represented by objects called **symbols**

conventions:
- global variables: `*package*`.
- constant: `+PI+`.

- S-expressions As Lisp Forms

legal Lips form:
- any atom (any nonlist or the empty list).
	- **symbol**: the name of a variable, evaluate to the current value of the variable.
		- the variables they name can be assigned the value of the symbol itself: `T`, `NIL`.
		- keyword symbols: *self-evaluating symbols*, start with `:`.
	- everything else: ex numbers and strings, *self-evaluating objects*.
- any list that has a symbol as its first element.
	- evaluator determine whether the symbol starts the list is the name of a function, a macro, a special operator.
	- *function call forms*
	- *macro forms*
	- *special forms*

- Function Calls

```lisp
(function-name argument*)
```

- Special Operators

ex: `IF`
There are 25 in all. see [[spec.CLHS(Common Lisp HyperSpec)#3.1.2.1.2.1 特殊形式(Special Forms)]]
``` lisp
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

```lisp
(if test-form then-form [ else-form ])

(quote (+ 1 2))
'(+ 1 2) ; special syntax in reader

(let ((x 10)) x)
```

- Macros

A macro is a function that takes s-expressions as arguments and returns a Lisp form that's then evaluated in place of the macro form.

evaluation of a macro form:
- the elements of the macro form are passed as unevaluated to the macro function;
- the form returned by the macro function (called its *expansion*) is evaluated according to the normal evaluation rules.

use function `COMPILE-FILE` to compile a whole file of source code: 
- all the macro forms in the file are recursively expanded until the code consists of nothing but function call forms and special forms; (macros generate their expansion at compile time)
- this macroless code is then compiled into a FASL file, the `LOAD` function knows how to load.

- Truth, Falsehood, and Equality

真假值

`NIL`是唯一的假值, 其他所有的都是真值. `T`是标准的真值.
`NIL`是唯一一个即是原子又是列表的对象, 其还用来表示空列表`()`.
``` lisp
nil () 'nil '()
t 't
```

特定于类型的等价谓词:
``` lisp
=         ; 比较数字
CHAR=     ; 比较字符
...
```

通用的等价谓词:
- `EQ`: Returns true if its arguments are the same, *identical* object; otherwise, returns false.
- `EQL`: The value of `eql` is true of two objects, x and y, in the following cases:
	- If x and y are `eq`.
	- If x and y are both *numbers* of the same type and the same value. If an implementation supports positive and negative zeros as distinct values, then `(eql 0.0 -0.0)` returns false. Otherwise, when the syntax -0.0 is read it is interpreted as the value 0.0, and so `(eql 0.0 -0.0)` returns true.
	- If they are both *characters* that represent the same character.
	- Otherwise the value of `eql` is false.
- `EQUAL`: Returns true if x and y are *structurally similar (isomorphic)* objects. Objects are treated as follows by `equal`:
	- *Symbols*, *Numbers*, and *Characters*: `equal` is true of two objects if they are symbols that are `eq`, if they are numbers that are `eql`, or if they are characters that are `eql`.
	- *Conses*: For conses, `equal` is defined recursively as the two cars being equal and the two cdrs being equal.
	- *Arrays*: Two arrays are `equal` only if they are eq`,` with one exception: strings and bit vectors are compared element-by-element (using eql).` `If either x or y has a fill pointer, the fill pointer limits the number of elements examined by equal. Uppercase and lowercase letters in strings are considered by equal to be different.
	- *Pathnames*: Two pathnames are equal if and only if all the corresponding components (host, device, and so on) are equivalent. Whether or not uppercase and lowercase letters are considered equivalent in strings appearing in components is implementation-dependent. pathnames that are equal should be functionally equivalent.
	- Other (Structures, hash-tables, instances, ...): Two other objects are `equal` only if they are eq`.`
	- `equal` does not descend any objects other than the ones explicitly specified above.
- `EQUALP`: Returns true if x and y are `equal`, or if they have *components* that are of the same type as each other and if those components are `equalp`; specifically, `equalp` returns true in the following cases:
	- *Characters*: If two characters are `char-equal`.
	- *Numbers*: If two numbers are the same under =.
	- *Conses*: If the two cars in the conses are `equalp` and the two cdrs in the conses are `equalp`.
	- *Arrays*: If two arrays have the same number of dimensions, the dimensions match, and the corresponding active elements are `equalp`. The types for which the arrays are specialized need not match; for example, a string and a general array that happens to contain the same characters are `equalp`. Because `equalp` performs element-by-element comparisons of strings and ignores the case of characters, case distinctions are ignored when `equalp` compares strings.
	- *Structures*: If two structures S1 and S2 have the same class and the value of each slot in S1 is the same under `equalp` as the value of the corresponding slot in S2.
	- *Hash Tables*: `equalp` descends hash-tables by first comparing the count of entries and the `:test` function; if those are the same, it compares the keys of the tables using the `:test` function and then the values of the matching keys using `equalp` recursively.
	- `equalp` does not descend any objects other than the ones explicitly specified above. The next figure summarizes the information given in the previous list. In addition, the figure specifies the priority of the behavior of equalp, with upper entries taking priority over lower ones.

- Formatting Lisp Code

The key to formatting Lisp code is to indent it properly.
Closing parentheses are always put on the same line as the last element of the list they're closing.

comments:
```lisp
;;;; Four semicolons are used for a file header comment.

;;; A comment with three semicolons will usually be a paragraph
;;; comment that applies to a large section of code that follows,

(defun foo (x)
  (dotimes (i x)
    ;; Two semicolons indicate this comment applies to the code
	;; that follows. Note that this comment is indented the same
	;; as the code that follows.
	(some-function-call)
	(another i) ; this comment applies to this line only
	(and-another) ; and this is for this line
	(baz)))
```

# 5 Functions

- Defining new functions

``` lisp
(defun name (parameter*)
  "Optional documentation string."
  body-form*)
```
- any symbol can be used as a function name.
	- `string-widget`
	- `frob-widget`
- parameter list: required, optional, multiple, keyword
- documentation string: `DOCUMENTATION`
- body: any number of Lisp expressions
	- the value of the last expression is returned as the value of the function.
	- `RETURN-FROM` special operator: return immediately from anywhere in a function.

> [!example] `hello-world`, `verbose-sum`

- Function parameter lists

required parameters: when a parameter list is a simple list of variable names.

- Optional parameters `&optional`

optional parameter:
- callers who don't care will get a reasonable default.
- other callers can provide a specific value.

if the arguments run out before the optional parameters do, the remaining optional parameters are bound to the value `NIL`.
```lisp
; &optional followed by the names of the optional parameter
(defun foo (a b &optional c d) (list a b c d))

(foo 1 2)     ; (1 2 NIL NIL)
(foo 1 2 3)   ; (1 2 3 NIL)
(foo 1 2 3 4) ; (1 2 3 4)
```
specify the default value by replacing the parameter name with a list containing a name and an expression.
```lisp
(defun foo (a &optional (b 10)) (list a b))

(foo 1 2) ; (1 2)
(foo 1)   ; (1 10)
```
the default value expression can refer to parameters that occur earlier in the parameter list.
```lisp
(defun make-rectangle (width &optional (height width))) ; width
```
whether the value of an optional argument was supplied by the caller or is the default value: `<parmeter-name>-supplied-p`
```lisp
(defun foo (a b &optional (c 3 c-supplied-p))
  (list a b c c-supplied-p))

(foo 1 2)   ; (1 2 3 NIL)
(foo 1 2 3) ; (1 2 3 T)
(foo 1 2 4) ; (1 2 4 T)
```

- Rest parameters `&rest`

some functions need to take a variable number of arguments. ex: `FORMAT`, `+`.

if a function includes a `&rest` parameter, any arguments remaining after values have been doled out to all the required and optional parameters, are gathered up into a list that becomes the value of the `&rest` parameter.
```lisp
(defun format (stream string &rest values) ...)
(defun + (&rest numbers) ...)

; example
(format t "hello, world")
(format t "hello, ~a" name)
(format t "x: ~d y: ~d" x y)
(+)
(+ 1)
(+ 1 2)
(+ 1 2 3)
```

- Keyword parameters `&key`

To give a function keyword parameters, after any required, `&optional` and `&rest` parameters, you include the symbol `&key` and then any number of keyword parameter specifier, which *work like optional parameter specifier*.
When the function is called, each keyword parameter is bound to the value immediately following a keyword of the same name.
If a given keyword doesn't appear in the argument list, then the corresponding parameter is assigned its default value, just like an optional parameter.
Keyword arguments are labeled, they can be *passed in any order* as long as they follow any required arguments.
```lisp
; take only keyword parameters
(defun foo (&key a b c) (list a b c))

(foo) → (NIL NIL NIL)
(foo :a 1)           ; (1 NIL NIL)
(foo :b 1)           ; (NIL 1 NIL)
(foo :c 1)           ; (NIL NIL 1)
(foo :a 1 :c 3)      ; (1 NIL 3)
(foo :a 1 :b 2 :c 3) ; (1 2 3)
(foo :a 1 :c 3 :b 2) ; (1 2 3)
```
Keyword parameters can provide a default form and the name of a supplied-p variable.
```lisp
(defun foo (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))
  
(foo :a 1)           ; (1 0 1 NIL)
(foo :b 1)           ; (0 1 1 T)
(foo :b 1 :c 4)      ; (0 1 4 T)
(foo :a 2 :b 1 :c 4) ; (2 1 4 T)
```
Specify the caller used parameter name to be different from the name of the actual parameter: replace the parameter name with a list containing the keyword to use when calling the function and the name to be used for the parameter.
```lisp
(defun foo (&key ((:apple a)) ((:box b) 0) ((:charlie c) 0 c-supplied-p))
  (list a b c c-supplied-p))
  
(foo :apple 10 :box 20 :charlie 30) ; (10 20 30 T)
```

- Mixing different parameter types

parameter declaration order:
- required parameters
- optional parameters
- rest parameters
- keyword parameters

- combine `&optional` and `&rest` parameters
- combine `&optional` and `&key` parameters
	- if caller not supply values for all optional parameters, those parameters will eat up the keywords and values intended for the keyword parameters.
	- change to use all `&key` parameters.
```lisp
(defun foo (x &optional y &key z) (list x y z))

(foo 1 2 :z 3) ; (1 2 3)
(foo 1)        ; (1 nil nil)
(foo 1 :z 3)   ; ERROR
```
- combine `&rest` and `&key` parameters
	- all the remaining values, include the keywords themself are gathered into a list bound to the `&rest` parameter, and the appropriate values are also bound to the `&key` parameters.
```lisp
(defun foo (&rest rest &key a b c) (list rest a b c))

(foo :a 1 :b 2 :c 3) ; ((:A 1 :B 2 :C 3) 1 2 3)
```

- Function return values

default behavior of function: return the value of the last expression evaluated as return value.

`RETURN-FROM` special operator: immediately return any value from the function.
- return from a block of code defined with `BLOCK` special operator: `DEFUN` wrap whole function body in a block with the same name as the function.
- its first argument is the name of the block from which to return: not evaluated and not quoted.
```lisp
(defun foo (n)
  (dotimes (i 10)
    (dotimes (j 10)
      (when (> (* i j) n)
        (return-from foo (list i j))))))
```

All Lisp expression, including control structures(loops, conditionals), evaluate to a value.

- Function as data, high-order functions

In Lisp, functions are an object, the actual representation of a function object, whether named or anonymous, is opaque(in a native-compiling Lisp, consists mostly of machine code).

`FUNCTION` special operator: get a function object 
- takes a single argument and returns the function with that name. 
- the name isn't quoted.
- syntax sugar: `#'`
```lisp
(defun foo (x) (* 2 x))

(function foo)
#'foo
```

invoke a function through a function object:
- `FUNCALL`: when know the number of arguments, the first argument is a function object.
- `APPLY`: like `FUNCALL`, but after the function object, instead of individual argument, expects a list. apply the function to the values in the list.
	- also accept loose arguments as long as the last argument is a list.
```lisp
(funcall #'foo 1 2 3) ; same as (foo 1 2 3)

; fn: intepreted as a variable, the variable's value is a function object
(defun plot (fn min max step)
  (loop for i from min to max by step do
    (loop repeat (funcall fn i) do (format t "*")) ; call fn with i
    (format t "~%")))
(plot #'exp 0 4 1/2)
```
```lisp
; plot-data is a list (fn min max step)
(plot (first plot-data) (second plot-data) (third plot-data) (fourth plot-data))

(apply #'plot plot-data)
```
```lisp
; plot-data is a list (min max step)
(apply #'plot #'exp plot-data)
```

- Anonymous functions

`LAMBDA` expression: create anonymous functions
- think it as a special kind of function name: can be used anywhere a normal function name can be.
```lisp
(lambda (parameters) body)

(funcall #'(lambda (x y) (+ x y)) 2 3) ; 5
((lambda (x y) (+ x y)) 2 3)           ; 5
```
```lisp
(defun double (x) (* 2 x))
(plot #'double 0 10 1)
; more ad-hoc
(plot #'(lambda (x) (* 2 x)) 0 10 1)
```

`LAMBDA` expression also make *closures*: functions that capture part of the environment where they'are created.

# 6 Variables

- Variable Basics

In Common Lisp:
- **variables** are named places that can hold a value.
- **variables** aren't typed: a variable can hold values of any type, the value carry type information that can be used to check types at runtime.
	- *dynamically typed*: type errors are detected dynamically.
	- *strongly typed*: all type errors will be detected.

All **values** in Common Lisp are (conceptually at least) **references** to objects.
- assign a varaible a new value changes what object the variable refers to but has no effect on the previously referenced object.
- if a varibale holds a reference to *a mutable object*, we can use that reference to modify the object.

introduce new variables:
- define function parameters: 
	- create new **bindings** to hold the arguments passed by the function's caller.
	- function parameters hold object references.
```lisp
; function
(defun foo (x y x) (+ x y z))

```
- `LET` special operator
	- when evaluated, all the initial value forms are first evaluted.
	- new bindings are created and initialized to appropriate initial values before the body forms are executed.
	- with the body of `LET`, the variable names refer to the newly created binding.
	- after `LET`, the names refer to whatever they referrred to before `LET`.
```lisp
(let (variable*) ; variable: a variable initialization form
  body-form*)

(let ((x 10) (y 20) z) 
  (list x y z)) ; (10 20 NIL)
```

The **scope** of function parameters and `LET` variables is delimited by the form that introduces the variable: the **binding form**.
- nest binding forms that introduce variables with the same name: the bindings of the innermost variable *shadows* the outer bindings.

```lisp

(defun foo (x)
  (format t "Parameter: ~a~%" x)
  (let ((x 2))
    (format t "Outer LET: ~a~%" x)
    (let ((x 3))
      (format t "Inner LET: ~a~%" x))
    (format t "Outer LET: ~a~%" x))
  (format t "Parameter: ~a~%" x))

(foo 1)
Parameter: 1
Outer LET: 2
Inner LET: 3
Outer LET: 2
Parameter: 1
NIL
```

other constructs that serve as binding forms: ex `DOTIMES`.
```lisp
(dotimes (x 10) (format t "~d " x))
```

`LET*` binding form: the intial value forms for each variable can refer to variabels introduced earlier in the variabels list.
```lisp
(let* ((x 10)
	   (y (+ x 10))) ; refer x
  (list x y))
```

- Lexical Variables and Closures

By default, all binding forms in Common Lisp introduce **lexically scoped** variables
- can be referred to only by code that's textually within the binding form.

The anonymous function is called a **closure** because it closes over the binding created by the `LET`:
```lisp
(let ((count 0)) #'(lambda () (setf count (1+ count))))
```
Closures capture the bindings, not the value of the variable.
- access the value of the variable it closes over.
- assign new values that will persist between calls to the closure.

```lisp
(defparameter *fn* (let ((count 0)) #'(lambda () (setf count (1+ count)))))

(funcall *fn*)
1
(funcall *fn*)
2
(funcall *fn*)
3
```
A single closure can close over many variable bindings, multiple closures can capture the same binding.
```lisp
(let ((count 0))
  (list
  #'(lambda () (incf count))
  #'(lambda () (incf count))
  #'(lambda () count)))
```

- Dynamic/Special Variables

create global variables: start and end with `*`
- `DEFVAR`: assign the variable if the variable is undefined. can use with no initial value: *unbound variable*.
- `DEFPARAMETER`: always assign the initial value to the named variable.
```lisp
(defvar *count* 0
  "Count of widgets made so far.")

(defparameter *gap-tolerance* 0.001
  "Tolerance to be allowed in widget gaps.")
```
After defininig a global variable, we can refer to it from anywhere:
```lisp
(defun increment-widget-count () (incf *count*))
```

With a dynamic variable, when bind it (with `LET` variable or function parameter), the binding that's create on entry to the binding form replaces the gobal binding for the duration of the binding form.
```lisp
(let ((*standard-output* *some-other-stream*))
  (stuff))
```
```lisp
(defvar *x* 10)
(defun foo () (format t "X: ~d~%" *x*))

(foo)
X: 10
NIL

(let ((*x* 20)) (foo))
(foo)
X: 10
NIL

(defun bar ()
  (foo)
  (let ((*x* 20)) (foo))
  (foo))
(bar)
X: 10
X: 20
X: 10
NIL

; redefine foo
(defun foo ()
  (format t "Before assignment~18tX: ~d~%" *x*)
  (setf *x* (+ 1 *x*)) ; update
  (format t "After assignment~18tX: ~d~%" *x*))
(foo)
Before assignment X: 10
After assignment X: 11
NIL

(bar)
Before assignment X: 11
After assignment X: 12
Before assignment X: 20
After assignment X: 21
Before assignment X: 12
After assignment X: 13
NIL
```

The name of every variable defined with `DEFVAR` and `DEFPARAMETER` is automatically declared globally **special**.
We can declare a name locally special. 
- If, in a binding form, we declare a name special, then the binding created for that variable will by dynamic rather than lexical.
- Other code can locally declare a name special in order to refer to the dynamic binding.

- Constants

All constants are global and are defined with `DEFCONSTANT`.
- The name can be used only to refer to the constant, can't be used as a function parameter or rebound with any other binding form.
- convention: start and end with `+`.
- the effect of redefining a constant is undefined.
```lisp
(defconstant name initial-value-form [ documentation-string ])
```

- Assignment

`SETF` macro: assign a new value to a binding.
- returns the newly assigned value.
```lisp
(setf place value)

(setf x (setf y (random 10)))
```
- when `place` is a variable, it expands into a call to `SETQ` special operator, which has access to both lexical and dynamic bindings.
```lisp
(setf x 10)
```
- assign a new value to a binding has no effect on any other bindings of that variable
```lisp
(defun foo (x) (setf x 10))

(let ((y 20))
  (foo y)
  (print y)) ; output: 20
```
`SETF` can also assign to multiple places in sequence:
```lisp
(setf x 1 y 2)
```

- Generalized Assignment

`SETF`able places
- array, hash table, list, user defined structure.
- assign to user-defined places: `DEFSETF`, `DEFINE-SETF-EXPANDER`.
```lisp
(setf x 10)                   ; simple variable
(setf (aref a 0) 10)          ; array
(setf (gethash 'key hash) 10) ; hashtable
(setf (field o) 10)           ; user-defined object
```
`SETF`ing a place that's part of a large object has the same semantics as `SETF`ing a variable: the place is modified without any effect on the object that was previously stored in the place.

- Other Ways to Modify places

modify macros: built on top of `SETF` that modify places by assigning a new value based on the current value of the place.
- `INCF`
- `DECF`
```lisp
(incf x)     ; same as (setf x (+ x 1))
(decf x)     ; same as (setf x (- x 1))
(incf x 10)  ; same as (setf x (+ x 10))
```
modify macro are defined in a way that make them safe to use with places where the place expression must be evaluated only once:
```lisp
(incf (aref *array* (random (length *array*))))
; expand to
(let ((tmp (random (length *array*)))) ; evaluate once
  (setf (aref *array* tmp) (1+ (aref *array* tmp))))
```
- `ROTATEF`: rotate values between places, return `NIL`.
- `SHIFTF`: shift values to the left, the original value of the first argument is returned.
```lisp
(rotatef a b)
; same as
(let ((tmp a)) (setf a b b tmp) nil)

(shiftf a b 10)
; same as
(let ((tmp a)) (setf a b b 10) tmp)
```

# 7 Macros: Standard Control Constructs

- `WHEN`, `UNLESS`

`IF` special operator:
```lisp
; then-form, else-form: a single Lisp form
(if condition then-form [else-form])

(if (> 2 3) "Yup" "Nope") ; "Nope"
(if (> 2 3) "Yup")        ; NIL
(if (> 3 2) "Yup" "Nope") ; "Yup"
```
`PROGN` special operator: execute any number of forms in order, return the value of the last form
```lisp
(if (spam-p current-message)
  (progn
    (file-in-spam-folder current-message)
    (update-spam-database current-message)))
```
`WHEN`: pattern of `IF` plus `PROGN`
```lisp
(when (spam-p current-message)
  (file-in-spam-folder current-message)
  (update-spam-database current-message))
; definition
(defmacro when (condition &rest body)
  `(if ,condition (progn ,@body)))
```
`UNLESS`: counterpart to `WHEN`
```lisp
(defmacro unless (condition &rest body)
  `(if (not ,condition) (progn ,@body)))
```

DSL example:
- [[#5.24 Practical Parsing Binary Files]]
- [[#5.26 Practical Web Programming with AllegroServe]]
- [[#5.31 Practical An HTML Generation Library, the Compiler]]

- `COND`

multibranch conditional:
```lisp
; if a do x, else if b do y; else do z
(if a
  (do-x)
  (if b
    (do-y)
    (do-z)))
```
`COND`: express multibranch conditionals
```lisp
(cond
  (test-1 form*)
  (test-2 form*)
  ...
  (test-N form*))

(cond (a (do-x))
      (b (do-y))
      (t (do-z))) ; T
```

- `AND`, `OR`, `NOT`

`NOT` function: return `T` is the argument is `NIL` and `NIL` otherwise.
`AND`, `OR` macro: logical conjunction and disjunction, they can *short-circuit*.
```lisp
(not nil)             ; T
(not (= 1 1))         ; NIL

(and (= 1 2) (= 3 3)) ; NIL
(or (= 1 2) (= 3 3))  ; T
```

- Looping

All Lisp's looping control constructs are macros built on top of a pair of special operator that provide a primitive goto facility:
- `DO`: a basic structured looping construct on top of the underlying primitives provided by special operators.
	- `DOLIST` macro
	- `DOTIMES` macro
- `LOOP` macro: a full-blown mini-language for expressing looping constructs in a non-Lispy, English-like language.

- `DOLIST`, `DOTIMES`

`DOLIST`: loop across the items of a list, executing the loop body with a variable holding the successive items of the list.
- `RETURN`: break out of a loop before the end of the list
```lisp
(dolist (var list-form)
  body-form*)

(dolist (x '(1 2 3)) (print x))
(dolist (x '(1 2 3)) (print x) (if (evenp x) (return))) ; return
```

`DOTIMES`: a high-level looping construct for counting loops
- `count-form`: must evaluate to an integer.
- each time through the loop, `var` holds successive integers from 0 to the one less than `count-form` value.
- use `RETURN` to break out the loop early.
```lisp
(dotimes (var count-form)
  body-form*)

(dotimes (i 4) (print i))
0
1
2
3
NIL

; nest loop: print out times tables from 1x1 to 20x20
(dotimes (x 20)
  (dotimes (y 20)
    (format t "~3d " (* (1+ x) (1+ y))))
  (format t "~%"))
```

- `DO`

`DO`: bind any number of variables and has complete control over how they change on each step through the loop.
- define the test that determine *when to end* the loop.
- provide a form to evaluate at the end of the loop to *generate a return value* for the `DO` expression.
```lisp
(do (variable-definition*)
    (end-test-form result-form*)
  statement*)

; variable-definition
(var init-form step-form)
```
- `variable-definition`: introduce a variable in scope in the body of the loop.
	- `int-form`: evaluate at the beginning of the loop, bound to the variable `var`. 
		- if left out, bound to `NIL`.
	- `step-form`: before each subsequence iteration of the loop, evaluate and the new value assigned to `var`. 
		- if left out, `var` will keep its value from iteration to iteration, unless explicitly assign a new value in the loop body
		- can refer any of the other loop variables.
- `end-test-form`: at the beginning of each iteration, after all loop variables have been give new values, is evaluated.
	- as long as evaluate to `NIL`, the iteration proceed, evaluating the `statements` in order.
	- when evaluate to `T`, `result-forms` are evaluates, return the value of the last result form as the value of the `DO` expression.

```lisp
; Fibonacci number
(do ((n 0 (1+ n))
	 (cur 0 next)           ; 'step-form' can refer other 'var'
	 (next 1 (+ cur next)))
    ((= 10 n) cur))

(do ((i 0 (1+ i)))
    ((>= i 4))
  (print i))
; same as
(dotime (i 4) (print i))

(do () ; bind no variables
    ((> (get-universal-time) *some-future-date*))
  (format t "Waiting~%")
  (sleep 60))
```

- `LOOP`

looping idioms:
- loop over various data structures: list, vector, hash table, package.
- accumulate values in various way while looping: collect, count, sum, min, max.

`LOOP` macro flavors:
- simple: the form in the body are evaluated each time through the loop, until use `RETURN` to break out.
```lisp
(loop
  body-form*)

(loop
  (when (> (get-universal-time) *some-future-date*)
    (return))
  (format t "Waiting~%")
  (sleep 1))
```
- extended: use *loop keywords* to implement a special-purpose language for expressing looping idioms.
	- `from`, `to`
	- `across`
	- `for`, `below`, `and`, `then`, `finally`
	- `collecting`, `summing`, `counting` 
```lisp
; collect 1 to 10 into a list
(loop for i from 1 to 10 collecting i) ; (1 2 3 4 5 6 7 8 9 10)

; sum of first ten squares
(loop for x from 1 to 10 summing (expt x 2)) ; 385

; count of vowels in a string
(loop for x across "the quick brown fox jumps over the lazy dog"
	  couting (find x "aeiou")) ; 11

; the 11th Fibonacci number
(loop for i below 10
	  and a = 0 then b
	  and b = 1 then (+ b a)
	  finally (return a))
```

`LOOP` detail: [[#5.22 LOOP for Black Belts]]

# 8 Macros: Defining Your Own

Macros are part of the language to allow you to **create abstractions** on top of the core language and standard library the move you closer toward being able to directly express the things you want to express.
Macros *operate at a different level than functions* and create a totally different kind of abstraction.

- The Story of Mac: A Just-So Story

- `Definition for Mac, Read Only`
- `DEF. MAC. R/O`
- `DEFMACRO`

- Macro Expansion Time vs. Runtime

distinction:
- the code that generate code: macros.
- the code that eventually makes up the program: everything else.

- macros expansion time: the time when macros run.
	- can deal only with the data that's inherent in the source code.
	- there is no way to access data that will exists at runtime.
- runtime: when regular code, including the code generated by macros, runs.

example:
```lisp
(defun foo (x)
  (when (> x 10) (print 'big)))

; WHEN take form (> x 10) and (print 'big) as arguments
(defmacro when (condition &rest body)
  `(if ,condition (progn ,@body)))
; expand to
(if (> x 10) (progn (print 'big)))
```

- `defmacro`
```lisp
; DEFine MACRO
(defmacro name (parameter*)
  "Optional documentation string."
  body-form*)
```

- A Sample Macro: `do-primes`
```lisp
; 2 utility functions
(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number) 
          never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number
        when (primep n) return n))
```

- Macro Parameters
```lisp
(defmacro do-primes ((var start end) &body body)
  `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
       ((> ,var ,end))
     ,@body))
```

- Generating the Expansion

- Plugging the Leaks

- Macro-Writing Macros

- Beyond Simple Macros


- 8.1 `'`
阻止求值

``` lisp
> '(1 2 3)
(1 2 3)
```

- 8.2 `` ` ``

阻止求值和部分求值

``` lisp
> `(1 2 3)
(1 2 3)
> `(1 2 (+ 1 2))
(1 2 (+ 1 2))
; 部分求值
> `(1 2 ,(+ 1 2))
(1 2 3)
```

- 8.3 `,@`

将后续的表达式的值嵌入到其外围的列表中, 这个表达式必须求值成一个列表.

``` lisp
> `(and ,(list 1 2 3))
(AND (1 2 3))
> `(and ,@(list 1 2 3))
(AND 1 2 3)
> `(and ,@(list 1 2 3) 4)
(AND 1 2 3 4)
```


# 9 Practical: Building a Unit Test Framework
- [ ] Practical: Building a Unit Test Framework

- Two Frist Tries

- Refactoring

- Fixing the Return Value

- Better Result Reporting

- An Abstraction Emerges

- A Hierarchy of Tests

- Wrapping Up


# 10 Numbers, Characters, and Strings

- Numbers

- Numeric Literals

- Basic Math

- Numeric Comparisons

- Higher Math

- Characters

- Character Comparisons

- Strings

- String Comparisons

# 11 Collections

- Vectors

- Subtypes of Vector

- Vectors As Sequences

- Sequence Iterating Functions

- Higher-Order Function Variants

- Whole Sequence Manipulations

- Sorting and Merging

- Subsequence Manipulations

- Sequence Predicates

- Sequence Mapping Functions

- Hash Tables

- Hash Table Iteration

# 12 They Called It LISP for a Reason: List Processing

- There Is No List

- Functional Programming and Lists

- “Destructive” Operations

- Combining Recycling with Shared Structure

- List-Manipulation Functions

- Mapping

- Other Structures

# 13 Beyond Lists: Other Uses for Cons Cells

- Trees

- Sets

- Lookup Tables: Alists and Plists

- `destructuring-bind`

# 14 Files and File I/O

- Reading File Data

- Reading Binary Data

- Bulk Reads

- File Output

- Closing Files

- Filenames

- How Pathnames Represent Filenames

- Constructing New Pathnames

- Two Representations of Directory Names

- Interacting with the File System

- Other Kinds of I/O

# 15 Practical: A Portable Pathname Library
- [ ] Practical: A Portable Pathname Library
- The API

- `*features*` and Read-Time Conditionalization

- Listing a Directory

- Testing a File’s Existence

- Walking a Directory Tree

# 16 Object Reorientation: Generic Functions

- Generic Functions and Classes

- Generic Functions and Methods

- `defgeneric`

- `defmethod`

- Method Combination

- The Standard Method Combination

- Other Method Combinations

- Multimethods

- To Be Continued

# 17 Object Reorientation: Classes

- `defclass`

- Slot Specifiers

- Object Initialization

- Accessor Functions

- `WITH-SLOTS` and `WITH-ACCESSORS`

```lisp
(with-slots (slot*) instance-form
  body-form*)
```

- Class-Allocated Slots

- Slots and Inheritance

- Multiple Inheritance

- Good Object-Oriented Design

# 18 A Few `FORMAT` Recipes

- The `FORMAT` Function

`FORMAT` function arguments
- a destination for output: `T`(`*STANDARD-OUTPUT*`), `NIL`, a stream, a string with a fill pointer.
- a control string
- any additional arguments(format arguments): provide the values used by the directive in the control string that interpolate values into the output

- `FORMAT` Directives

- `~$`
- `~5$`
- `~v$`
- `~#$`
- `~F`: `~,5F`

- `~D`
- `~:D`
- `~@D`
- `~:@D`

- Basic Formatting

- `~A`
- `~S`

- Character and Integer Directives

- Floating-Point Directives

- English-Language Directives

- Conditional Formatting

- Iteration

- Hop, Skip, Jump

- And More

# 19 Beyond Exception Handling: Conditions and Restarts

- The Lisp Way

- Conditions

- `DEFINE-CONDITION`
- `CONDITION`
- `MAKE-CONDITION`
- `ERROR`: a subclass of `CONDITION`

- Condition Handlers

- `ERROR` function
- `SIGNAL` function
- debugger
- `HANDLER-CASE`
```lisp
(handler-case expression
  error-clause*)
; error-clause
(condition-type ([var]) code)
```

- Restarts

- `RESTART-CASE`: similar to `HANDLER-CASE`, except the names of restarts are just names

call hierarchy:
- `log-analyzer`: `HANDLER-BIND`, `INVOKE-RESTART`
	- `analyze-log`
		- `parse-log-file`
			- `parse-log-entry`: `RESTART-CASE` `'skip-log-entry`

- `HANDLER-BIND`
	- the handler function bound by `HANDLER-BIND` will be run without unwinding the stack: the flow of control is still in the call to `parse-log-enty` when this function(the handler function) is called.
```lisp
(handler-bind (binding*) form*)
; binding: a list of
;; a condtion type
;; a handler function of one argument(the condition): a function object
```
- `FIND-RESTART`

- Providing Multiple Restarts

define multiple restarts: each provides a different recovery strategy.
restarts can take arbitrary arguments, which are passed in the call to `INVOKE-RESTART`.

- `USE-VALUE`: a standard name of restart.

- Other Uses for Conditions

use conditions, condition handlers and restarts to build a variety of protocols between low- and high-level code.

- `SIGNAL`
- `ERROR`: `*DEBUGGER-HOOK*`
- `WARN`: `*ERROR-OUTPUT*`, `MUFFLE-WARNNING`
- `CERROR`: `CONTINUE` restart
- build protocols on `SIGNAL`

see examples: [[#5.25 Practical An ID3 Parser]]

# 20 The Special Operators

- Controlling Evaluation

- `QUOTE`
- `IF`
- `PROGN`

- Manipulating the Lexical Environment

- `LET`
- `LET*`
- `SETQ`
- `FLET`
- `LABELS`
- `MACROLET`
- `SYMBOL-MACROLET`
	- global symbol macro: `DEFINE-SYMBOL-MACRO`
- `FUNCTION`

- Local Flow of Control

- `BLOCK`
- `RETURN-FROM`: [[#5.5 Functions]]
	- `RETURN` macro: syntactic sugar fro `(return-from nil ...)`
- `TAGBODY`
- `GO`

- Unwinding the Stack

- `CATCH`
- `THROW`
- `UNWIND-PROTECT`

- Multiple Values

- `MULTIPLE-VALUE-CALL`
	- `MULTIPLE-VALUE-BIND` macro build upon this. [[#5.11 Collections]]
	- `MULTIPLE-VALUE-LIST` macro

function:
- `VALUES`
- `VALUES-LIST`

- `EVAL-WHEN`

prerequisite:
- `LOAD`: load a file and evaluate all the top-level forms it contains.
- `COMPILE-FILE`: compile a source file into a FASL file, which can be loaded with `LOAD`.
	- normally does not evaluate the forms.
	- but must evaluate some form: ex `IN-PACKAGE`, `DEFMACRO`.
	- *the file compiler*

distinction between 
- compiling top-level forms
	- all forms appear directly at the top level of a source file
		- the `DEFUN` appearing at the top level of source file
	- all forms appear directly in a top level `PROGN`
	- forms appearing directly in a `MACROLET` or `SYMBOL-MACROLET`
	- the expansion of a top-level macro form
- compiling non-top-level forms
	- the form within the body of the function

`EVAL-WHEN`: borrowed from Maclisp
```lisp
(eval-when (situation*)
  body-form*)
```
`situation`
- `EVAL-WHEN` compiled as a top-level form
	- `:compile-toplevel`: the file compiler evaluate the subforms at compile time.
	- `:load-toplevel`: the file compiler compile the subforms as top-level forms.
	- neither: compiler ignores it.
- `EVAL-WHEN` compiled as a non-top-level form
	- `:execute`: compiled like a `PROGN`
	- other: ignored.

two use cases:
- if you want to write macros that need to save some information at compile time to be used when generating the expansion of other macro from in the same file.
- if you want to put the definition of a macro and helper function it uses in the same file as code that uses the macro.

see examples:
- [[#5.24 Practical Parsing Binary Files]]
- [[#5.31 Practical An HTML Generation Library, the Compiler]]

- Other Special Operators

- `LOCALLY`
- `THE`
- `LOAD-TIME-VALUE`
- `PROGV`

# 21 Programming in the Large: Packages and Symbols

- How the Reader Uses Packages

`FIND-PACKAGE`
access symbols in packages:
- `FIND-SYMBOL`: return `NIL` if not found.
- `INTERN`: create a new symbol and add to package if not found.

`*PACKAGE*`: current package.

package-qualified name: names contains
- `:` : must refer to an external symbol.
- `::`: refer to any symbol from the named package.

reader also understand symbol syntax:
- keyword symbols: names start with `:`, interned in package `KEYWORD`.
- uninterned symbols: names start with `#:`, not interned(reader create a new symbol whenever it read).

```lisp
(eql ':foo :foo) ; T
(symbol-name :foo) ; "FOO"

(eql '#:foo '#:foo) ; NIL
; GENSYM function
(gensym) ; #:G391
```

- A Bit of Package and Symbol Vocabulary

every package contains a name-to-symbol lookup table.

symbols *accessible* in a package: the symbols can be found using `FIND-SYMBOL`.
- the symbol *present* in the package: package's name-to-symbol table contain an entry for the symbol.
	- when the reader interns a new symbol in a package, add to the name-to-symbol table.
	- *home package*: a symbol is first interned into a package.
- the package *inherits* the symbol
	- the package *using* other packages: only *external* symbols are inherited.
	- a symbol is made external in a package by *exporting* it.

*shadowing* symbol: make other symbols of the same name inaccessible.
- a package have a present symbol and an inherited symbol with the same name.
- a package inherit two different symbols with the same name from different package.

an existing symbol can be *imported* into another package by adding it to the package's name-to-symbol table.
a present symbol can be *uninterned* from a package.

*uninterned* symbol: a symbol that isn't present in any package.

- Three Standard Packages

- `COMMON-LISP-USER`, `CL-USER`
	- use `COMMON-LISP`
- `COMMON-LISP`, `CL`
	- export all the names defined by the language standard: functions, macros, variables.
	- users cannot intern new symbols in it.
- `KEYWORD`
	- reader uses to intern names start with `:` into it.

```lisp
*package*    ; #<PACKAGE "COMMON-LISP-USER">
cl:*package* ; #<PACKAGE "COMMON-LISP-USER">

; COMMON-LISP:DEFVAR
; COMMON-LISP-USER:*X*
(defvar *x* 10) ; *X*

(cl:defun add-2 (x) (cl:+ x 2)) ; ADD-2


:a                 ; A
keyword:a          ; A
(eql :a keyword:a) ; T
```

- Defining Your Own Packages

`DEFPACKAGE`:
- create the package
- specify what package it uses
- specify what symbols is exports
- specify what symbols it imports from other packages
- resolve conflicts by creating shadowing symbols.

```lisp
(defpackage :com:gigamonkeys:email-db
  (:use :common-lisp))
```

*string designator*: specify the names of packages and symbols
- a string: designate itself
- a symbol: designate its name
- a character: designate a one-character string containing the character.
```lisp
(defpackage "COM.GIGAMONKEYS.EMAIL-DB"
  (:use "COMMON-LISP"))
```

`IN-PACKAGE`: read code in this package
- REPL: change the value of `*PACKAGE*`.
- file loaded with `LOAD` or compiled with `COMPILE-FILE`: change the package.
```lisp
(in-package :com:gigamonkeys:email-db)
```

- Packaging Reusable Libraries

`:export`
```lisp
(defpackage :com.gigamonkeys.text-db
  (:use :common-lisp)
  (:export :open-db
           :save
           :store))
```
`:use`
```lisp
(defpackage :com.gigamonkeys.email-db
  (:use :common-lisp :com.gigamonkeys.text-db))
```

- Importing Individual Names

`:import-from`
```lisp
(defpackage :com.gigamonkeys.email-db
  (:use :common-lisp :com.gigamonkeys.text-db)
  (:import-from :com.acme.email :parse-email-address))
```
`:shadow`
```lisp
(defpackage :com.gigamonkeys.email-db
  (:use
    :common-lisp
    :com.gigamonkeys.text-db
    :com.acme.text)
  (:import-from :com.acme.email :parse-email-address)
  (:shadow :build-index)) ; shaow 'com.acme.text:build-index'
```
`:shadowing-import-from`: resolve name conflicts from two packages
```lisp
(defpackage :com.gigamonkeys.email-db
  (:use
    :common-lisp
    :com.gigamonkeys.text-db
    :com.acme.text) ; exports 'save'
  (:import-from :com.acme.email :parse-email-address)
  (:shadow :build-index)
  (:shadowing-import-from :com.gigamonkeys.text-db :save)) ; shadow 'com.gigamonkeys.text-db:save'
```

- Packaging Mechanics

make sure package exist when they need: put all `DEFPACKAGE`s in files separated from the code that needs to be read in those packages
- `foo-package.lisp`: for each individual package
- `packages.lisp`: contains all the `DEFPACKAGE`s for a group of related packages.

arrange `LOAD` the files containing `DEFPACKAGE`s before compile or load other files:
- `load.lisp`: contains the `LOAD` and `COMPILE-FILE` calls in the right order.
- system definition facility: [[ASDF(Another System Definition Facility)]]

more rules:
- each file should contain exactly one `IN-PACKAGE` form, and it should be the first form in the file other than comments.
- files containing `DEFPACKAGE` form should start with `(in-package "COMMON-LISP-USER")`, and all other files should contain an `IN-PACKAGE` of one of your packages.

package naming:
- Java-style names.

- Package Gotchas

- intern new symbols.
- redefine.
- `quit` is in `COMMON-LISP-USER`.

# 22 LOOP for Black Belts

- The Parts of a LOOP

- Iteration Control

- Counting Loops

- Looping Over Collections and Packages

- Equals-Then Iteration

- Local Variables

- Destructuring Variables

- Value Accumulation

- Unconditional Execution

- Conditional Execution

- Setting Up and Tearing Down

- Termination Tests

- Putting It All Together


# 23 Practical: A Spam Filter
- [ ] Practical: A Spam Filter
# 24 Practical: Parsing Binary Files
- [ ] Practical: Parsing Binary Files
# 25 Practical: An ID3 Parser
- [ ] Practical: An ID3 Parser
# 26 Practical: Web Programming with AllegroServe
- [ ] Practical: Web Programming with AllegroServe
# 27 Practical: An MP3 Database
- [ ] Practical: An MP3 Database
# 28 Practical: A Shoutcast Server
- [ ] Practical: A Shoutcast Server
# 29 Practical: An MP3 Browser
- [ ] Practical: An MP3 Browser
# 30 Practical: An HTML Generation Library, the Interpreter
- [ ] Practical: An HTML Generation Library, the Interpreter
# 31 Practical: An HTML Generation Library, the Compiler
- [ ] Practical: An HTML Generation Library, the Compiler

# 32 Conclusion: What's Next?

# 6 See Also

## Comments

``` lisp
;;;; 文件头注释

;;; 段落注释, 应用到接下来的一大段代码上
(defun foo (x)
  (dotimes (i x)
    ;; 应用到接下来的代码上
    (some-function-call)
    (another i) ; 行中注释
    (and-another)
    (baz)))
```

## Data Types

Common Lisp提供了内置支持的数据类型:

- 数字: 整数, 浮点数和复数
- 字符
- 字符串: 字符的序列
- 数组: 包括多维数组
- 列表
- 哈希表
- 输入输出流
- 一种可移植的表示文件名的抽象

- 数字, 字符和字符串

Common Lisp中整数可以是任意大, 两个整数相除得到一个确切的壁纸而非截断的值.

> 字面数值

整数:

``` lisp
> 123
123
> +123
123
> -123
-123
> 123.
123
```
比值:

``` lisp
> 2/3
2/3
> -2/3
-2/3
> 4/6
2/3
> 6/3
2
```

进制: `#B`, `#b`, `#O`, `#o`, `#X`, `#x`, `#nR`, `#nr`

`#nR`中`n`是十进制书写的, 从2到36的进制数.

``` lisp

> #b10101
21
> #b1010/1011
10/11
> #o777
511
> #xDADA
56026
> #36rABCDEFGHIJKLMNOPQRSTUVWXYZ
8337503854730415241050377135811259267835
```

浮点数: 短型(`s`, `S`), 单精度(`f`, `F`), 双精度(`d`, `D`), 长型(`l`, `L`).

`e`, `E`: 表示默认方式(单浮点数).

没有指数标记的数字以默认方式读取, 必须含有一个`.`且后面至少由一个数字. 其中数字总是以十进制表示.

``` lisp
> 1.0
1.0
> 1e0
1.0
> 1d0
1.0d0
> 123.0
123.0
> 123e0
123.0
> 0.123
0.123
> .123
0.123
> 123e-3
0.123
> 123E-3
0.123
> 0.123e20
1.23e19
> 123d23
1.23d25
```

复数: `#c`, `#C`, 后跟由两个实数组成的列表.

``` lisp
> #c(2 1)
#C(2 1)
> #c(2/3 3/4)
#C(2/3 3/4)
> #c(2 1.0)
#C(2.0 1.0)
> #c(2.0 1.0d0)
#C(2.0d0 1.0d0)
> #c(1/2 1.0)
#C(0.5 1.0)
> #c(3 0)
3
> #c(3.0 0.0)
#C(3.0 0.0)
> #c(1/2 0)
1/2
> #c(-6/3 0)
-2
```

- 集合


- 列表

>  属性表

property list, plist
``` lisp
(list :a 1 :b 2 :c 3)
```

- 文件
