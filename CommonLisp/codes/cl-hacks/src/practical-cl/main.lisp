(defpackage :practical-cl
  (:use :cl)
  (:export :hello))
(in-package :practical-cl)

(defun hello ()
  (format t "Examples in Practical Common Lisp."))