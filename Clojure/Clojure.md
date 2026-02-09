# Clojure
* https://clojure.org/
* https://github.com/clojure/clojure
* https://en.wikipedia.org/wiki/Clojure

> The Clojure Programming Language
> 
> Clojure is a **dynamic, general-purpose programming language/动态的通用编程语言**, combining the approachability and interactive development of a **scripting language/脚本语言** with an efficient and robust infrastructure for **multithreaded programming/多线程编程**. Clojure is a **compiled language/编译语言**, yet remains completely **dynamic/动态的** – every feature supported by Clojure is supported at runtime. Clojure provides easy access to the Java frameworks, with optional **type hints and type inference/类型提示和类型推断**, to ensure that calls to Java can avoid reflection.
>
> Clojure is a **dialect of Lisp/Lisp方言**, and shares with Lisp the code-as-data philosophy and a powerful macro system. Clojure is predominantly a **functional programming language/函数式编程语言**, and features a rich set of immutable, persistent data structures. When mutable state is needed, Clojure offers a **software transactional memory system/软件事务内存系统** and **reactive Agent system/响应式Agent系统** that ensure clean, correct, multithreaded designs.

Features: https://clojure.org/about/features
* Dynamic Development/动态开发
  * The REPL
  * Basics
  * Dynamic Compilation
* Functional Programming/函数式编程
  * First-class functions: `fn`, `defn`
  * Immutable Data Structures: Persistence/持久性 is a term used to describe the property wherein the old version of the collection is still available after the 'change', and that the collection maintains its performance guarantees for most operations.
  * Extensible Abstractions: Clojure uses Java interfaces to define its core data structures. - seq, `lazy-seq`
  * Recursive Looping: `recur`
* Lisp: Clojure extends the code-as-data system beyond parenthesized lists (s-expressions) to vectors and maps.
* Runtime Polymorphism/运行时多态
  * Most core infrastructure data structures in the Clojure runtime are defined by Java interfaces.
  * Clojure supports the generation of implementations of Java interfaces in Clojure using proxy/代理.
  * The Clojure language supports polymorphism along both class and custom hierarchies with multimethods/多方法. - `defmulti`, `defmethod`
  * The Clojure language also supports a faster form of polymorphism with protocols/协议 (but limited only to class polymorphism to take advantage of the JVMs existing capabilities for invocation). - `defprotocol`
* Concurrent Programming/并发编程
  * STM: software transactional memory system
  * ref, agent, atom, var
* Hosted on the JVM
  * Clojure is designed to be a hosted language, sharing the JVM type system, GC, threads etc.
  * Clojure supports the dynamic implementation of Java interfaces and classes using `reify` and `proxy`

Actions
- [Programming Clojure](./codes/programming-clojure/ProgrammingClojure.md)
- [Clojure Programming](./clojure-prog/README.md)

