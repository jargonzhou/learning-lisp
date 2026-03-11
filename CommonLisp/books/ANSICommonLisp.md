# ANSI Common Lisp

- 2: explains, in 21 pages, everything you need to start writing Lisp programs.
- 3-9: introduce the essential elements of Lisp programming.
- 10-14: cover macros, CLOS, operations on list structure, optimization, and advanced topics like packages and read-macros.
- 15-17: sum up the lessons of the preceding chapters in three examples of real applications: a program for making logical inferences, an HTML generator, and an embedded language for object-oriented programming.


# 1 Introduction

# 2 Welcome to Lisp
## 2.1 Form
Any Lisp system will include an interactive front-end called the **toplevel**.
prefix notation
All Lisp expressions are either **atoms**, like `1`, or **lists**, which consist of zero or more expressions enclosed in parentheses.
## 2.2 Evaluation
In Lisp, `+` is a function, an expression like `(+ 2 3)` is a function call.
When Lisp evaluates a function call: (the evaluation rule for Common Lisp)
- First the arguments are evaluated, from left to right.
- The values of the arguments are passed to the function named by the operator.
If any of the arguments are themselves function calls, they are evaluated according to the same rules.

Not all the operators in Common Lisp are functions, but most are.
One operator that doesn't follow the Common Lisp evaluation rule is `quote`. It's a **special operator**, and it has a distinct evaluation rule of its own: do nothing.
For convenience, Common Lisp defined `'` as an abbreviation for `quote`.
Lisp provides the quote as a way of protecting expressions from evaluation.
## 2.3 Data
date types:
- integer
- string
- symbol
- list
	Lisp programs are expressed as lists.
	empty list: `()`, `nil`.
```lisp
list
```
## 2.4 List Operations
```lisp
cons
car
cdr
third
```
## 2.5 Truth
```lisp
t
listp
nil
null
not
if    ; special operator
and   ; macro
or    ; macro
```
Although `t` is the default representation for truth, everything except `nil` also counts as true in a logical context.
## 2.6 Functions
```lisp
defun
```
Lisp makes no distinction between a program, a procedure, and a function.
## 2.7 Recursion
A function that calls itself is **recursive**.
```lisp
member
```
## 2.8 Reading Lisp
Lisp programmers read and write code by indentation, not by parentheses.
## 2.9 Input and Output
```lisp
format
~A ; indicate a position to be filled
~% ; indicate a newline
read ; a complete Lisp parser
```
## 2.10 Variables
```lisp
let ; local variable
numberp
defparameter ; global variable
defconstant
boundp

```
## 2.11 Assignment
```lisp
setf
```
The first argument to `setf` can be almost any expression that refers to a particular place.
## 2.12 Functional Programming
**Functional programming** means writing programs that work by returning values, instead of by modifying things.
```lisp
remove
```
One of the most important advantages of functional programming is that it allows **interactive testing**.
## 2.13 Iteration
```lisp
do
dolist
```
## 2.14 Functions as Objects
In Lisp, functions are regular objects, like symbols or strings or lists.
```lisp
function ; special operator
#'       ; sharp-quote: an abbreviation for function
apply
funcall
lambda
```
## 2.15 Types
In Common Lisp, values have types, not variables. The approach is called **manifest typing**.
You don't have to declare the type of variables, because any variable can hold objects of any type.
The built-in Common Lisp types form a hierarchy of subtypes and supertypes. An object always has more that one type.
`27` is of type `fixnum`, `integer`, `rational`, `real`, `number`, `atom`, `t`.
```lisp
typep
```
## 2.16 Looking Forward
We could likewise describe Lisp as a Language for writing Lisp.

