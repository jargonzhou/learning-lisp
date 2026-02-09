(defpackage :cl-cookbook/c11-data-structures
  (:use #:cl
        #:log4cl)
  (:import-from :alexandria
                #:lastcar)
  (:import-from :serapeum
                #:dict))

(in-package :cl-cookbook/c11-data-structures)

(log:info "cl-cookbook/c11-data-structures")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(list 1 2 3)
;;; (1 2 3)

;;; 1. build list: cons cells, lists
(cons 1 2)
;;; (1 . 2)
(cons 1 (cons 2 nil))
;;; (1 2)
'(1 2) ; quote
;;; (1 2)

;;; 2. circular lists
(setf *print-circle* t)

(defun circular! (items)
  "Modifies the last cdr of list ITEMS, returning a circular list"
  (setf (cdr (last items)) items))
(circular! (list 1 2 3))
;;; #1=(1 2 3 . #1#)
(fifth (circular! (list 1 2 3)))
;;; 2
(list-length (circular! (list 1 2 3)))
;;; NIL

;;; #n=, #n#
(let ((a '#42=(1 2 3 . #42#)))
  a)
;;; #1=(1 2 3 . #1#)

;;; 3. car/cdr, first/rest, second ... tenth
(car (cons 1 2)) ; 1
(cdr (cons 1 2)) ; 2
(first (cons 1 2)) ; 1
(first '(1 2 3)) ; 1
(rest '(1 2 3)) ; (2 3)

;;; 4. last, butlast, nbutlast
(last '(1 2 3)) ; (3)
(butlast '(1 2 3)) ; (1 2)
(alexandria:lastcar '(1 2 3)) ; 3

;;; 5. reverse, nreverse

;;; 10. car/cdr
;;; (caar list) ≡ (car (car list))
;;; (cadr list) ≡ (car (cdr list))
;;; (cadadr list) ≡ (car (cdr (car (cdr list))))

;;; 11. destructuring-bind

;;; 12. predicates: null, listp, consp, atom

;;; 13. list*, make-list

;;; 14. ldiff, tailp

;;; 15. member

;;; 16. replace objects in a tree: subst, sublis

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sequences
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; arrays, vectors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hash table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defparameter *my-hash* (make-hash-table))
(setf (gethash 'one-entry *my-hash*) "one")
;;; one
(setf (gethash 'another-entry *my-hash*) 2/4)
;;; 1/2
(gethash 'one-entry *my-hash*)
;;; one
;;; T
(gethash 'another-entry *my-hash*)
;;; 1/2
;;; T

(defparameter *my-hash-dict* (serapeum:dict
                              :one-entry "one"
                              :another-entry 2/4))

;;; 10. printing a hash table readably
(serapeum:toggle-pretty-print-hash-table)
(serapeum:dict :a 1 :b 2 :c 3)
;;; (SERAPEUM:DICT
;;;   :A 1
;;;   :B 2
;;;   :C 3
;;;  ) 
(serapeum:pretty-print-hash-table (serapeum:dict :a 1 :b 2 :c 3))
;;; (DICT
;;;   :A 1
;;;   :B 2
;;;   :C 3
;;;  ) 
;;; (SERAPEUM:DICT
;;;   :A 1
;;;   :B 2
;;;   :C 3
;;;  )

(hash-table-p (serapeum:dict :a 1 :b 2 :c 3))
;;; T
;;; read back: read from string then eval
(multiple-value-bind (o p)
    (read-from-string "(SERAPEUM:DICT
      :A 1
      :B 2
      :C 3
    ) ")
  (print (eval o))
  (print p)
  (hash-table-p (eval o)))


;;; 11. thread-safe hash tables

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; alist: an association list is a list of cons cells
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. definition
(defparameter *my-alist* (list (cons 'foo "foo")
                               (cons 'bar "bar")))

;;; 2. construction
(setf *my-alist* '((:foo . "foo")
                   (:bar . "bar")))
;;; ((FOO . foo) (BAR . bar))

;;; pairlis
(pairlis (list :foo :bar)
         (list "foo" "bar"))
;;; ((BAR . bar) (FOO . foo))

(defparameter *alist-with-duplicate-keys* nil)
(setf *alist-with-duplicate-keys*
  '((:a . 1)
    (:a . 2)
    (:b . 3)
    (:a . 4)
    (:c . 5)))
;;; ((A . 1) (A . 2) (B . 3) (A . 4) (C . 5))

;;; 3. access
(assoc :foo *my-alist*)
;;; (FOO . foo)
(alexandria:assoc-value *my-alist* :foo)
;;; foo
;;; (FOO . foo)

(rassoc "foo" *my-alist*)
;;; NIL
(rassoc "foo" *my-alist* :test #'equal)
;;; (FOO . foo)

(remove-if-not (lambda (entry)
                 (eq :a entry))
    *alist-with-duplicate-keys*
  :key #'car)
;;; ((A . 1) (A . 2) (A . 4))

;;; 4. insert and remove entries
(acons :key "key" *my-alist*)
;;; ((KEY . key) (FOO . foo) (BAR . bar))
(push (cons 'team "team") *my-alist*)
;;; ((TEAM . team) (FOO . foo) (BAR . bar))
*my-alist*
;;; ((TEAM . team) (FOO . foo) (BAR . bar))
(remove 'team *my-alist* :key #'car)
;;; ((FOO . foo) (BAR . bar))

(push (cons 'bar "bar2") *my-alist*)
;;; ((BAR . bar2) (TEAM . team) (FOO . foo) (BAR . bar))
(remove 'bar *my-alist* :key #'car :count 1) ; specify count
;;; ((TEAM . team) (FOO . foo) (BAR . bar))
(remove 'bar *my-alist* :key #'car)
;;; ((TEAM . team) (FOO . foo))

;;; 5. update entries
;;; replace value
(setf *my-alist* '((:foo . "foo")
                   (:bar . "bar")))
*my-alist*
;;; ((FOO . foo) (BAR . bar))
(setf (cdr (assoc :foo *my-alist*)) "new-value")
*my-alist*
;;; ((FOO . new-value) (BAR . bar))

;;; replace key
(setf (car (assoc :bar *my-alist*)) :new-key)
*my-alist*
;;; ((FOO . new-value) (NEW-KEY . bar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; plist: property list is a list that alternate a key, a value and so one
;;;   its key are keywords or symbols
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defparameter my-plist (list :foo "foo" :bar "bar"))

;;; 2. access data in a plist: use plists as queue
(getf my-plist :foo)
;;; foo

;;; 3. remove elements from a plist
(remf my-plist :foo)
my-plist
;;; (BAR bar)

;;; 4. add element to a plist: list*, append
;;; add element in front
(list* :baz "baz" my-plist)
;;; (BAZ baz BAR bar)
;;; add element to the end
(append my-plist '(bazz "bazz"))
;;; (BAR bar BAZZ bazz)

;;; 5. set elements of a plist
(setf (getf my-plist :bar) "bar!!!")
my-plist
;;; (BAR bar!!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; structures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. creation
;;; (defstruct person
;;;   id
;;;   (name "john doe" :type string)
;;;   age)

;;; (defparameter *me* (make-person))
;;; *me*
;;; ; #S(PERSON :ID NIL :NAME john doe :AGE NIL)

(defstruct (person (:constructor create-person (id name age)))
  id
  name
  age)
(defparameter *me* (create-person 1 "me" 7))
*me*
;;; #S(PERSON :ID 1 :NAME me :AGE 7)

;;; 2. slot access
(person-name *me*)
;;; me

;;; 3. setting
(setf (person-name *me*) "Cookbook author")
(person-name *me*)
;;; Cookbook author

;;; 4. predicate
(person-p *me*)
;;; T

;;; 5. single inheritance
(defstruct (female (:include person))
  (gender "female" :type string))
(make-female :name "Lilie")
;;; #S(FEMALE :ID NIL :NAME Lilie :AGE NIL :GENDER female)

;;; 6. shorter slot access with symbol-macrolet
(defstruct ship x-position y-position x-velocity y-velocity)
(defun move-ship (ship)
  ;;; create symbol macro
  (symbol-macrolet
      ((x (ship-x-position ship))
       (y (ship-y-position ship))
       (xv (ship-x-velocity ship))
       (yv (ship-y-velocity ship)))
    ;;; psetf
    (psetf x (+ x xv)
      y (+ y yv))
    ship))
(move-ship (make-ship :x-position 1 :y-position 1 :x-velocity 2 :y-velocity 2))
;;; #S(SHIP :X-POSITION 3 :Y-POSITION 3 :X-VELOCITY 2 :Y-VELOCITY 2)

;;; 7. structures and with-slots
(defstruct point x y)
(defvar p (make-point :x 2.3 :y -3.2))
(with-slots (x y) p
  (list x y))
;;; (2.3 -3.2)

;;; 8. limitations
;;; redefine a structure is undefiend
;;; add a slot

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; trees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; FSet: immutable functional data structure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sycamore: purely functional weight-balanced binary tree
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; *print-length*, *print-level*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; generic and nested access of alists, plists, hash-tables and CLOS slots
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; accessing nested data structures
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; collection type hierarchy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
