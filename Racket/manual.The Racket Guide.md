# The Racket Guide
* https://docs.racket-lang.org/guide/index.html

# 1 Welcome to Racket

## 1.1 Interacting with Racket

```shell
$ Racket.exe
Welcome to Racket v9.1 [cs].
> 5
5
> "Hello World!"
"Hello World!"
> (substring "the boy out of the country" 4 7)
"boy"
```

## 1.2 Definitions and Interactions

```shell
> (define (extract str)
  (substring str 4 7))
> (extract "the boy out of the country")
"boy"
```

`extract.rkt` for DrRacket:
```racket
#lang racket

(define (extract str)
  (substring str 4 7))
```

```shell
# Magic Racket for VS Code: 'Racket: Open the REPL for the current file'
$ /d/software/Racket/Racket.exe --repl --eval '(enter! (file "d:/workspace/github/learning-lisp/Racket/codes/guide/extract.rkt"))'
Welcome to Racket v9.1 [cs].
"racket\\codes\\guide\\extract.rkt"> (extract "the gal out of the city")
"gal"
"racket\\codes\\guide\\extract.rkt"> 
```

## 1.3 Creating Executables

```shell
$ racket extract.rkt 
"cat"
```

- DrRacket: Racket > Create Executable...
```shell
$ ./extract.exe 
"cat"
```
- raco
```shell
$ raco exe extract.rkt
$ ./extract.exe 
"cat"
```
- shebang: `#!/usr/bin/env racket`

## 1.4 A Note to Readers with Lisp/Scheme Experience

racket is willing to imitate a traditional Lisp environment: `load`.

# 2 Racket Essentials/Racket基本要素
## 2.1 Simple Values/简单值
## 2.2 Simple Definitions and Expressions/简单定义和表达式
- Definitions
- An Aside on Indenting Code
- Identifiers
- Function Calls
- Conditionals with if, and, or, and cond
- Function Calls, Again
- Anonymous Functions with lambda
- Local Binding with define, let, and let*
## 2.3 Lists, Iteration, and Recursion/列表, 迭代和递归
- Predefined List Loops
- List Iteration from Scratch
- Tail Recursion
- Recursion versus Iteration
## 2.4 Pairs, Lists, and Racket Syntax/对, 列表和Racket语法
- Quoting Pairs and Symbols with quote
- Abbreviating quote with '
- Lists and Racket Syntax

# 3 Built-In Datatypes/内置数据类型
## 3.1 Booleans/布尔值
## 3.2 Numbers/数字
## 3.3 Characters/字符
## 3.4 Strings/字符串
## 3.5 Bytes and Byte Strings/字节和字节字符串
## 3.6 Symbols/符号
## 3.7 Keywords/关键字
## 3.8 Pairs and Lists/对和列表
## 3.9 Vectors/向量
## 3.10 Hash Tables/哈希表
## 3.11 Boxes/盒子
## 3.12 Void and Undefined/空值和未定义的

# 4 Expressions and Definitions/表达式和定义
## 4.1 Notation
## 4.2 Identifiers and Binding/标识符和绑定
## 4.3 Function Calls/函数调用
- Evaluation Order and Arity
- Keyword Arguments
- The apply Function 
## 4.4 Functions/函数
- Declaring a Rest Argument
- Declaring Optional Arguments
- Declaring Keyword Arguments
- Arity-Sensitive Functions: case-lambda
## 4.5 Definitions/定义: `define`
- Function Shorthand
- Curried Function Shorthand
- Multiple Values and define-values
- Internal Definitions
## 4.6 Local Binding/本地绑定
- Parallel Binding: `let`
- Sequential Binding: `let*`
- Recursive Binding: `letrec`
- Named let
- Multiple Values: `let-values`, `let*-values`, `letrec-values`
## 4.7 Conditionals/条件
- Simple Branching: `if`
- Combining Tests: `and` and `or`
- Chaining Tests: `cond`
## 4.8 Sequencing/序列化
- Effects Before: `begin`
- Effects After: `begin0`
- Effects If...: `when` and `unless`
## 4.9 Assignment/赋值: `set!`
- Guidelines for Using Assignment
- Multiple Values: `set!-values`
## 4.10 Quoting/引用: `quote` and `'`
## 4.11 Quasiquoting/反引用: `quasiquote` and ```````
## 4.12 Simple Dispatch/简单分发: `case`
## 4.13 Dynamic Binding/动态绑定: `parameterize`

