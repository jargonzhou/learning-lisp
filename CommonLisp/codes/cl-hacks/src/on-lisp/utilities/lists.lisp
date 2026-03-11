(defpackage :on-lisp/utilities/lists
  (:use #:cl)
  (:export #:last1
	   #:single
	   #:append1
	   #:conc1
	   #:mklist
	   #:longer
	   #:filter
	   #:group
	   #:flatten
	   #:prune
	   #:find2
	   #:before
	   #:after
	   #:duplicate
	   #:split-if
	   #:most
	   #:best
	   #:mostn))

(in-package :on-lisp/utilities/lists)

(format t "on-lisp/utilities/lists~&")


(proclaim '(inline last1 single append1 conc1 mklist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; small functions that operate on lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun last1 (lst)
  "Return the last element in a list."
  (car (last lst)))
(handler-case (last1 "blub")
  (type-error (condition)
    (format nil "~S" condition))) ; "#<TYPE-ERROR expected-type: LIST datum: \"blub\">"

(defun single (lst)
  "Test whether something is a list of one element."
  (and (consp lst) (not (cdr lst))))

(defun append1 (lst obj)
  "Attach a new element to the end of a list."
  (append lst (list obj)))

(defun conc1 (lst obj)
  "Destructively attach a new element to the end of a list."
  (nconc lst (list obj)))

(defun mklist (obj)
  "Ensure something is a list."
  (if (listp obj) obj (lsit obj)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; larger functions that operate on lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun longer (x y)
  "Compare two sequences and return true only if `x` is longer."
  (labels (;; compare length of two lists
	   (compare (x y)
	     (and (consp x)
		  (or (null y)
		      (compare (cdr x) (cdr y))))))
    (if (and (listp x) (listp y))
	(compare x y)
	(> (length x) (length y)))))
(longer '(1) '(1 2)) ; NIL
(longer '(1 2) '(1)) ; T
(longer '(1) '(1)) ; NIL


(defun filter (fn lst)
  "Apply `fn` to each element of `lst`, return a list of non-nil values returned by `fn`."
  (let (;; acc for accumulator
	(acc nil))
    (dolist (x lst)
      (let ((val (funcall fn x)))
	(if val (push val acc))))
    ;; reverse
    (nreverse acc)))
(filter #'(lambda (x) (if (numberp x) (1+ x)))
	'(a 1 2 b 3 c d 4)) ; (2 3 4 5)

(defun group (source n)
  "Group list `source` into sublists of length `n`, the remainder is put in a final sublist."
  (if (zerop n) (error "zero length"))
  (labels (;; acc for accumulator
	   (rec (source acc)
	     (let ((rest (nthcdr n source)))
	       (if (consp rest)
		   (rec rest (cons (subseq source 0 n) acc))
		   (nreverse (cons source acc))))))
    (if source (rec source nil) nil)))
(group '(a b c d e f g) 2) ; ((A B) (C D) (E F) (G))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; doubly-recursive list utilities
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun flatten (x)
  "Return a list of all the atoms that are elements of a list, or elements of its elements, and so on."
  (labels (;; acc for accumulator
	   (rec (x acc)
	     (cond ((null x) acc)
		   ((atom x) (cons x acc))
		   (t (rec (car x) (rec (cdr x) acc))))))
    (rec x nil)))
(flatten '(a (b c) ((d e) f))) ; (A B C D E F)


(defun prune (test tree)
  "`prune` is to `remove-if` as `copy-tree` to `copy-list`."
  (labels (;; acc for accumulator
	   (rec (tree acc)
	     (cond ((null tree) (nreverse acc))
		   ((consp (car tree))
		    (rec (cdr tree)
			 (cons (rec (car tree) nil) acc)))
		   (t (rec (cdr tree)
			   (if (funcall test (car tree))
			       acc
			       (cons (car tree) acc)))))))
    (rec tree nil)))
(prune #'evenp '(1 2 (3 (4 5) 6) 7 8 (9))) ; (1 (3 (5)) 7 (9))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; functions which search lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun find2 (fn lst)
  "Find element e in `lst` which satisfy `fn`, return multiple value (e, (fn e))."
  (if (null lst)
      nil
      (let ((val (funcall fn (car lst))))
	(if val
	    (values (car lst) val)
	    (find2 fn (cdr lst))))))

(defun before (x y lst &key (test #'eql))
  "Whether `x` is before `y` in `lst` using test defaults to `eql`."
  (and lst
       (let ((first (car lst)))
	 (cond ((funcall test y first) nil)
	       ((funcall test x first) lst)
	       (t (before x y (cdr lst) :test test))))))
(before 'b 'd '(a b c d)) ; (B C D)
(before 'a 'b '(a)) ; (A)

(defun after (x y lst &key (test #'eql))
  "Whether `x` is after `y` in `lst` using test defaults to `eql`."
  (let ((rest (before y x lst :test test)))
    (and rest (member x rest :test test))))
(after 'a 'b '(b a d)) ; (A D)
(after 'a 'b '(a)) ; NIL

(defun duplicate (obj lst &key (test #'eql))
  "If `obj` is duplicate in `lst`, return its second occurence to the end of `lst`."
  (member obj (cdr (member obj lst :test test))
	  :test test))
(duplicate 'a '(a b c a d)) ; (A D)
(duplicate 'a '(a b c d)) ; NIL

(defun split-if (fn lst)
  "Split `lst` in to multiple values (list-not-satisfy-fn, list-satisfy-fn)."
  (let ((acc nil))
    (do ((src lst (cdr src)))
	((or (null src) (funcall fn (car src)))
	 (values (nreverse acc) src))
      (push (car src) acc))))
(split-if #'(lambda (x) (> x 4))
	  '(1 2 3 4 5 6 7 8 9 10))
;; (1 2 3 4)
;; (5 6 7 8 9 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; search functions which compare elements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun most (fn lst)
  "Return the highest score element from `lst` using scoring function `fn`, which is multiple value (e, score)."
  (if (null lst)
      (values nil nil)
      (let* ((wins (car lst))
	     (max (funcall fn wins)))
	(dolist (obj (cdr lst))
	  (let ((score (funcall fn obj)))
	    (when (> score max)
	      (setq wins obj
		    max score))))
	(values wins max))))
(most #'length '((a b) (a b c) (a) (e f g)))
;; (A B C)
;; 3


(defun best (fn lst)
H  "Return the BEST element from `lst` using comparing function `fn`."
  (if (null lst)
      nil
      (let ((wins (car lst)))
	(dolist (obj (cdr lst))
	  (if (funcall fn obj wins)
	      (setq wins obj)))
	wins)))
(best #'> '(1 2 3 4 5)) ; 5

(defun mostn (fn lst)
  "Return multiple value: (a list of all the elements from `lst` which `fn` yields the highest score, score)."
  (if (null lst)
      (values nil nil)
      (let ((result (list (car lst)))
	    (max (funcall fn (car lst))))
	(dolist (obj (cdr lst))
	  (let ((score (funcall fn obj)))
	    (cond ((> score max)
		   (setq max score
			 ressult (list obj)))
		  ((= score max)
		   (push obj result)))))
	(values (nreverse result) max))))
(mostn #'length '((a b) (a b c) (a) (e f g)))
;; ((A B) (E F G))
;; 3
