# ASDF: Another System Definition Facility
* https://asdf.common-lisp.dev/
* https://github.com/fare/asdf

ASDF is the de facto standard build facility for Common Lisp. Your Lisp implementation probably contains a copy of ASDF, which you can load using `(require "asdf")`.

ASDF is what Common Lisp hackers use to build and load software. It is the successor of the Lisp `DEFSYSTEM` of yore. ASDF stands for **Another System Definition Facility**.

ASDF 3 contains two parts: asdf/defsystem and uiop.
- `asdf/defsystem`
is a tool to describe how Lisp source code is organized in systems, and how to build and load these systems. The build happens based on a plan in term of actions that depend on previous actions; the plan is computed from the structure of the systems.
- `uiop`
the Utilities for Implementation- and OS- Portability, formerly known as asdf/driver, is a Common Lisp portability library and runtime support system that helps you write Common Lisp software in a portable way.

```shell
; load ASDF itself to Lisp image
* (require :asdf)
NIL
; check version
* (asdf:asdf-version)
"3.3.1"
```

# Load system

dependency library/project path
```lisp
* asdf:*central-registry*
(#P"C:/Users/zhouj/quicklisp/quicklisp/")
; ~/.sbclrc
(pushnew "~/to/project/" asdf:*central-registry* :test #'equal)

* asdf:*source-registry-parameter*
nil
* (maphash #'(lambda (k v)
             (format t "~A = ~A~%" k v))
         asdf::*source-registry*)
sb-aclrepl = D:/software/SBCL-2.6.0/contrib/sb-aclrepl.asd
sb-bsd-sockets = D:/software/SBCL-2.6.0/contrib/sb-bsd-sockets.asd
sb-capstone = D:/software/SBCL-2.6.0/contrib/sb-capstone.asd
sb-cltl2 = D:/software/SBCL-2.6.0/contrib/sb-cltl2.asd
sb-concurrency = D:/software/SBCL-2.6.0/contrib/sb-concurrency.asd
sb-cover = D:/software/SBCL-2.6.0/contrib/sb-cover.asd
sb-executable = D:/software/SBCL-2.6.0/contrib/sb-executable.asd
sb-gmp = D:/software/SBCL-2.6.0/contrib/sb-gmp.asd
sb-grovel = D:/software/SBCL-2.6.0/contrib/sb-grovel.asd
sb-introspect = D:/software/SBCL-2.6.0/contrib/sb-introspect.asd
sb-md5 = D:/software/SBCL-2.6.0/contrib/sb-md5.asd
sb-mpfr = D:/software/SBCL-2.6.0/contrib/sb-mpfr.asd
sb-posix = D:/software/SBCL-2.6.0/contrib/sb-posix.asd
sb-queue = D:/software/SBCL-2.6.0/contrib/sb-queue.asd
sb-rotate-byte = D:/software/SBCL-2.6.0/contrib/sb-rotate-byte.asd
sb-rt = D:/software/SBCL-2.6.0/contrib/sb-rt.asd
sb-simd = D:/software/SBCL-2.6.0/contrib/sb-simd.asd
sb-simple-streams = D:/software/SBCL-2.6.0/contrib/sb-simple-streams.asd
sb-sprof = D:/software/SBCL-2.6.0/contrib/sb-sprof.asd
nil

* (asdf/source-registry:default-system-source-registry)
(:source-registry
 (:directory (#P"C:/Users/zhouj/AppData/Roaming/common-lisp/" "systems/"))
 (:tree (#P"C:/Users/zhouj/AppData/Roaming/common-lisp/" "source/"))
 (:directory (#P"C:/ProgramData/Application Data/common-lisp/" "systems/"))
 (:tree (#P"C:/ProgramData/Application Data/common-lisp/" "source/"))
 :inherit-configuration)

* (asdf/source-registry:default-user-source-registry)
(:source-registry (:tree (:home "common-lisp/"))
 (:directory (:home ".sbcl/systems/"))
 (:directory #P"C:/Users/zhouj/AppData/Local/common-lisp/systems/")
 (:tree #P"C:/Users/zhouj/AppData/Local/common-lisp/source/")
 :inherit-configuration)
```

load system
```lisp
(asdf:load-system "my-system")

; load-asd
(asdf:load-asd "absolute/path/to/my-project.asd")
; (asdf:load-asd (uiop:subpathname (uiop:getcwd) "my-project.asd"))
```

# Make system

custom system path
```shell
# Windows Git Bash
~/AppData/Local/config/common-lisp/source-registry.conf.d/xxx.conf
# Others
~/.config/common-lisp/source-registry.conf.d/xxx.conf

# content
(:tree "/absolute/path/to/your-direcotry/")
```

example: [ex-cl-project](../cl-project/ex-cl-project/README.markdown)
```shell
# in folder ex-cl-project

# Windows Git Bash
mkdir -p ~/AppData/Local/config/common-lisp/source-registry.conf.d/
CURRENT_DIR=`pwd`
SYSTEM_NAME=ex-cl-project
echo '(:tree "'${CURRENT_DIR/\/d/D:}'/")' > ~/AppData/Local/config/common-lisp/source-registry.conf.d/$SYSTEM_NAME.conf

# Windows WSL
mkdir -p ~/.config/common-lisp/source-registry.conf.d/
CURRENT_DIR=`pwd`
SYSTEM_NAME=ex-cl-project
echo '(:tree "'${CURRENT_DIR}'/")' > ~/.config/common-lisp/source-registry.conf.d/$SYSTEM_NAME.conf
```

