# The Racket Reference
* https://docs.racket-lang.org/reference/index.html

This manual defines the core Racket language and describes its most prominent libraries. The companion manual [The Racket Guide](https://docs.racket-lang.org/guide/index.html) provides a friendlier (though less precise and less complete) overview of the language.

Unless otherwise noted, the bindings defined in this manual are exported by the [racket/base](https://docs.racket-lang.org/reference/index.html) and [racket](https://docs.racket-lang.org/reference/index.html) languages.
```racket
#lang racket/base
#lang racket
```

The [racket/base](https://docs.racket-lang.org/reference/index.html) library is much smaller than the [racket](https://docs.racket-lang.org/reference/index.html) library and will typically load faster.

The [racket](https://docs.racket-lang.org/reference/index.html) library combines 
- [racket/base](https://docs.racket-lang.org/reference/index.html)
- [racket/bool](https://docs.racket-lang.org/reference/booleans.html#%28mod-path._racket%2Fbool%29)
- [racket/bytes](https://docs.racket-lang.org/reference/bytestrings.html#%28mod-path._racket%2Fbytes%29)
- [racket/class](https://docs.racket-lang.org/reference/mzlib_class.html)
- [racket/cmdline](https://docs.racket-lang.org/reference/Command-Line_Parsing.html)
- [racket/contract](https://docs.racket-lang.org/reference/contracts.html)
- [racket/dict](https://docs.racket-lang.org/reference/dicts.html)
- [racket/file](https://docs.racket-lang.org/reference/Filesystem.html#%28mod-path._racket%2Ffile%29)
- [racket/format](https://docs.racket-lang.org/reference/strings.html#%28mod-path._racket%2Fformat%29)
- [racket/function](https://docs.racket-lang.org/reference/procedures.html#%28mod-path._racket%2Ffunction%29)
- [racket/future](https://docs.racket-lang.org/reference/futures.html)
- [racket/include](https://docs.racket-lang.org/reference/include.html)
- [racket/list](https://docs.racket-lang.org/reference/pairs.html#%28mod-path._racket%2Flist%29)
- [racket/local](https://docs.racket-lang.org/reference/local.html)
- [racket/match](https://docs.racket-lang.org/reference/match.html)
- [racket/math](https://docs.racket-lang.org/reference/generic-numbers.html#%28mod-path._racket%2Fmath%29)
- [racket/mutability](https://docs.racket-lang.org/reference/booleans.html#%28mod-path._racket%2Fmutability%29)
- [racket/path](https://docs.racket-lang.org/reference/More_Path_Utilities.html)
- [racket/place](https://docs.racket-lang.org/reference/places.html)
- [racket/port](https://docs.racket-lang.org/reference/port-lib.html)
- [racket/pretty](https://docs.racket-lang.org/reference/pretty-print.html)
- [racket/promise](https://docs.racket-lang.org/reference/Delayed_Evaluation.html)
- [racket/sequence](https://docs.racket-lang.org/reference/sequences.html#%28mod-path._racket%2Fsequence%29)
- [racket/set](https://docs.racket-lang.org/reference/sets.html)
- [racket/shared](https://docs.racket-lang.org/reference/shared.html)
- [racket/stream](https://docs.racket-lang.org/reference/streams.html)
- [racket/string](https://docs.racket-lang.org/reference/strings.html#%28mod-path._racket%2Fstring%29)
- [racket/system](https://docs.racket-lang.org/reference/subprocess.html#%28mod-path._racket%2Fsystem%29)
- [racket/tcp](https://docs.racket-lang.org/reference/tcp.html)
- [racket/udp](https://docs.racket-lang.org/reference/udp.html)
- [racket/unit](https://docs.racket-lang.org/reference/mzlib_unit.html)
- [racket/vector](https://docs.racket-lang.org/reference/vectors.html#%28mod-path._racket%2Fvector%29)

In addition, it re-exports [for-syntax](https://docs.racket-lang.org/reference/require.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._for-syntax%29%29) everything from [racket/base](https://docs.racket-lang.org/reference/index.html).

# 1 Language Model/语言模型
## 1.1 Evaluation Model/求值模型
- Sub-expression Evaluation and Continuations/子表达式求值和延续
- Tail Position/尾部位置
- Multiple Return Values/多返回值
- Top-Level Variables/顶级变量
- Objects and Imperative Update/对象和命令式更新
- Garbage Collection/垃圾收集
- Procedure Applications and Local Variables/过程应用和局部变量
- Variables and Locations/变量和位置
- Modules and Module-Level Variables/模块和模块级变量
	- Phases/阶段
	- The Separate Compilation Guarantee/单独编译保证
	- Cross-Phase Persistent Modules/跨阶段持久的模块
	- Module Redeclarations/模块重新声明
	- Submodules/子模块
- Continuation Frames and Marks/延续帧和标记
- Prompts, Delimited Continuations, and Barriers/提示, 限定延续和障碍
- Threads/线程
- Parameters/参数
- Exceptions/异常
- Custodians/保管

## 1.2 Syntax Model/语法模型
- Identifiers, Binding, and Scopes/标识符, 绑定和作用域
- Syntax Objects/语法对象
- Expansion (Parsing)/展开(接卸)
	- Fully Expanded Programs/完全展开的程序
	- Expansion Steps/展开步骤
	- Expansion Context/展开上下文
	- Introducing Bindings/引入绑定
	- Transformer Bindings/转换器绑定
	- Local Binding Context/局部绑定上下文
	- Partial Expansion/部分展开
	- Internal Definitions/内部定义
	- Module Expansion, Phases, and Visits/模块展开, 节点和访问
	- Macro-Introduced Bindings/宏引入的绑定
- Compilation/编译
- Namespaces/命名空间
- Inferred Value Names/推断的值名称
- Cross-Phase Persistent Module Declarations/跨截断持久的模块声明

## 1.3 The Reader/读取器
## 1.4 The Printer/打印器
## 1.5 Implementations/实现

- CS: uses Chez Scheme as its core compiler and runtime system. the default implementation as of Racket version 8.0.
- BC: before Chez, bytecode. the default implementation up until version 7.9.

# 2 Notation for Documentation
## 2.1 Notation for Module Documentation
## 2.2 Notation for Syntactic Form Documentation
## 2.3 Notation for Function Documentation
## 2.4 Notation for Structure Type Documentation
## 2.5 Notation for Parameter Documentation
## 2.6 Notation for Other Documentation

# 3 Syntactic Forms/句法形式
## 3.1 Modules.模块: `module`, `module*`, ...
## 3.2 Importing and Exporting/导入和导出: `require` and `provide`
- Additional `require` Forms
- Additional `provide` Forms
## 3.3 Literals/字面量: `quote` and `#%datum`
## 3.4 Expression Wrapper/表达式包装器: `#%expression`
## 3.5 Variable References/变量引用 and `#%top`
## 3.6 Locations/位置: `#%variable-reference`
## 3.7 Procedure Applications/程序应用 and `#%app`
## 3.8 Procedure Expressions/过程表达式: `lambda` and `case-lambda`
## 3.9 Local Binding/局部绑定: `let`, `let*`, `letrec`, ...
## 3.10 Local Definitions/本地定义: `local`
## 3.11 Constructing Graphs/构造图: `shared`
## 3.12 Conditionals/条件: `if`, `cond`, `and`, and `or`
## 3.13 Dispatch/分发: `case`
## 3.14 Definitions/定义: `define`, `define-syntax`, ...
- `require` Macros
- `provide` Macros
## 3.15 Sequencing/序列化: `begin`, `begin0`, and `begin-for-syntax`
## 3.16 Guarded Evaluation: `when` and `unless`
## 3.17 Assignment: `set!` and `set!-values`
## 3.18 Iterations and Comprehensions: `for`, `for/list`, ...
- Iteration and Comprehension Forms
- Deriving New Iteration Forms
- Do Loops
## 3.19 Continuation Marks: `with-continuation-mark`
## 3.20 Quasiquoting: `quasiquote`, `unquote`, and `unquote-splicing`
## 3.21 Syntax Quoting: `quote-syntax`
## 3.22 Interaction Wrapper: `#%top-interaction`
## 3.23 Blocks: `block`
## 3.24 Internal-Definition Limiting: `#%stratified-body`
## 3.25 Performance Hints: `begin-encourage-inline`
## 3.26 Importing Modules Lazily: `lazy-require`

# 4 Datatypes/数据类型
## 4.1 Equality/相等性
- Object Identity and Comparisons
- Equality and Hashing
- Implementing Equality for Custom Types
- Honest Custom Equality
- Combining Hash Codes
## 4.2 Booleans/布尔值
- Boolean Aliases
- Mutability Predicates
## 4.3 Numbers/数字
- Number Types/数字类型
- Generic Numerics/通用数值
	- Arithmetic/算术
	- Number Comparison/数字比较
	- Powers and Roots/幂和根
	- Trigonometric Functions/三角函数
	- Complex Numbers/负数
	- Bitwise Operations/位操作
	- Random Numbers/随机数
	- Other Randomness Utilities/其他随机性实用程序
	- Number–String Conversions/数字-字符串转换
	- Extra Constants and Functions/其他常量和函数
- Flonums/浮点数
	- Flonum Arithmetic
	- Flonum Vectors
- Fixnums/固定数
	- Fixnum Arithmetic
	- Fixnum Vectors
	- Fixnum Range
- Extflonums/扩展精度浮点数
	- Extflonum Arithmetic
	- Extflonum Constants
	- Extflonum Vectors
	- Extflonum Byte Strings
## 4.4 Strings/字符串
- String Constructors, Selectors, and Mutators
- String Comparisons
- String Conversions
- Locale-Specific String Operations
- String Grapheme Clusters
- Additional String Functions
- Converting Values to Strings
## 4.5 Byte Strings/字节字符串
- Byte String Constructors, Selectors, and Mutators
- Byte String Comparisons
- Bytes to/from Characters, Decoding and Encoding
- Bytes to Bytes Encoding Conversion
- Additional Byte String Functions
## 4.6 Characters/字符
- Characters and Scalar Values
- Character Comparisons
- Classifications
- Character Conversions
- Character Grapheme-Cluster Streaming
## 4.7 Symbols/符号
- Additional Symbol Functions
## 4.8 Regular Expressions/正则表达式
- Regexp Syntax
- Additional Syntactic Constraints
- Regexp Constructors
- Regexp Matching
- Regexp Splitting
- Regexp Substitution
## 4.9 Keywords/关键字
- Additional Keyword Functions
## 4.10 Pairs and Lists/对和列表
- Pair Constructors and Selectors
- List Operations
- List Iteration
- List Filtering
- List Searching
- Pair Accessor Shorthands
- Additional List Functions and Synonyms
- Immutable Cyclic Data
## 4.11 Mutable Pairs and Lists/可变对和列表
- Mutable Pair Constructors and Selectors
## 4.12 Vectors/向量
- Additional Vector Functions
## 4.13 Stencil Vectors/模板向量
## 4.14 Boxes/盒子
## 4.15 Hash Tables/哈希表
- Additional Hash Table Functions
## 4.16 Sequences and Streams/序列和流
- Sequences
	- Sequence Predicate and Constructors
	- Sequence Conversion
	- Additional Sequence Operations
####.1 Additional Sequence Constructors and Functions
- Streams
- Generators
## 4.17 Dictionaries/字典
- Dictionary Predicates and Contracts
- Generic Dictionary Interface
	- Primitive Dictionary Methods
	- Derived Dictionary Methods
- Dictionary Sequences
- Contracted Dictionaries
- Custom Hash Tables
- Passing Keyword Arguments in Dictionaries
## 4.18 Sets/集
- Hash Sets
- Set Predicates and Contracts
- Generic Set Interface
	- Set Methods
- Custom Hash Sets
## 4.19 Procedures/过程
- Keywords and Arity
- Reflecting on Primitives
- Additional Higher-Order Functions
## 4.20 Void
## 4.21 Undefined/未定义的

# 5 Structures: 结构
## 5.1 Defining Structure Types: `struct`
## 5.2 Creating Structure Types
## 5.3 Structure Type Properties
## 5.4 Generic Interfaces
## 5.5 Copying and Updating Structures
## 5.6 Structure Utilities
- Additional Structure Utilities
## 5.7 Structure Type Transformer Binding

# 6 Classes and Objects/类和对象
## 6.1 Creating Interfaces/创建接口
## 6.2 Creating Classes/创建类
- Initialization Variables
- Fields
- Methods
	- Method Definitions
	- Inherited and Superclass Methods
	- Internal and External Names
## 6.3 Creating Objects/创建对象
## 6.4 Field and Method Access/字段和方法访问
- Methods
- Fields
- Generics
## 6.5 Mixins/混入
## 6.6 Traits/特质
## 6.7 Object and Class Contracts/对象和类契约
## 6.8 Object Equality and Hashing/对象相等性和哈希
## 6.9 Object Serialization/对象序列化
## 6.10 Object Printing/对象打印
## 6.11 Object, Class, and Interface Utilities/对象, 类和接口实用程序
## 6.12 Surrogates/代理

# 7 Units/单元
## 7.1 Creating Units/创建单元
## 7.2 Invoking Units/调用单元
## 7.3 Linking Units and Creating Compound Units/链接单元和创建符合单元
## 7.4 Inferred Linking/推断的链接
## 7.5 Generating A Unit from Context/从上下文生成单元
## 7.6 Structural Matching/结构化匹配
## 7.7 Extending the Syntax of Signatures/扩展签名语法
## 7.8 Unit Utilities/单元实用程序
## 7.9 Unit Contracts/单元契约
## 7.10 Single-Unit Modules/单单元的模块
## 7.11 Single-Signature Modules/单签名的模块
## 7.12 Transformer Helpers/转换器助手

# 8 Contracts/契约
## 8.1 Data-structure Contracts/数据结构契约
## 8.2 Function Contracts/函数契约
## 8.3 Parametric Contracts/参数化契约
## 8.4 Lazy Data-structure Contracts/惰性数据结构契约
## 8.5 Structure Type Property Contracts/结构类型属性契约
## 8.6 Attaching Contracts to Values/附加契约到值
- Nested Contract Boundaries
- Low-level Contract Boundaries
## 8.7 Building New Contract Combinators/构建新契约组合器
- Blame Objects
- Contracts as structs
- Obligation Information in Check Syntax
- Utilities for Building New Combinators
## 8.8 Contract Utilities/契约实用程序
## 8.9 racket/contract/base
## 8.10 Collapsible Contracts/可折叠的契约
## 8.11 Legacy Contracts/遗留契约
## 8.12 Random generation/随机生成

# 9 Pattern Matching/模式匹配
## 9.1 Additional Matching Forms/其他匹配形式
## 9.2 Extending `match`/扩展`match`
## 9.3 Library Extensions/库扩展

# 10 Control Flow/控制流
## 10.1 Multiple Values/多值
## 10.2 Exceptions/异常
- Error Message Conventions/错误消息约定
- Raising Exceptions/抛出异常
- Handling Exceptions/处理异常
- Configuring Default Handling/配置默认处理器
- Built-in Exception Types/内置异常类型
- Additional Exception Functions/其他异常函数
- Realms and Error Message Adjusters/
## 10.3 Delayed Evaluation/延迟的求值
- Additional Promise Kinds
## 10.4 Continuations/延续
- Additional Control Operators
## 10.5 Continuation Marks/延续标记
## 10.6 Breaks/退出循环
## 10.7 Exiting/退出
## 10.8 Unreachable Expressions/不可达表达式
- Customized Unreachable Reporting

# 11 Concurrency and Parallelism/并发和并行
## 11.1 Threads/线程
- Creating Threads
- Suspending, Resuming, and Killing Threads
- Synchronizing Thread State
- Thread Mailboxes
## 11.2 Synchronization/同步
- Events
- Channels
- Semaphores
- Buffered Asynchronous Channels
	- Creating and Using Asynchronous Channels
	- Contracts and Impersonators on Asynchronous Channels
## 11.3 Thread-Local Storage/线程本地粗出
- Thread Cells
- Parameters
## 11.4 Futures
- Creating and Touching Futures
- Future Semaphores
- Future Performance Logging
## 11.5 Places/位置
- Using Places
- Syntactic Support for Using Places
- Places Logging
## 11.6 Engines/引擎
## 11.7 Machine Memory Order/机器内存序

# 12 Macros/宏
## 12.1 Pattern-Based Syntax Matching/基于模型的语法匹配
## 12.2 Syntax Object Content/语法对象内容
- Syntax Object Source Locations
## 12.3 Syntax Object Bindings/语法对象绑定
## 12.4 Syntax Transformers/语法转换器
- require Transformers
- provide Transformers
- Keyword-Argument Conversion Introspection
- Portal Syntax Bindings
## 12.5 Syntax Parameters/语法参数
- Syntax Parameter Inspection
## 12.6 Local Binding with Splicing Body/局部绑定与剪接体
## 12.7 Syntax Object Properties/语法对象属性
## 12.8 Syntax Taints/语法误点
## 12.9 Expanding Top-Level Forms/展开顶级形式
- Information on Expanded Modules
## 12.10 Serializing Syntax/序列化语法
## 12.11 File Inclusion/文件包含
## 12.12 Syntax Utilities/语法实用程序
- Creating formatted identifiers
- Pattern variables
- Error reporting
- Recording disappeared uses
- Miscellaneous utilities
## 12.13 Phase and Space Utilities/阶段和位置实用程序

# 13 Input and Output/输入和输出
## 13.1 Ports/端口
- Encodings and Locales
- Managing Ports
- Port Buffers and Positions
- Counting Positions, Lines, and Columns
- File Ports
- String Ports
- Pipes
- Structures as Ports
- Custom Ports
- More Port Constructors, Procedures, and Events
	- Port String and List Conversions
	- Creating Ports
	- Port Events
	- Copying Streams
## 13.2 Byte and String Input/字节和字符串输入
## 13.3 Byte and String Output/字节和字符串输出
## 13.4 Reading/读取
## 13.5 Writing/写
## 13.6 Pretty Printing/美化打印
- Basic Pretty-Print Options
- Per-Symbol Special Printing
- Line-Output Hook
- Value Output Hook
- Additional Custom-Output Support
## 13.7 Reader Extension/读取器扩展
- Readtables
- Reader-Extension Procedures
- Special Comments
## 13.8 Printer Extension/打印器扩展
## 13.9 Serialization/序列化
## 13.10 Fast-Load Serialization/快速加载序列化
## 13.11 Cryptographic Hashing/加密哈希

# 14 Reflection and Security/反射和安全性
## 14.1 Namespaces/命名空间
## 14.2 Evaluation and Compilation/求值和编译
## 14.3 The racket/load Language/`racket/load`语言
## 14.4 Module Names and Loading/模块名称和加载
- Resolving Module Names
- Compiled Modules and References
- Dynamic Module Access
- Module Cache
## 14.5 Impersonators and Chaperones/模仿者和监护人
- Impersonator Constructors
- Chaperone Constructors
- Impersonator Properties
## 14.6 Security Guards/安全性守卫
## 14.7 Custodians/保管
## 14.8 Thread Groups/线程组
## 14.9 Structure Inspectors/结构查看器
## 14.10 Code Inspectors/代码查看器
## 14.11 Plumbers/水管工
## 14.12 Sandboxed Evaluation/沙盒求值
- Security Considerations
- Customizing Evaluators
- Interacting with Evaluators
- Miscellaneous
## 14.13 The racket/repl Library/`racket/repl`库
## 14.14 Linklets and the Core Compiler/链接器和核心编译器

# 15 Operating System/操作系统
## 15.1 Paths/路径
- Manipulating Paths
- More Path Utilities
- Unix and Mac OS Paths
	- Unix Path Representation
- Windows Paths
	- Windows Path Representation
## 15.2 Filesystem/文件系统
- Locating Paths
- Files
- Directories
- Detecting Filesystem Changes
- Declaring Paths Needed at Run Time
- More File and Directory Utilities
## 15.3 Networking/网络
- TCP
- UDP
## 15.4 Processes/进程
- Simple Subprocesses
## 15.5 Logging/日志
- Creating Loggers
- Logging Events
- Receiving Logged Events
- Additional Logging Functions
## 15.6 Time/时间
- Date Utilities
## 15.7 Environment Variables/环境变量
## 15.8 Environment and Runtime Information/环境和运行时信息
## 15.9 Command-Line Parsing/命令行解析
## 15.10 Additional Operating System Functions/其他操作器系统函数

# 16 Memory Management/内存管理
## 16.1 Weak Boxes/弱盒子
## 16.2 Ephemerons/蜉蝣
## 16.3 Wills and Executors/遗嘱和执行人
## 16.4 Garbage Collection/垃圾收集
## 16.5 Phantom Byte Strings/幻象字节字符串

# 17 Unsafe Operations/不安全的操作
## 17.1 Unsafe Numeric Operations
## 17.2 Unsafe Character Operations
## 17.3 Unsafe Compound-Data Operations
## 17.4 Unsafe Extflonum Operations
## 17.5 Unsafe Impersonators and Chaperones
## 17.6 Unsafe Assertions
## 17.7 Unsafe Undefined

# 18 Running Racket/运行Racket
## 18.1 Running Racket or GRacket
- Initialization
- Exit Status
- Init Libraries
- Command Line
- Language Run-Time Configuration
- Language Expand Configuration
## 18.2 Libraries and Collections/库和馆藏
- Collection Search Configuration
- Collection Links
- Collection Paths and Parameters
## 18.3 Interactive Help/交互式帮助
## 18.4 Interaction Configuration/交互式配置
## 18.5 Interactive Module Loading/交互式模块加载
- Entering Modules
- Loading and Reloading Modules
## 18.6 Debugging/调试
- Tracing
## 18.7 Controlling and Inspecting Compilation/控制和查看编译
- Compilation Modes
	- BC Compilation Modes
	- CS Compilation Modes
- Inspecting Compiler Passes
## 18.8 Kernel Forms and Functions/内核形式和函数

# Bibliography
