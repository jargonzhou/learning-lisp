# Programming Clojure, Third Edition

# Setup

VSCode:
- Calva: Create a Getting Started REPL project
- Calva: Start a Project REPL and Connect (aka Jack-In) - deps.edn
- Calva: Load/Evaluate Current File and its Requires/Dependencies
- Calva: Run Tests for Current Namespace

# Deps
* org.clojure/clojure 1.12.3
* org.clojure/test.check 1.1.2

# Introduction

notations
- result
```clojure
(+ 2 2)
-> 4
```
- output
```clojure
(println "hello")
| hello
-> nil
```
- form
```clojure
(example-fn required-arg)
(example-fn optional-arg?)
(example-fn zero-or-more-arg*)
(example-fn one-or-more-arg+)
(example-fn & collection-of-variable-args)
```
- libs
```clojure
; (require '[lib-name :refer [var-names+] :as alias])
(require '[clojure.java.io :as io])
(io/file "hello.txt")
-> #<File hello.txt>
```
- namespace
```clojure
user=> (+ 2 2)
-> 4
```

# 1. Getting Started

simplicity and power
- concise and expressive programs
- the power of Lisp updated with a modern syntax
- an immutable-first approach to state and concurrency
- an embrace of the JVM host and its ecosystem

Clojure coding quick start
- `clj`
  - `deps.edn`
  - `load-file`
```clojure
; .calva > output-window > output.calva-repl
clj꞉user꞉> (println "hello world")
; hello world
nil
clj꞉user꞉> (defn hello [name] (str "hello, " name))
#'user/hello
clj꞉user꞉> (hello "Stu")
"hello, Stu"
```
- adding shared state
  - `#{}`, `conj`
  - reference types(refs): `atom`, `def`, `swap!`, `deref`/`@`

Navigating Clojure libraries
- `require`: quoted-namesapce-symbol
- `doc`, `find-doc`, `clojure.repl/source`
- Java Reflection API: `class`, `ancestors`, `instance?`, ...
- conventions for paramter names
  - `a`: a Java array
  - `agt`: an agent
  - `coll`: a collection
  - `expr`: an expression
  - `f`: a function
  - `idx`: an index
  - `r`: a ref
  - `v`: a vector
  - `val`: a value

# 2. Exploring Clojure

reading Clojure
- in Clojure, there are no statements, only expressions that can be nested in mostly arbitrary wais.
- numbers: `M` for `BigDecimal`, `N` for `BigInt`
- symbols: used to name things
  - aplhanumeric characters, `+`, `-`, `*`, `/`, `!`, `?`, `.`, `_`, `'` 
- collections: lists `()`, vectors `[]`, sets `#{}`, maps `{}`.
- strings `""`, characters `\{letter}`
- booleans `true` `false`, `nil`

functions
- variable arity: `&`
```clojure
(defn name doc-string? attr-map? [params*] prepost-map? body)

; multiple argument lists and method bodies
(defn name doc-string? attr-map?
  ([params*] body)+)
```
- anonymous functions: `fn`
  - reader macro syntax: `#(body)`, `%1`, `%2`, `%&`, `%`

vars, bindings, namespaces: In Clojure, a namesapce is a collection of names/symbols that refer to vars. each var is bound to a value.
- **vars/变量/变数**: `var`/`#'`
  - when define an object with `def` or `defn`, that object is stored in a Clojure **var**.
  - the same var can be aliased into more than one namespace
  - vars can have metadata: documentation, type hints for optimization, unit tests
  - vars can be dynamically rebound on a per-thread basis
- **bindings/绑定**
  - vars are bound to names
  - in a function call, argument values bind to parameter names
  - `let` special form: create a set of lexical bindings
- destructuring/解构
  - any place that you bind names, you can nest a vector or a map in the binding to reach into a collection and bind only the part you want.
  - `_`: donot care about the binding
  - `:as`: a binding for the entire enclosing structure
  - a mini-language
- **namespces/命名空间**
  - root bindings live in a namespace
  - `(resolve symbol)`
  - `(in-ns name)`: switch namesapces, create a new one if needed
    - `java.lang` package is available
    - `java.io.File/separator`
  - `clojure.core/use`
  - `(import '(package Class+)')`: only for Java classes
  - `(require '[clojure.string :as str]')`: refer var from another namespace into current namespace
  - `(ns name & references)` macro

metadata: In Clojure, metadata is data that orthogonal/正交 to the logical value of an object.
- `(meta #'str)`
- common metadata keys: `:ns` `:name` `:added` `:file` `:line` `:column` `:tag` `:arglists` `:doc` `:macro`
- metadata reader macro: `^metadata form`
  - `^Classname`: short-form of `^{:tag Classname}`

