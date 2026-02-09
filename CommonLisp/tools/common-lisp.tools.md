# Common Lisp Tools

# IDE
* [Alive](./Alive.md): Common Lisp Extension for VSCode.
* ~~[commonlisp-formatter](https://github.com/rrepo/commonlisp-formatter)~~
* ~~[vscode-lisp-formatter](https://marketplace.visualstudio.com/items?itemName=imjacobclark.vscode-lisp-formatter)~~
* [commonlisp-vscode](https://marketplace.visualstudio.com/items?itemName=ailisp.commonlisp-vscode): Roswell, cl-lsp.
* [common-lisp-jupyter](https://github.com/yitzchak/common-lisp-jupyter): A Common Lisp kernel for Jupyter along with a library for building Jupyter kernels.
* [lisp-format](https://github.com/eschulte/lisp-format): A tool to format lisp code. Designed to mimic clang-format. - [.lisp-format](./.lisp-format)
* ~~[vscode-common-lisp](https://github.com/qingpeng9802/vscode-common-lisp): This VS code extension supports language features for Common Lisp.~~

# Project
* [cl-cookieproject](https://github.com/vindarel/cl-cookieproject): Generate a ready-to-use Common Lisp project.
* [cl-project](./cl-project/cl-project.md): Generate modern project skeletons
* [CI-Utils](https://github.com/neil-lindquist/ci-utils): Utilities for running Common Lisp on CI platforms.
* [CLPM](https://www.clpm.dev/): Common Lisp Project Manager.
* [icl](https://github.com/atgreen/icl): Interactive Common Lisp: an enhanced REPL.
* [ocicl](https://github.com/ocicl/ocicl): An OCI-based ASDF system distribution and management tool for Common Lisp. - [OCI: Open Container Initiative](https://github.com/opencontainers/)
* [Qlot](https://github.com/fukamachi/qlot): A project-local library installer for Common Lisp.
* [Quicklisp](./Quicklisp.md): Quicklisp is a library manager for Common Lisp.
* [quickproject](https://quickdocs.org/quickproject): Creates the skeleton of a new Common Lisp project. 2019-12-27.
* [Roswell](./Roswell.md): Common Lisp environment setup Utility.
* [SBCL](./SBCL.md): Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler.
* [sbcl-librarian](https://github.com/quil-lang/sbcl-librarian): An opinionated interface for creating C- and Python-compatible shared libraries in Common Lisp with SBCL.

## Docker
* [CL Docker Images](https://cl-docker-images.common-lisp.dev/): The purpose of this project is to make it easy to use any open source ANSI Common Lisp implementation inside a Docker container.
* [base-lisp-image](https://github.com/40ants/base-lisp-image): Base image for Common Lisp projects with SBCL or CCL and latest ASDF, Qlot and Roswell.
* [s2i-lisp](https://github.com/container-lisp/s2i-lisp): Source-to-Image builder for Common Lisp applications on OpenShift.

# Libraries
* [cffi](https://github.com/cffi/cffi): The Common Foreign Function Interface.
* [cl-indentify](https://github.com/yitzchak/cl-indentify): A code beautifier for Common Lisp.
* [cl-prolog2](https://github.com/cl-model-languages/cl-prolog2): Common Interface to ISO Prolog implementations from Common Lisp.
* [Clasp](https://github.com/clasp-developers/clasp): Clasp is a new Common Lisp implementation that seamlessly interoperates with C++ libraries and programs using LLVM for compilation to native code.
* [paiprolog](https://github.com/quek/paiprolog): forked Christophe Rhodes's PAIProlog that an update of Peter Norvig's "Prolog in Common Lisp".

## Core
* [Alexandria](./Alexandria.md): Alexandria is a collection of portable public domain utilities.
* [defstar](https://github.com/lisp-maintainers/defstar): Type declarations for `defun` et all.
* [eclector](https://github.com/s-expressionists/Eclector): A portable, extensible Common Lisp reader.
* [iterate](https://iterate.common-lisp.dev/): iterate is an iteration construct for Common Lisp. It is similar to the `CL:LOOP` macro, with these distinguishing marks: (1) it is extensible, (2) it helps editors like Emacs indent iterate forms by having a more lisp-like syntax, and (3) it isn't part of the ANSI standard for Common Lisp (which is sometimes a bad thing and sometimes good). `_iterate.ipynb`
* [multilang-documentation](https://github.com/Shinmera/multilang-documentation): A drop-in replacement for `cl:documentation` with support for multiple languages.
* [named-readtables](https://github.com/melisgl/named-readtables): Named-Readtables is a library that provides a namespace for `readtables` akin to the already-existing namespace of packages.
* [rutils](https://github.com/vseloved/rutils): RUTILS is a syntactic utilities package for Common Lisp. `_rutils.ipynb`
* [Serapeum](./Serapeum.md): Utilities beyond Alexandria.
* [series](https://series.sourceforge.net/): Richard C. Waters' `SERIES` package for Common Lisp.
* [trivial-do](https://github.com/yitzchak/trivial-do): Looping extensions that follow the style of the core `DO` functions.
* [trivial-features](https://github.com/trivial-features/trivial-features): Ensures consistent `*FEATURES*` across multiple CLs.
* [trivial-garbage](https://github.com/trivial-garbage/trivial-garbage): Portable finalizers, weak hash-tables and weak pointers.

### Mathematics
* [Antik](https://gitlab.common-lisp.net/antik/antik): a Common Lisp library for computational mathematics, science, and engineering.
* [Axiom](https://github.com/daly/axiom): Axiom is a free, open source computer algebra system.
* [cmu-infix](https://github.com/quil-lang/cmu-infix): A library for writing infix mathematical notation in Common Lisp.
* [lla](https://github.com/Lisp-Stat/lla): A linear algebra library for Common Lisp. LLA is a high-level Common Lisp library built on on [BLAS (Basic Linear Algebra Subprograms)](http://www.netlib.org/blas/) and [LAPACK (Linear Algebra PACKage)](http://www.netlib.org/lapack/), but providing a more abstract interface with the purpose of freeing the user from low-level concerns and reducing the number of bugs in numerical code.
* [MAGICL](https://github.com/quil-lang/magicl): Matrix Algebra proGrams In Common Lisp.
* [MatLisp](https://github.com/bharath1097/matlisp/): Matlisp, incorporating multiindex datastructures (tensor-branch).
* [Maxima](https://sourceforge.net/projects/maxima/): Maxima is a computer algebra system comparable to commercial systems like Mathematica and Maple. It emphasizes symbolic mathematical computation: algebra, trigonometry, calculus, and much more. - [maxima-jupyter](https://github.com/robert-dodier/maxima-jupyter)

See Also
* [linear algebra - CLiki](https://www.cliki.net/linear%20algebra)

### Packages
* [cl-package-locks](https://github.com/elliottjohnson/cl-package-locks): A compatability layer for dealing with package locks in a uniform manner.

### Macros
* [Anaphora](https://github.com/spwhitton/anaphora): Anaphora is the anaphoric macro/指代宏 collection from Hell: it includes many new fiends in addition to old friends like `AIF` and `AWHEN`.

### Strings
* [cl-ppcre](https://github.com/edicl/cl-ppcre): Portable Perl-compatible regular expressions for Common Lisp.
* [cl-str](https://github.com/vindarel/cl-str/): Modern, simple and consistent Common Lisp string manipulation library.
* [optima](https://github.com/m2ym/optima): Optimized Pattern Matching Library for Common Lisp. - Archived 2018-12-29.
* [Trivia](https://github.com/guicho271828/trivia): Trivia is a pattern matching compiler that is compatible with Optima.

### Date, Time
* [local-time](https://github.com/dlowe-net/local-time/): Time manipulation library for Common Lisp.

### Arrays
* [array-operations](https://github.com/Lisp-Stat/array-operations): Common Lisp utilities for working with arrays.
* [MGL-MAT](https://github.com/melisgl/mgl-mat): MGL-MAT is library for working with multi-dimensional arrays which supports efficient interfacing to foreign and CUDA code with automatic translations between cuda, foreign and lisp storage. BLAS and CUBLAS bindings are available.
* [static-vectors](https://github.com/sionescu/static-vectors): Create vectors allocated in static memory.

### Hash Tables
* [cl-custom-hash-table](https://github.com/metawilm/cl-custom-hash-table): Custom hash tables for Common Lisp.

### Files, OS
* [cl-fad](https://edicl.github.io/cl-fad/): A portable pathname library for Common Lisp.
* [clingon](https://github.com/dnaeon/clingon): a command-line options parser system for Common Lisp.
* [file-attributes](https://github.com/Shinmera/file-attributes): Access to common file attributes (uid, gid, permissions, ctime, mtime, atime).
* [Osicat](https://github.com/osicat/osicat): Osicat is a lightweight operating system interface for Common Lisp on Unix-platforms.
* [unix-opts](https://github.com/libre-man/unix-opts): Unix-style command line options parser.

### Streams
* [flexi-streams](https://github.com/edicl/flexi-streams): Flexible bivalent streams for Common Lisp.
* [nontrivial-gray-streams](https://github.com/yitzchak/nontrivial-gray-streams): A compatibility layer for Gray streams including extensions.
* [trivial-gray-streams](https://github.com/trivial-gray-streams/trivial-gray-streams): Portability library for CL gray streams.

### Conditions
* [dissect](https://github.com/Shinmera/dissect): A lib for introspecting the call stack and active restarts.
* [trivial-backtrace](https://github.com/gwkkwg/trivial-backtrace): Portable simple API to work with backtraces in Common Lisp.
* [trivial-dump-core](https://github.com/rolpereira/trivial-dump-core): a small wrapper that provides a common interface between Lisp implementations for the creation of Lisp cores and executables.

### CLOS
* [closer-mop](https://github.com/pcostanza/closer-mop): Closer to MOP is a compatibility layer that rectifies many of the absent or incorrect CLOS Meta Object Protocol (MOP) features across a broad range of Common Lisp implementations.
* [defclass-std](https://github.com/EuAndreh/defclass-std): A shortcut macro to write `DEFCLASS` forms quickly.

## Testing
* [check-it](https://github.com/DalekBaldwin/check-it): Randomized specification-based testing for Common Lisp. Available through Quicklisp.
* [cl-quickcheck](https://github.com/mcandre/cl-quickcheck): a Common Lisp port of the QuickCheck unit test framework.
* [cl-test-grid](https://github.com/cl-test-grid/cl-test-grid): Collaborative testing of Common Lisp libraries
* [FiveAM](./FiveAM/FiveAM.md): Common Lisp regression testing framework
* Prove: archived, see [Rove](./Rove/Rove.md).
* [Rove](./Rove.md): Rove is a unit testing framework for Common Lisp applications.
* [sb-cover](https://www.sbcl.org/manual/index.html#sb_002dcover): The `sb-cover` module provides a code coverage tool for SBCL.
* [Slite](https://github.com/tdrhq/slite): a SLIme-based TEst runner for FiveAM and Parachute Tests.

See Also
* [Comparison of Common Lisp Testing Frameworks (28 Aug 2023 Edition)](https://sabracrolleton.github.io/testing-framework)

## Logging
* [Log4CL](./log4cl.ipynb): Common Lisp logging framework, modeled after Log4J.

See Also
* [Comparison of Common Lisp Logging Libraries](https://sabracrolleton.github.io/logging-comparison.html)

## Applications
* [apply-argv](https://github.com/pve1/apply-argv): Apply-argv is a library for parsing command line arguments.
* [Caveman2](./Caveman2/Caveman2.md): Lightweight web application framework.
* [Ceramic](https://github.com/ceramic/ceramic): Desktop web apps with Common Lisp.
* [cl-emb](https://cl-emb.common-lisp.dev/): CL-EMB is a library to embed Common Lisp and special template tags into normal text files. Can be used for dynamically generated HTML pages.
* [cl-gserver](https://github.com/mdbergmann/cl-gserver): Sento - Actor framework featuring actors and agents for easy access to state and asynchronous operations.
* [cl-html-parse](https://github.com/gwkkwg/cl-html-parse): HTML Parser.
* [cl-markup](https://github.com/arielnetworks/cl-markup): Modern markup (HTML) generation library for Common Lisp. 2013-10-03.
* [clack](https://github.com/fukamachi/clack): Clack is a web application environment for Common Lisp inspired by Python's WSGI and Ruby's Rack.
* [clip](https://github.com/Shinmera/clip): A Common Lisp HTML templating engine..
* [dexador](https://github.com/fukamachi/dexador): A fast HTTP client for Common Lisp.
* [Djula](https://github.com/mmontone/djula):Djula is a port of Python's Django template engine to Common Lisp.
* [drakma](https://github.com/edicl/drakma): Full-featured http/https client based on `usocket`.
* [external-program](https://github.com/edicl/flexi-streams): A portable Common Lisp library for running external programs from within Lisp.
* [hunchentoot](https://github.com/edicl/hunchentoot): Hunchentoot is a web server written in Common Lisp and at the same time a toolkit for building dynamic websites.
* [introspect-environment](https://github.com/Bike/introspect-environment): Small interface to portable but nonstandard introspection of CL environments.
* [Reblocks](https://github.com/40ants/reblocks): Reblocks is the fork of the Weblocks web frameworks written by Slava Akhmechet and maintained by Scott L. Burson and Olexiy Zamkoviy.
* [Spinneret](https://github.com/ruricolist/spinneret): Common Lisp HTML5 generator.
* [usocket](https://github.com/usocket/usocket): Universal socket library for Common Lisp.
* [Weblocks](https://github.com/40ants/weblocks): see Reblocks.

## Data Processing
* [Babel](https://github.com/cl-babel/babel): Babel is a charset encoding/decoding library, not unlike GNU libiconv, written in pure Common Lisp.
* [bknr-datastore](https://github.com/bknr-datastore/bknr-datastore): MOP-Based in-memory database with transactions for Common Lisp.
* [cl-ana](https://github.com/ghollisjr/cl-ana): Free (GPL) Common Lisp data analysis library with emphasis on modularity and conceptual clarity.
* [cl-base64](https://quickdocs.org/cl-base64): Base64 encoding and decoding with URI support.
* [cl-cuda](https://github.com/takagi/cl-cuda): Cl-cuda is a library to use NVIDIA CUDA in Common Lisp programs.
* [cl-dbi](https://github.com/fukamachi/cl-dbi): Database independent interface for Common Lisp.
* [cl-fad](https://github.com/edicl/cl-fad): Portable pathname library.
* [cl-pass](https://github.com/eudoxia0/cl-pass): Password hashing and verification library.
* [cl-store](https://github.com/skypher/cl-store): an portable serialization package which should give you the ability to store all common-lisp data types (well not all yet) into streams.
* [cl-yaml](https://github.com/eudoxia0/cl-yaml): A YAML parser and emitter built on top of [libyaml](http://pyyaml.org/wiki/LibYAML). Uses the [cl-libyaml](https://github.com/eudoxia0/cl-libyaml) library.
* [CL-Yesql](https://github.com/ruricolist/cl-yesql): CL-Yesql is a Common Lisp library for using SQL, based on Clojure’s Yesql. SQL statements live in their own files, in SQL syntax, and are imported into Lisp as functions.
* [clsql](https://github.com/sharplispers/clsql): Common Lisp SQL Interface library.
* [cxml](https://github.com/sharplispers/cxml): Closure XML - A Common Lisp XML Parser.
* [Ironclad](https://github.com/froydnj/ironclad): A cryptographic toolkit written in Common Lisp.
* [mito](https://github.com/fukamachi/mito): An ORM for Common Lisp with migrations, relationships and PostgreSQL support.
* [puri](https://quickdocs.org/puri): Portable Universal Resource Indentifier Library.
* [pzmq](https://github.com/orivej/pzmq): ZeroMQ bindings.
* [shasht](https://github.com/yitzchak/shasht): JSON reading and writing for the Kzinti.
* [SxQL](https://github.com/fukamachi/sxql): An SQL generator for Common Lisp.
* [trivial-mimes](https://github.com/Shinmera/trivial-mimes): Tiny library to detect mime types in files.
* [yason](https://github.com/phmarek/yason): Common Lisp JSON serializer written with simplicity in mind.

## Parallel, Concurrent and Async programming
* [Bordeaux](./Bordeaux/Bordeaux.md): a Common Lisp threading library.
* [chanl](https://www.cliki.net/chanl) : ChanL is a concurrency library built on top of bordeaux-threads that provides channels as thread-synchronisation primitives
* [cl-async](https://www.cliki.net/cl-async) : cl-async implements a higher-level interface for non-blocking, asynchronous programming in Common Lisp
* [lparallel](https://github.com/lmj/lparallel) : A Common Lisp library for parallel programming

# See Also
* Peter Norvig, Kent Pitman. **Tutorial on Good Lisp Programming Style**. 1993.
* [cl-library-docs/common-lisp-libraries](https://github.com/cl-library-docs/common-lisp-libraries): Common Lisp documentation - libraries or the HyperSpec.
* [Free Software Lisp Libraries - CLiki](https://www.cliki.net/)
  * [Current recommended libraries](https://www.cliki.net/current%20recommended%20libraries): Cliki contributors (that's you!) believe that the libraries on this page are considered "good enough for government use", and serve as a starting point when looking for a library covering a given field.
  * [Application](https://www.cliki.net/application): Applications suitable for (or at least, intended for) end-users
* [Full Stack Lisp](https://leanpub.com/read/fullstacklisp)
* [Google Common Lisp Style Guide](https://google.github.io/styleguide/lispguide.xml): This guide recommends formatting and stylistic choices designed to make your code easier for other people to understand.
* [Quickdocs](https://quickdocs.org/): Find Common Lisp libraries shipped by Quicklisp.
* [Quickref](https://quickref.common-lisp.net/): Reference manuals for Quicklisp libraries.
* [Style Guide - lisp-lang.org](https://lisp-lang.org/style-guide/): This is an opinionated guide to writing good, maintainable Common Lisp code. This page is largely based on Google’s [Common Lisp Style Guide](https://google.github.io/styleguide/lispguide.xml) and Ariel Networks’ own [guide](http://labs.ariel-networks.com/cl-style-guide.html).
