# Clojure Reference
* https://clojure.org/reference/reader

# The Reader

## Reader forms

- Symbols
  - alphanumeric characters, `*`, `+`, `!`, `-`, `_`, `'`, `?`, `<`, `>`
  - `/`, `.`, `:`
- Literals
  - strings
  - numbers: integer, floating point number, ratio
  - characters: ex `\c`
  - `nil`
  - booleans
  - symbolic values
  - keywords
- Lists: ex `(a b c)`
- Vectors: ex `[1 2 3]`
- Maps: ex `{:a 1 :b 2}`
  - map namespace syntax
- Sets: ex `#{:a :b :c}`
- `deftype`, `defrecord` constructor calls

## Macro characters/宏字符

The behavior of the reader is driven by a combination of built-in constructs and an extension system called the **read table/读取器表**.
Entries in the read table provide mappings from certain characters, called **macro characters/宏字符**, to specific reading behavior, called **reader macros/读取器宏**.
Unless indicated otherwise, macro characters cannot be used in user symbols.

- Quote (`'`)
- Character (`\`)
- Comment (`;`)
- Deref (`@`)
- Metadata (`^`)
- Dispatch (`#`)
  - `#{}`: set
  - `#"pattern"`: regex pattern
  - `#'`: var quote
  - `#()`: anonymous function literal
  - `#_`: ignore next form
- Syntax-quote (``` ` ```, the "backquote" character), Unquote (`~`) and Unquote-splicing (`~@`)

## extensible data notation (edn)

Clojure’s reader supports a superset of extensible data notation (edn).

## Tagged Literals/标记的字面量

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

## Reader Conditionals/条件句

Clojure 1.7 introduced a new extension (`.cljc`) for portable files that can be loaded by multiple Clojure platforms.
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

- The `clojure.main` namespace: provides functions that allow Clojure programs and interactive sessions to be launched via Java’s application launcher tool `java`.
- clojure.main --help
- Launching a REPL: `clj`
- Launching a Script: `clj -M /path/to/myscript.clj`
- Passing arguments to a Script: `clj -M /path/to/myscript.clj arg1 arg2 arg3`, `*command-line-args*`
- Error printing
  - At REPL
  - As launcher
- The `user` namespace
- Loading of `user.clj`
- Adding libraries for interactive use
- tap: tap is a shared, globally accessible system for distributing a series of informational or diagnostic values to a set of (presumably effectful) handler functions. It can be used as a better debug prn, or for facilities like logging etc.
- Launching a Socket Server
- Related functions

## Error printing

As of Clojure 1.10, Clojure errors categorized into one of several phases:

- `:read-source`: an error thrown while reading characters at the REPL or from a source file.
- `:macro-syntax-check`: a syntax error found in the syntax of a macro call, either from spec or from a macro throwing IllegalArgumentException, IllegalStateException, or ExceptionInfo.
- `:macroexpansion`: all other errors thrown during macro evaluation are categorized as macroexpansion errors.
- `:compile-syntax-check`: a syntax error caught during compilation.
- `:compilation`: non-syntax errors caught during compilation.
- `:execution`: any errors thrown at execution time.
- `:read-eval-result`: any error thrown while reading the result of execution (only applicable for REPLs that read the result).
- `:print-eval-result`: any error thrown while printing the result of execution.

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

The Clojure runtime will look for and load `user.clj` on runtime startup, if it is found on the classpath. This is a facility designed to provide development-time facilities, and generally not recommended in production use.

Because the `user.clj` file is loaded by the Clojure runtime on initialization, this typically happens before the main namespace in an application executes.

## Adding libraries for interactive use

The Clojure CLI can be used to declare dependencies loaded at REPL startup time. 

Since Clojure 1.12, you can also dynamically load libraries at the REPL for interactive use. These functions are available in the clojure.repl.deps namespace:
- `add-lib` takes a lib that is not available on the classpath, and makes it available by downloading (if necessary) and adding to the classloader. Libs already on the classpath are not updated. If the coordinate is not provided, the newest Maven version or git tag (if the library has an inferred git repo name) are used.
- `add-libs` is like `add-lib`, but resolves a set of new libraries and versions together.
- `sync-deps` calls `add-libs` with any libs present in `deps.edn`, but not yet present on the classpath.

## tap

tap is a shared, globally accessible system for distributing a series of **informational or diagnostic values** to a set of (presumably effectful) handler functions. It can be used as a better debug `prn`, or for facilities like logging etc.

- `add-tap`
- `tap>`
- `remove-tap`

## Launching a Socket Server

The Clojure runtime now has the ability to start a socket server at initialization based on system properties. One expected use for this is serving a socket-based REPL, but it also has many other potential uses for dynamically adding server capability to existing programs without code changes.

```shell
clj -J-Dclojure.server.repl="{:port 5555 :accept clojure.core.server/repl}"

$ telnet 127.0.0.1 5555
user=> (println "hello")
hello
user=> :repl/quit
```

## Related functions

- Main entry point: `clojure.main/main`
- Reusable REPL: `clojure.main/repl`
- Error handling: `clojure.main/ex-triage` `clojure.main/ex-str`
- Allowing set! for the customary REPL vars: `clojure.main/with-bindings`
- Socket server control: `clojure.core.server/start-server` `clojure.core.server/stop-server` `clojure.core.server/stop-servers`
- Socket repl: `clojure.core.server/repl`

# Evaluation/求值

Evaluation can occur in many contexts:
- Interactively, in the REPL
- On a sequence of forms read from a stream, via `load` / `load-file` / `load-reader` / `load-string`
- Programmatically, via `eval`

Clojure programs are composed of expressions.
- Strings, numbers, characters, `true`, `false`, `nil` and keywords evaluate to themselves.
- Symbol: namespace-qualified, package-qualified, not qualified, metadata...
- Vectors, Sets and Maps yield vectors and (hash) sets and maps whose contents are the evaluated values of the objects they contain. 
- An empty list `()` evaluates to an empty list.
- Non-empty Lists are considered calls to either special forms/特殊形式, macros/宏, or functions/函数. A call has the form `(operator operands*)`.
  - Special forms are primitives built-in to Clojure that perform core operations.
  - Macros are functions that manipulate forms, allowing for syntactic abstraction.
  - If the operator is not a special form or macro, the call is considered a function call.
- Any object other than those discussed above will evaluate to itself.

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
  - Java Interop: dot `.`, `new`, `set!`
  - Vars: `set!` of vars
- Binding Forms (Destructuring)
  - Sequential destructuring: `[]`
  - Associative destructuring: `{}`
  - Keyword Arguments: `:keys`, `:as`, `:or`
  - Nested destructuring

# Macros/宏

Clojure has a programmatic macro system which allows the compiler to be extended by user code. 
Macros can be used to define syntactic constructs which would require primitives or built-in support in other languages.

- Some macros produce simple combinations of primitive forms. For example, `when` combines `if` and `do`. - `macroexpand`
- Other macros re-arrange forms in useful ways, like the `->` macro, which recursively inserts each expression as the first argument of the next expression.

Two special variables are available inside defmacro for more advanced usages:
- `&form`: the actual form (as data) that is being invoked
- `&env`: a map of local bindings at the point of macro expansion. The env map is from symbols to objects holding compiler information about that binding.

Macros
- Creating macros/创建宏: `defmacro` `definline` `macroexpand-1` `macroexpand`
- Branching/分支: `and` `or` `when` `when-not` `when-let` `when-first` `if-not` `if-let` `cond` `condp`
- Looping/循环: `for` `doseq` `dotimes` `while`
- Working with vars/处理var: `ns` `declare` `defn` `defmacro` `definline` `defmethod` `defmulti` `defn-` `defonce` `defstruct`
- Arranging code differently/编排代码: `..` `doto` `->`
- Dynamic scopes/动态作用域: `binding` `locking` `time` `with-in-str` `with-local-vars` `with-open` `with-out-str` `with-precision`
- Creating lazy things/惰性: `lazy-seq` `lazy-cat` `delay`
- Java interop macros/Java互操作: `..` `amap` `areduce` `gen-class` `gen-interface` `proxy` `proxy-super` `memfn`
- Documenting code/代码文档: `assert` `comment` `doc`
- Transactions/事务: `dosync` `io!`
- A few special forms are actually implemented as macros/用宏实现的特殊形式, primarily to provide destructuring: `fn` `let` `loop`

# Other Useful Functions and Macros

## Creating functions
- `fn`: `(map (fn [x] (+ 2 x)) [1 2 3]) ; (3 4 5)`
- `#()` reader macro: `(map #(+ 2 %) [1 2 3]) ; (3 4 5)`
- `partial`: `(map (partial + 2) [1 2 3]) ; (3 4 5)`
- `comp`: `(map (comp - *) [2 4 6] [1 2 3]) ; (-2 -8 -18)`
- `complement`: `(map (complement zero?) [3 2 1 0]) ; (true true true false)`
- `constantly`: `(map (constantly 9) [1 2 3]) ; (9 9 9)`

## Printing

vars:
- `*out*`
- `*print-readably*`: default `true`
- `*print-meta*`: default `nil`

Print to `*out*`: `pr` `prn` `print` `println` `newline`

Print to string: `pr-str` `prn-str` `print-str` `println-str` `with-out-str`

## Regex Support

Regex patterns can be compiled at read-time via the `#"pattern"` reader macro, or at run time with `re-pattern`. 
Both forms produce `java.util.regex.Pattern` objects.

functions: `re-matcher` `re-find` `re-matches` `re-groups` `re-seq`

# Data Structures/数据结构

Clojure has a rich set of data structures. They share a set of properties:
- They are immutable/不变的
- They are read-able/可读的
- They support proper value equality semantics/恰当的值等价语义 in their implementation of equals
- They provide good hash values/哈希值
- In addition, the collections:
  - Are manipulated via interfaces/通过接口操作
  - Support sequencing/序列化
  - Support persistent manipulation/持久的操作
  - Support metadata/元数据
  - Implement `java.lang.Iterable`/可迭代的
  - Implement the non-optional (read-only) portion of `java.util.Collection` or `java.util.Map`/集合和映射

## `nil`
## Numbers
- longs
- ratio
- contagion/传染性
- `BigInt`, `BigDecimal` literal: postfix `N` `M`

functions
- Computation: `+ - * / inc dec quot rem min max`
- Auto-promoting computation: `+' -' *' inc' dec'`
- Comparison: `== < <= > >= zero? pos? neg?`
- Bitwise operations: `bit-and bit-or bit-xor bit-not bit-shift-right bit-shift-left`
- Ratios: `numerator denominator`
- Coercions: `int bigdec bigint double float long num short`

## Strings

functions
- `str string? pr-str prn-str print-str println-str with-out-str`

## Characters

functions
- `char char-name-string char-escape-string`

## Keywords

functions
- `keyword keyword?`

## Symbols

functions
- `symbol symbol? gensym` (see also the `#`-suffix reader macro)

## Collections

All of the Clojure collections are immutable and persistent. 

## Lists (`IPersistentList`)

functions
- Create a list: `list list*`
- Treat a list like a stack: `peek pop`
- Examine a list: `list?`

## Vectors (`IPersistentVector`)

functions
- Create a vector: `vector vec vector-of`
- Examine a vector: `get nth peek rseq vector?`
- 'change' a vector: `assoc pop subvec replace`

## Maps (`IPersistentMap`)

functions
- Create a new map: `hash-map sorted-map sorted-map-by`
- 'change' a map: `assoc dissoc select-keys merge merge-with zipmap`
- Examine a map: `get contains? find keys vals map?`
- Examine a map entry: `key val`

## StructMaps

Most uses of StructMaps would now be better served by **records**.

functions
- StructMap setup: `create-struct defstruct accessor`
- Create individual struct: `struct-map struct`

## ArrayMaps

it is simply implemented as an array of key val key val…​

functions
- create array map: `array-map`

## Sets

functions
- create sets: `hash-set sorted-set`
- get a set of values from collection: `set`
- manipulate set: `disj contains? get`
- set operation: `union difference intersection`
- relation algrbra: `select index rename join`

# Datatypes/数据类型

## Basics

The datatype features - `deftype` , `defrecord` and `reify` , provide the mechanism for defining implementations of abstractions/定义抽象的实现, and in the case of `reify`, instances of those implementations/实现的示例.
The abstractions themselves are defined by either **protocols/协议** or **interfaces/接口**.
A datatype provides a host type/宿主机类型, (named in the case of `deftype` and `defrecord`, anonymous in the case of `reify`), with some structure/接口 (explicit fields in the case of `deftype` and `defrecord`, implicit closure in the case of `reify`), and optional in-type implementations of abstraction methods/抽象方法的类型中实现.

## `deftype` and `defrecord`

`deftype` and `defrecord` dynamically generate compiled bytecode for a named class with a set of given fields, and, optionally, methods for one or more protocols and/or interfaces.

## Why have both `deftype` and `defrecord`?
## Datatypes and protocols are opinionated
## `reify`

While `deftype` and `defrecord` define named types, `reify` defines both an **anonymous type/匿名类型** and creates an instance of that type.

The method bodies of reify are lexical closures, and can refer to the surrounding local scope. 

`reify` differs from `proxy` in that:
- Only protocols or interfaces are supported, no concrete superclass.
- The method bodies are true methods of the resulting class, not external fns.
- Invocation of methods on the instance is direct, not using map lookup.
- No support for dynamic swapping of methods in the method map.

## Java annotation support

Types created with `deftype`, `defrecord`, and `definterface`, can emit classes that include Java annotations for Java interop. 
Annotations are described as **meta** on:
- Type name (`deftype/record/interface`) - class annotations
- Field names (`deftype/record`) - field annotations
- Method names (`deftype/record`) - method annotations

# Sequences/序列

## The Seq interface
```clojure
(first coll)
(rest coll)
(cons item seq)
```

## The Seq library

Seq in, Seq out
- Shorter seq from a longer seq: `distinct filter remove for keep keep-indexed`
- Longer seq from a shorter seq: `cons concat lazy-cat mapcat cycle interleave interpose`
- Seq with head-items missing: `rest next fnext nnext drop drop-while nthnext for`
- Seq with tail-items missing: `take take-nth take-while butlast drop-last for`
- Rearrangment of a seq: `flatten reverse sort sort-by shuffle`
- Create nested seqs: `split-at splitv-at split-with partition partition-all partition-by partitionv partitionv-all`
- Process each item of a seq to create a new seq: `map pmap mapcat for replace reductions map-indexed seque`

Using a seq
- Check if a coll can produce a seq: `seqable?`
- Extract a specific-numbered item from a seq: `first ffirst nfirst second nth when-first last rand-nth`
- Construct a collection from a seq: `zipmap into reduce set vec into-array to-array-2d frequencies group-by`
- Pass items of a seq as arguments to a function: `apply`
- Compute a boolean from a seq: `not-empty some reduce seq? every? not-every? not-any? empty?`
- Search a seq using a predicate: `some filter`
- Force evaluation of lazy seqs: `doseq dorun doall`
- Check if lazy seqs have been forcibly evaluated: `realized?`

Creating a seq
- Lazy seq from collection: `seq vals keys rseq subseq rsubseq`
- Lazy seq from producer function: `lazy-seq repeatedly iterate`
- Lazy seq from constant: `repeat range`
- Lazy seq from other objects: `line-seq resultset-seq re-seq tree-seq file-seq xml-seq iterator-seq enumeration-seq`

# Transients/瞬态

Transient data structures are always created from an existing persistent Clojure data structure. 
As of Clojure 1.1.0, vectors, hash-maps, and hash-sets are supported.
Note that not all Clojure data structures can support this feature, but most will. **Lists will not**, as there is no benefit to be had.
- You obtain a transient 'copy' of a data structure by calling `transient`.
- Transients support **the read-only interface of the source**, i.e. you can call `nth`, `get`, `count` and fn-call a transient vector, just like a persistent vector.
- Transients do **not** support **the persistent interface of the source data structure**. `assoc`, `conj` etc will all throw exceptions, because transients are not persistent.
- Transients support a parallel set of 'changing' operations, with similar names followed by `!` - `assoc!`, `conj!` etc.
- When you are finished building up your results, you can create a persistent data structure by calling `persistent!` on the transient. This operation is also O(1).

Transients require thread isolation.

# Transducers/转换器

Transducers are composable algorithmic transformations.

A **transducer** (sometimes referred to as **xform** or **xf**) is a transformation from one reducing function to another:
```clojure
;; reducing function signature
whatever, input -> whatever

;; transducer signature
(whatever, input -> whatever) -> (whatever, input -> whatever)
```

## Defining Transformations With Transducers
Most sequence functions included in Clojure have an arity that produces a transducer. This arity omits the input collection; the inputs will be supplied by the process applying the transducer.

The recommended way to compose transducers is with the existing `comp` function.
As a mnemonic, remember that the ordering of transducer functions in comp is the same order as sequence transformations in `->>`.

functions produce a transducer when the input collection is omitted: 
- `map cat mapcat filter remove take take-while take-nth drop drop-while replace partition-by partition-all keep keep-indexed map-indexed distinct interpose dedupe random-sample`

### Using Transducers
- `transduce`: analogous to the standard reduce function
- `eduction`: capture the process of applying a transducer to a coll
- `into`: apply a transducer to an input collection and construct a new output collection
- `sequence`: create a sequence from the application of a transducer to an input collection

## Creating Transducers

transducers shape:
```clojure
(fn [rf] ; rt for reducing function
      
  (fn ; Init
      ([] ...)
      ; Step
      ([result] ...)
      ; Completion
      ([result input] ...)))
```

Clojure has a mechanism for specifying early termination of a reduce:
- `reduced` - takes a value and returns a reduced value indicating reduction should stop
- `reduced?` - returns true if the value was created with reduced
- `deref` or `@` can be used to retrieve the value inside a reduced

## Creating Transducible Processes

# Multimethods/多方法 and Hierarchies

Clojure supports sophisticated runtime polymorphism/运行时多态 through **a multimethod system** that supports dispatching on types, values, attributes and metadata of, and relationships between, one or more arguments.

The multimethod system exposes this API: 
- `defmulti` creates new multimethods, 
- `defmethod` creates and installs a new method of multimethod associated with a dispatch-value, 
- `remove-method` removes the method associated with a dispatch-value and 
- `prefer-method` creates an ordering between methods when they would otherwise be ambiguous.

Derivation/派生 is determined by a combination of either Java inheritance (for class values), or using Clojure’s ad hoc hierarchy system. 
The hierarchy system supports derivation relationships between names (either symbols or keywords), and relationships between classes and names. 
- The `derive` function creates these relationships: `(derive child parent)`
- `parents` / `ancestors` / `descendants` and `isa?` let you query the hierarchy

## `isa?` based dispatch

Multimethods use `isa?` rather than `=` when testing for dispatch value matches.

`prefer-method`is used for disambiguating in case of multiple matches where neither dominates the other.

entire independent hierarchies can also be created with `make-hierarchy`.

# Protocols/协议

The **protocols** and **datatypes** features add powerful and flexible mechanisms for abstraction and data structure definition with no compromises vs the facilities of the host platform.

## Basics
A protocol is a named set of named methods and their signatures, defined using `defprotocol`.
- defprotocol will automatically generate a corresponding interface, with the same name as the protocol. The interface will have methods corresponding to the protocol functions, and the protocol will automatically work with instances of the interface.
- Note that you do not need to use this interface with `deftype`, `defrecord`, or `reify`, as they support protocols directly.

External implementations of the protocol can be provided using the `extend` construct.

Protocols are fully reified and support reflective capabilities via `extends?`, `extenders`, and `satisfies?`.
- Note the convenience macros `extend-type` and `extend-protocol`
- If you are providing external definitions inline, these will be more convenient than using `extend` directly

## Guidelines for extension

## Extend via metadata

As of Clojure 1.10, protocols can optionally elect to be extended via per-value metadata: `:extend-via-metadata true`.

# Metadata/元数据

Symbols and collections support metadata, a map of data about the symbol or collection. 
The metadata system allows for arbitrary annotation of data. 
It is used to convey information to the compiler about types, but can also be used by application developers for many purposes, annotating data sources, policy etc.

An important thing to understand about metadata is that it is **not** considered to be part of the value of an object. 
Two objects that differ only in metadata are equal.

```clojure
(meta obj)
(with-meta obj map)
*print-meta*
(vary-meta obj f & args)

(alter-meta! ref f & args)
(reset-meta! ref map)
```

## Metadata Reader

reader support (Metadata Reader `^`) for applying metadata to the expression following it at read-time.

See Java Interop 'Type Hints' and 'param-tags' for more information on how metadata is used by the compiler for method overload selection.

# Namespaces/命名空间

Namespaces are mappings from simple (unqualified) symbols to Vars and/or Classes. 
Vars can be interned in a namespace, using `def` or any of its variants, in which case they have a simple symbol for a name and a reference to their containing namespace, and the namespace maps that symbol to the same var. 
A namespace can also contain mappings from symbols to vars interned in other namespaces by using `refer` or `use`, or from symbols to Class objects by using `import`. 

Note that namespaces are first-class, they can be enumerated etc. 
Namespaces are also dynamic, they can be created, removed and modified at runtime, at the Repl etc.
- The best way to set up a new namespace at the top of a Clojure source file is to use the `ns` macro.
- At the Repl it’s best to use `in-ns`, in which case the new namespace will contain mappings only for the classnames in `java.lang`. In order to access the names from the `clojure.core` namespace you must execute `(clojure.core/refer 'clojure.core)`. The `user` namespace at the Repl has already done this.
- The current namespace, `*ns*` can and should be set only with a call to `in-ns` or the `ns` macro, both of which create the namespace if it doesn’t exist.

functions
- Creating and switching to a namespace: `in-ns` `ns` `create-ns`
- Adding to a namespace: `alias` `def` `import` `intern` `refer`
- Finding what namespaces exist: `all-ns` `find-ns`
- Examining a namespace: `ns-name` `ns-aliases` `ns-imports` `ns-interns` `ns-map` `ns-publics` `ns-refers`
- Getting a namespace from a symbol: `resolve` `ns-resolve` `namespace`
- Removing things: `ns-unalias` `ns-unmap` `remove-ns`

# Libs

Clojure provides for code loading and dependency tracking via its "lib" facility. 
A lib is a named unit of Clojure source code contained in a Java resource within classpath. 
A lib will typically provide the complete set of definitions that make up one Clojure namespace.

Clojure defines conventions for naming and structuring libs:
- A lib name is a symbol that will typically contain two or more parts separated by periods `.`.
- A lib’s container is a Java resource whose classpath-relative path is derived from the lib name:
  - The path is a string
  - Periods in the lib name are replaced by slashes `/` in the path
  - Hyphens `-` in the lib name are replaced by underscores `_` in the path
  - The path may end with ".class", ".clj", or ".cljc" (see Lib load order below)
- A lib begins with an "ns" form that
  - creates the Clojure namespace that shares its name, and
  - declares its dependencies on Java classes, Clojure’s core facilities, and/or other libs,
  - Clojure ensures that if the call to "ns" completes without throwing an exception, the declared dependencies have been satisfied and the capabilities they provide are available.

Example Lib
```clojure
(ns com.my-company.clojure.examples.my-utils
  (:import java.util.Date)
  (:use [clojure.string :only (join)])
  (:require [clojure.java.io :as jio]))
```

Prefix Lists
```clojure
(require 'clojure.contrib.def 'clojure.contrib.except 'clojure.contrib.sql)
(require '(clojure.contrib def except sql))
```

functions
- Creating a namespace: `ns`
- Ensuring a lib is loaded: `require` `use`
- Listing loaded libs: `loaded-libs`

Libs may exist in either compiled (`.class`) or source (`.clj` or `.cljc`) form.
The lib is loaded from one of them based on the following rules:
- A `.class` file is always preferred over a source file, unless the source file’s timestamp is newer than the `.class` file, in which case the source file is preferred.
- A `.clj` (platform-specific file) is always preferred over a `.cljc` (common across platforms).

# Vars/变数 and the Global Environments/环境

Vars provide a mechanism to refer to a mutable storage location that can be dynamically rebound (to a new storage location) on a per-thread basis/每线程的. 
Every Var can (but needn’t) have a **root binding/根绑定**, which is a binding that is shared by all threads that do not have a per-thread binding. Thus, the value of a Var is the value of its per-thread binding, or, if it is not bound in the thread requesting the value, the value of the root binding, if any.

The special form `def` creates (and interns) a Var. 
- If the Var did not already exist and no initial value is supplied, the var is **unbound/未绑定的**
- Supplying an initial value **binds the root/绑定根** (even if it was already bound).
- By default Vars are **static/静态的**, but Vars can be marked as **dynamic/动态的** to allow per-thread bindings via the macro binding: `^:dynamic`
- Bindings created with `binding` cannot be seen by any other thread.
- Likewise, bindings created with `binding` can be assigned to/赋值, which provides a means for a nested context/内嵌的上下文 to communicate with code before it is placed on the call stack. This capability is opt-in only by setting a metadata tag: `^:dynamic` to true.
- There are scenarios that one might wish to **redefine static Vars/重新定义静态var** within a context and Clojure (since version 1.3) provides the functions `with-redefs` and `with-redefs-fn` for such purposes.

Functions defined with `defn` are stored in Vars, allowing for the re-definition of functions in a running program/运行时重新定义函数.

functions
- Variants of `def`: `defn defn- definline defmacro defmethod defmulti defonce defstruct`
- Working with interned Vars: `declare intern binding find-var var`
- Working with Var objects: `with-local-vars var-get var-set alter-var-root var? with-redefs with-redefs-fn`
- Var validators: `set-validator! get-validator`
- Using Var metadata: `doc find-doc test`

## Binding conveyance/绑定输送

Binding conveyance allows the current set of dynamic bindings to be conveyed to another thread for the purpose of continuing work asynchronously with the same environment.
- `future`, `send`, `send-off`, and `pmap`.

## `(set! var-symbol expr)`

Assignment special form.

When the first operand is a symbol, it must resolve to a global var. 
The value of the var’s current thread binding is set to the value of `expr`. 
Currently, it is an error to attempt to set the root binding of a var using `set!`, i.e. var assignments are thread-local/var赋值是线程局部的. 
In all cases the value of `expr` is returned.

Note you cannot assign to function params or local bindings. Only Java fields, Vars, Refs and Agents are **mutable/可变的** in Clojure.

## Interning

## Non-interned Vars

## Var metadata

- `:doc`
- `:added`
- `:private`
- `:arglists`
- `:macro`
- `:tag`
- `:test`
- `:dynamic`
- `:refef`
- `:static`
- `:const`

Also see Compiler Options for more information about direct linking and metadata elision/省略 during compilation.

# Refs/引用 and Transactions/事务

While Vars ensure safe use of mutable storage locations via thread isolation, transactional references (Refs)/事务性引用 ensure safe shared use of mutable storage locations via a software transactional memory (STM) system/软件事务内存系统. 
Refs are bound to a single storage location for their lifetime, and only allow mutation of that location to occur within a transaction.

The Clojure STM uses multiversion concurrency control with adaptive history queues for snapshot isolation, and provides a distinct commute operation.

functions
- Create a Ref: `ref`
- Examine a Ref: `deref` (see also the `@` reader macro)
- Transaction macros: `dosync` `io!`
- Allowed only in a transaction: `ensure` `ref-set` `alter` `commute`
- Ref validators: `set-validator!` `get-validator`

# Agents/代理 and Asynchronous Actions/异步动作

Like Refs, Agents provide shared access to mutable state. Where Refs support coordinated, synchronous change of multiple locations, Agents provide **independent**, **asynchronous** change of **individual** locations. 
**Agents/代理** are bound to a single storage location for their lifetime, and only allow mutation of that location (to a new state) to occur as a result of an action. 
**Actions/动作** are functions (with, optionally, additional arguments) that are **asynchronously/一步的** applied to an Agent’s state/状态 and whose return value becomes the Agent’s new state.

Clojure’s Agents are **reactive/响应式的**, not autonomous - there is no imperative message loop and no blocking receive. 
The *state* of an Agent should be itself **immutable** (preferably an instance of one of Clojure’s persistent collections), and the state of an Agent is always **immediately available for reading by any thread** (using the deref function or reader macro @) without any messages, i.e. observation does not require cooperation or coordination.

semantics of action:
Agent action dispatches/动作分发 take the form `(send agent fn args*)`. 
`send` (and `send-off`) always returns immediately. 
At some point later, in another thread, the following will happen:
- The given `fn` will be applied to the *state* of the Agent and the `args`, if any were supplied.
- The return value of `fn` will be passed to the **validator** function, if one has been set on the Agent. See `set-validator!` for details.
- If the validator succeeds or if no validator was given, the return value of the given `fn` will become the new *state* of the Agent.
- If any **watchers** were added to the Agent, they will be called. See `add-watch` for details.
- If during the function execution any **other dispatches** are made (directly or indirectly), they will be **held** until after the *state* of the Agent has been changed/在状态修改完成之前持有内嵌动作分发.

exception handling:
If any exceptions/异常 are thrown by an action function, no nested dispatches will occur, and the exception will be cached in the Agent itself. 
When an Agent has errors cached, any subsequent interactions will immediately throw an exception, until the agent’s errors are cleared. 
Agent errors can be examined with `agent-error` and the agent restarted with `restart-agent`.

orders of actions:
The actions of all Agents get interleaved amongst threads in a thread pool. 
At any point in time, at most one action for each Agent is being executed. 
Actions dispatched to an agent from another single agent or thread will occur in the order they were sent, potentially interleaved with actions dispatched to the same agent from other sources. 
`send` should be used for actions that are CPU limited, while `send-off` is appropriate for actions that may block on IO.

Agents are integrated with the STM/集成了STM - any dispatches made in a transaction are held until it commits, and are discarded if it is retried or aborted.
As with all of Clojure’s concurrency support, no user-code locking is involved.

Note that use of Agents **starts a pool of non-daemon background threads** that will prevent shutdown of the JVM. 
Use `shutdown-agents` to terminate these threads and allow shutdown.

functions
- Create an Agent: `agent`
- Examine an Agent: `deref` (see also the `@` reader macro) `agent-error` `error-handler` `error-mode`
- Change Agent state: `send` `send-off` `restart-agent`
- Block waiting for an Agent: `await` `await-for`
- Ref validators: `set-validator!` `get-validator`
- Watchers: `add-watch` `remove-watch`
- Agent thread management: `shutdown-agents`
- Agent error management: `agent-error` `restart-agent` `set-error-handler!` `error-handler` `set-error-mode!` `error-mode`

# Atoms/原子

Atoms provide a way to manage shared, synchronous, independent state. They are a reference type like refs and vars. 
You create an atom with `atom`, and can access its state with `deref`/`@`. 
Like refs and agents, atoms support validators. 
To change the value of an atom, you can use `swap!`. A lower-level `compare-and-set!` is also provided. 

Changes to atoms are always free of race conditions.

functions
- Create an Atom: `atom`
- Examine an Atom: `deref` (see also the `@` reader macro)
- Change Atom state: `swap!` `reset!` `swap-vals!` `reset-vals!`
- Validators: `set-validator!` `get-validator`
- Watchers: `add-watch` `remove-watch`

# Reducers/规约器

Reducers provide an alternative approach to using sequences to manipulate standard Clojure collections.

A **reducer** is the combination of a **reducible collection/可规约的集合** (a collection that knows how to reduce itself) with a **reducing function/规约函数** (the "recipe" for what needs to be done during the reduction). 
The standard sequence operations are replaced with new versions that do not perform the operation but merely transform the reducing function. 
Execution of the operations is deferred until the final reduction is performed/最终的规约执行时才开始执行操作. This removes the intermediate results and lazy evaluation seen with sequences.

Additionally, some collections (persistent vectors and maps) are **foldable**. The fold operation on a reducer executes the reduction in **parallel** by:
- Partitioning the reducible collection at a specified granularity (default = 512 elements)
- Applying reduce to each partition
- Recursively combining each partition using Java’s fork/join framework.

If a collection does not support folding, it will fall back to non-parallel reduce instead.

```clojure
(require '[clojure.core.reducers :as r])

(r/reduce f coll)
(r/reduce f init coll)

(r/fold reducef coll)
(r/fold combinef reducef coll)
(r/fold n combinef reducef coll)
```

Use the reducer form of these operations for:
- Efficient eager application of a multi-step transformation
- Avoiding the dangling I/O resource issues (as seen with lazy seqs)

Use `fold` when:
- Source data can be generated and held in memory
- Work to be performed is computation (not I/O or blocking)
- Number of data items or work to be done is "large"

# Java Interop

## Class access
```clojure
Classname
Classname$InnerClass

; added in 1.12: array class, 1-9
Classname/N
primitive/N
```

## Member access
```clojure
(.instanceMember instance args*)
(.instanceMember Classname args*)
(.-instanceField instance)
(Classname/staticMethod args*)
(Classname/.instanceMethod instance args*)
Classname/staticField
```

Method values: Since Clojure 1.12, programmers can use qualified methods as ordinary functions in value contexts - the compiler will automatically generate the wrapping function.

## The Dot special form
```clojure
; special form
(. instance-expr member-symbol)
(. Classname-symbol member-symbol)
(. instance-expr -field-symbol)
(. instance-expr (method-symbol args*))
; or
(. instance-expr method-symbol args*)
(. Classname-symbol (method-symbol args*))
; or
(. Classname-symbol method-symbol args*)
```

```clojure
; macro
(.. instance-expr member+)
(.. Classname-symbol member+)
; member ⇒ fieldName-symbol or (instanceMethodName-symbol args*)

; example
(.. System (getProperties) (get "os.name"))
; expand to
(. (. System (getProperties)) (get "os.name"))
; ->
(-> (System/getProperties) (.get "os.name"))
```

```clojure
; macro
(doto instance-expr (instanceMethodName-symbol args*)*)
```

```clojure
; special form
(Classname. args*)
(Classname/new args*)
(new Classname args*)

(instance? Class expr)

; assignment special form
(set! (. instance-expr instanceFieldName-symbol) expr)
(set! (. Classname-symbol staticFieldName-symbol) expr)

; macro
(memfn method-name arg-names*)

(bean obj)
```


## Support for Java in Clojure Library Functions

Many of the Clojure library functions have defined semantics for objects of Java types. 
- `contains?` and `get` work on Java Maps, arrays, Strings, the latter two with integer keys. 
- `count` works on Java Strings, Collections and arrays. 
- `nth` works on Java Strings, Lists and arrays. 
- `seq` works on Java reference arrays, Iterables and Strings. 
- Since much of the rest of the library is built upon these functions, there is great support for using Java objects in Clojure algorithms.

## Implementing Interfaces and Extending Classes
```clojure
; macro
(proxy [class-and-interfaces] [args] fs+)
; class-and-interfaces - a vector of class names
; args - a (possibly empty) vector of arguments to the superclass constructor.
; f ⇒ (name [params*] body) or (name ([params*] body) ([params+] body) …​)
```
## Arrays

functions
- Create array from existing collection:` aclone amap to-array to-array-2d into-array`
- Multi-dimensional array support: `aget aset to-array-2d make-array`
- Type-specific array constructors: `boolean-array byte-array char-array double-array float-array int-array long-array object-array short-array`
- Primitive array casts: `booleans bytes chars doubles floats ints longs shorts`
- Mutate an array: `aset`
- Process an existing array: `aget alength amap areduce`

## Type Hints

Clojure supports the use of type hints to assist the compiler in avoiding reflection in performance-critical areas of code. 
Type hints are **metadata tags** placed on symbols or expressions that are consumed by the compiler. 
They can be placed on function parameters, let-bound names, var names (when defined), and expressions.
```clojure
; function parameters
(defn len [^String x]
  (.length x))

; function return value
(defn hinted-single ^String [])
(defn hinted
  (^String [])
  (^Integer [a])
  (^java.util.List [a & args]))
```

## Aliases
Clojure provides aliases for primitive Java types and arrays which do not have typical representations as Java class names.

```clojure
int ints 
long longs
float floats
double doubles
void                  ; void return
short shorts
boolean booleans
byte bytes
char chars
objects               ; object array
```

## param-tags

Since Clojure 1.12, developers can supply `:param-tags` metadata on qualified methods to specify the signature of a single desired method, 'resolving' it.
The `:param-tags` metadata is a vector of zero or more tags: `[…​ tag …​]`. 
A tag is any existing valid `:tag` metadata value as described above. 
Each tag corresponds to a parameter in the desired signature (arity should match the number of tags).
Parameters with non-overloaded types can use the placeholder `_` in lieu of the tag. 
When you supply `:param-tags` metadata on a qualified method, the metadata must allow the compiler to resolve it to a single method at compile time.

A new metadata reader syntax `^[ …​ ]` attaches `:param-tags` metadata to member symbols, just as `^tag` attaches `:tag` metadata to a symbol.

## Support for Java Primitives

Clojure has support for high-performance manipulation of, and arithmetic involving, Java primitive types in local contexts. 
All Java primitive types are supported: int, float, long, double, boolean, char, short, and byte.

## Coercions

Primitive coercions: These coercion functions yield a value of the indicated type as long as such a coercion is possible: `bigdec bigint boolean byte char double float int long num short`.

Functional Interface Conversion
- Clojure developers can invoke Java methods taking Functional Interfaces by passing functions with matching arity. The Clojure compiler implicitly converts functions to the required Functional Interface by constructing a lambda adapter. 
- You can explicitly coerce a function to a Functional Interface by hinting the binding name in a `let` binding, e.g. to avoid repeated adapter construction in a loop, e.g. `(let [^java.util.function.Predicate p even?] …​)`.
- Since Clojure 1.12, all `IDeref` impls (`delay`, `future`, `atom`, etc) implement the `Supplier` interface directly.

## Some optimization tips


## Java Stream Support

Clojure provides functions (since 1.12) to interoperate with streams in an idiomatic manner, all functions behave analogously to their Clojure counterparts:
```clojure
(stream-seq! stream) ⇒ seq
(stream-reduce! f [init-val] stream) ⇒ val
(stream-transduce! xf f [init-val] stream) ⇒ val
(stream-into! to-coll [xf] stream) ⇒ to-coll
```

All of these operations are terminal stream operations (they consume the stream).

## Simple XML Support
```clojure
(clojure.xml/parse "/Users/rich/dev/clojure/build.xml")
```

## Calling Clojure From Java

The `clojure.java.api` package provides a minimal interface to bootstrap Clojure access from other JVM languages. It does this by providing:
- The ability to use Clojure’s namespaces to locate an arbitrary var, returning the var’s `clojure.lang.IFn` interface.
- A convenience method read for reading data using Clojure’s edn reader

```java
// call a function
IFn plus = Clojure.var("clojure.core", "+");
plus.invoke(1, 2);

// load other namespace
IFn require = Clojure.var("clojure.core", "require");
require.invoke(Clojure.read("clojure.set"));

// HOF
IFn map = Clojure.var("clojure.core", "map");
IFn inc = Clojure.var("clojure.core", "inc");
map.invoke(inc, Clojure.read("[1 2 3]"));

// non=function value
IFn printLength = Clojure.var("clojure.core", "*print-length*");
IFn deref = Clojure.var("clojure.core", "deref");
deref.invoke(printLength);
```

# Ahead-of-time Compilation and Class Generation

The Clojure compilation model preserves as much as possible the dynamic nature of Clojure, in spite of the code-reloading limitations of Java.
- Source and classfile pathing follows Java classpath conventions.
- The target of compile is a namespace/编译的目标是命名空间
- Each file, `fn` and `gen-class` will produce a `.class` file
- Each file generates a loader class/加载器类 of the same name with `"__init"` appended.
- The static initializer for a loader class produces the same effects as does loading its source file
  - You generally shouldn’t need to use these classes directly, as use, require and load will choose between them and more recent source
- The loader class is generated for each file referenced when a namespace is compiled, when its loader `.class` file is older than its source.
- A stand-alone `gen-class` facility is provided to create named classes for direct use as Java classes/生成Java命名类, with facilities for:
  - Naming the generated class
  - Selecting the superclass
  - Specifying any implemented interfaces
  - Specifying constructor signatures
  - Specifying state
  - Declaring additional methods
  - Generating static factory methods
  - Generating main
  - Controlling the mapping to an implementing namespace
  - Exposing inherited protected members
  - Generating more than one named class from a single file, with implementations in one or more namespaces
- An optional `:gen-class` directive can be used in the `ns` declaration to generate a named class corresponding to a namespace. `(:gen-class …​)`, when supplied, defaults to `:name` corresponding to the ns name, `:main` true, `:impl-ns same` as ns, and `:init-impl-ns` true. All options of gen-class are supported.
- `gen-class` and the `:gen-class` directive are ignored when not compiling.
- A stand-alone `gen-interface` facility is provided for generating named interface classes for direct use as Java interfaces/生成Java接口, with facilities for:
  - Naming the generated interface
  - Specifying any superinterfaces
  - Declaring the signatures of interface methods

## Compiling

To compile a lib, use the `compile` function, and supply the namespace name as a symbol. 

For some namespace `my.domain.lib`, defined in `my/domain/lib.clj`, in the classpath, the following should occur:
- A loader classfile will be produced in `my/domain/lib__init.class`, under `*compile-path*`, which must be in the classpath
- A set of classfiles will be produced, one per fn in the namespace, with names such as `my/domain/lib$fnname__1234.class`
- For each gen-class: A stub classfile will be produced with the specified name

## Compiler options

`clojure.core/*compiler-options*`
- `:disable-locals-clearing` (boolean)
- `:elide-meta` (vector of keywords)
- `:direct-linking` (boolean)

## Runtime

`gen-class` specifies only a signature, and the class that it generates is only a stub. 
This stub class defers all implementation to functions defined in the implementing namespace. 
At runtime, a call to some method `foo` of the generated class will find the current value of the var implementing `namespace/prefixfoo` and call it. 
If the var is not bound or nil, it will call the superclass method, or if an interface method, generate an `UnsupportedOperationException`.

## gen-class Examples


# Other Libraries

- Java Utilities: `clojure.java.*`)`
- Parallel Processing: DEPRECATED
- Reflection Utilities: `clojure.reflect`
- REPL Utilities: `clojure.repl`
- Sets and Relational Algebra: `clojure.set`
- String Handling: `clojure.string`
- Unit Testing: `clojure.test`
- Walking Data Structures: `clojure.walk`
- XML: `clojure.xml`
- Zippers: Functional Tree Editing `clojure.zip`


# Differences with Lisps

# Clojure CLI

The Clojure CLI is **a command-line tool to run Clojure programs on the Java Virtual Machine**. The Clojure CLI uses `deps.edn` files to configure and download program dependencies to include on the JVM classpath.

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

Aliases are simply keywords that name edn data.

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

The `deps.edn` file is a data file specifying all information needed to form a project classpath, including deps, paths, and external dependency repository information. 
The `deps.edn` file format is used by the `tools.deps` library and the Clojure CLI.


```clojure
{;; Project paths
 :paths ["relative/path1" :path-alias]

 ;; Project dependencies
 :deps {
   ;; Maven lib
   groupId/artifactId$classifier {:mvn/version "1.2.3"
                                  :exclusions [lib1 lib2]}

   ;; Git lib
   gitlib/name {:git/url "https://example.com/repo"
                :git/tag "dev"
                :git/sha "123abcd"
                :deps/root "sub/dir"
                :deps/manifest :pom
                :exclusions [lib1 lib2]}

   ;; Local directory
   localdir/name {:local/root "path/to/dir"
                  :deps/manifest :pom
                  :exclusions [lib1 lib2]}

   ;; Local jar
   localjar/name {:local/root "path/to.jar"
                  :exclusions [lib1 lib2]}}

 ;; Aliases give a name to any set of edn data
 :aliases {
   :alias-name {
     :extra-deps {lib coord}
     :override-deps {lib coord}
     :default-deps {lib coord}
     :deps {lib coord}
     :replace-deps {lib coord}

     :extra-paths ["p1" "p2"]
     :paths ["p1" "p2"]
     :replace-paths ["p1" "p2"]
     :classpath-overrides {lib "path"}

     :ns-default namespace
     :ns-aliases {alias namespace}

     :exec-fn afn/symbol
     :exec-args {key val}

     :jvm-opts ["opt1" "opt2"]
     :main-opts ["opt1" "opt2"]}}

 ;; Procurer config
 :mvn/local-repo "path/to/local-repo"
 :mvn/repos {"repo" {:url "https://..."
                     :releases {:enabled true
                                :update :daily
                                :checksum :warn}
                     :snapshots {#_same_as_releases}}}

 ;; Tool publishing
 :tools/usage {:ns-default namespace
               :ns-aliases {alias namespace}}

 ;; Lib that requires preparation (compilation) before use
 :deps/prep-lib {:ensure "target/classes"
                 :alias :build
                 :fn compile}}
```

## :paths
## :deps

Maven
- :mvn/version

Git
- :git/url
- :git/tag
- :git/sha

Local
- :local/root

Shared
- :exclusions
- :deps/root
- :deps/manifest

## :aliases

Aliases give a name to a data structure that can be used either by the Clojure CLI itself or other consumers of deps.edn. 
They are defined in the `:aliases` section of the config file.

- :extra-deps
- :override-deps
- :default-deps
- :deps / :replace-deps
- :extra-paths
- :paths / :replace-paths
- :classpath-overrides
- :ns-default
- :ns-aliases
- :exec-fn
- :exec-args
- :jvm-opts
- :main-opts

## Procurer config

## Tool definition :tools/usage

## Prep lib :deps/prep-lib

## Runtime basis

- :basis-config
- :argmap
- :libs
- :classpath
- :classpath-roots