# Specification
* [Is there a language spec for clojure? - StackOverflow](https://stackoverflow.com/questions/3902813/is-there-a-language-spec-for-clojure)
  * [LispReader.java](https://github.com/clojure/clojure/blob/master/src/jvm/clojure/lang/LispReader.java)
  * [tools.reader](https://github.com/clojure/tools.reader)
  * [core.specs.alpha](https://github.com/clojure/core.specs.alpha)

## Release History

| Version | Release date       | Major features, improvements                                                                                                                                   |
| ------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|         | October 17, 2007   | Initial public release                                                                                                                                         |
| 1.0     | May 4, 2009        | First stable release                                                                                                                                           |
| 1.1     | December 31, 2009  | Futures                                                                                                                                                        |
| 1.2     | August 19, 2010    | Protocols                                                                                                                                                      |
| 1.3     | September 23, 2011 | Enhanced primitive support                                                                                                                                     |
| 1.4     | April 15, 2012     | Reader literals                                                                                                                                                |
| 1.5     | March 1, 2013      | Reducers                                                                                                                                                       |
| 1.5.1   | March 10, 2013     | Fixing a memory leak                                                                                                                                           |
| 1.6     | March 25, 2014     | Java API, improved hashing algorithms                                                                                                                          |
| 1.7     | June 30, 2015      | Transducers, reader conditionals                                                                                                                               |
| 1.8     | January 19, 2016   | Additional string functions, direct linking, socket server                                                                                                     |
| 1.9     | December 8, 2017   | Integration with spec, command-line tools                                                                                                                      |
| 1.10    | December 17, 2018  | Improved error reporting, Java compatibility                                                                                                                   |
| 1.10.1  | June 6, 2019       | Working around a Java performance regression and improving error reporting from `clojure.main`                                                                 |
| 1.10.2  | January 26, 2021   | Java interoperability/compatibility improvements and other important language fixes                                                                            |
| 1.10.3  | March 4, 2021      | prepl support for reader conditionals                                                                                                                          |
| 1.11.0  | March 22, 2022     | New syntax for keyword argument invocation, new `clojure.math` namespace, namespace aliasing without loading, and new helper functions added to `clojure.core` |
| 1.11.1  | April 5, 2022      | Rolling back unintended change in binary serialisation of objects of types `clojure.lang.Keyword` and `clojure.lang.ArraySeq`.                                 |
| 1.11.2  | March 8, 2024      | Fix for CVE-2024-22871 Denial of Service                                                                                                                       |
| 1.12.0  | September 5, 2024  | Java method values, params type hints, array class syntax, `add-lib`, `clojure.java.process`                                                                   |
| 1.12.1  | June 2, 2025       | Includes bug fixes, improved interop, enhanced tool support, and metadata updates.                                                                             |
| 1.12.2  | August 25, 2025    | Fixes for CLJ-2914, CLJ-1798, CLJ-2916 and CLJ-2917.                                                                                                           |
| 1.12.3  | August 25, 2025    | Fix for CLJ-2919.                                                                                                                                              |

# Guides
* [clojure.guides.md](./language/clojure.guides.md)

Learning
* Learn Clojure
* FAQ: These questions and answers are adapted from mailing lists and other Clojure community forums.

Language
* **spec**: The spec library specifies the structure of data, validates or conforms it, and can generate data based on the spec. To use spec, declare a dependency on Clojure 1.9.0 or higher.
* **Reading Clojure Characters**: This page explains the Clojure syntax for characters that are difficult to "google". Sections are not in any particular order, but related items are grouped for ease. Please refer to the reader reference page as the authoritative reference on the Clojure reader. This guide is based on James Hughes original blog post and has been updated and expanded here with the permission of the author.
* **Destructuring in Clojure**: Destructuring is a way to concisely bind names to the values inside a data structure. Destructuring allows us to write more concise and readable code.
* **Threading Macros**: Threading macros, also known as arrow macros(`->`), convert nested function calls into a linear flow of function calls, improving readability.
* **Equality**: This document discusses the concept of equality in Clojure, including the functions `=`, `==`, and `identical?`, and how they differ from Java’s `equals` method. It also has some description of Clojure’s `hash`, and how it differs from Java’s `hashCode`.
* **Comparators**: A comparator is a function that takes two arguments x and y and returns a value indicating the relative order in which x and y should be sorted. It can be a 3-way comparator returning an integer, or a 2-way comparator returning a boolean.
* **Reader Conditionals**: Reader conditionals were added in Clojure 1.7. They are designed to allow different dialects of Clojure to share common code that is mostly platform independent, but contains some platform dependent code. If you are writing code across multiple platforms that is mostly independent you should separate `.clj` and `.cljs` files instead. Reader conditionals are integrated into the Clojure reader, and don’t require any extra tooling. To use reader conditionals, all you need is for your file to have a `.cljc` extension. Reader conditionals are expressions, and can be manipulated like ordinary Clojure expressions.
* **Higher Order Functions**

Usage
* **Improving Development Startup Time**

Tools
* **Deps and CLI**
* `tools.build`: tools.build is a library of functions for building Clojure projects. It is intended to be used in a build program to create user-invokable target functions.

Libraries
* **Go Block Best Practices**
* `test.check`: test.check is a property-based testing library for clojure, inspired by QuickCheck.

# Reference
* [clojure.reference.md](./language/clojure.reference.md)

Contents
* The Reader/读取器
* The REPL and main
* Evaluation/求值
* Special Forms/特殊形式
* Macros/宏
* Other Functions
* Data Structures
* Datatypes/数据类型
* Sequences
* Transients/瞬态
* Transducers/转换器
* Multimethods/多方法 and Hierarchies
* Protocols/协议
* Metadata/元数据
* Namespaces/命名空间
* Libs: Clojure provides for code loading and dependency tracking via its "lib" facility. A lib is a named unit of Clojure source code contained in a Java resource within classpath. A lib will typically provide the complete set of definitions that make up one Clojure namespace.
* Vars and Environments/环境
* Refs and Transactions/事务
* Agents/代理
* Atoms/原子
* Reducers/规约器
* Java Interop
* Compilation and Class Generation
* Other Libraries: Other included Libraries
  * `clojure.java.*`: Java Utilities. - `basic`, `io`, `javadocs`, `process`, `shell`.
  * `parallel`: Prarllel Processing. - DEPRECATED
  * `clojure.reflect`: Reflection Utilities.
  * `clojure.repl`: REPL Utilities
  * `clojure.set`: Sets and Relational Algebra
  * `clojure.string`: String Handling
  * `clojure.test`: Unit Testing
  * `clojure.walk`: Walking Data Structures
  * `clojure.xml`: XML
  * `clojure.zip`: Zipper - FUnctional Tree Editing
* Differences with Lisps
* Clojure CLI: The Clojure CLI is a command-line tool to run Clojure programs on the Java Virtual Machine. The Clojure CLI uses deps.edn files to configure and download program dependencies to include on the JVM classpath.
* deps.edn: The `deps.edn` file is a data file specifying all information needed to form a project classpath, including deps, paths, and external dependency repository information. The `deps.edn` file format is used by the [tools.deps library](https://github.com/clojure/tools.deps) and the Clojure CLI.


# API
* [clojure.API.md](./language/clojure.API.md)

| Namespace                    | Description                                                                                            |
| :--------------------------- | :----------------------------------------------------------------------------------------------------- |
| `clojure.core`               | Fundamental library of the Clojure language.                                                           |
| `clojure.data`               | Non-core data functions.                                                                               |
| `clojure.datafy`             | Functions to turn objects into data. Alpha, subject to change.                                         |
| `clojure.edn`                | edn reading.                                                                                           |
| `clojure.inspector`          | Graphical object inspector for Clojure data structures.                                                |
| `clojure.instant`            | Utilities for data and timestamp.                                                                      |
| `clojure.java.basis`         | The lib basis is from the resolution process: libraries dependencies, classpath and other information. |
| `clojure.java.browse`        | Start a web browser from Clojure.                                                                      |
| `clojure.java.io`            | This file defines polymorphic I/O utility functions for Clojure.                                       |
| `clojure.java.javadoc`       | A repl helper to quickly open javadocs.                                                                |
| `clojure.java.process`       | A process invocation API wrapping the Java process API.                                                |
| `clojure.java.shell`         | Conveniently launch a sub-process providing its stdin and collecting its stdout.                       |
| `clojure.main`               | Top-level main function for Clojure REPL and scripts.                                                  |
| `clojure.math`               | Clojure wrapper functions for `java.lang.Math` static methods.                                         |
| `clojure.pprint`             | A Pretty Printer for Clojure.                                                                          |
| `clojure.reflect`            | Reflection on Host Types. Alpha - subject to change.                                                   |
| `clojure.repl`               | Utilities meant to be used interactively at the REPL.                                                  |
| `clojure.set`                | Set operations such as union/intersection.                                                             |
| `clojure.stacktrace`         | Print stack traces oriented towards Clojure, not Java.                                                 |
| `clojure.string`             | Clojure String utilities.                                                                              |
| `clojure.template`           | Macros that expand to repeated copies of a template expression.                                        |
| `clojure.test`               | A unit testing framework.                                                                              |
| `clojure.tools.deps.interop` | Functions for invoking Java processes and invoking tools via the Clojure CLI.                          |
| `clojure.walk`               | This file defines a generic tree walker for Clojure data structures.                                   |
| `clojure.xml`                | XML reading/writing.                                                                                   |
| `clojure.zip`                | Functional hierarchical zipper, with navigation, editing, and enumeration.                             |

# Tools
* [clojure.tools.md](./tools/clojure.tools.md)

# Ecosystem
* [ClojureScript](./language/ClojureScript.md)
## ClojureCLR
* https://github.com/clojure/clojure-clr

> This project is a native implementation of Clojure on the **Common Language Runtime (CLR)**, the execution engine of Microsoft's .Net Framework.
>
> ClojureCLR is programmed in C# (and Clojure itself).

# Implementation
* [clojure.rtfsc.md](./language/clojure.rtfsc.md)

# See Also
* [clojure-koans](https://github.com/functional-koans/clojure-koans): A set of exercises for learning Clojure.
* [edn-format/edn](https://github.com/edn-format/edn): Extensible Data Notation.
* [mal - Make a Lisp](https://github.com/kanaka/mal): Mal is a Clojure inspired Lisp interpreter.
* [transit-format](https://github.com/cognitect/transit-format): Transit is a format and set of libraries for conveying values between applications written in different programming languages. This spec describes Transit in order to facilitate its implementation in a wide range of languages.
* [Typed Clojure](./language/Typed%20Clojure.md)
* [functional-koans/clojure-koans](https://github.com/functional-koans/clojure-koans): A set of exercises for learning Clojure.
* [mbuczko/awesome-clojure](https://github.com/mbuczko/awesome-clojure): list of useful links for clojurians.
* [razum2um/awesome-clojure](https://github.com/razum2um/awesome-clojure): A curated list of awesome Clojure libraries and resources.
* [Clojure Cheatsheets](https://jafingerhut.github.io/)
