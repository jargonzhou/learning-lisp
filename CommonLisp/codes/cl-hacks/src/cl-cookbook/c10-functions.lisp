(defpackage :cl-cookbook/c10-functions
  (:use #:cl
        #:log4cl)
  (:import-from :alexandria
                #:curry)
  (:export #:hello-world))

(in-package :cl-cookbook/c10-functions)

(log:info "cl-cookbook/c10-functions")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun hello-world ()
  (print "hello world!"))

;;; cl-cookbook/c10-functions>(hello-world)
;;; "hello world!" 
;;; hello world!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; arguments
;;;
;;; required arguments
;;; optional arguments: &optional
;;; named parameters: &key
;;; default values to key parameters
;;; variable number of arguments: &rest
;;; defining key arguments and allowing more: &allow-other-keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun hello (name)
  (format t "hello ~a !~&" name))

;;; cl-cookbook/c10-functions>(hello "me")
;;; hello me !
;;; NIL

(defun hello-optional (name &optional age gender)
  (format t "hello name=~a age=~a gender=~a~&" name age gender))

;;; cl-cookbook/c10-functions>(hello-optional "me")
;;; hello name=me age=NIL gender=NIL
;;; NIL
;;; cl-cookbook/c10-functions>(hello-optional "me" "7")
;;; hello name=me age=7 gender=NIL
;;; NIL
;;; cl-cookbook/c10-functions>(hello-optional "me" 7 :h)
;;; hello name=me age=7 gender=H
;;; NIL

(defun hello-key (name &key happy)
  "If `happy` is `t`, print a smiley"
  (format t "hello ~a " name)
  (when happy
        (format t ":)~&")))

;;; cl-cookbook/c10-functions>(hello-key "me")
;;; hello me 
;;; NIL
;;; cl-cookbook/c10-functions>(hello-key "me" :happy t)
;;; hello me :)
;;; NIL
;;; cl-cookbook/c10-functions>(hello-key "me" :happy nil)
;;; hello me 
;;; NIL

;;; choose keys programmatically
(let ((key :happy)
      (val t))
  (hello-key "me" key val))
;;; hello me :)
;;; NIL

;;; mixing optional and key parameters
(defun hello-optional-key (&optional name &key happy)
  (format t "hello ~a " name)
  (when happy
        (format t ":)~&")))
;;; cl-cookbook/c10-functions>(hello-optional-key "me" :happy t)
;;; hello me :)
;;; NIL

;;; default values to key parameters
(defun hello-key-default-value (name &key (happy t))
  (format t "~a " name)
  (when happy
        (format t ":)~&")))
;;; cl-cookbook/c10-functions> (hello-key-default-value "me")
;;; me :)
;;; NIL
;;; cl-cookbook/c10-functions> (hello-key-default-value "me" :happy nil)
;;; me
;;; NIL

;;; was a key parameter specified?
;;; happy-p: a predicate variable
(defun hello-predicate-variable (name &key (happy nil happy-p))
  (format t "Key supplied? ~a~&" happy-p)
  (format t "hello ~a " name)
  (when happy-p
        (if happy
            (format t ":)")
            (format t ":("))))
