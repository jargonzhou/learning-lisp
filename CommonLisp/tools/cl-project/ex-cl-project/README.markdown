# Ex-Cl-Project

# Usage

## load-asd

```lisp
* (asdf:load-asd (uiop:subpathname (uiop:getcwd) "ex-cl-project.asd"))
#<asdf/find-system:define-op >
#<asdf/plan:sequential-plan {1104266493}>
* (ql:quickload "ex-cl-project")
To load "ex-cl-project":
  Load 1 ASDF system:
    ex-cl-project
; Loading "ex-cl-project"

("ex-cl-project")
* (in-package :ex-cl-project)
#<package "EX-CL-PROJECT">
* (hello)

"Hello from example CL-Project."
"Hello from example CL-Project."
```

## load-system

```shell
# Windows Git Bash
mkdir -p ~/AppData/Local/config/common-lisp/source-registry.conf.d/
CURRENT_DIR=`pwd`
# must use windows directory
# echo "${CURRENT_DIR/\/d/D:}/"
SYSTEM_NAME=ex-cl-project
echo '(:tree "'${CURRENT_DIR/\/d/D:}'/")' > ~/AppData/Local/config/common-lisp/source-registry.conf.d/$SYSTEM_NAME.conf

# Windows WSL
mkdir -p ~/.config/common-lisp/source-registry.conf.d/
CURRENT_DIR=`pwd`
SYSTEM_NAME=ex-cl-project
echo '(:tree "'${CURRENT_DIR}'/")' > ~/.config/common-lisp/source-registry.conf.d/$SYSTEM_NAME.conf
```

```
(asdf:load-system "ex-cl-project")
```

## test-system

```lisp
; $ ros run -- --load ~/quicklisp/setup.lisp
* (asdf:load-asd (uiop:subpathname (uiop:getcwd) "ex-cl-project.asd"))
* (asdf:test-system "ex-cl-project")
Testing System ex-cl-project/tests

;; testing 'ex-cl-project/tests/main'
test-target-1
  should (= 1 1) to be true

"runnig: should (= 1 1) to be true"     ✓ Expect (= 1 1) to be true.

✓ 1 test completed

Summary:
  All 1 test passed.
T
```

# Installation