calling java
- create objects
  - `new`: `(new java.util.Random)`
  - append `.` to classname: `(java.util.Random.)`
- invoke methods
  - `.` special form: `(. rnd nextInt)`
- access static methods and fields
  - `(. System lineSeparator)`: static method
  - `(. Math PI)`: static field
  - `(. Math -PI)`: `-<fieldName>` to distinguish method and field with the same name
  - `(. p x)` `(. p -x)`: instance field `(def p (java.awt.Point. 10 20))
```clojure
; call methods
(. class-or-instance member-symbol & args)
(. class-or-instance (member-symbol & args))

(.method instance & args)
(.field instance)
(.-field instance)
(Class/method & args)
Class/field
```
- `(javadoc java.net.URL)`

comments
- `;`
- `comment` macro: ignore its body and return `nil`
- `#_` reader macro: ignore next form

flow control
- branch with `if` form
  - `when`, `when-not` macro
- introduce side effects with `do` form
- recur with `loop`/`recur`

where is for loop?
- `for`: sequence comprehension

# 3. Unifying Data with Sequences

Clojure's single abstraction: **sequence**/**seq**/序列
- all Clojure collections
- all Java collections
- Java arrays, strings
- regular expression matches
- directory structures
- IO streams
- XML trees

everything is a sequence
- 3 core capbilities: 
  - `(first aseq)`
  - `(rest aseq)`
  - `(cons elem aseq)`
- `(seq coll)`
- `(next aseq)`
- `seq?` predicate
- `sorted-set`, `sorted-map`
- other capabilities: for list add to the front, for vector add to the back
  - `(conj coll element & elements)`
  - `(into to-coll from-coll)`
- Most Clojure sequences are lazy.
- Clojure sequences are immutable: they never change.

use the sequence libarary
- contract: `first/rest/cons`
- functions that create sequences
```clojure
(range start? end? step?)
(repeat n x)
(iterate f x)
(take n sequence)

(repeat x)
(cycle coll)
(interleave & colls)
(interpose separator coll)
(join separator sequence)

; creation
(list & elements)
(vector & elements)
(vec coll)
(hash-set & elements)
(set coll)
(hash-map key-1 val-1 ...)
```
- functions that filter sequences
```clojure
(filter pred coll)
(take-while pred coll)
(drop-while pred coll)
(split-at index coll)
(split-with pred coll)
```
- sequence predicates
```clojure
(every? pred coll)
(some pred coll)
(not-every? pred coll)
(not-any? pred coll)
```
- functions that transform sequences
```clojure
(map f coll)
(reduce f coll)
(sort comp? coll)
(sort-by a-fn comp? coll)

; list comprehension
(for [binding-form coll-expr filter-expr? ...] expr)
```

lazy and infinite sequences
```clojure
; force evaluation
(doall coll)
(dorun coll)
```

Clojure makes Java seqable
- seq-ing Java collections
  - arrays, `Tashtable`, `Map`, strings
- seq-ing regular expressions: `java.util.regex`
```clojure
(re-matcher regexp string)
(re-find m)
(re-seq regexp string)
```
- seq-ing the file system
```clojure
(import 'java.io.File')
(seq (.listFiles (File. ".")))
(file-seq (File. "."))
```
- seq-ing a stream: Java `Reader`
```clojure
(require '[clojure.java.io :refer [reader]])
(line-seq (reader "utils.clj"))
(with-open [rdr (reader "utils.clj")]
  (count (line-seq rdr)))
```

call structure-specific functions
- functions on lists
```clojure
(peek coll)
(pop coll)
```
- functions on vectors
  - `peek`, `pop`: at the end
  - `(get vec index)`
  - vectors are functions: `(the-vector index)`
  - `(assoc the-vector index elem)`
  - `(subvec the-vector start end?)`
- functions on maps
```clojure
(keys map)
(vals map)
(get map key value-if-not-found?)
(the-map key) ; maps are functions of their keys
(the-keyword map) ; keyword are functions
(contains? map key)

; build new maps
assoc
dissoc
select-keys
merge
(merge-with merge-fun & maps)
```
- functions on sets
```clojure
(require '[clojure.set :refer :all])

; operations from set theory
union
intersection
difference
select
```

# 4. Functional Programming

```clojure
(letfn fnspecs & body)
; fnspecs ==> [(fname [params&] exprs)+]
```

Clojure's workarounds for tail recursion
- self-recursion with `recur`
- lazy sequences
  - `(lazy-seq & body)` macro
- mutual recursion with `trampoline`

# 5. Specifications

```clojure
(require '[clojure.spec.alpha :as s])
(require '[clojure.spec.test.alpha :as stest])
```

defining specs
- specs are logical compositons of predicates/谓词 used to describe a set of data values.
- `s/def` macro: name and register a spec in the global registry of specs

