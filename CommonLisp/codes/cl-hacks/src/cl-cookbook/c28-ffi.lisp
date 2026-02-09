(defpackage :cl-cookbook/c28-ffi
  (:use #:cl
        #:cffi
        #:log4cl))

(in-package :cl-cookbook/c28-ffi)


(log:info "cl-cookbook/c28-ffi")

;;; CFFI
(cffi:defcfun ("ceil" c-ceil) :double (number :double))
(cffi:defcfun ("floor" c-floor) :double (number :double))
(cffi:defcfun ("sqrt" c-sqrt) :double (number :double))

(c-ceil 5.4d0)
;;; 6.0d0

(c-floor 5.4d0)
;;; 5.0d0

(c-sqrt 36.50d0)
;;; 6.041522986797286d0
(+ 2 (c-sqrt 3d0))
;;; 3.732050807568877d0
(mapcar #'c-sqrt '(3d0 4d0 5d0 6d0 7.5d0 12.75d0))
;;; (1.7320508075688772d0 2.0d0 2.23606797749979d0 2.449489742783178d0
;;; 2.7386127875258306d0 3.570714214271425d0)
