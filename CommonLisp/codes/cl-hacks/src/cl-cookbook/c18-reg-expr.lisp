(defpackage :cl-cookbook/c18-reg-expr
  (:use #:cl
        #:log4cl))

(in-package :cl-cookbook/c18-reg-expr)

(log:info "cl-cookbook/c18-reg-expr")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lib: cl-ppcre(Portable Perl-compatible regular expressions)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 1. scan, create-scanner: lokking for matching patterns

;;; 2. extracting information
;;; all-matches-as-strings
;;; all-matches
;;; count-matches

;;; scan-to-strings, register-groups-bind

;;; regex-replace, regex-replace-all
