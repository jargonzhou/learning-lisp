(defpackage :on-lisp
  (:use :cl)
  (:export :hello))
(in-package :on-lisp)

(defun hello ()
  (format t "Examples in On Lisp."))