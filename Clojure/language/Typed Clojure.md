# Typed Clojure
* https://github.com/typedclojure/typedclojure

> An optional type system for Clojure. 
> 
> Typed Clojure supports Clojure 1.12.3 and JDK 21+.

Clojure implementation
- `typed.clj.checker`: The JVM type checker
- `typed.clj.runtime`: JVM Runtime dependencies
- `typed.clj.analyzer`: Analyzer for JVM Clojure
- `typed.malli`: Malli integration.

ClojureScript implementation
- `typed.cljs.analyzer`: Analyzer for JS Clojure
- `typed.cljs.checker`: The JS type checker
- `typed.cljs.runtime`: Runtime dependencies

Implementation-agnostic
- `typed.cljc.analyzer`: Implementation-agnostic base for Clojure analyzers

Library Annotations
- `typed.lib.clojure`: Base type annotations
- `typed.lib.core.async`: Annotations for `core.async`
- `typed.lib.spec.alpha`: Annotations for `spec.alpha`

# See Also
* [malli](https://github.com/metosin/malli): High-performance data-driven data specification library for Clojure/Script.