# 3 Lists
Lisp: LISt Processor
## 3.1 Conses
```lisp
cons
car
cdr
list
consp
listp
atom
nil
```
## 3.2 Equality
```lisp
eql    ; return true only if its arguments are the same object
equal  ; return true if its argument would print the same
```
## 3.3 Why Lisp Has No Pointers
## 3.4 Building Lists
```lisp
copy-list
append
```
## 3.5 Example: Compression
run-length encoding
```lisp
; loading programs
(load "compress.lisp")
```
## 3.6 Access
```lisp
nth
nthcdr
zerop
last
first, ..., tenth
cadddr, ... ; car of cdr of cdr
```
## 3.7 Mapping Functions
```lisp
mapcar
maplist
mapc
mapcan
```
## 3.8 Trees
```lisp
copy-tree
substitute ; replace elements in a sequence
subst      ; replace elements in a tree
```
## 3.9 Understanding Recursion
## 3.10 Sets
```lisp
member ; keyword argument :test, :key
member-if
adjoin
union
intersection
set-difference
```
## 3.11 Sequences
```lisp
length
subseq
reverse
sort ; destructive
every
some
```
## 3.12 Stacks
```lisp
push
pop
pushnew
```
## 3.13 Dotted Lists
proper list: either `nil`, or a cons whose cdr is a proper list.
dotted list: a cons that isn't a proper list.
## 3.14 Assoc-lists
assoc-list, alist: a list of conses.
```lisp
assoc ; :test, :key
assoc-if
```
## 3.15 Example: Shortest Path
## 3.16 Garbage
automatic memory management: heap, garbage collection/GC

# 4 Specialized Data Structures
## 4.1 Arrays
```lisp
make-array ; :initial-element
aref
#na(...)   ; literal array
*print-array*

vector
svref      ; sv: simple vector
```
## 4.2 Example: Binary Search
Commenting conventions:
```lisp
;;;; heading
;;; a description of a function or macro
;; explain the line below
; line comment
```
## 4.3 Strings and Characters
```lisp
#\c ; individual character c
char-code
code-char
char< char<= char= char>= char> char/=
char
string-equal
concatenate
```
## 4.4 Sequences
In Common Lisp the type `sequence` includes both lists and vectors (and therefore strings).
```lisp
remove
length
subseq
reverse
sort
every
some

elt

; keyword arguments
:key
:test
:from-end
:start
:end

position
position-if
find
find-if
remove-duplicates
reduce
```
## 4.5 Example: Parsing Dates
## 4.6 Structures
```lisp
; each point will be of type point, then structure, then atom, then t
(defstruct point
	x
	y)
make-point
point-p
copy-point
point-x
point-y

:conc-name
:print-function
```
## 4.7 Example: Binary Search Trees
## 4.8 Hash Tables
```lisp
make-hash-table
#<...> ; diplay form
gethash
remhash
maphash
```

# 5 Control
## 5.1 Blocks
Common Lisp has 3 basic operators for creating blocks of code: `progn`, `block`, `tagbody`.
```lisp
progn

block
return-from
return

tagbody
go
```
## 5.2 Context
An operator like `let` creates a new **lexical context**.
```lisp
let
let*

destructuring-bind
```
## 5.3 Conditionals
```lisp
if
when
unless
cond
case
typecase
```
## 5.4 Iteration
```lisp
do
do*
dolist
dotimes

mapc
mapcar
```
## 5.5 Multiple Values
In Common Lisp, an expression can return zero or more values.
```lisp
get-decoded-time

values
multiple-value-bind

multiple-value-call
multiple-value-list
```
## 5.6 Aborts
```lisp
catch
throw
error

unwind-protect
```
## 5.7 Example: Date Arithmetic