## `defsystem`
```lisp
system-definition := ( defsystem system-designator system-option* )

(* 系统标识 *)
system-designator := simple-component-name
                    | complex-component-name
(* see [Simple component names], page 18, NOTE: Underscores are not permitted. *)
simple-component-name := lower-case string | symbol
(* see [Complex component names], page 19, 支持在一个.asd文件中放置多个系统 *)
complex-component-name := string | symbol

(* 系统选项 *)
system-option := :defsystem-depends-on system-list (* 定义系统间依赖关系 *)
                | :weakly-depends-on system-list
                | :class class-name (* 系统类, see [System class names], page 19 *)
                | :build-pathname pathname-specifier
                | :build-operation operation-name
                | system-option/asdf3
                | module-option
                | option
(* ASDF3中系统选项: These are only available since ASDF 3 (actually its alpha release 2.27) *)
system-option/asdf3 := :homepage string
                      | :bug-tracker string
                      | :mailto string
                      | :long-name string
                      | :source-control source-control
                      | :version version-specifier
                      | :entry-point object (* 指定可执行程序的入口点, see [Entry point], page 24 *)
(* 源码控制 *)
source-control := ( keyword string )
(* 模块选项 *)
module-option := :components component-list
                | :serial [ t | nil ]
(* 具体的选项 *)
option := :description string
          | :long-description string
          | :author person-or-persons
          | :maintainer person-or-persons
          | :pathname pathname-specifier (* 代码位置 *)
          | :default-component-class class-name
          | :perform method-form
          | :explain method-form
          | :output-files method-form
          | :operation-done-p method-form
          | :if-feature feature-expression (* 类似于#+ *)
          | :depends-on ( dependency-def* )
          | :in-order-to ( dependency+ )

person-or-persons := string | ( string+ )

system-list := ( simple-component-name* )

component-list := ( component-def* )
(* 组件定义 *)
component-def := ( component-type simple-component-name option* )
(* 组件类型, see [Component types], page 19 *)
component-type := :module | :file | :static-file | other-component-type
other-component-type := symbol-by-name

(* :depends-on中依赖定义 *)
(* This is used in :depends-on, as opposed to "dependency", which is used in :in-order-to *)
dependency-def := simple-component-name
                  | ( :feature feature-expression dependency-def ) (* 按特性定义依赖, see [Feature dependencies], page 22 *)
                  | ( :version simple-component-name version-specifier )
                  | ( :require module-name )

(* :in-order-to中依赖定义 *)
(* "dependency" is used in :in-order-to, as opposed to "dependency-def" *)
dependency := ( dependent-op requirement+ )
requirement := ( required-op required-component+ )
dependent-op := operation-name
required-op := operation-name

(* 路径名描述符 *)
(* NOTE: pathnames should be all lower case, and have no underscores, although hyphens are permitted. *)
pathname-specifier := pathname | string | symbol

(* 版本描述符. *)
version-specifier := string
                    | ( :read-file-form pathname-specifier form-specifier? )
                    | ( :read-file-line pathname-specifier line-specifier? )
line-specifier := :at integer (* base zero *)
form-specifier := :at [ integer | ( integer+ ) ]

(* 方法形式 *)
method-form := ( operation-name qual lambda-list &rest body )
qual := method-qualifier?
method-qualifier := :before | :after | :around

(* 特性表达式 *)
feature-expression := keyword
                      | ( :and feature-expression* )
                      | ( :or feature-expression* )
                      | ( :not feature-expression )

(* 操作名 *)
operation-name := symbol
```

## example: `foo.asd`
```lisp
(in-package :asdf-user)

(defsystem "foo"                                       ; system foo
  :version (:read-file-form "variables" :at (3 2))     ; system version: (defparameter *foo-version* "5.6.7")
  :components
  ((:file "package")                                   ; source file 
   (:file "variables" :depends-on ("package"))         ; source file dependency
   (:module "mod"                                      ; module mod: subdirectory
            :depends-on ("package")
            :serial t                                  ; source file dependency order
            :components ((:file "utils")
                         (:file "reader")
                         (:file "cooker")
                         (:static-file "data.raw"))    ; static file
            ; method-form
            :output-files (compile-op (o c) (list "data.cooked"))
            :perform (compile-op :after (o c)
                                 (cook-data
                                  :in (component-pathname (find-component c "data.raw"))
                                  :out (first (output-files o c)))))
   (:file "foo" :depends-on ("mod"))                   ; source file
  )
)

(defmethod action-description
  ((o compile-op) (c (eql (find-component "foo" "mod"))))
  "cooking data")
```

# package `asdf` `uiop`
* https://asdf.common-lisp.dev/uiop.html

```lisp
* (asdf:run-shell-command "ls") 
* (uiop:run-program "ls") 

* (uiop:getcwd)
#P"D:/workspace/github/learning-lisp/CommonLisp/"
* (uiop:subpathname (uiop:getcwd) "CommonLisp.md")
#P"D:/workspace/github/learning-lisp/CommonLisp/CommonLisp.md"
```

# See Also
* [ASDF Best Practices](https://gitlab.common-lisp.net/asdf/asdf/blob/master/doc/best_practices.md)
* [Getting started with ASDF](https://common-lisp.net/~mmommer/asdf-howto.shtml) - 2006-04-05
* [SBCL - ASDF: Another System Definition Facility](https://www.sbcl.org/manual/asdf.html)
