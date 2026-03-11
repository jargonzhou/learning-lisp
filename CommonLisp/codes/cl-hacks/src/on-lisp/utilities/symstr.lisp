(defpackage :on-lisp/utilities/symstr
  (:use #:cl)
  (:export #:mkstr
	   #:symb
	   #:reread
	   #:explode))

(in-package :on-lisp/utilities/symstr)

(format t "on-lisp/utilities/symstr~&")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Symbols and Strings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mkstr (&rest args)
  "Take any number of arguments, concatenate their printed representation into a string."
  (with-output-to-string (s)
    (dolist (a args) (princ a s))))
(mkstr pi " pieces of " 'pi) ; "3.141592653589793d0 pieces of PI"

(defun symb (&rest args)
  "Take any number of arguments, return the symbol whose print-name is their concatenation."
  (values (intern (apply #'mkstr args))))
(symb 'ar "Madi" #\L #\L 0) ; |ARMadiLL0|

(defun reread (&rest args)
  "Take any number of arguments, print and reread them"
  (values (read-from-string (apply #'mkstr args))))
(reread 'cl:defun) ; DEFUN
(reread "(" '+ 1 2 ")") ; (12)
(mkstr "(" '+ 1 2 ")") ; "(+12)"
(read-from-string "(+12)") ; (12) 5

(defun explode (sym)
  "Take a symbol, return a list of symbols made from the characters in its name."
  (map 'list #'(lambda (c)
		 (intern (make-string 1 :initial-element c)))
       (symbol-name sym)))
(explode 'bomb) ; (B O M B)


