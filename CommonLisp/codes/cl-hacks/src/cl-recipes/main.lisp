(defpackage :cl-recipes
  (:use :cl)
  (:export :hello))
(in-package :cl-recipes)

(defun hello ()
  (format t "Examples in Common Lisp Recipes."))