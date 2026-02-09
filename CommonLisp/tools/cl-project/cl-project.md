# cl-project
* https://github.com/fukamachi/cl-project

> Generate modern project skeletons

```lisp
* (ql:quickload "cl-project")

* (cl-project:make-project #P"./ex-cl-project")
writing ./ex-cl-project/ex-cl-project.asd
writing ./ex-cl-project/README.org
writing ./ex-cl-project/README.markdown
writing ./ex-cl-project/.gitignore
writing ./ex-cl-project/src/main.lisp
writing ./ex-cl-project/tests/main.lisp
t

; change directory
* (uiop:chdir "ex-cl-project")
* (uiop:run-program "tree" :output t) 
.
|-- README.markdown
|-- README.org
|-- ex-cl-project.asd
|-- src
|   `-- main.lisp
`-- tests
    `-- main.lisp
```