# 5 Programmer-Defined Datatypes/程序员定义的数据类型
## 5.1 Simple Structure Types/简单结构类型: `struct`
## 5.2 Copying and Update/拷贝和更新
## 5.3 Structure Subtypes/结构子类型
## 5.4 Opaque versus Transparent Structure Types/不透明的 v.s. 透明的结构类型
## 5.5 Structure Comparisons/结构比较
## 5.6 Structure Type Generativity/结构类型生成性
## 5.7 Prefab Structure Types/预置结构类型
## 5.8 More Structure Type Options/其他结构类型选项

# 6 Modules/模块
## 6.1 Module Basics/模块基础
- Organizing Modules
- Library Collections
- Packages and Collections
- Adding Collections
- Module References Within a Collection
## 6.2 Module Syntax/模块语法
- The module Form
- The #lang Shorthand
- Submodules
- Main and Test Submodules
## 6.3 Module Paths/模块路径
## 6.4 Imports/导入: `require`
## 6.5 Exports/导出: `provide`
## 6.6 Assignment and Redefinition/赋值和重新定义
## 6.7 Modules and Macros/模块和宏
## 6.8 Protected Exports/保护的导出

# 7 Contracts/契约
## 7.1 Contracts and Boundaries/契约和边界
- Contract Violations
- Experimenting with Contracts and Modules
- Experimenting with Nested Contract Boundaries
## 7.2 Simple Contracts on Functions/函数上简单契约
- Styles of `->`
- Using `define/contract` and `->`
- `any` and `any/c`
- Rolling Your Own Contracts
- Contracts on Higher-order Functions
- Contract Messages with “???”
- Dissecting a contract error message
## 7.3 Contracts on Functions in General/函数契约
- Optional Arguments
- Rest Arguments
- Keyword Arguments
- Optional Keyword Arguments
- Contracts for case-lambda
- Argument and Result Dependencies
- Checking State Changes
- Multiple Result Values
- Fixed but Statically Unknown Arities
## 7.4 Contracts: A Thorough Example/一个详尽示例
## 7.5 Contracts on Structures/结构上契约
- Guarantees for a Specific Value
- Guarantees for All Values
- Checking Properties of Data Structures
## 7.6 Abstract Contracts using `#:exists` and `#:∃`/抽象契约
## 7.7 Additional Examples/其他示例
- A Customer-Manager Component
- A Parameteric
- A Dictionary
- A Queue
## 7.8 Building New Contracts/构建新契约
- Contract Struct Properties
- With all the Bells and Whistles
## 7.9 Gotchas/陷阱
- Contracts and `eq?`
- Contract boundaries and `define/contract`
- Exists Contracts and Predicates
- Defining Recursive Contracts
- Mixing `set!` and `contract-out`

# 8 Input and Output/输入和输出
## 8.1 Varieties of Ports/端口种类
## 8.2 Default Ports/默认端口
## 8.3 Reading and Writing Racket Data/读写Racket数据
## 8.4 Datatypes and Serialization/数据类型和序列化
## 8.5 Bytes, Characters, and Encodings/字节, 字符和编码
## 8.6 I/O Patterns/IO模式

# 9 Regular Expressions/正则表达式
## 9.1 Writing Regexp Patterns/编写正则表达式模式
## 9.2 Matching Regexp Patterns/匹配正则表达式模式
## 9.3 Basic Assertions/基本断言
## 9.4 Characters and Character Classes/字符和字符类
- Some Frequently Used Character Classes
- POSIX character classes
## 9.5 Quantifiers/量词
## 9.6 Clusters/群
- Backreferences
- Non-capturing Clusters
- Cloisters
## 9.7 Alternation/交替
## 9.8 Backtracking/回溯
## 9.9 Looking Ahead and Behind/前瞻和回顾
- Lookahead
- Lookbehind
## 9.10 An Extended Example/一个扩展示例

