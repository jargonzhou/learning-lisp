(defpackage :cl-cookbook/c24-clos
  (:use #:cl
        #:log4cl)
  (:import-from #:closer-mop
                #:class-direct-slots))

(in-package :cl-cookbook/c24-clos)

;;; CLOS: Common Lisp Object System


(log:info "cl-cookbook/c24-clos")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; classes and instances
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1. diving in 
(defclass person ()
    ((name
      :initarg :name
      :accessor name)
     (lisper
      :initarg :lisper
      :initform nil
      :accessor lisper)))


(defvar p1 (make-instance 'person :name "me"))
(name p1) ; me
(lisper p1) ; NIL
(setf (lisper p1) t) ; T

(defclass child (person)
    ())
(defclass child (person)
    ((can-walk-p
      :initarg :can-walk-p
      :accessor can-walk-p
      :initform t)))
(can-walk-p (make-instance 'child)) ; T


;;; 2. defclass: defining classes
(class-of p1) ; #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::PERSON>
(type-of p1) ; PERSON

(defclass point ()
    (x y z))

;;; 3. make-instance: creating objects

;;; constructor
(defun make-person (name &key lisper)
  (make-instance 'person :name name :lisper lisper))
(make-person "me") ; #<PERSON {1103AF7183}>
(make-person "me" :lisper t) ; #<PERSON {1100C08603}>


;;; 4. slots
;;; 4.1 slot-value
(defvar pt (make-instance 'point))
;;; (inspect pt)
;;; The object is a STANDARD-OBJECT of type POINT.
;;; 0. X: #<unbound slot>
;;; 1. Y: #<unbound slot>
;;; 2. Z: #<unbound slot>

;;; (slot-value pt 'x)
;;; The slot CL-COOKBOOK/C24-CLOS::X is unbound in the object #<POINT {1104A3BAA3}>.
(setf (slot-value pt 'x) 1)
(slot-value pt 'x) ; 1

;;; 4.2 initarg, initform

(defclass foo ()
    ((a
      :initarg :a
      :initform (error "you didnot supply an initial value for slot a"))))
;;; (make-instance 'foo)
;;; you didnot supply an initial value for slot a

;;; 4.3 accessor, reader, writer
(type-of #'name) ; STANDARD-GENERIC-FUNCTION
;;; with-slots
(with-slots (name lisper) ; slot names
  p1
  (format t "got ~a, ~a~&" name lisper))
;;; got me, NIL

;;; with-accessors
(with-accessors ((name name) ; variable accessor
                            (lisper lisper))
    p1
  (format t "name: ~a, lisper: ~a" name lisper))
;;; name: me, lisper: NIL

;;; 4.4 class slots, instance slots
(defclass person ()
    ((name :initarg :name :accessor name)
     (species
      :initform 'homo-sapiens
      :accessor species
      :allocation :class
      :documentation "Species of person")))
(defvar p2 (make-instance 'person))
(species p1) ; HOMO-SAPIENS
(species p2) ; HOMO-SAPIENS
(setf (species p2) 'homo-numericus)
(species p1) ; HOMO-NUMERICUS
(let ((temp (make-instance 'person)))
  (setf (species temp) 'homo-lisper))
(species (make-instance 'person)) ; HOMO-LISPER

;;; 4.5 slot documentation
(let ((slots (closer-mop:class-direct-slots (find-class 'person))))
  (documentation (find 'species slots :key #'closer-mop:slot-definition-name) t))
;;; Species of person

;;; 4.6 slot type
;;; whether slot types are being checked or not is undefined.
;;; see SBCL

;;; 5. find-class, class-name, class-of
(find-class 'point) ; #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::POINT>
(class-name (find-class 'point)) ; POINT
(class-of pt) ; #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::POINT>
(typep pt (class-of pt)) ; T
;;; CLOS classes are also instances of a CLOS class
(class-of (class-of pt)) ; #<STANDARD-CLASS COMMON-LISP:STANDARD-CLASS>


;;; 6. subclasses and inheritance
;;; all objects inherit from the class `standard-object` and `t`
(defvar c1 (make-instance 'child))
(type-of c1) ; CHILD
(class-of c1) ; #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::CHILD>
(subtypep (type-of c1) 'person) ; T T
(closer-mop:subclassp (class-of c1) 'person) ; T

(closer-mop:class-precedence-list (class-of c1))
;;; (#<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::CHILD>
;;;  #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::PERSON>
;;;  #<STANDARD-CLASS COMMON-LISP:STANDARD-OBJECT>
;;;  #<SLOT-CLASS SB-PCL::SLOT-OBJECT> #<SYSTEM-CLASS COMMON-LISP:T>)
(closer-mop:class-direct-superclasses (class-of c1))
;;; (#<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::PERSON>)

;;; 7. multiple inheritance
(defclass baby (child person)
    ())
(closer-mop:class-direct-superclasses (class-of (make-instance 'baby)))
;;; (#<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::CHILD>
;;;  #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::PERSON>)

;;; 8. redefining and changing a class
;;; redefinition of an existing class
;;; `change-class`: change an instance of one claass into an instance of another
(defclass person ()
    ((name
      :initarg :name
      :accessor name)
     (lisper
      :initarg :lisper
      :initform nil
      :accessor lisper)))
(setf p1 (make-instance 'person :name "me"))
(lisper p1) ; NIL
(defclass person ()
    ((name
      :initarg :name
      :accessor name)
     (lisper
      :initarg :lisper
      :initform t ; from nil to t
      :accessor lisper)))
(lisper p1) ; NIL
(lisper (make-instance 'person :name "You")) ; T
(defclass person ()
    ((name
      :initarg :name
      :accessor name)
     (lisper
      :initarg :lisper
      :initform nil
      :accessor lisper)
     (age ; add slot
         :initarg :age
         :initform 18
         :accessor age)))
(age p1) ; 18
;;; (slot-value p1 'bwarf)
;;; When attempting to read the slot's value (slot-value), the slot BWARF is
;;; missing from the object #<PERSON {1101463F93}>.
(setf (age p1) 30)
(age p1) ; 30
(defclass person () ; remove slot
  ((name
    :initarg :name
    :accessor name)))
;;; (slot-value p1 'lisper)
;;; When attempting to read the slot's value (slot-value), the slot LISPER is
;;; missing from the object #<PERSON {11018328A3}>.
;;; (lisper p1)
;;; There is no applicable method for the generic function
;;; #<STANDARD-GENERIC-FUNCTION CL-COOKBOOK/C24-CLOS::LISPER (0)>
;;; when called with arguments
;;; (#<PERSON {11018328A3}>).
;;; See also:
;;; The ANSI Standard, Section 7.6.6

(change-class p1 'child)
(change-class p1 'child :can-walk-p nil)
(class-of p1) ; #<STANDARD-CLASS CL-COOKBOOK/C24-CLOS::CHILD>
(can-walk-p p1) ; NIL

;;; 9. pretty printing
(defclass person ()
    ((name
      :initarg :name
      :accessor name)
     (lisper
      :initarg :lisper
      :initform t ; from nil to t
      :accessor lisper)))
(defmethod print-object ((obj person) stream)
  ;;; #<PERSON ...>: :type, :identity
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((name name)
                     (lisper lisper))
        obj
      (format stream "~a, lisper: ~a" name lisper))))
p1 ; #<CHILD me, lisper: T>

;;; 10. classes of traditional lisp types
(find-class 'symbol) ; #<BUILT-IN-CLASS COMMON-LISP:SYMBOL>
(let ((c (find-class 'symbol)))
  (values
    (class-name c)
    (eq c (class-of 'symbol))
    (class-of c)))
;;; SYMBOL
;;; T
;;; #<STANDARD-CLASS COMMON-LISP:BUILT-IN-CLASS>

;;; 11. introspection

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; methods
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MOP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
