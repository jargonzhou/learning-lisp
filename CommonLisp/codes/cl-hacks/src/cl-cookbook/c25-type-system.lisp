(defpackage :cl-cookbook/c25-type-system
  (:use #:cl
        #:serapeum
        #:log4cl)
  (:import-from #:defstar
                #:defun*))

(in-package :cl-cookbook/c25-type-system)


(log:info "cl-cookbook/c25-type-system")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; values/objects have types, not variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar *var* 1234)
(type-of *var*)
;;; (INTEGER 0 4611686018427387903) <- a type specifier

(setf *var* "hello")
(type-of *var*)
;;; (SIMPLE-ARRAY CHARACTER (5))

(type-of 1234)
;;; (INTEGER 0 4611686018427387903)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; type hierarchy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(describe 'integer)
;;; COMMON-LISP:INTEGER
;;;   [symbol]
;;; INTEGER names the built-in-class #<BUILT-IN-CLASS COMMON-LISP:INTEGER>:
;;;   Class precedence-list: INTEGER, RATIONAL, REAL, NUMBER, T
;;;   Direct superclasses: RATIONAL
;;;   Direct subclasses: BIGNUM, FIXNUM
;;;   Sealed.
;;;   No direct slots.
;;; INTEGER names a primitive type-specifier:
;;;   Lambda-list: (&OPTIONAL (LOW (QUOTE *)) (HIGH (QUOTE *)))
;;; NIL

(type-of 1234)
;;; (INTEGER 0 4611686018427387903)
(class-of 1234)
;;; #<BUILT-IN-CLASS COMMON-LISP:FIXNUM>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; checking types
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(typep 1234 'integer)
;;; T

(subtypep 'integer 'number)
;;; T
;;; T
(subtypep 'string 'number)
;;; NIL
;;; T

;;; typecase
(defun plus1 (arg)
  (typecase arg
    (integer (+ arg 1))
    (string (concatenate 'string arg "1"))
    (t 'error)))
(values
  (plus1 100)
  (plus1 "hello")
  (plus1 'hello))
;;; 101
;;; hello1
;;; ERROR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; type specifier
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compound type specifier
(typep #(1 2 3) '(vector number 3)) ; T
(typep #(1 2 3) '(vector number *)) ; T
(typep #(1 2 3) '(vector number)) ; T
(typep #(1 2 3) '(vector)) ; T
(typep #(1 2 3) 'vector) ; T

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; define new types: deftype
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; enum type
(deftype fruite () '(member :apple :orange :pear))
(typep :apple 'fruite) ; T
(typep :computer 'fruite) ; NIL

(defun small-number-array-p (thing)
  (and (arrayp thing)
       (<= (length thing) 10)
       (every #'numberp thing)
       (every (lambda (x) (< x 10)) thing)))
(deftype small-number-array (&optional type)
  `(and (array ,type 1)
        (satisfies small-number-array-p)))
(typep #(1 2 3 4) '(small-number-array number)) ; T
(typep #(1 2 3 4) 'small-number-array) ; T
(typep #(1 2 3 4 100) 'small-number-array) ; NIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; run-time type checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun plus1-check (arg)
  (check-type arg number)
  (1+ arg))
(plus1-check 1) ; 2
;;; (plus1-check "hello")
;;; The value of ARG is "hello", which is not of type NUMBER.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compile-time type checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; provide type info for variables: proclaim/declaim at toplevel, declare inside functions and macros

;;; SBCL does type checking
(defconstant +foo+ 3)
;;; (defun bar ()
;;;   (concatenate 'string "+" +foo+))
;;; caught WARNING:
;;;   Constant 3 conflicts with its asserted type SEQUENCE.
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"

;;; 1. declaring the type of variables
(declaim (type (string) *name*))
(defparameter *name* "book")
;;; (setf *name* :me)
;;; Value of :ME in (THE STRING :ME) is :ME, not a STRING.

(defun list-of-strings-p (list)
  "Return t if LIST is non nil and contains only strings."
  (and (consp list)
       (every #'stringp list)))
(deftype list-of-strings ()
  `(satisfies list-of-strings-p))

(declaim (type (list-of-strings) *all-names*))
;;; (defparameter *all-names* "")
;;; Cannot set SYMBOL-VALUE of *ALL-NAMES* to "", not of type
;;; (SATISFIES LIST-OF-STRINGS-P).
(defparameter *all-names* '(""))

;;; 2. composing types
(declaim (type (or null list-of-strings) *all-names-or-null*))

;;; 3. declaring the input and output types of functions
(declaim (ftype (function (fixnum) fixnum) add))
(defun add (n)
  (+ n 1))
;;; (defun bad-concat (n)
;;;   (concatenate 'string (add n)))
;;;   conflicting with its asserted type
;;;     SEQUENCE.
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"

(declaim (ftype (function (string)) bad-arg))
;;; (defun bad-arg (n)
;;;   (add n))
;;; caught WARNING:
;;;   Derived type of CL-COOKBOOK/C25-TYPE-SYSTEM::N is
;;;     (VALUES STRING &OPTIONAL),
;;;   conflicting with its asserted type
;;;     FIXNUM.
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"

;;; 4. declaring &key parameters: &key (:argument type)
(declaim (ftype (function (string &key (:n integer))) foo))
(defun foo (bar &key n)
  (list bar n))
(foo "bar" :n 1) ; (bar 1)

;;; 5. declaring &rest parameters
(declaim (ftype (function (&rest fruite)) place-order))
;;; (defun place-order (&rest selections)
;;;   (dolist (s selections)
;;;     (format t "Ordering ~S~%" s)))
;;; (defun placing-orders ()
;;;   (place-order :orange :apple :bacon))
;;; caught WARNING:
;;;   Constant :BACON conflicts with its asserted type (MEMBER :PEAR :ORANGE :APPLE).
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"

;;; (defun place-order (&rest selections)
;;;   (dolist (s selections)
;;;     ; declare
;;;     (declare (type fruite s))
;;;     (format t "Ordering ~S~%" s)))
;;; (defun placing-orders ()
;;;   (place-order :orange :apple :bacon))
;;; caught WARNING:
;;;   Constant :BACON conflicts with its asserted type (MEMBER :PEAR :ORANGE :APPLE).
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"

;;; 6. declaring class slots types
;;; (defclass foo-class ()
;;;     ((name :type number :initform "17")))
;;; caught WARNING:
;;;   Constant "17" conflicts with its asserted type NUMBER.
;;;   See also:
;;;     The SBCL Manual, Node "Handling of Types"
(defclass foo-class ()
    ((name :type number :initform 17)))

;;; 7. alternative type checking syntax: defstar, serapeum
(serapeum/types:-> mod-fixnum+ (fixnum fixnum) fixnum)
(defun mod-fixnum+ (x y) (mod x y))

(defun* sum ((a real) (b real))
        (+ a b))

;;; 8. limitations
;;; only check at boundary
#|
(declaim (ftype (function () string) bad-adder))
(defun bad-adder ()
  (let ((res 10))
    (loop for name in '("alice")
          do (incf res name))
    (format nil "finally doing sth with ~a" res)))
|#
;;; Derived type of CL-COOKBOOK/C25-TYPE-SYSTEM::NAME is ;
;;;   (VALUES (OR NULL VECTOR) &OPTIONAL), ;
;;; conflicting with its asserted type	;
;;;   NUMBER.				;
;;; (bad-adder)				;
;;; Value of NAME in (+ NAME RES) is "alice", not a NUMBER. ;
;;;
;(declaim (ftype (function () string) bad-adder2)) ;
;;;
;;; (defun bad-adder2 () ;
;;;   (let ((res 10)) ;
;;;     (loop for name in '("alice") ;
;;;             return (incf res name)))) ;
;;; (bad-adder2) ;
;;; Value of NAME in (+ NAME RES) is "alice", not a NUMBER. ;
#|					;
(defun bad-adder2 ()			; ;
(let ((res 10))				; ;
(loop for name in '("alice")		; ;
return (incf res (the string name)))))	; ;
|# ;
;;; caught WARNING: ;
;;;   Derived type of COMMON-LISP-USER::NAME is ; ; ;
;;;     (VALUES STRING &OPTIONAL),	; ; ;
;;;   conflicting with its asserted type	; ; ;
;;;     NUMBER.				; ; ;
;;;   See also:				; ; ;
;;;     The SBCL Manual, Node "Handling of Types" ; ; ;
