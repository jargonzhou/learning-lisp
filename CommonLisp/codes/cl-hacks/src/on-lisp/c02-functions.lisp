(defpackage :on-lisp/c02-functions
  (:use #:cl))

(in-package :on-lisp/c02-functions)

(format t "on-lisp/c02-functions~&")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; defining functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun double (x) (* x 2))
(double 1)
;;; get the function object
#'double
(eq #'double (car (list #'double))) ; T

;;; lambda expression
(lambda (x) (* x 2))
#'(lambda (x) (* x 2))
;;; lambda expressions are also names of functions
(double 3) ; 6
((lambda (x) (* x 2)) 3) ; 6

;;; function and variable with same name: difference namespace
(defvar double)
(setq double 2) ; 2
(double double) ; 4

(symbol-value 'double) ; 2
(symbol-function 'double) ; #<FUNCTION DOUBLE>
;;; a varibale has a function as its value
(defvar x)
(setq x #'append) ; #<FUNCTION APPEND>
(eq (symbol-value 'x) (symbol-function 'append)) ; T

;;; defun: set symbol-function of its first argument to a function
;;; build a function and associate it with a certain name are two seperate operations
(defvar double-2)
(setf (symbol-function 'double-2)
      #'(lambda (x) (* x 2))) ; #<FUNCTION (LAMBDA (X)) {10013F82BB}>
(double-2 3) ; 6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functional arguments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; apply: a function, a list of arguments for the function
(apply #'+ '(1 2)) ; 3
(apply (symbol-function '+) '(1 2)) ; 3
(apply #'(lambda (x y) (+ x y)) '(1 2)) ; 3

(apply #'+ 1 '(2)) ; 3

;;; funcall
(funcall #'+ 1 2) ; 3

;;; built-in functions
(mapcar #'(lambda (x) (+ x 10))
	'(1 2 3)) ; (11 12 13)
(mapcar #'+
	'(1 2 3)
	'(10 100 1000)) ; (11 102 1003)
(let ((lst (list 1 4 2 5 6 7 3)))
  (print (sort lst #'<))) ; (1 2 3 4 5 6 7)
;;; (sort '( 1 4 2 5 6 7 3) #'<)

(remove-if #'evenp '(1 2 3 4 5 6 7)) ; (1 3 5 7)

(defun our-remove-if (fn lst)
  (if (null lst)
      '()
      (if (funcall fn (car lst))
	  (our-remove-if fn (cdr lst))
	  (cons (car lst) (our-remove-if fn (cdr lst))))))
(our-remove-if #'evenp '(1 2 3 4 5 6 7)) ; (1 3 5 7)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functions as properties 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; extend to deal with new cases on the fly
(defun behave (animal)
  (case animal
    (:dog ((lambda () (format t "wag-tail~&")))
     ((lambda () (format t "bark~&"))))
    (:rat ((lambda () (format t "scurry~&")))
     ((lambda () (format t "squeak~&"))))
    (:cat ((lambda () (format t "rub-legs~&")))
     ((lambda () (format t "scratch-carpet~&"))))))
(let ((animal :dog))
  (behave animal))
;;; wag-tail
;;; bark

;;; get, setf
(defun behave-2 (animal)
  (funcall (get animal 'behavior)))
(setf (get :dog 'behavior)
      #'(lambda ()
	  ((lambda () (format t "wag-tail~&")))
	  ((lambda () (format t "bark~&")))	  ))

(behave-2 :dog)
;;; wag-tail
;;; bark


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; scope
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|
(let ((y 7))				
(defun scope-test (x)			
(list x y)))				
(scope-test 1) ; (1 7)
(let ((y 5))
  (declare (ignore y))
  (scope-test 2)) ; (2 7)
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; closures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; a combination of a function and a set of variable bindings

(defun list+ (lst n)
  (mapcar #'(lambda (x) (+ x n))
	  lst))
(list+ '(1 2 3) 10) ; (11 12 13)

;;; closures are functions with local state
(let ((counter 0))
  (defun new-id () (incf counter))
  (defun reset-id () (setq counter 0)))
;;; return functions with local state
(defun make-adder (n)
  #'(lambda (x) (+ x n)))
(defvar add2)
(defvar add10)
(setq add2 (make-adder 2)
      add10 (make-adder 10))
(funcall add2 5) ; 7
(funcall add10 3) ; 13

(defun make-adder2 (n)
  #'(lambda (x &optional change)
      (if change
	  (setq n x)
	  (+ x n))))
(defvar addx)
(setq addx (make-adder2 1))
(funcall addx 3) ; 4
(funcall addx 100 t) ; 100
(funcall addx 3) ; 103

;;; 3 closures share a list
(defun make-dbms (db)
  (list
   ; get
   #'(lambda (key)
       (cdr (assoc key db)))
   ; put
   #'(lambda (key val)
       (push (cons key val) db)
       key)
   ; delete
   #'(lambda (key)
       (setf db (delete key db :key #'car))
       key)))
(defvar cities)
(setq cities (make-dbms '((boston . us) (paris . france))))
(funcall (car cities) 'boston) ; US
(funcall (second cities) 'london 'england)
(funcall (car cities) 'london) ; ENGLAND
(defun lookup (key db)
  (funcall (car db) key))
(lookup 'london cities) ; ENGLAND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; local functions 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(labels ((inc (x) (1+ x)))
  (inc 3)) ; 4

(defun count-instance (obj lsts)
  (labels ((instances-in (lst)
	     (if (consp lst)
		 (+ (if (eq (car lst) obj) 1 0)
		    ; refer self
		    (instances-in (cdr lst)))
		 0)))
    (mapcar #'instances-in lsts)))
(count-instance 'a '((a b c) (d a r p a) (d a r) (a a))) ; (1 2 1 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tail recursion 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; not tail recursive
(defun our-length (lst)
  (if (null lst)
      0
      (1+ (our-length (cdr lst)))))
(our-length '(1 2 3)) ; 3
;;; tail recursive
(defun our-find-if (fn lst)
  (if (funcall fn (car lst))
      (car lst)
      (our-find-if fn (cdr lst))))
;;; change to tail recursive with accumulator
(defun our-length-2 (lst)
  (labels ((rec (lst acc)
	     (if (null lst)
		 acc
		 (rec (cdr lst) (1+ acc)))))
    (rec lst 0)))
(our-length-2 '(1 2 3)) ; 3

;;; with type declarations
(defun triangle (n)
  (labels ((tri (c n)
	     (declare (type fixnum n c))
	     (if (zerop n)
		 c
		 (tri (the fixnum (+ n c))
		      (the fixnum (- n 1))))))
    (tri 0 n)))
(triangle 100) ; 5050

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compilation 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun foo (x) (1+ x))
(compiled-function-p #'foo) ; T
(compile 'foo)
;;; (compile xnil '(lambda (x) (+ x 2))) ; #<FUNCTION (LAMBDA (X)) {100141BCAB}>
;;; build and compile new functions on the fly

(progn (compile 'bar '(lambda (x) (* x 3))) 
       (compiled-function-p #'bar)) ; T	
(bar 1) ; 3				
					
(let ((y 2))				
  (defun foo-2 (x) (+ x y)))		
(compile 'foo-2)			
(compile 'bar '(lambda (x) (* x 4)))	
(bar 1) ; 4				

					
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functions from lists 	       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

