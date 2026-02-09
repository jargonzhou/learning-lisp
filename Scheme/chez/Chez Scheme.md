# Chez Scheme
* https://github.com/cisco/chezscheme
* [The Scheme Programming Language, 4th Edition](https://www.scheme.com/tspl4/)
* [User's Guide](https://cisco.github.io/ChezScheme/csug/csug.html)

> Chez Scheme is both a programming language and an implementation of that language, with supporting tools and documentation.

```shell
# MacOS
✗ cd csv9.5.8
✗ ./configure
✗ sudo make install

✗ which scheme
/usr/local/bin/scheme
✗ scheme
Chez Scheme Version 9.5.8
Copyright 1984-2022 Cisco Systems, Inc.

> (+ 1 2)
3
> (exit)
```

Work with libraries:
```shell
export CHEZSCHEMELIBDIRS="/path/to/lib"
export CHEZSCHEMELIBEXTS=".ss:.scm"
```

# Tools

* [chez-exe](https://github.com/gwatt/chez-exe): Chez Scheme self hosting executable
```shell
# Windows WSL
git clone https://github.com/ufo5260987423/chez-exe.git
scheme --script gen-config.ss --bootpath /usr/lib/csv10.1.0/ta6le
sudo make install
```

# The Scheme Programming Language

## Contents

Introduction
* 1. Introduction
* 2. Getting Started
* 3. Going Further
* 4. Procedures and Variable Bindings
* 5. Control Operations
* 6. Operations on Objects
* 7. Input and Output
* 8. Syntactic Extension
* 9. Records
* 10. Libraries and Top-Level Programs
* 11. Exceptions and Conditions
* 12. Extended Examples

Naming Convention: add a prefix '_' to same construction in R6RS.

Libraries:

> add lib to CHEZSCHEMELIBDIRS.

* lib/list-tools/setops.ss, lib/more-setops.ss: Example for '10. Libraries and Top-Level Programs'.
* lib/grades.ss: Example for '3.6. Libraries'.
* lib/base.ss: base datum operations.
* lib/files.ss: file system operations. 

## tools

* tests.ss: unit tests.
* stack.ss: stack.
* queue.ss: queue.
* lazy.ss: lazy evaluation of a thunk.

##  io

* simple.ss: output to console.

## tspl: for '12 Extended Examples'

* matrix.ss: matrix multiplication.
* sort.ss: sorting and merging lists.
* sets.ss: set construction with customed syntax.
* wrfreq.ss: calculate word frequency.
* printer.ss: print Scheme objects.
* formatted-output.ss: formatted output.
* interpreter.ss: a meta-circular interpreter for Scheme.
* oop.ss: define abstract objects.
* unification.ss: Unification algorithm.
* engine.ss: multitasking engine.

## sicp: Structure and Interpretation of Computer Programs

TODO