(defpackage :let-over-lambda
  (:use :cl)
  (:export :hello))
(in-package :let-over-lambda)

(defun hello ()
  (format t "Examples in Let Over Lambda."))