# 10 Exceptions and Control/异常和控制
## 10.1 Exceptions/异常
## 10.2 Prompts and Aborts/提示和中止
## 10.3 Continuations/延续

# 11 Iterations and Comprehensions/迭代和推导式
## 11.1 Sequence Constructors/序列构造器
## 11.2 `for` and `for*`
## 11.3 `for/list` and `for*/list`
## 11.4 `for/vector` and `for*/vector`
## 11.5 `for/and` and `for/or`
## 11.6 `for/first` and `for/last`
## 11.7 `for/fold` and `for*/fold`
## 11.8 Multiple-Valued Sequences/多值的序列
## 11.9 Breaking an Iteration/结束迭代
## 11.10 Iteration Performance/迭代性能

# 12 Pattern Matching/模式匹配

# 13 Classes and Objects/类和对象
## 13.1 Methods/方法
## 13.2 Initialization Arguments/初始化参数
## 13.3 Internal and External Names/内部和外部名称
## 13.4 Interfaces/结构
## 13.5 Final, Augment, and Inner/最终, 增广和你饿不
## 13.6 Controlling the Scope of External Names/控制外部名称的作用域
## 13.7 Mixins/混入
- Mixins and Interfaces
- The mixin Form
- Parameterized Mixins
## 13.8 Traits/特质
- Traits as Sets of Mixins
- Inherit and Super in Traits
- The trait Form
## 13.9 Class Contracts/类契约
- External Class Contracts
- Internal Class Contracts

# 14 Units/单元
## 14.1 Signatures and Units/签名和单元
## 14.2 Invoking Units/调用单元
## 14.3 Linking Units/链接单元
## 14.4 First-Class Units/一等单元
## 14.5 Whole-module Signatures and Units/整个模块的签名和单元
## 14.6 Contracts for Units/单元契约
- Adding Contracts to Signatures
- Adding Contracts to Units
## 14.7 unit versus module/比较单元与模块

# 15 Reflection and Dynamic Evaluation/反射和动态求值
## 15.1 `eval`
- Local Scopes
- Namespaces
- Namespaces and Modules
## 15.2 Manipulating Namespaces/操作命名空间
- Creating and Installing Namespaces
- Sharing Data and Code Across Namespaces
## 15.3 Scripting Evaluation/脚本求值 and Using `load`
## 15.4 Code Inspectors for Trusted and Untrusted Code/可信和不可信代码的代码查看器

# 16 Macros/宏
## 16.1 Pattern-Based Macros/基于模式的宏
- `define-syntax-rule`
- Lexical Scope/词法作用域
- `define-syntax` and `syntax-rules`
- Matching Sequences/匹配序列
- Identifier Macros/标识符宏
- `set!` Transformers
- Macro-Generating Macros/宏生成红
- Extended Example: Call-by-Reference Functions/扩展示例: 按引用调用函数
## 16.2 General Macro Transformers/通用宏转换器
- Syntax Objects/语法对象
- Macro Transformer Procedures/宏转换器过程
- Mixing Patterns and Expressions/混合模式和表达式: `syntax-case`
- `with-syntax` and `generate-temporaries`
- Compile and Run-Time Phases/编译和运行时阶段
- General Phase Levels/一般阶段层级
  - Phases and Bindings/阶段和绑定
  - Phases and Modules/阶段和模块
- Tainted Syntax/受污染的语法
## 16.3 Module Instantiations and Visits/模块实例化和访问
- Declaration versus Instantiation/比较声明与实例化
- Compile-Time Instantiation/编译时实例化
- Visiting Modules/访问模块
- Lazy Visits via Available Modules/通过可用模块的惰性访问

# 17 Creating Languages/创建语言
## 17.1 Module Languages/模块语言
- Implicit Form Bindings/隐式表单绑定
- Using `#lang` s-exp
## 17.2 Reader Extensions/读取器扩展
- Source Locations
- Readtables
## 17.3 Defining new `#lang` Languages/定义新的`#lang`语言
- Designating a `#lang` Language
- Using `#lang` reader
- Using `#lang` s-exp `syntax/module-reader`
- Installing a Language
- Source-Handling Configuration
- Module-Handling Configuration