# 6 Functions
## 6.1 Global Functions
```lisp
fboundp
symbol-function

; function's documentation string
documentation
```
## 6.2 Local Functions
```lisp
labels
```
## 6.3 Parameter Lists
```lisp
; rest parameter
&rest

; optional parameters
&optional

; keyword parameters
&key
```
## 6.4 Example: Utilities
Experienced Lisp programmers work bottom-up as well as top-down.
Operators written to augment Lisp are called **utilities**.
## 6.5 Closures
A function can be returned as the value of an expression just like any other kind of object.
If a function is defined within the scope of a lexical variable, it can continue to refer to that variable, even if it is returned as a value outside the context where the variable was created.
When a function refers to a variable defined outside it, it's called a **free** variable. A function that refers to a free lexical variable is called a **closure**. The variable must persist as long as the function does.
A closure is a combination of a function and an **environment**. Closures are created implicitly whenever a function refers to something from the surrounding lexical environment.
```lisp
complement
```
## 6.6 Example: Function Builders
[Dylan](https://opendylan.org/index.html) is a hybrid of Scheme and Common Lisp.
> [!info] Open Dylan
> Dylan is an object-functional language originally created by Apple for the Newton. Dylan is a direct descendant of Scheme and CLOS (without the Lisp syntax) with a programming model designed to support efficient machine code generation, including fine-grained control over dynamic and static behaviors.

```lisp
compose
disjoin
conjoin
curry
rcurry
always  ; constantly, identity 
```
## 6.7 Dynamic Scope
Under lexical scope, a symbol refers to the variable that has the name in the context where the symbol appears. Local variables have lexical scope by default.
With **dynamic scope**, we look for a variable in the environment where the function is called, not in the environment where is was defined.
To cause a variable to have dynamic scope, we must declare it to be `special` in any context where is occurs.
```lisp
declare
special
```
Global variables established by calling `setf` at the toplevel are implicitly special.
## 6.8 Compilation
Common Lisp functions can be compiled either individually or by the file.
```lisp
compiled-function-p
compile
compile-file
```
When one function occurs within another, and the containing function is compiled, the inner functions should also be compiled.
## 6.9 Using Recursion
Recursion plays a greater role in Lisp than in most other languages, 3 main reasons:
- Functional programming
- Recursive data structures
- Elegance

# 7 Input and Output
There are 2 kinds of streams: **character streams**, **binary streams**.
This chapter describes operations on character streams.
## 7.1 Streams
```lisp
*standard-input*
*standard-output*
```
A **pathname** is a portable way of specifying a file, has 6 components: host, device, directory, name, type, version.
```lisp
make-pathname

open
	:direction ; :input, :output, :io
	:if-exists ; :supersede
close

read-line
with-open-file ; unwind-protect
```
## 7.2 Input
```lisp
read-line
read
read-from-string ; :start, :end
read-char
peek-char
```
## 7.3 Output
```lisp
prin1   ; generate output for program
princ   ; generate output for people
terpri  ; print a newline

; format directives
~A ; a placeholder for a value, printed as if by pric
~% ; a newline
~S ; like ~A, but printed as if by prin1
~F ; format directive arguments
```
## 7.4 Example: String Substitution
## 7.5 Macro Characters
A **macro character** is a character that gets special treatment from `read`.
A macro character or combination of macro characters is also known as a **read-macro**.
```lisp
'a ; (quote a)
```
All the predefined dispatching read-macros use the sharp sign `#` as the dispatching character.
```lisp
#'        ; (function ...)
#(...)    ; vector
#nA(...)  ; array
#\,       ; character ,
#S(n ...) ; structure
```
When objects of each of these types are displayed by `prin1` or `format` with `~S`, they are displayed using the corresponding read-macros.
Not all objects are displayed in a distinct readable form.
```lisp
#<...> ; function, hash table
#<     ; use to cause an error if it is encountered by read
```

# 8 Symbols
## 8.1 Symbol Names
A symbol can have any string as its name.
```lisp
symbol-name

; any sequence of characters between vertical bars 
; is treated as a symbol
'|Lisp 1.5|
```
## 8.2 Property Lists
Every symbol has a **property-list**, or **plist**.
```lisp
get
symbol-plist
```
## 8.3 Symbols Are Big
In fact a symbol is a substantial object.
A symbol can have a name, a home package, a values as a variable, a value as a function, and a property list.
## 8.4 Creating Symbols
Conceptually, packages are symbol-tables, mapping names to symbols.
Every ordinary symbol belongs to a particular package.
A symbol that belongs to a package is said to be **interned** in that package.
Functions and variables have symbols as their names.

The first time you type the name of a new symbol, Lisp will create a new symbol object and intern it in the current package (by default `common-lisp-user`).
```lisp
intern
```
Not all symbols are interned.
Uninterned symbols are called **gensyms**.
## 8.5 Multiple Packages
Larger programs are often divided up into multiple packages.
Only symbols that you explicitly **export** will be visible in other packages, and there they will usually have to be preceded (or **qualified**) by the name of the package that owns them.
```lisp
defpackage ; :use, :nicknames, :export
in-package
```
## 8.6 Keywords
Symbols in the `keyword` package (known as **keywords**) have 2 unique properties:
- they always evaluate to themselves, and
- you can refer to them anywhere simply as `:x`, instead of `keyword:x`.
## 8.7 Symbols and Variables
When a symbol is the name of a *special variable*, the value of the variable is a field within the symbol.
```lisp
symbol-value
```
A symbol used as a *lexical variable* is just a placeholder.
The compiler will translate it into a reference to a register or a location in memory.
## 8.8 Example: Random Text
A program to generate random text.

# 9 Numbers
## 9.1 Types
Common Lisp provide 4 distinct types of numbers:
- integers: `2002`
- floating point numbers: `253.72`, `2.5372e2`
- ratios: `2/3`
- complex numbers: `a+bi`, `#c(a b)`
```lisp
; numeric types
number
 real
  rational
   ratio
   integer
    bignum
    fixnum
     bit
  float
   short-float
   single-float
   double-float
   long-float
 complex


integerp
floatp
complexp
```
There are general rules of thumb for determining what kind of number a computation will return.
## 9.2 Conversion and Extraction
```lisp
float
truncate
floor
ceiling
round
mod
rem
signum
abs

numerator
denominator
realpart
imagpart

random
```
## 9.3 Comparison
```lisp
< <= = >= > /=
zerop
plusp
minusp
oddp
evenp
max
min
```
## 9.4 Arithmetic
```lisp
+
-
1+
1-
incf
decf
*
/
```
## 9.5 Exponentiation
```lisp
expt
log
exp
sqrt
```
## 9.6 Trigonometric Functions
```lisp
pi
sin cos tan
asin acos atan
sinh cosh tanh
asinh acosh atanh
```
## 9.7 Representation
Common Lisp imposes no limit on the size of integers:
- small integers fit in one word of memory and are called **fixnum**.
- larger integers **bignum** use multiple words of memory.
```lisp
most-positive-fixnum
most-negative-fixnum
typep

short-float
single-float
double-float
long-float
; m-s-f
; m: most, least
; s: positive, negative
; f: 4 types of float
most-positive-long-float
```
## 9.8 Example: Ray-Tracing
Image files will be written in a simple ASCII format called *PGM*.



# 10 Macros
Lisp code is expressed as lists, which are Lisp objects.
## 10.1 Eval
```lisp
; used to generate expressions
list
; make Lisp treat them as code
eval
```
Calling `eval` is one way to cross the line between lists and code.
For programmers the main value of `eval` is probably as a conceptual model for Lisp.
The functions `coerce` and `compile` provide a similar bridge from lists to code.
```lisp
(coerce '(lambda (x) x) 'function)
(compile nil '(lambda (x) (+ x 2)))
```
The trouble with `eval`, `coerce` and `compile` is not that they cross the line between lists and code, but that they do it at run-time.
## 10.2 Macros
The most common way to write programs that write programs is by defining macros.
**Macros** are operators that are implemented by transformation.
You define a macro by saying how a call to it should be translated. This translation, called **macro-expansion**, is done automatically by the compiler. 
So the code generated by your macros becomes an integral part of your program, just as if had typed it in yourself.
```lisp
defmacro ; define how a call should be translated
macroexpand-1
```
A macro call can expand into another macro call.
When the compiler or the toplevel encounters a macro call, it simply keeps expanding it until it is no longer one.
Underneath, macros are just functions that transform expressions.
## 10.3 Backquote
The backquote read-macro makes it possible to build lists from templates.
Used by itself, a backquote is equivalent to a regular quote.
The advantage of backquote is that, within a backquoted expression, you can use `,`(comma) and `,@`(comma-at) to turn evaluation back on.
```lisp
`
,
,@


(defmacro while (test &test body)
	`(do ()
		((not ,test))
		,@body))
```
## 10.4 Example: Quicksort
An example of a function that relies heavily on macros: a function to sort vectors using the Quicksort algorithms.
```lisp
while
when
incf
decf
rotatef
```
## 10.5 Macro Design
When you start writing macros, you have to start thinking like a language designer.
One of the problems that macro designer have to think about is inadvertent **variable capture**. We can use gensyms to solve this problem.
Another problem is **multiple evaluation**. We can set a variable to the value of the expression in question before any iteration.
```lisp
gensym

(defmacro ntimes (n &rest body)
	(let ((g (gensym))
		  (h (gensym)))
		`(let ((,h ,n))
			(do ((,g 0 (+ ,g 1)))
				((>= ,g ,h))
				,@body))))
