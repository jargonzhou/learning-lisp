# Rove
* https://github.com/fukamachi/rove

> Rove is a unit testing framework for Common Lisp applications. This is intended to be a successor of [Prove](https://github.com/fukamachi/prove).

Windows
```shell
#
# Windows sbcl 2.6.0/2.4.10: NOT WORK!!!
#
* (lisp-implementation-version)
"2.6.0"
* (ql:quickload :rove)
To load "rove":
  Load 1 ASDF system:
    rove
; Loading "rove"
..
debugger invoked on a SB-EXT:PACKAGE-DOES-NOT-EXIST in thread
#<THREAD tid=25980 "main thread" RUNNING {1103F980A3}>:
  The name NIL does not designate any package.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE                     ] Use the current package, ROVE.
  1: [RETRY                        ] Retry finding the package.
  2: [USE-VALUE                    ] Specify a different package
  3: [TRY-RECOMPILING              ] Recompile lisp and try loading it again
  4: [RETRY                        ] Retry
                                     loading FASL for #<CL-SOURCE-FILE "rove/main" "lisp">.
  5: [ACCEPT                       ] Continue, treating
                                     loading FASL for #<CL-SOURCE-FILE "rove/main" "lisp">
                                     as having been successful.
  6:                                 Retry ASDF operation.
  7: [CLEAR-CONFIGURATION-AND-RETRY] Retry ASDF operation after resetting the
                                     configuration.
  8:                                 Retry ASDF operation.
  9:                                 Retry ASDF operation after resetting the
                                     configuration.
 10: [ABORT                        ] Give up on "rove"
 11: [REGISTER-LOCAL-PROJECTS      ] Register local projects and try again.
 12:                                 Exit debugger, returning to top level.

(SB-INT:%FIND-PACKAGE-OR-LOSE NIL)

#
# WSL
#
* (lisp-implementation-version)
"2.4.10-WIP"
* (ql:quickload :rove)
To load "rove":
  Load 5 ASDF systems:
    asdf bordeaux-threads cl-ppcre dissect
    trivial-gray-streams
  Install 1 Quicklisp release:
    rove
; Fetching #<URL "http://beta.quicklisp.org/archive/rove/2026-01-01/rove-20260101-git.tgz">
; 18.64KB
==================================================
19,092 bytes in 0.16 seconds (116.53KB/sec)
; Loading "rove"
[package rove/core/result]........................
[package rove/stats]..............................
[package rove/core/assertion].....................
[package rove/core/suite/file]....................
[package rove/core/suite/package].................
[package rove/core/test]..........................
[package rove/core/suite].........................
[package rove/reporter/registry]..................
[package rove/reporter]...........................
[package rove/misc/color].........................
[package rove/misc/stream]........................
[package rove/utils/reporter].....................
[package rove/reporter/spec]......................
[package rove/reporter/dot]...
(:ROVE)
```

with Roswell:
```shell
$ ros run -- --load ~/quicklisp/setup.lisp
* (lisp-implementation-version)
"2.4.10.roswell"
* (ql:quickload :rove)
To load "rove":
  Load 1 ASDF system:
    rove
; Loading "rove"
...
(:ROVE)

$ ros run -- --load ~/quicklisp/setup.lisp
* (lisp-implementation-version)
"2.6.0"
* (ql:quickload :rove)
To load "rove":
  Load 1 ASDF system:
    rove
; Loading "rove"
...
(:ROVE)
```