(defpackage :cl-cookbook/c22-packages
  (:use #:cl
        #:cl-ppcre
        #:log4cl)
  (:export #:hello))

;;; #: does NOT intern a new symbol in current package

(in-package :cl-cookbook/c22-packages)

(log:info "cl-cookbook/c22-packages")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; create a package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defpackage
;;; in-package

(defun hello ()
  (print "Hello from my package."))

;;; 1. access symbols from a package

;;; :: when symbol is not exported
;;; (package::non-exported-symbol)

;;; cl-user>(in-package :my-package)
;;; #<PACKAGE "MY-PACKAGE">
;;;
;;; my-package>(hello)
;;; "Hello from my package." 
;;; Hello from my package.
;;; 
;;; cl-user>(my-package::hello)
;;; "Hello from my package." 
;;; Hello from my package.

;;; with :export
;;; cl-user>(my-package:hello)
;;; "Hello from my package." 
;;; Hello from my package.

;;; 2. export symbols

;;; 3. import symbols from another package

;;; 4. import all symbols

;;; 5. :use

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; list all symbols in a package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; do-symbols
;;; do-external-symbols

;;; find-package


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package nickname
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. PLN: package local nicknames
;;; uiop:add-package-local-nickname
;;; defpackage: :local-nicknames, :nicknames
;;; rename-package


;;; 2. package locks
;;; lib: cl-package-lock
