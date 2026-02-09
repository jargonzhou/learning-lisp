(defpackage :ansi-cl
  (:use :cl)
  (:export :hello))
(in-package :ansi-cl)

(defun hello ()
  (format t "Examples in ANSI Common Lisp."))