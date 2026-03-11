(defpackage :cl-cookbook/c21-error
  (:use #:cl
        #:log4cl)
  (:import-from #:trivial-backtrace
		#:print-backtrace))

(in-package :cl-cookbook/c21-error)

(log:info "cl-cookbook/c21-error")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; throwing/catching v.s. signaling/handling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; throw, catch: trasfer control
;;; conditions: signaled and handled

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ignoring all errors, return nil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ignore-errors
(ignore-errors
 (/ 3 0)) ; #<DIVISION-BY-ZERO {110221C553}>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; handle all error conditions with handler-case
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; handler-case
;;; error
(handler-case (/ 3 0)
  (error (c)
    (format t "We handled an error.~&")
    (values 0 c))) ; 0 #<DIVISION-BY-ZERO {1102832233}>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; handle a specific condition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; handler-case
;;; division-by-zero
(handler-case (/ 3 0)
  (division-by-zero (c)
    (format t "Got division by zero: ~a~&" c))) ; Got division by zero: arithmetic error DIVISION-BY-ZERO signalled
					; Operation was (/ 3 0).

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; absolute control over condtions and restarts: handler-bind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; handler-bind
(defun handler-bind-example ()
  (handler-bind
      ((error (lambda (c)
		(format t "we handle this condtion: ~a" c)
		(return-from handler-bind-example))))
    (format t "starting example...~&")
  (error "oh no")))
(handler-bind-example)
;;; starting example...
;;; we handle this condtion: oh no
;;; NIL


;;; lib: trivial-backtrace
(defun f0 ()
  (error "oh no"))
(defun f1 ()
  (f0))
(defun f2 ()
  (f1))

(defun main ()
  (handler-case (f2)
    (error (c)
      (format t "in main, we handle: ~a" c)
      (trivial-backtrace:print-backtrace c :output t))))
(main)
;;; in main, we handle: oh no
;;; 0: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE-TO-STREAM NIL)
;;; 1: (PRINT-BACKTRACE #<SIMPLE-ERROR "oh no" {1104868353}> :OUTPUT T :IF-EXISTS :APPEND :VERBOSE NIL)
;;; 2: (SB-INT:SIMPLE-EVAL-IN-LEXENV (MAIN) #<NULL-LEXENV>)
;;; 3: (EVAL (MAIN))
;;; 4: ((LAMBDA NIL :IN SWANK:PPRINT-EVAL))
;;; 5: (SWANK::CALL-WITH-BUFFER-SYNTAX NIL #<FUNCTION (LAMBDA NIL :IN SWANK:PPRINT-EVAL) {110486817B}>)
;;; 6: (SB-INT:SIMPLE-EVAL-IN-LEXENV (SWANK:PPRINT-EVAL "(main)") #<NULL-LEXENV>)
;;; 7: (EVAL (SWANK:PPRINT-EVAL "(main)"))
;;; 8: (SWANK:EVAL-FOR-EMACS (SWANK:PPRINT-EVAL "(main)") ":cl-cookbook/c21-error" 72)
;;; ...
(defun main-no-stack-unwinding ()
  (handler-bind
      ((error (lambda (c)
		(format t "in main, we handle: ~a" c)
		(trivial-backtrace:print-backtrace c :output t)
		(return-from main-no-stack-unwinding))))
    (f2)))
(main-no-stack-unwinding)
;;; in main, we handle: oh no
;;; 0: (TRIVIAL-BACKTRACE:PRINT-BACKTRACE-TO-STREAM NIL)
;;; 1: (PRINT-BACKTRACE #<SIMPLE-ERROR "oh no" {1101130393}> :OUTPUT T :IF-EXISTS :APPEND :VERBOSE NIL)
;;; 2: ((LAMBDA (C) :IN MAIN-NO-STACK-UNWINDING) #<SIMPLE-ERROR "oh no" {1101130393}>)
;;; 3: (SB-KERNEL::%SIGNAL #<SIMPLE-ERROR "oh no" {1101130393}>)
;;; 4: (ERROR "oh no")
;;; 5: (F0)
;;; 6: (MAIN-NO-STACK-UNWINDING)
;;; 7: (SB-INT:SIMPLE-EVAL-IN-LEXENV (MAIN-NO-STACK-UNWINDING) #<NULL-LEXENV>)
;;; 8: (EVAL (MAIN-NO-STACK-UNWINDING))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; run some code, conditon or not: unwind-protect
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; unwind-protect
(unwind-protect
     (/ 3 0)
  (format t "This place is safe.~&"))
;; debugger invoked on a DIVISION-BY-ZERO @10002875D5 in thread
;; #<THREAD tid=8392 "main thread" RUNNING {1100030003}>:
;;   arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;
;; Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.
;
;; restarts (invokable by number or by possibly-abbreviated name):
;;   0: [ABORT] Exit debugger, returning to top level.
;
;; (SB-KERNEL::INTEGER-/-INTEGER 3 0)
;; 0] 0
;; This place is safe.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; define and make conditions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; define-condition
;;; make-condition
(define-condition my-division-by-zero (error)
  ())
(make-condition 'my-division-by-zero) ; #<MY-DIVISION-BY-ZERO {11053C8393}>

(define-condition my-division-by-zero-2 (error)
  ;; slots
  ((dividend :initarg :dividend
	     :initform nil
	     :reader dividend))
  ;; doc
  (:documentation "Custom error when we encounter a division by zero."))
(make-condition 'my-division-by-zero-2 :dividend 3) ; #<MY-DIVISION-BY-ZERO-2 {1101400393}>
(dividend (make-condition 'my-division-by-zero-2 :dividend 3)) ; 3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; signal conditions: error, cerror, warn, signal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; error
;;; cerror: like error, but establish a `continue` restart
;;; warn: not enter the debugger
;;; signal: signal to the upper levels

;; (error 'my-division-by-zero-2 :dividend 3)
;; Condition CL-COOKBOOK/C21-ERROR::MY-DIVISION-BY-ZERO-2 was signalled.
;;    [Condition of type MY-DIVISION-BY-ZERO-2]
;; same as:
;; (error (make-condition 'my-division-by-zero-2 :dividend 3))
(warn "something bad happened")


;;; simple-error: simple-condition, error, serious-condition, conditon, t
;;; simple-warning: simple-condition, warning, condition, t

;;; :report: custom error message
(define-condition my-division-by-zero-3 (error)
  ((dividend :initarg :dividend
	     :initform nil
	     :accessor dividend))
  ;; message into the debugger
  (:report (lambda (condition stream)
	     (format stream "You were going to divide ~a by zero.~&" (dividend condition)))))
;;; (error 'my-division-by-zero-3 :dividend 3)
;; You were going to divide 3 by zero.
;;    [Condition of type MY-DIVISION-BY-ZERO-3]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; inspect the stacktrace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; restarts, interactive choices in the debugger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; assert
(assert (realp 3))
(defun divide (x y)
  (assert (not (zerop y)))
  (/ x y))
;;; (divide 3 0)
;; The assertion (NOT (ZEROP Y)) failed with (ZEROP Y) = T.
;;    [Condition of type SIMPLE-ERROR]
(defun divide-2 (x y)
  (assert (not (zerop y))
	  (y) ; values that we can change
	  "Y can not be zero. Please change it")
  (/ x y))
;;; (divide-2 3 0)
;; Y can not be zero. Please change it
;;    [Condition of type SIMPLE-ERROR]

;;; restart-case
(defun divide-with-restarts (x y)
  (restart-case (/ x y)
    (return-zero ()
      ; optional report
      :report "Return 0"
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))))
;;; (divide-with-restarts 3 0)
;; arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;;    [Condition of type DIVISION-BY-ZERO]
;;
;; Restarts:
;;  0: [RETURN-ZERO] Return 0
;;  1: [DIVIDE-BY-ONE] Divide by 1
;;  2: [*ABORT] Return to SLIME's top level.
;;  3: [ABORT] abort thread (#<THREAD tid=23704 "worker" RUNNING {11039DA843}>)

;;; change a varibale with restarts
(defun prompt-new-value (prompt)
  (format *query-io* prompt)
  (force-output *query-io*)
  (list (read *query-io*)))
(defun divide-with-restarts-2 (x y)
  (restart-case (/ x y)
    (return-zero ()
      :report "Return 0"
      0)
    (divide-by-one ()
      :report "Divide by 1"
      (/ x 1))
    (set-new-divisor (value)
      :report "Enter a new divisor"
      ;; ask for new value
      :interactive (lambda () (prompt-new-value "Please enter a new divisor: "))
      (divide-with-restarts-2 x value))))
;;; (divide-with-restarts-2 3 0)
;; arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;;    [Condition of type DIVISION-BY-ZERO]
;;
;; Restarts:
;;  0: [RETURN-ZERO] Return 0
;;  1: [DIVIDE-BY-ONE] Divide by 1
;;  2: [SET-NEW-DIVISOR] Enter a new divisor

;;; call restarts programmatically
;;; handler-bind, invoke-restart
(defun divide-and-handle-error (x y)
  (handler-bind
      ((division-by-zero (lambda (c)
			   (format t "Got error: ~a~&" c)
			   (format t "and will divide by 1~&")
			   ;; call restarts
			   (invoke-restart 'divide-by-one))))
    (divide-with-restarts-2 x y)))
(divide-and-handle-error 3 0)
;; Got error: arithmetic error DIVISION-BY-ZERO signalled
;; Operation was (/ 3 0).
;; and will divide by 1
;;
;; 3

;;; find-restasrt
;;; restart-case :test

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; invoke the debugger manually
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; invoke-debugger
;;; (invoke-debugger (error "something wrong"))
;; something wrong
;;    [Condition of type SIMPLE-ERROR]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; disable the debugger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sbcl --disable-debugger