```
By expanding calls to the built-in macros, we can usually understand how they were written.
```lisp
(pprint (macroexpand-1 '(cond (a b)
							  (c d e)
							  (t f))))
```
## 10.6 Generalized Reference
Since a macro call is expanded right into the code where it appears, any macro call whose expansion could be the first argument to `set` can itself be the first argument to `setf`.
Common Lisp provides `define-modify-macro` as a way of writing a restricted class of macros on `setf`.
## 10.7 Example: Macro Utilities
```lisp
for
in
random-choice
avg
with-gensyms
aif ; intentional variable capture
```
Is it worth writing a macro just to save typing? Very much so.
As you're writing a program, ask yourself, am I writing macro expansions? If so, the macros that generate those expansions are the one you need to write.
## 10.8 On Lisp
Only 25 of Common Lisp's built-in operators are special operators.
John Foderaro has called Lisp *a programmable programming language.*
By writing your own functions and macros, you can turn Lisp into just about any language you want.

# 11 CLOS
## 11.1 Object-Oriented Programming
## 11.2 Classes and Instances
## 11.3 Slot Properties
## 11.4 SuperClasses
## 11.5 Precedence
## 11.6 Generic Functions
## 11.7 Auxiliary Methods
## 11.8 Method Combination
## 11.9 Encapsulation
## 11.10 Two Models

# 12 Structure
## 12.1 Shared Structure
## 12.2 Modification
## 12.3 Example: Queues
## 12.4 Destructive Functions
## 12.5 Example: Binary Search Trees
## 12.6 Example Doubly-Linked Lists
## 12.7 Circular Structure
## 12.8 Constant Structure

# 13 Speed
## 13.1 The Bottleneck Rule
## 13.2 Compilation

```ebnf
(optimize {quality | (quality value)}*)
```
`quality`:
- `compilation-speed`
- `debug`: the amount of information retained for debugging
- `safety`: the amount of error-checking done in the object code
- `space`: the size and memory needs of the object code
- `speed`: the speed of the code produced by the compiler
`value`: 0(unimportant),1,2,3(most important).

`(disassemble fn)`

## 13.3 Type Declarations

**manifest typing**: 
- values have types, not variables.
- variables can hold objects of any type.

- `declaim`: global declarations.
- `declare`: local declarations.
- `the`: declare the value of an expression will be of a certain type.

`time`

## 13.4 Garbage Avoidance

safe and destructive counterparts functions.

| Safe              | Destructive       |
| :---------------- | :---------------- |
| append            | nconc             |
| reverse           | nreverse          |
| remove            | delete            |
| remove-if         | delete-if         |
| remove-duplicates | delete-duplicates |
| subst             | nsubset           |
| subst-if          | nsubset-if        |
| union             | nunion            |
| intersection      | nintersection     |
| set-difference    | nset-difference   |


`dynamic-extent`: allocate objects on the stack instead of the heap.

## 13.5 Example: Pools

avoid dynamic allocation by pre-allocating a certain number of data structures: pool.

## 13.6 Fast Operators

Some features of Common Lisp are intended mainly for speed, and others mainly for convenience.
- `elt`, `aref`, `svref`, `nth`.
- `eql`, `eq`.
- rest, optional and keyword parameters are expensive.

## 13.7 Two-Phase Development

rewrite part of a Lisp program in lower-level langauges like C or assembler.

# 14 Advanced Topics
## 14.1 Type Specifiers

## 14.2 Binary Streams

## 14.3 Read-Macros

## 14.4 Packages

## 14.5 The Loop Facility

## 14.6 Conditions

```lisp
error
ecase
check-type
assert
```

```lisp
ignore-errors
```

# 15 Example: Inference

# 16 Example: Generating HTML

# 17 Example: Objects



# 18 A. Debugging

break loops
```lisp
(trace foo)
(untrace foo)
(untrace)
```
backtrace
when nothing happens: infinite loop
no value/unbound
unexpected nils
renaming
keywords as optional parameters
misdeclarations
warnings
```lisp
(map-int #'(lambda (x)
			(declare (ignore x)) ; ignore
			(random 100))
		 10)
