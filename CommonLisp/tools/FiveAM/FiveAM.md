# FiveAM
* https://github.com/lispci/fiveam
* https://fiveam.common-lisp.dev/docs/index.html
* https://common-lisp-libraries.readthedocs.io/fiveam/

> Common Lisp regression testing framework

```lisp
(ql:quickload "fiveam")
```

# Example: `ex-fiveam.lisp`

```shell
* (load "ex-fiveam.lisp")
t
* (in-package :it.bese.fiveam.example)
#<package "IT.BESE.FIVEAM.EXAMPLE">
* (run! 'example-suite-root)

Running test suite example-suite-root
 Running test suite example-suite0
  Running test add-2 ..
 Running test suite example-suite
  Running test add-4 .
  Running test dummy-add ...
  Running test dummy-strcat ...
 Did 5 checks.
    Pass: 5 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)

t
nil
nil
```