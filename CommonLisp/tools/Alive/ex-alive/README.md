# ex-alive

Examples in 'Common Lisp Cookbook - 7. Using VSCode with Alive'
- hello.lisp
- experiment.asd
```shell
touch experiment.asd
mkdir src test
touch src/app.lisp
touch test/all.lisp
```

```lisp
; Alive REPL (v0.6.3)
cl-user> (asdf:load-asd (uiop:subpathname (uiop:getcwd) "experiment.asd")) ; (asdf:load-asd "experiment.asd")
cl-user> (asdf:load-system :experiment/test)
cl-user> (in-package :test/all)
#<package "TEST/ALL">
test/all> (test-suite)
Test Suite
nil
```