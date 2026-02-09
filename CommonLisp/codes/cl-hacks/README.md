# Cl-Hacks

```shell
$ sbcl
* (ql:quickload "cl-project")
* (cl-project:make-project #P"./cl-hacks")  
```

# Usage

```shell
# env
cl-user>(uiop:getcwd)
d:/workspace/github/learning-lisp/CommonLisp/codes/cl-hacks/

# load asd
cl-user>(asdf:load-asd (uiop:subpathname (uiop:getcwd) "cl-hacks.asd"))

# load dependencies...
P
# load system
cl-user>(ql:quickload "cl-hacks")
```

## ANSI Common Lisp
```shell
cl-user>(in-package :ansi-cl)
cl-hacks/ansi-cl>(hello)
Examples in ANSI Common Lisp.
NIL
```

## The Common Lisp Cookbook
```shell
# load dependencies: repl.lisp

cl-user>(in-package :cl-cookbook)
cl-hacks/ansi-cl>(hello)
Examples in Common Lisp Cookbook.
NIL

cl-user>(in-package :cl-cookbook/c22-packages)
#<PACKAGE "CL-COOKBOOK/C22-PACKAGES">
cl-cookbook/c22-packages>(hello)
"Hello from my package." 
Hello from my package.
```

## SBCL Hacks
```shell
cl-user>(in-package :sbcl-hacks)
cl-hacks/sbcl-hacks>(hello)
Examples in SBCL.
NIL
```

## Practical Common Lisp
```shell
cl-user>(in-package :practical-cl)
cl-hacks/practical-cl>(hello)
Examples in Practical Common Lisp.
NIL
```

## On Lisp
```shell
cl-user>(in-package :on-lisp)
cl-hacks/on-lisp>(hello)
Examples in On Lisp.
NIL
```

## Let Over Lambda
```shell
cl-user>(in-package :let-over-lambda)
cl-hacks/let-over-lambda>(hello)
Examples in Let Over Lambda.
NIL
```

## Common Lisp Recipes
```shell
cl-user>(in-package :cl-recipes)
cl-hacks/cl-recipes>(hello)
Examples in Common Lisp Recipes.
NIL
```

# Tests
```shell
(asdf:test-system :cl-hacks)
```

# Scripts
* repl.lisp
* cover.lisp: sb-cover
* clean.lisp: cleanup work.
