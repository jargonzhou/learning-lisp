# SBCL: Steel Bank Common Lisp
* https://www.sbcl.org/
* https://github.com/sbcl/sbcl

> Steel Bank Common Lisp (SBCL) is a high performance Common Lisp compiler. It is open source / free software, with a permissive license. In addition to the compiler and runtime system for ANSI Common Lisp, it provides an interactive environment including a debugger, a statistical profiler, a code coverage tool, and many other extensions.
>
> SBCL runs on Linux, various BSDs, macOS, Solaris, and Windows.

```shell
$ sbcl --version
SBCL 2.6.0

* (lisp-implementation-version)
"2.6.0"
* (lisp-implementation-type)
"SBCL"
```

Features
```lisp
(loop for feature in *features*
      do (print feature))
```

`~/.sbclrc`


# Manual

## Getting Support and Reporting Bugs

## Introduction

## Starting and Stopping

## Compiler

## Debugger

## Efficiency

## Beyond the ANSI Standard

## External Formats

## Foreign Function Interface

## Pathnames

## Streams

## Package Locks

an errors solved using `sb-ext:unlock-package`

```shell
* (asdf:test-system "example-cl-project")
; compiling file "~/quicklisp/dists/quicklisp/software/dissect-20231021-git/backend/sbcl.lisp" (written 18 AUG 2024 10:54:10 AM):
; 
; caught ERROR:
;   READ error during COMPILE-FILE:
;   
;     Lock on package SB-DI violated when interning DEBUG-VAR-INFO while in package
;     DISSECT.
;   See also:
;     The SBCL Manual, Node "Package Locks"
;   
;     (in form starting at line: 38, column: 0, position: 1539)

; compilation aborted after 0:00:00.034

debugger invoked on a UIOP/LISP-BUILD:COMPILE-FILE-ERROR in thread
#<THREAD tid=775 "main thread" RUNNING {1003F90143}>:
  COMPILE-FILE-ERROR while
  compiling #<CL-SOURCE-FILE "dissect" "backend" "sbcl">

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

; unlock!!!
* (sb-ext:unlock-package :sb-di)
T
* (asdf:test-system "example-cl-project")
Testing System example-cl-project/tests

;; testing 'example-cl-project/tests/main'
test-target-1
  should (= 1 1) to be true
    ✓ Expect (= 1 1) to be true.

✓ 1 test completed

Summary:
  All 1 test passed.
```

## Threading

```lisp
* (member :sb-thread *features*)
(:sb-thread :sb-unicode :sbcl :win32)
```

TODO: CommonLisp SBCL Threading.ipynb

## Timers

## Networking

## Profiling

## Contributed Modules

- `sb-aclrepl`: an Allegro CL-style REPL for SBCL.
- `sb-concurrency`: additional data structures, synchronization primitives and tools for concurrent programming.
- `sb-cover`: a code coverage tool for SBCL.
- `sb-grovel`: help in generation of foreign function interfaces.
- `sb-md5`: implements RFC1321 MD5 Message Digest Algorithm.
- `sb-posix`: interface for calling out to OS.
```lisp
(require 'sb-posix)
(sb-posix:getcwd)
(sb-posix:chdir "/tmp/")
```
- `sb-queue`: merged into `sb-concurrency`.
- `sb-rotate-byte`: an interface to bitwise rotation.
- `sb-simd`: an interface for SIMD programming in SBCL.

## Deprecation

# RTFSC

Build From Source
```shell
# Windows WSL
# old version: 2.4.7
➜  sbcl git:(sbcl-2.4.10) sh make.sh "sbcl" 
➜  sbcl git:(sbcl-2.4.10) ✗ grep -E "*\.sh" make.sh | grep -v "#"
➜  sbcl git:(sbcl-2.4.10) sudo sh install.sh
➜  sbcl git:(sbcl-2.4.10) sbcl --version
➜  sbcl git:(sbcl-2.4.10) ✗ src/runtime/sbcl --core output/cold-sbcl.core
```

## See Also
* [The SBCL Internals Manual](https://www.sbcl.org/sbcl-internals/): describes SBCL's implementation details.
* [The SBCL Internals CLiki](http://sbcl-internals.cliki.net/): a wiki describing SBCL's implementation.
  * https://web.archive.org/web/20120814000933/http://sbcl-internals.cliki.net/index
* [Planet SBCL](http://planet.sbcl.org/): a meta-blog of blogs of SBCL developers, SBCL commits, and SBCL test results.
* [SBCL Benchmarks](http://sbcl.boinkor.net/bench/) - automatic benchmarks of SBCL builds, used by the SBCL developers for catching performance regressions.
* Links to other interesting / relevant pages:
  * [CLiki](http://www.cliki.net/): a SBCL-powered Wiki for free Common Lisp software
  * [Planet Lisp](http://planet.lisp.org/): a meta-blog of blogs from Common Lisp users and implementors.
  * [The HyperSpec](http://www.lispworks.com/reference/HyperSpec/): an online hyperlinked version of the ANSI Common Lisp specification.

# Related

## ~~sbcli~~
* https://github.com/hellerve/sbcli

A better REPL for SBCL.

`~/.sbclirc`
```shell
; https://github.com/hellerve/sbcli/blob/master/examples/.sbclirc
(setf *prompt*    "SBCLi> ")
(setf *prompt2*   ".....> ")
(setf *ret*       "=>")
(setf *repl-name* "SBCL")
(setf *hist-file* "~/.sbcli_history") ; set to empty string or nil to disable
(setf *pygmentize* "D:\\software\\miniconda3\\Scripts\\pygmentize.exe") ; path to pygmentize for highlighting;
                                              ; set to nil to disable
```

## sbcl-image-builder
* https://github.com/jpcima/sbcl-image-builder

Lisp image build for SBCL.

# See Also
* [asdf-vm](https://asdf-vm.com/): The Multiple Runtime Version Manager. - [asdf-sbcl](https://github.com/smashedtoatoms/asdf-sbcl)