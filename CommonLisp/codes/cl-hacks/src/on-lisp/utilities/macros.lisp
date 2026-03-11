(defpackage :on-lisp/utilities/macros
  (:use #:cl)
  (:export #:mac))

(in-package :on-lisp/utilities/macros)

(format t "on-lisp/utilities/macros~&")

(defmacro mac (expr)
  `(pprint (macroexpand-1 ',expr)))
(mac (or x y))
;; (LET ((#:G242 X))
;;   (IF #:G242
;;       #:G242
;;       Y)); No value
