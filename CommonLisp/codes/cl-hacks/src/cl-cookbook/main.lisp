(defpackage :cl-cookbook
  (:use #:cl
        #:log4cl)
  (:export :hello))
(in-package :cl-cookbook)

;;; log4cl configuraion
(log:config
 :pretty
 :thread
 ;;; :pattern "%-5p [%c] - %m%n"
 )

(log:info "cl-cookbook")

(defun hello ()
  (format t "Examples in Common Lisp Cookbook."))