# 18 Concurrency and Synchronization/并发和同步
## 18.1 Threads/线程
## 18.2 Thread Mailboxes/线程邮箱
## 18.3 Semaphores/信号量
## 18.4 Channels/通道
## 18.5 Buffered Asynchronous Channels/缓冲的异步通道
## 18.6 Synchronizable Events and `sync`/同步的事件
## 18.7 Building Your Own Synchronization Patterns/构建同步模式

# 19 Performance/性能
## 19.1 Performance in DrRacket/DrRacket中性能
## 19.2 Racket Virtual Machine Implementations/Racket虚拟机实现
## 19.3 Bytecode, Machine Code, and Just-in-Time/字节码, 机器码和即时编译器
## 19.4 Modules and Performance/模块和性能
## 19.5 Function-Call Optimizations/函数调用优化
## 19.6 Mutation and Performance/修改和性能
## 19.7 `letrec` Performance
## 19.8 Fixnum and Flonum Optimizations/固定数和浮点数优化
## 19.9 Unchecked, Unsafe Operations/未检查的不安全操作
## 19.10 Foreign Pointers/外部指针
## 19.11 Regular Expression Performance/正则表达式性能
## 19.12 Memory Management/内存管理
## 19.13 Reachability and Garbage Collection/可达性和垃圾收集
## 19.14 Weak Boxes and Testing/弱盒子和测试
## 19.15 Reducing Garbage Collection Pauses/减少垃圾手机停顿

# 20 Parallelism/并行
## 20.1 Parallelism with Futures
## 20.2 Parallelism with Places
## 20.3 Distributed Places

# 21 Running and Creating Executables/运行和创建执行程序
## 21.1 Running racket and gracket
- Interactive Mode
- Module Mode
- Load Mode
## 21.2 Scripts
- Unix Scripts
- Windows Batch Files
## 21.3 Creating Stand-Alone Executables

# 22 More Libraries/其他库
## 22.1 Graphics and GUIs
## 22.2 The Web Server
## 22.3 Using Foreign Libraries
## 22.4 And More

# 23 Dialects of Racket and Scheme/Racket和Scheme方言
## 23.1 More Rackets

The `#lang` line that starts a Racket module declares the base language of the module. By “Racket,” we usually mean `#lang` followed by the base language `racket` or `racket/base` (of which `racket` is an extension). The Racket distribution provides additional languages, including the following:
- [typed/racket](https://docs.racket-lang.org/ts-reference/index.html) — like `racket`, but statically typed.
- [lazy](https://docs.racket-lang.org/lazy/index.html) — like [racket/base](https://docs.racket-lang.org/reference/index.html), but avoids evaluating an expression until its value is needed.
- [frtime](https://docs.racket-lang.org/frtime/index.html) — changes evaluation in an even more radical way to support reactive programming.
- [scribble/base](https://docs.racket-lang.org/scribble/base.html) — a language, which looks more like Latex than Racket, for writing documentation.

## 23.2 Standards
- R5RS: stands for [The Revised5 Report on the Algorithmic Language Scheme](https://docs.racket-lang.org/r5rs/r5rs-std/index.html), and it is currently the most widely implemented Scheme standard.
- R6RS: stands for [The Revised6 Report on the Algorithmic Language Scheme](https://docs.racket-lang.org/r6rs/r6rs-std/index.html), which extends R5RS with a module system that is similar to the Racket module system.
## 23.3 Teaching

See [How to Design Programs](./books/How%20to%20Design%20Programs.md).

# 24 Command-Line Tools and Your Editor of Choice/命令行工具和编辑器选择
## 24.1 Command-Line Tools
- Compilation and Configuration: raco
- Interactive evaluation
- Shell completion
## 24.2 Emacs
- Major Modes
- Minor Modes
- Packages specific to Evil Mode
## 24.3 Vim
- Plugins
- Indentation
- Highlighting
- Structured Editing
- REPLs
- Scribble
- Miscellaneous
## 24.4 Sublime Text
## 24.5 Visual Studio Code

