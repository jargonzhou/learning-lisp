# Quicklisp
* https://www.quicklisp.org/beta/

> Quicklisp is a library manager for Common Lisp. It works with your existing Common Lisp implementation to download, install, and load any of over 1,500 libraries with a few simple commands.
>
> Quicklisp is easy to install and works with ABCL, Allegro CL, Clasp, Clozure CL, CLISP, CMUCL, ECL, LispWorks, MKCL, SBCL, and Scieneer CL, on Linux, Mac OS X, and Windows.
>
> The Quicklisp beta includes the following projects: https://www.quicklisp.org/beta/releases.html

# Setup

```shell
$ curl -O https://beta.quicklisp.org/quicklisp.lisp
$ sbcl --load quicklisp.lisp
* (quicklisp-quickstart:install)
  ==== quicklisp installed ====
    To load a system, use: (ql:quickload "system-name")
    To find systems, use: (ql:system-apropos "term")
    To load Quicklisp every time you start Lisp, use: (ql:add-to-init-file)
    For more information, see http://www.quicklisp.org/beta/

# https://github.com/xach/vecto
* (ql:system-apropos "vecto")
* (ql:quickload "vecto")
(defpackage #:vecto-examples
  (:use #:cl #:vecto))
(in-package #:vecto-examples)
(defun radiant-lambda (file)
  (with-canvas (:width 90 :height 90)
   ; font: https://github.com/georgmartius/lpzrobots/blob/master/ode_robots/osg/data/fonts/times.ttf
    (let ((font (get-font "times.ttf"))
          (step (/ pi 7)))
      (set-font font 40)
      (translate 45 45)
      (draw-centered-string 0 -10 "A"); #(#\U+03bb)
      (set-rgb-stroke 1 0 0)
      (centered-circle-path 0 0 35)
      (stroke)
      (set-rgba-stroke 0 0 1.0 0.5)
      (set-line-width 4)
      (dotimes (i 14)
        (with-graphics-state
          (rotate (* i step))
          (move-to 30 0)
          (line-to 40 0)
          (stroke)))
      (save-png file))))
(radiant-lambda "lambda.png")

* (ql:uninstall "vecto")

* (ql:add-to-init-file)
#P"~/.sbclrc"
* (cl:in-package "CL-USER")
* (quit)
$
```

# Commands

```lisp
(ql:help)

ql:*quicklisp-home*
```

load software
```lisp
(ql:quickload system-name)
CL-USER> (ql:quickload "vecto")
```

remove software
```lisp
(ql:uninstall system-name)
CL-USER> (ql:uninstall "vecto")
```

find software
```lisp
(ql:system-apropos substring)
CL-USER> (ql:system-apropos "xml")

; To find out what's available
(ql-dist:system-apropos "vecto")
(ql-dist:system-apropos-list "vecto")

; (ql:system-list)
(ql:list-local-systems)
(ql:list-local-projects)
```

see what systems depend on a particular system
```lisp
(ql:who-depends-on system-name)
```

go back to a previous set of libraries: 

load Quicklisp when you start Lisp
```lisp
(ql:add-to-init-file)
```

install and configure SLIME
```lisp
(ql:quickload "quicklisp-slime-helper")
```

get updated software
```lisp
(ql:update-dist "quicklisp")
```

update the Quicklisp client
```lisp
(ql:update-client)
```

# library bundles
* https://www.quicklisp.org/beta/bundles.html

Quicklisp library bundles are self-contained sets of systems that are exported from Quicklisp and loadable without involving Quicklisp.

# Quicklisp Controller
* https://github.com/quicklisp/quicklisp-controller

The Quicklisp Controller is responsible for building and updating Quicklisp distributions from a project list (maintained separately in the quicklisp-projects repo).

# Misc

default library location:
- `~/quicklisp/local-projects`
- `~/common-lisp`
- `~/.local/share/common-lisp/source`

# See Also
* [quicklisp-projects](https://github.com/quicklisp/quicklisp-projects): Metadata for projects tracked by Quicklisp.
* [quicklisp - Library Manager](https://github.com/cl-library-docs/common-lisp-libraries/blob/master/docs/quicklisp.md)