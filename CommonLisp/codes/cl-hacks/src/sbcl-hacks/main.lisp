(defpackage :sbcl-hacks
  (:use :cl)
  (:export :hello))
(in-package :sbcl-hacks)

(defun hello ()
  (format t "Examples in SBCL."))