```

# 19 B. Lisp in Lisp

58 definitions of the most frequently used Common Lisp operators.
based on
```lisp
apply aref backquote block car cdr ceiling char= cons defmacro
documentation eq error expt fdefinition function floor gensym
get-setf-expansion if imagpart labels length multiple-value-bind
nth-value quote realpart symbol-function tagbody type-of typep
= + - / < >
```

# 20 C. Changes to Common Lisp

> SKIP.

# 21 D. Language Reference
Conventions:
- Syntax

`*`: indicates zero or more.
`[]`: indicates zero or one.
`{}`: used for grouping.
`|`: indicates a choice between several alternatives.

- Parameter Names
`alist`:
`body`:
`c`: must be a complex number.
`declaration`:
`environment`:
`f`: must be a float.
`fname`:
`format`:
`i`: must be an integer.
`list`:
`n`: must be a non-negative integer.
`object`: can be of any type.
`package`:
`path`:
`place`
`plist`: must be a property list.
`pprint-dispatch`:
`predicate`:
`prolist`: must be a proper list.
`proseq`: must be a proper sequences, that is, a vector or proper list.
`r`: must be a real.
`tree`:
`type`: must be a type designator.

- Defaults
```lisp
*standard-input*
*standard-output*
*package*
*readtable*
*print-pprint-dispatch*
```

- Comparison
```lisp
; key word arguments
key
test
test-not
from-end
start
end
```

- Structure
Only parameters shown in angle brackets `<list>` can actually be modified by the call.
## 21.1 Evaluation and Compilation
```lisp
(compile fname &optional function) ; function

(declaim declaration-spec) ; macro

(eval-when (case*) expression*) ; special operator
```
## 21.2 Types and Classes
## 21.3 Control and Data Flow
## 21.4 Iteration
## 21.5 Objects
## 21.6 Structures
## 21.7 Conditions
## 21.8 Symbols
## 21.9 Packages
## 21.10 Numbers
## 21.11 Characters
## 21.12 Conses
## 21.13 Arrays
## 21.14 Strings
## 21.15 Sequences
## 21.16 Hash Tables
## 21.17 Filenames
## 21.18 Files
## 21.19 Streams
## 21.20 Printer
## 21.21 Reader
## 21.22 System Construction
## 21.23 Environment
## 21.24 Constants and Variables
## 21.25 Type Specifiers
## 21.26 Read Macros
