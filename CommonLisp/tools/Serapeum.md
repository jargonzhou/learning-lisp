# Serapeum
> https://github.com/ruricolist/serapeum

Serapeum is a conservative library of Common Lisp utilities. It is a supplement, not a competitor, to [Alexandria](http://common-lisp.net/project/alexandria/).

```lisp
(ql:quickload "serapeum")
```

Serapeum is being carefully refactored into modular subsystems. Using Serapeum as a whole is still recommended. Modularization will make Serapeum easier to maintain, easier to incrementally adopt, and more discoverable.
* **binding**: Binding macros.
* **conditions**: Condition handling utilities.
* **control-flow**: Control flow macros.
* **defining-types**: Macros for defining types.
* **definitions**: Global definition macros.
* **iter**: Iteration constructs and utilities.
* **macro-tools**: Tools for writing macros.
* **op**: The `op’ macro for succint lambdas.
* **portability**: “Subtrivial” portability.
* **types**: Utility types and type utilities.
* **box**: Box data structure.
* **queue**: Queue data structure.
