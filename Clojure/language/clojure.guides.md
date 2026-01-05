# Clojure Guides
* https://clojure.org/guides/getting_started

# Learn Clojure
* https://clojure.org/guides/learn/clojure

* Syntax
* Functions
* Sequential Collections
* Hashed Collections
* Flow Control
* Namespaces

# spec

```clojure
(require '[clojure.spec.alpha :as s])
; or
(ns my.ns
  (:require [clojure.spec.alpha :as s]))

; instrumentation and testing
(require '[clojure.spec.test.alpha :as stest])

; generators
(require '[clojure.spec.gen.alpha :as gen])
```

# Reading Clojure Characters/Clojure字符

- `( …​ )`: List/列表
- `[ …​ ]`: Vector/向量
- `{ …​ }`: Map/映射
- `#`: Dispatch character/分发字符
- `#{ …​ }`: Set/集
- `#_`: Discard/忽略
- `#"…​"`: Regular Expression/正则表达式
- `#(…​)`: Anonymous function/匿名函数
- `#'`: Var quote/var引用
- `##`: Symbolic values/符号值
- `#inst`, `#uuid`, and `#js` etc.: tagged literals/标记的字面量
- `%, %n, %&`: Anonymous function arguments/匿名函数参数
- `@`: Deref
- `^` (and `#^`): Metadata/元数据
- `'`: Quote/引用
- `;`: Comment/注释
- `:`: Keyword/关键字
- `::`: Auto-resolved keyword/自动解析的关键字
- `#:` and `#::`: Namespace Map Syntax/命名空间映射余压阀
- `/`: Namespace separator/命名空间分隔符
- `\`: Character literal/字符字面量
- `$`: Inner class reference/内部内引用
- `->`, `->>`, `some->`, `cond->`, `as->` etc.: Threading macros/线程宏
- ``` ` ```: Syntax quote/语法引用
- `~`: Unquote/解引用
- `~@`: Unquote splicing/解引用凭借
- `<symbol>#`: Gensym/卫生宏
- `#?`: Reader conditional/读取器条件
- `#?@`: Splicing Reader conditional/拼接读取器条件
- `*var-name*`: "Earmuffs"/耳套
- `>!!`, `<!!`, `>!`, and `<!`: core.async channel macros/通道宏
- `<symbol>?`: Predicate Suffix/谓词后缀
- `<symbol>!`: Unsafe Operations/不安全操作
- `_`: Unused argument/未使用的参数
- `,`: Whitespace character/空白符号

# Destructuring in Clojure

# Threading Macros

# Equality

# Comparators

# Reader Conditionals

# Higher Order Functions

# Improving Development Startup Time

# Deps and CLI

# tools.build

# Go Block Best Practices

# test.check

test.check is a property-based testing library for clojure, inspired by QuickCheck.

```clojure
(require '[clojure.test.check :as tc])
(require '[clojure.test.check.generators :as gen])
(require '[clojure.test.check.properties :as prop])
```