# Clojure Reference
* https://clojure.org/reference/reader

# The Reader

## Reader forms

- Symbols
- Literals
- Lists
- Vectors
- Maps
- Sets
- `deftype`, `defrecord`, constructor calls

## Macro characters

- Quote (`'`)
- Character (`\`)
- Comment (`;`)
- Deref (`@`)
- Metadata (`^`)
- Dispatch (`#`)
- Syntax-quote (``` ` ```, note, the "backquote" character), Unquote (`~`) and Unquote-splicing (`~@`)

## extensible data notation (edn)

Clojure’s reader supports a superset of extensible data notation (edn).

## Tagged Literals

Tagged literals are Clojure’s implementation of edn tagged elements.

When Clojure starts, it searches for files named `data_readers.clj` or `data_readers.cljc` at the root of the classpath. 
Each such file must contain a Clojure map of symbols
```clojure
{foo/bar my.project.foo/bar
 foo/baz my.project/baz}
```
The key in each pair is a tag that will be recognized by the Clojure reader. 
The value in the pair is the fully-qualified name of a Var which will be invoked by the reader to parse the form following the tag.

Reader tags without namespace qualifiers are reserved for Clojure. 
Default reader tags are defined in `default-data-readers` but may be overridden in `data_readers.clj` / `data_readers.cljc` or by rebinding `*data-readers*`. 
If no data reader is found for a tag, the function bound in `*default-data-reader-fn*` will be invoked with the tag and value to produce a value. 
If `*default-data-reader-fn*` is `nil` (the default), a RuntimeException will be thrown.

If a `data_readers.cljc` is provided, it is read with the same semantics as any other cljc source file with reader conditionals.

- Built-in tagged literals
  - `#inst "yyyy-mm-ddThh:mm:ss.fff+hh:mm"`
  - `#uuid "3b8a31ed-fd89-4f1b-a00f-42e3d60cf5ce"`
- Default data reader function: `(set! *default-data-reader-fn* tagged-literal)`

## Reader Conditionals

Clojure 1.7 introduced a new extension (.cljc) for portable files that can be loaded by multiple Clojure platforms.
In cases where is not feasible to isolate the varying parts of the code, or where the code is mostly portable with only small platform-specific parts, 1.7 also introduced **reader conditionals**, which are supported only in cljc files and at the default REPL.

Reader conditionals are a new reader dispatch form starting with `#?` or `#?@`.
Every Clojure platform has a well-known "platform feature" - `:clj`, `:cljs`, `:cljr`. Each condition in a reader conditional is checked in order until a feature matching the platform feature is found. The reader conditional will read and return that feature’s expression. 
```clojure
#?(:clj     Double/NaN
   :cljs    js/NaN
   :default nil)
```
The syntax for `#?@` is exactly the same but the expression is expected to return a collection that can be spliced into the surrounding context, similar to unquote-splicing in syntax quote.
```clojure
[1 2 #?@(:clj [3 4] :cljs [5 6])]
;; in clj =>        [1 2 3 4]
;; in cljs =>       [1 2 5 6]
;; anywhere else => [1 2]
```

# The REPL and main

- The `clojure.main` namespace
- clojure.main --help
- Launching a REPL
- Launching a Script
- Passing arguments to a Script
- Error printing
  - At REPL
  - As launcher
- The `user` namespace
- Loading of `user.clj`
- Adding libraries for interactive use
- tap: tap is a shared, globally accessible system for distributing a series of informational or diagnostic values to a set of (presumably effectful) handler functions. It can be used as a better debug prn, or for facilities like logging etc.
- Launching a Socket Server
- Related functions

## Launching a REPL

```shell
$ clj
user=>
```

The REPL prompt shows the name of the current namespace (`*ns*`), which defaults to `user`.

Several special vars are available when using the REPL:
- `*1`, `*2`, `*3` - hold the result of the last three expressions that were evaluated
- `*e` - holds the result of the last exception.

The `clojure.repl` namespace has a number of useful functions for inspecting the source and documentation of available functions:
- `doc` - prints the docstring for a var given its name
- `find-doc` - prints the docstring for any var whose doc or name matches the pattern
- `apropos` - returns a seq of definitions matching a regex
- `source` - prints the source for a symbol
- `pst` - print stack trace for a given exception or *e by default

## Launching a Script
```shell
clj -M /path/to/myscript.clj
```
## Passing arguments to a Script
```shell
clj -M /path/to/myscript.clj arg1 arg2 arg3
```
```clojure
; bound to var *command-line-args*
*command-line-args* => ("arg1" "arg2" "arg3")
```

## The `user` namespace

The Clojure REPL automatically loads the following namespaces and refers the following functions:
- `clojure.repl`: `source` `apropos` `dir` `pst` `doc` `find-doc`
- `clojure.repl.deps`: `add-lib` `add-libs` `sync-deps`
- `clojure.java.javadoc`: `javadoc`
- `clojure.pprint`: `pp` `pprint`

If you switch to a different namespace (with `in-ns` or `ns`), these functions will not be available unless referred there explicitly.

## Loading of `user.clj`

## Adding libraries for interactive use

## tap

## Launching a Socket Server

## Related functions

# Evaluation/求值
# Special Forms/特殊形式

regular expression syntax: `?` (optional), `*` (0 or more), and `+` (1 or more).

- `(def symbol doc-string? init?)`
- `(if test then else?)`
- `(do expr*)`: Evaluates the expressions `exprs` in order and returns the value of the last. If no expressions are supplied, returns `nil`.
- `(let [ binding* ] expr*)`: Evaluates the expressions `exprs` in a lexical context in which the symbols in the `binding-forms` are bound to their respective `init-exprs` or parts therein. 
  - The bindings are sequential, so each binding can see the prior bindings. 
  - The `exprs` are contained in an implicit `do`. 
  - If a `binding` symbol is annotated with a metadata tag, the compiler will try to resolve the tag to a class name and presume that type in subsequent references to the `binding`.
  - If the `binding` symbol `:tag` metadata is a Java interface annotated as a `FunctionalInterface`, the `init-expr` will be coerced (if necessary) to the specified interface.
  - Locals created with `let` are not variables. Once created their values never change!
```
binding ⇒ binding-form init-expr
```
- `(quote form)`: Yields the unevaluated `form`
- `(var symbol)`: The `symbol` must resolve to a var, and the Var object itself (not its value) is returned. The reader macro `#'x` expands to `(var x)`.
- `(fn name? [params* ] expr*)`, `(fn name? ([params* ] expr*)+)`: Defines a function (`fn`)
  - The first form defines a fn with a single invoke method. 
  - The second defines a fn with one or more overloaded invoke methods. The arities of the overloads must be distinct
```
params ⇒ positional-param* , or positional-param* & rest-param
positional-param ⇒ binding-form
rest-param ⇒ binding-form
name ⇒ symbol
```

- `(fn name? [param* ] condition-map? expr*)`, `(fn name? ([param* ] condition-map? expr*)+)`
  - The `condition-map` parameter may be used to specify **pre- and post-conditions** for a function. The condition map may also be provided as **metadata of the arglist**.
  - `pre-expr` and `post-expr` are boolean expressions that may refer to the parameters of the function. In addition, `%` may be used in a `post-expr` to refer to the function’s return value. 
  - If any of the conditions evaluate to `false` and `*assert*` is `true`, a `java.lang.AssertionError` exception is thrown.
```clojure
{:pre [pre-expr*]
 :post [post-expr*]}
```
- `(loop [binding* ] expr*)`
- `(recur expr*)`
- `(throw expr)`
- `(try expr* catch-clause* finally-clause?)`
- `(monitor-enter expr)`
- `(monitor-exit expr)`
- Other Special Forms
- Binding Forms (Destructuring)
  - Sequential destructuring
  - Associative destructuring
  - Keyword Arguments
  - Nested destructuring


# Macros/宏
# Other Functions
# Data Structures
# Datatypes/数据类型
# Sequences
# Transients/瞬态
# Transducers/转换器
# Multimethods/多方法 and Hierarchies
# Protocols/协议
# Metadata/元数据
# Namespaces/命名空间

Related functions
- Creating and switching to a namespace: `in-ns` `ns` `create-ns`
- Adding to a namespace: `alias` `def` `import` `intern` `refer`
- Finding what namespaces exist: `all-ns` `find-ns`
- Examining a namespace: `ns-name` `ns-aliases` `ns-imports` `ns-interns` `ns-map` `ns-publics` `ns-refers`
- Getting a namespace from a symbol: `resolve` `ns-resolve` `namespace`
- Removing things: `ns-unalias` `ns-unmap` `remove-ns`

# Libs
# Vars/变数 and Environments/环境
# Refs/引用 and Transactions/事务
# Agents/代理
# Atoms/原子
# Reducers/规约器
# Java Interop
# Compilation and Class Generation
# Other Libraries
# Differences with Lisps

# Clojure CLI
> The Clojure CLI is a command-line tool to run Clojure programs on the Java Virtual Machine. The Clojure CLI uses `deps.edn` files to configure and download program dependencies to include on the JVM classpath.

The CLI is invoked via either `clojure` or `clj`: `clj` includes `rlwrap` for extended keyboard editing, particularly useful with the REPL.

```shell
## Start a REPL (default):
clj [clj-opts] [-Aaliases]

## Execute a function (-X):
clojure [clj-opts] -X[aliases] my/fn? [kpath v …​] kv-map?

## Run a tool (-T):
clojure [clj-opts] -T[name|aliases] my/fn [kpath v …​] kv-map?

## Run a main namespace or script (-M):
clojure [clj-opts] -M[aliases] [init-opts] [main-opts] [args]
```

## Options
## Aliases
## Dependencies
## Classpath
## JVM properties
## CLI command
## Programs
## Tools

A tool is **a collection of functions delivered in a lib**. Tool functions are run in a separate process with their own classpath, independent of the project classpath. Tool functions take a single map argument and are invoked with `-T`.

```shell
$ clj -Ttools list
Cloning: https://github.com/clojure/tools.tools.git
Checking out: https://github.com/clojure/tools.tools.git at 0e9e6c8b409ac916ad6f2ec5bc075bbcb09545c0
Downloading: org/clojure/tools.deps/0.21.1449/tools.deps-0.21.1449.pom from central
Downloading: org/clojure/tools.gitlibs/2.5.197/tools.gitlibs-2.5.197.pom from central
Downloading: org/clojure/pom.contrib/1.1.0/pom.contrib-1.1.0.pom from central
Downloading: org/clojure/data.xml/0.2.0-alpha9/data.xml-0.2.0-alpha9.pom from central
Downloading: com/cognitect/aws/s3/868.2.1580.0/s3-868.2.1580.0.pom from central
Downloading: org/eclipse/jetty/jetty-client/9.4.53.v20231009/jetty-client-9.4.53.v20231009.pom from central
Downloading: com/cognitect/aws/endpoints/1.1.12.718/endpoints-1.1.12.718.pom from central
Downloading: org/eclipse/jetty/jetty-http/9.4.53.v20231009/jetty-http-9.4.53.v20231009.pom from central
Downloading: com/cognitect/aws/api/0.8.692/api-0.8.692.pom from central
Downloading: org/clojure/tools.cli/1.1.230/tools.cli-1.1.230.pom from central
Downloading: org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.pom from central
Downloading: org/eclipse/jetty/jetty-project/9.4.53.v20231009/jetty-project-9.4.53.v20231009.pom from central
Downloading: org/apache/commons/commons-parent/52/commons-parent-52.pom from central
Downloading: org/junit/junit-bom/5.9.1/junit-bom-5.9.1.pom from central
Downloading: org/junit/junit-bom/5.7.1/junit-bom-5.7.1.pom from central
Downloading: org/clojure/data.json/2.5.0/data.json-2.5.0.pom from central
Downloading: org/clojure/tools.logging/1.2.4/tools.logging-1.2.4.pom from central
Downloading: org/clojure/core.async/1.6.681/core.async-1.6.681.pom from central
Downloading: org/testcontainers/testcontainers-bom/1.16.1/testcontainers-bom-1.16.1.pom from central
Downloading: org/infinispan/infinispan-bom/11.0.17.Final/infinispan-bom-11.0.17.Final.pom from central
Downloading: org/infinispan/infinispan-build-configuration-parent/11.0.17.Final/infinispan-build-configuration-parent-11.0.17.Final.pom from central
Downloading: org/clojure/tools.analyzer.jvm/1.2.3/tools.analyzer.jvm-1.2.3.pom from central
Downloading: org/eclipse/jetty/jetty-io/9.4.53.v20231009/jetty-io-9.4.53.v20231009.pom from central
Downloading: org/eclipse/jetty/jetty-util/9.4.53.v20231009/jetty-util-9.4.53.v20231009.pom from central
Downloading: org/clojure/core.memoize/1.0.253/core.memoize-1.0.253.pom from central
Downloading: org/clojure/tools.reader/1.3.6/tools.reader-1.3.6.pom from central
Downloading: org/clojure/tools.analyzer/1.1.1/tools.analyzer-1.1.1.pom from central
Downloading: org/clojure/core.cache/1.0.225/core.cache-1.0.225.pom from central
Downloading: org/clojure/data.priority-map/1.1.0/data.priority-map-1.1.0.pom from central

Downloading: org/eclipse/jetty/jetty-io/9.4.53.v20231009/jetty-io-9.4.53.v20231009.jar from central
Downloading: org/clojure/tools.gitlibs/2.5.197/tools.gitlibs-2.5.197.jar from central
Downloading: org/eclipse/jetty/jetty-client/9.4.53.v20231009/jetty-client-9.4.53.v20231009.jar from central
Downloading: org/clojure/data.json/2.5.0/data.json-2.5.0.jar from central
Downloading: org/eclipse/jetty/jetty-util/9.4.53.v20231009/jetty-util-9.4.53.v20231009.jar from central
Downloading: org/clojure/data.xml/0.2.0-alpha9/data.xml-0.2.0-alpha9.jar from central
Downloading: org/clojure/tools.deps/0.21.1449/tools.deps-0.21.1449.jar from central
Downloading: org/clojure/tools.analyzer.jvm/1.2.3/tools.analyzer.jvm-1.2.3.jar from central
Downloading: org/clojure/core.cache/1.0.225/core.cache-1.0.225.jar from central
Downloading: org/clojure/tools.logging/1.2.4/tools.logging-1.2.4.jar from central
Downloading: org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar from central
Downloading: org/clojure/core.async/1.6.681/core.async-1.6.681.jar from central
Downloading: com/cognitect/aws/endpoints/1.1.12.718/endpoints-1.1.12.718.jar from central
Downloading: org/clojure/tools.analyzer/1.1.1/tools.analyzer-1.1.1.jar from central
Downloading: org/clojure/tools.cli/1.1.230/tools.cli-1.1.230.jar from central
Downloading: org/eclipse/jetty/jetty-http/9.4.53.v20231009/jetty-http-9.4.53.v20231009.jar from central
Downloading: com/cognitect/aws/s3/868.2.1580.0/s3-868.2.1580.0.jar from central
Downloading: com/cognitect/aws/api/0.8.692/api-0.8.692.jar from central
Downloading: org/clojure/core.memoize/1.0.253/core.memoize-1.0.253.jar from central
Downloading: org/clojure/tools.reader/1.3.6/tools.reader-1.3.6.jar from central
Downloading: org/clojure/data.priority-map/1.1.0/data.priority-map-1.1.0.jar from central
TOOL   LIB                            TYPE  VERSION
tools  io.github.clojure/tools.tools  :git  v0.3.4

# https://github.com/clojure/tools.deps.graph
$ clj -Ttools install-latest :lib io.github.clojure/tools.deps.graph :as tools.deps.graph
$ clj -Ttools show :tool tools.deps.graph
{:lib io.github.clojure/tools.deps.graph,
 :coord {:git/tag "v1.1.90", :git/sha "f8fb16e"}}
Default namespace:  clojure.tools.deps.graph
# Show dependency graph for current project
$ clj -Ttools.deps.graph graph
```

## Procurers/采购员

Dependency coordinates are interpreted by procurers, which understand a particular coordinate type and know how to find dependencies and download artifacts for a library. The Clojure CLI currently suports the folllowing procurers: **Maven**, **Git**, and **local** (which includes both directories and jars). The underlying tools.deps library supports procurer extensions when used as a library.

# deps.edn