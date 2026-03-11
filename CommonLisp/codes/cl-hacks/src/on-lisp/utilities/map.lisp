(defpackage :on-lisp/utilities/map
  (:use #:cl)
  (:export #:map0-n
	   #:map1-n
	   #:mapa-b
	   #:map->
	   #:mappend
	   #:mapcars
	   #:rmapcar))

(in-package :on-lisp/utilities/map)

(format t "on-lisp/utilities/map~&")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mapping functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mapa-b (fn a b &optional (step 1))
  "Return result of apply `fn` to each element of list from `a` to `b` with step `step`(default 1)."
  (do ((i a (+ i step))
       (result nil))
      ((> i b) (nreverse result))
    (push (funcall fn i) result)))
(mapa-b #'1+ 2 5) ; (3 4 5 6)

(defun map0-n (fn n)
  "Return result of apply `fn` to each element of list from 0 to `n`."
  (mapa-b fn 0 n))
(map0-n #'1+ 5) ; (1 2 3 4 5 6)

(defun map1-n (fn n)
   "Return result of apply `fn` to each element of list from 1 to `n`."
  (mapa-b fn 1 n))
(map1-n #'1+ 5) ; (2 3 4 5 6)

(defun map-> (fn start test-fn succ-fn)
  "Return result of apply `fn` to list start from `start` with successor (succ-fn e), stop when (test-fn e) returns true."
  (do ((i start (funcall succ-fn i))
       (result nil))
      ((funcall test-fn i) (nreverse result))
    (push (funcall fn i) result)))
(map-> #'1+ 2
       #'(lambda (x) (> x 5))
       #'(lambda (x) (+ x 1))) ; (3 4 5 6)

(defun mappend (fn &rest lsts)
  "Non-destructive to `mapcan`."
  (apply #'append (apply #'mapcar fn lsts)))
(mapcar #'+ '(1 2 3) '(4 5 6)) ; (5 7 9)
(mapcan #'(lambda (x y) (list (+ x y))) '(1 2 3) '(4 5 6)) ; (5 7 9)
(mappend #'(lambda (x y) (list (+ x y))) '(1 2 3) '(4 5 6)) ; (5 7 9)

(defun mapcars (fn &rest lsts)
  "`mapcar` function `fn` on several lists `lsts`"
  (let ((result nil))
    (dolist (lst lsts)
      (dolist (obj lst)
	(push (funcall fn obj) result)))
    (nreverse result)))
(mapcar #'1+ (append '(1 2 3) '(4 5 6))) ; (2 3 4 5 6 7)
(mapcars #'1+ '(1 2 3) '(4 5 6)) ; (2 3 4 5 6 7)

(defun rmapcar (fn &rest args)
  "Recursive `mapcar`."
  (if (some #'atom args)
      (apply fn args)
      (apply #'mapcar
	     #'(lambda (&rest args)
		 (apply #'rmapcar fn args))
	     args)))
(rmapcar #'princ '(1 2 (3 4 (5) 6) 7 (8 9)))
;; 123456789
;; (1 2 (3 4 (5) 6) 7 (8 9))
(rmapcar #'+ '( 1 (2 (3) 4)) '(10 (20 (30) 40))) ; (11 (22 (33) 44))

