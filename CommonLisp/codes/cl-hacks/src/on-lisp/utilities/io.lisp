(defpackage :on-lisp/utilities/io
  (:use #:cl)
  (:export #:readlist
	   #:prompt
	   #:break-loop))

(in-package :on-lisp/utilities/io)

(format t "on-lisp/utilities/io~&")

(defun readlist (&rest args)
  "Read a line of input, return it as a list."
  (values (read-from-string
	   (concatenate 'string "(" (apply #'read-line args)  ")"))))
;;; (readlist)
;; Call me "Ed"
;; (CALL ME "Ed")


(defun prompt (&rest args)
  "Print a question and read the answer."
  (apply #'format *query-io* args)
  (read *query-io*))
;;; (prompt "Enter a number between ~A and ~A~%>> " 1 10)
;; Enter a number between 1 and 10
;; >> 3
;; 3

(defun break-loop (fn quit &rest args)
  "A simple toplevel."
  (format *query-io* "Entering break-loop.~%")
  (loop
    (let ((in (apply #'prompt args)))
      (if (funcall quit in)
	  (return)
	  (format *query-io* "~A~%" (funcall fn in))))))
;;; (break-loop #'eval #'(lambda (x) (eq x :q)) ">>")
;; Entering break-loop.
;; >>
;; CL-USER> (+ 2 3)
;; 5
;; >>(+ 1 2)
;; 3
;; >>:q
;;  :q
;; :Q
;; NIL
