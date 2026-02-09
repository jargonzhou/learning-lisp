;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Test coverage helper
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(require :uiop)
(require :sb-cover)
;;; to use quicklisp
(load "~/.sbclrc")
(ql:quickload "fiveam" :silent t)
;(require :fiveam)

(declaim (optimize sb-cover:store-coverage-data))

(asdf:oos 'asdf:load-op :cl-hacks :force t)

(ql:quickload "cl-hacks/tests")
(fiveam:run! 'cl-hacks/tests/main:main-system)

(sb-cover:report "coverage/")

(declaim (optimize (sb-cover:store-coverage-data 0)))