validating data
- kind of specs: predicates, range specs, logical connectors `and` `or`, collection specs
- predicates: `boolean?` `string?` `keyword?` `rational?` `pos?` `zero?` `empty?` `any?` `some?`
- enumerated values
- range specs
- handling `nil`
- logical specs
- collection specs
- collection sampling
- tuples
- information maps

vaidating functions
- 3 specs: `:args`, `:ret`, `:fn`
- regex op specs: match any arbitrary value in a collection
  - patterns: concatenated `s/cat`, alternatives `s/alt`, repeated, optional
- sequences with structure
  - repetition operators: `s/?` `s/*` `s/+`
  - variable argument lists: `(s/? any?)`
  - multi-arity argument list
- specifying functions: `s/fdef`
- anonymous functions: `s/fspec`
- instrumenting functions: for `:args` only
  - `stest/instrument`: wrap a function with a version that uses spec to verify that the incoming arguments to a function conform to the function's spec.

generative function testing
- checking functions: `stest/check`
- generating examples: `s/exercise`
  - combining generators with `s/and`
  - creating custom generators

# 6. State and Concurrency

a **state/状态** is the **value/值** of an **identity/标识** at a point in time.

Clojure provide 4 reference types for identities:
- **refs/引用**: manage coordinated synchronous changes to shared state - 协同的同步变更
- **atoms/原子**: manage uncoordinated synchronous changes to shared state - 非协同的同步变更
- **agents/代理**: manage aynchronous changes to shared state - 异步变更
- **vars/变数**: manage thread-local state - 线程局部

concurrency, parallelism, and locking

refs and STM(software transactional memory)
- Clojure STM provides ACI.
```clojure
(ref initial-state options*)
;; options
;;  :validator validate-fn
;;  :meta metadata-map

(deref reference)
@refernce ; reader macro

(ref-set reference new-value)
; transaction
(dosync & exprs)

(alter ref update-fn & args...)
;; update-fn
(your-func things-that-gets-updated & optional-other-args)

(commute ref update-fn & args...)
```

use atoms for uncoordinated synchronous updates
```clojure
(atom initial-state options?)
;; options
;;  :validator validate-fn
;;  :meta metadata-map

(reset! an-atom newval)
(swap! an-atom f & args)
```

use agents for asynchronous updates
```clojure
(agent initial-state options*)
;; options
;;  :validator validate-fn
;;  :meta metadata-map
;;  :error-handler handler-fn
;;  :error-mode mode-key (:continue or :fail)

(send an-agent update-fn & args)

(await & agents)
(await-for timeout-millis & agents)
```

managing per-thread state with vars
```clojure
(binding [bindings] & body)

(set! var-symbol new-value)
```

Java locks: manage coordinated synchronous updates


a Clojure snake/贪吃蛇: TODO


# 7. Protocols and Datatypes

programming to abstractions
- `spit`/写入, `slurp`/读取

interfaces

protocols

datatypes

records

reify

# 8. Macros

when to use macros

writing a control flow macro

makeing macros simpler

taxonomy of macros
- conditional evaluation: `when` `when-not` `and` `or` `comment`
- defining vars: `defn` `defmacro` `defmulti` `defstruct` `declare`
- Java interop: `..` `todo` `import-static`
- postponing evaluation: `lazy-cat` `lazy-seq` `delay`
- wrapping evaluation: `with-open` `dosync` `with-out-str` `time` `assert`
- avoiding a lambda: same as wrapping evaluation

# 9. Multimethods

living without multimethods

defining multimethods

moving beyong simple dispatch

creating ad hoc taxonomies

when should i use multimethods

# 10. Java Interop

creating Java objects in Clojure
- direct use of Java types and interfaces
  - `defrecord` `deftype`
- anonymous interface implementation with `reify`
- class extension with `proxy`

calling Clojure from Java
- `clojure.java.api.Clojure`: in clojure-1.12.3.jar

exception handling
- `try` `throw` special forms
- `IExceptionInfo` class: `ex-info` `ex-data` functions
- `with-open` macro
```clojure
(try expr* catch-clause* finally-clause?)
; catch-clause -> (catch classname name expr*)
; finally-clause -> (finally expr*)
```

optimizing for performance

a real-world example: `pinger.clj`, `scheduler.clj`


# 11. Building an Application

```clojure
; src/hangman/core.clj
(ns hangman.core ...)

; src/hangman/specs.clj
(ns hangman.specs ...)
```

# See Also

* [“Ideal Hash Trees” by Phil Bagwell](http://lampwww.epfl.ch/papers/idealhashtrees.pdf)
* [“Understanding Clojure’s PersistentVector Implementation” by Karl Krukow](http://tinyurl.com/clojure-persistent-vector)
