(defpackage :cl-cookbook/c30-threads
  (:use #:cl
        #:bt
        #:log4cl)
  (:import-from #:serapeum
                #:count-cpus))

(in-package :cl-cookbook/c30-threads)

(log:info "cl-cookbook/c30-threads")

;;; thread support
(first (member :thread-support *FEATURES*))
;;; :THREAD-SUPPORT
bt:*supports-threads-p*
;;; T

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Bordeaux threads
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 1. install Bordeaux

;;; 2. check thread support in Common Lisp

;;; 3. basics: list current thread, all threads, get thread name
(defun print-thread-info ()
  (let* ((curr-thread (bt:current-thread))
         (curr-thread-name (bt:thread-name curr-thread))
         (all-threads (bt:all-threads)))
    (format t "Current thread: ~a~%~%" curr-thread)
    (format t "Current thread name: ~a~%~%" curr-thread-name)
    (format t "All threads:~%~{~a~%~}~%" all-threads)))
(print-thread-info)
;; Current thread: #<THREAD tid=15256 "worker" RUNNING {1102D10003}>

;; Current thread name: worker

;; All threads:
;; #<THREAD tid=15256 "worker" RUNNING {1102D10003}>
;; #<THREAD tid=9000 "new-repl-thread" RUNNING {1102DBE5A3}>
;; #<THREAD tid=13720 "swank-indentation-cache-thread" RUNNING {1100CF8273}>
;; #<THREAD tid=21336 "auto-flush-thread" RUNNING {11016C2733}>
;; #<THREAD tid=15504 "control-thread" RUNNING {1100CCB553}>
;; #<THREAD tid=10884 "main thread" RUNNING {1100030003}>
;; #<THREAD tid=1436 "reader-thread" RUNNING {1100CF8093}>

;;; update a global variable from a thread
(defparameter *counter* 0)
(defun test-update-global-variable ()
  (bt:make-thread
    (lambda ()
      (sleep 0.5)
      (incf *counter*)))
  *counter*)
(test-update-global-variable) ; 0
*counter* ; 1
;;; 4. create a thread: print message onto the top-level

;;; 5. fix 4
(defun print-message-top-level ()
  (let ((top-level *standard-output*))
    (bt:make-thread
      (lambda ()
        (format top-level "Hello from thread!~%"))
      :name "hello"))
  nil)
;;; run in REPL
(print-message-top-level)
;;; 6. 4 with read-time eval macro

#|
(eval-when (:compile-toplevel)		;
(defun print-message-top-level-reader-macro () ;
(bt:make-thread				;
(lambda ()				;
(format #.*standard-output* "Hello from thread - reader macro!~%")) ;
:name "hello")))			;
(print-message-top-level-reader-macro)	;
|#

;;; 7. modify a shared resource from multiple threads

;;; 8. fix 7 using locks
(defclass bank-account ()
  ((id :initarg :id
       :initform (error "id required")
       :accessor :id)
   (name :initarg :name
         :initform (error "name required")
         :accessor :name)
   (balance :initarg :balance
            :initform 0
            :accessor :balance)))

(defgeneric deposit (account amount)
  (:documentation "Deposit money into the account"))
(defgeneric withdraw (account amount)
  (:documentation "Withdraw amount from account"))

(defmethod deposit ((account bank-account) (amount real))
  (incf (:balance account) amount))
(defmethod withdraw ((account bank-account) (amount real))
  (decf (:balance account) amount))

(defparameter *rich*
              (make-instance 'bank-account
                :id 1
                :name "Rich"
                :balance 0))
(defvar *lock* (bt:make-lock))

(defun demo-race-condition ()
  (loop repeat 10
        do
          (bt:make-thread
            (lambda ()
              (loop repeat 100 do (bt:with-lock-held (*lock*) (deposit *rich* 100)))
              (loop repeat 100 do (bt:with-lock-held (*lock*) (withdraw *rich* 100))))
            :name "race")))
(dotimes (i 10)
  (demo-race-condition))
(bt:all-threads)
(:balance *rich*) ; 0
;(setf (:balance *rich*) 0)


;;; 9. 7 with atomic operations
;;; see SBCL atomic operations
;;; 10. join on a thread, destroying a thread
;;; bt:join-thread
;;; bt:destroy-thread
(defmacro until (condition &body body)
  (let ((block-name (gensym)))
    `(block ,block-name
       (loop
        (if ,condition
            (return-from ,block-name nil)
            (progn ,@body))))))
(defun join-destroy-thread ()
  (let* ((s *standard-output*)
         (joiner-thread
          (bt:make-thread
            (lambda ()
              (loop for i from 1 to 10
                    do
                      (format s "~%[Joiner Thread] Working...")
                      (sleep (* 0.01 (random 100)))))))
         (destroyer-thread
          (bt:make-thread
            (lambda ()
              (loop for i from 1 to 100
                    do
                      (format s "~%[Destroyer Thread] Working...")
                      (sleep (* 0.01 (random 1000))))))))
    (format t "~%[Main Thread] Waiting on joiner thread...")
    (bt:join-thread joiner-thread)
    (format t "~%[Main Thread] Done waiting on joiner thread")
    (if (bt:thread-alive-p destroyer-thread)
        (progn
         (format t "~%[Main Thread] Destroyer thread alive... killing it")
         (bt:destroy-thread destroyer-thread))
        (format t "~%[Main Thread] Destroyer thread is already dead"))
    (until (bt:thread-alive-p destroyer-thread)
           (format t "[Main Thread] Waiting for destroyer thread to die..."))
    (format t "~%[Main Thread] Destroyer thread dead")
    (format t "~%[Main Thread] Adios!~%")))


;(join-destroy-thread)
;; [Main Thread] Waiting on joiner thread... 
;; [Joiner Thread] Working...		
;; [Destroyer Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Destroyer Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Joiner Thread] Working...		
;; [Main Thread] Done waiting on joiner thread 
;; [Main Thread] Destroyer thread alive... killing it 
;; [Main Thread] Destroyer thread dead	
;; [Main Thread] Adios!		       


;;; 11. timeout
#|
(defun maybe-costly-operation ()
  (print "working hard...")
  (sleep 10))
(let ((thread (bt:make-thread
	       (lambda ()
		 (maybe-costly-operation))
	       :name "maybe-costly-thread")))
  (handler-case
      (bt:with-timeout (1)
	(bt:join-thread thread))
    (bt:timeout ()
      (bt:destroy-thread thread))))
(bt:all-threads)
|#
;;; 12. useful functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SBCL threads
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sb-thread

;;; sb-ext:atomic-incf
;;; sb-ext:atomic-decf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Iparallel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; kernel: make-kernel, end-kernel
;;; channels
;;; promises
;;; futures
;;; cognates: pmap


;;; 1. installation

;;; 2. get the number of cores

;;; 3. common setup

;;; 4. use channels and queues

;;; 5. kill tasks

;;; 6. use promises and futures

;;; 7. use cognates: parallel equivalents of Common Lisp counterparts

;;; 8. error handling

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; monitor and control threads with SLIME
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; slime-list-threads