;;; cl-cookbook/c10-functions>(hello-predicate-variable "me")
;;; Key supplied? NIL
;;; hello me 
;;; NIL
;;; cl-cookbook/c10-functions>(hello-predicate-variable "me" :happy t)
;;; Key supplied? T
;;; hello me :)
;;; NIL
;;; cl-cookbook/c10-functions>(hello-predicate-variable "me" :happy nil)
;;; Key supplied? T
;;; hello me :(
;;; NIL

(defun mean (x &rest numbers)
  (/ (apply #'+ x numbers)
     (1+ (length numbers))))
;;; cl-cookbook/c10-functions>(mean 1)
;;; 1
;;; cl-cookbook/c10-functions>(mean 1 2)
;;; 3/2
;;; cl-cookbook/c10-functions>(mean 1 2 3 4 5)
;;; 3

(defun hello-keys (name &key happy &allow-other-keys)
  (format t "hello ~a~&" name))
;;; cl-cookbook/c10-functions>(hello-keys "me" :lisper t)
;;; hello me
;;; NIL
(defun open-supersede (f &rest other-keys &key &allow-other-keys)
  (apply #'open f :if-exists :supersede other-keys))

;;; TODO: how to mix these stuff: named, optional, key, rest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; return values
;;;
;;; non-local exits: return-from
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; multiple return values
(values 'a 'b)
;;; A
;;; B
(+ (values 1 2 3) (values 10 20 30))
;;; 11

;;; capturing multiple values: multiple-value-bind, nth-value, multiple-value-list, ...
(multiple-value-bind (c d) (values 1 2)
  (list c d))
;;; (1 2)

;;; function values is setf-able
(let (c d)
  (setf (values c d) (values 1 2))
  (list c d))
;;; (1 2)
(let (c d)
  (multiple-value-setq (c d) (values 3 4))
  (list c d))
;;; (3 4)

(multiple-value-call #'list (values 1 2 3))
;;; (1 2 3)

(multiple-value-list (values 1 2 3))
;;; (1 2 3)

(nth-value 0 (values :a :b :c))
;;; A
(let ((l (list :a :b :c)))
  (values
    (nth-value 0 l)
    (nth-value 1 l)))
;;; (A B C)
;;; NIL

;;; use multiple values to report success or failure
(defvar *hash* (make-hash-table))
(setf (gethash 'a *hash*) 12)
(setf (gethash 'b *hash*) nil)
(gethash 'a *hash*)
;;; 12
;;; T
(gethash 'b *hash*)
;;; NIL
;;; T                       <-- whether key was found
(gethash 'c *hash*)
;;; NIL
;;; NIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lamnda: anonymous functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lambda expression in a car of compound form
((lambda (x) (print x)) "hello")
;;; "hello" 
;;; hello

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; calling functions programmatically
;;; funcall: with known number of arguments
;;; apply: with a list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(funcall #'+ 1 2)
;;; 3
(apply #'+ '(1 2))
;;; 3
(format t "call-arguments-limit: ~a~&" call-arguments-limit)
;;; call-arguments-limit: 1073741824

;;; reduce
(apply #'min '(22 1 2 3))
;;; 1
(reduce #'min '(22 1 2 3))
;;; 1

;;; trace, untrace
(trace min)
(reduce #'min '(22 1 2 3))
;;;   0: (MIN 22 1)
;;;   0: MIN returned 1
;;;   0: (MIN 1 2)
;;;   0: MIN returned 1
;;;   0: (MIN 1 3)
;;;   0: MIN returned 1
;;; 1
(untrace min)
(reduce #'min '(22 1 2 3))
;;; 1

;;; reference functions by names: #' or '
;;; #' respect lexical scope(catch the function by value), while ' not(always refer to symbols in the global environment)
(defun foo (x)
  (* x 100))
(flet ((foo (x) (1+ x)))
  (funcall #'foo 1))
;;; 2
(flet ((foo (x) (1+ x)))
  (funcall 'foo 1))
;;; 100
;;; #'xxx same as (function xxx)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; HOF: higher order functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functions that return functions: type `function`
(defun adder (n)
  (lambda (x) (+ x n)))
(adder 5)
;;; #<FUNCTION (LAMBDA (CL-COOKBOOK/C10-FUNCTIONS::X)
;;;              :IN
;;;              CL-COOKBOOK/C10-FUNCTIONS::ADDER) {11046E8D0B}>
(funcall (adder 5) 3)
;;; 8

;;; ((adder 5) 3)
;;; caught ERROR:
;;; illegal function call

;;; Common Lisp has different namespaces for functions and variables
(boundp 'bar)
;;; NIL
(fboundp 'bar)
;;; NIL
(defparameter bar 42)
(values
  (boundp 'bar)
  (symbol-value 'bar) ; symbol's cell: value cell, function cell
  (fboundp 'bar))
;;; T
;;; 42
;;; NIL
(defun bar (x) (* x x))
(values
  (boundp 'bar)
  (symbol-value 'bar)
  (fboundp 'bar)
  (symbol-function 'bar))
;;; T
;;; 42
;;; #<FUNCTION CL-COOKBOOK/C10-FUNCTIONS::BAR>
;;; #<FUNCTION CL-COOKBOOK/C10-FUNCTIONS::BAR>

(funcall #'adder 5)
;;; #<FUNCTION (LAMBDA (CL-COOKBOOK/C10-FUNCTIONS::X)
;;;              :IN
;;;              CL-COOKBOOK/C10-FUNCTIONS::ADDER) {11049A0B7B}>
(funcall (funcall #'adder 5) 3)
;;; 8

(describe bar)
;;; 42
;;;   [fixnum]
;;; NIL
(describe #'bar)
;;; #<FUNCTION BAR>
;;;   [compiled function]
;;; Lambda-list: (X)
;;; Derived type: (FUNCTION (T) (VALUES NUMBER &OPTIONAL))
;;; Source form:
;;;   (LAMBDA (X) (BLOCK BAR (* X X)))
;;; NIL

;;; (inspect bar)
;;; BUG in SBCL???


;;; car of a compound form
;;; a symbol: use symbol's function cell
;;; a lambda expression
(fboundp '*my-fun*)
;;; NIL
(setf (symbol-function '*my-fun*) (adder 3))
;;; #<FUNCTION (LAMBDA (CL-COOKBOOK/C10-FUNCTIONS::X)
;;;              :IN
;;;              CL-COOKBOOK/C10-FUNCTIONS::ADDER) {11035F5B7B}>
(fboundp '*my-fun*)
;;; #<FUNCTION (LAMBDA (CL-COOKBOOK/C10-FUNCTIONS::X)
;;;              :IN
;;;              CL-COOKBOOK/C10-FUNCTIONS::ADDER) {110486802B}>
(*my-fun* 5)
;;; 8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; closure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((limit 3)
      (counter -1))
  (defun my-counter ()
    (if (< counter limit)
        (incf counter)
        (setf counter 0))))
(my-counter)
;;; 0
(my-counter)
;;; 1
(my-counter)
;;; 2
(my-counter)
;;; 3
(my-counter)
;;; 0

;;; that's what we called let-over-lambda
(defun repeater (n)
  (let ((counter -1))
    (lambda ()
      (if (< counter n)
          (incf counter)
          (setf counter 0)))))
(defparameter *my-repeater* (repeater 3))
(dotimes (i 5)
  (print (funcall *my-repeater*)))
;;; 0 
;;; 1 
;;; 2 
;;; 3 
;;; 0 
;;; NIL

(defun fibonacci (n)
  (if (<= n 1)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))
;;; profiling
(time (fibonacci 40))
;;; Evaluation took:
;;;   1.583 seconds of real time
;;;   1.609375 seconds of total run time (1.562500 user, 0.046875 system)
;;;   [ Real times consist of 0.006 seconds GC time, and 1.577 seconds non-GC time. ]
;;;   [ Run times consist of 0.015 seconds GC time, and 1.595 seconds non-GC time. ]
;;;   101.64% CPU
;;;   4,621,660,162 processor cycles
;;;   48,529,184 bytes consed
;;; 102334155

;;; memo
(let ((memo (make-hash-table)))
  (defun fibonacci-memo (n)
    (let ((value (gethash n memo)))
      (cond ((<= n 1) n)
            (value value)
            (t (setf (gethash n memo)
                 (+ (fibonacci-memo (- n 1)) (fibonacci-memo (- n 2)))))))))
(time (fibonacci-memo 40))
;;; Evaluation took:
;;;   0.000 seconds of real time
;;;   0.000000 seconds of total run time (0.000000 user, 0.000000 system)
;;;   100.00% CPU
;;;   19,174 processor cycles
;;;   0 bytes consed
;;; 102334155

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; setf functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defparameter *square* (make-hash-table))
(setf (gethash :width *square*) 21)
;;; 21
(defun area (square)
  (expt (gethash :width square) 2))

(defun (setf area) (new-area square)
  (let ((width (sqrt new-area)))
    (setf (gethash :width square) width)))

(setf (area *square*) 100)
;;; 10.0
(maphash (lambda (k v) (format t "~a=~a" k v)) *square*)
;;; WIDTH=10.0
;;; NIL

(defun area-2 (w h)
  (* w h))
;;; optional arguments
(defun (setf area-2) (new-w-h square x y &key log)
  (list new-w-h square x y log))
(setf (area-2 'square 1 2 :log t) '(3 4))
;;; ((3 4) SQUARE 1 2 T)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; currying
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-curry (function &rest args)
  (lambda (&rest more-args)
    (apply function (append args more-args))))
(funcall (my-curry #'+ 3) 5)
;;; 8
(setf (symbol-function 'power-of-ten) (my-curry #'expt 10))
(power-of-ten 3)
;;; 1000

;;; alexandria curry
(defun adder-2 (foo bar)
  "Add the two arguments."
  (+ foo bar))
(defvar add-one (alexandria:curry #'adder-2 1) "Add 1 to the argument.")
(funcall add-one 10)
;;; 11
(defvar add-two (curry #'adder-2 2) "Add 2 to the argument.")
(funcall add-two 10)
;;; 12

(setf (symbol-function 'add-one) add-one)
(add-one 10)
;;; 11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; documentation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CLHS
;;; System Class FUNCTION
;;; 3.4.1 Ordinary Lambda Lists
;;; Macro MULTIPLE-VALUE-BIND
