(defpackage :on-lisp/c03-functional-programming
  (:use #:cl))

(in-package :on-lisp/c03-functional-programming)

(format t "on-lisp/c03-functional-programming~&")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functional design
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun bad-reverse (lst)
  (let* ((len (length lst))
	 (ilimit (truncate (/ len 2))))
    (do ((i 0 (1+ i))
	 (j (1- len) (1- j)))
	((>= i ilimit))
      ; in place
      (rotatef (nth i lst) (nth j lst)))))
(let ((lst '(a b c)))
  (bad-reverse lst)
  lst) ; (C B A)

;;; original list is not touched
(defun good-reverse (lst)
  (labels ((rev (lst acc)
	     (if (null lst)
		 acc
		 (rev (cdr lst) (cons (car lst) acc)))))
    (rev lst nil)))
(let ((lst '(a b c)))
  (values (good-reverse lst)
	  lst))
;;; (C B A)
;;; (A B C)

;;; (reverse lst)
;;; (setq lst (reverse lst))
;;; destructive functions
;;; (nreverse lst)

;;; multiple values
(truncate 26.42)
;;; 26
;;; 0.42000008
(= (truncate 26.42 26)) ; T
(multiple-value-bind (int frac) (truncate 26.42)
  (list int frac)) ; (26 0.42000008)
(defun powers (x)
  (values x (sqrt x) (expt x 2)))
(multiple-value-bind (base root square) (powers 4)
  (list base root square)) ; (4 2.0 16)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; imperative outside-in
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functional
(defun fun (x)
  (list 'a (expt (car x) 2)))
;;; imperative
(defun imp (x)
  (let (y sqr)
    (setq y (car x))
    (setq sqr (expt y 2))
    (list 'a sqr)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functional interfaces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; interactive programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





