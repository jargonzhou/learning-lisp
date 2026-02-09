(defpackage cl-hacks/tests/s-read-file-as-string
  (:use :cl
        :cl-cookbook
       	:fiveam)
  (:import-from :cl-hacks/tests/main #:main-system))
(in-package :cl-hacks/tests/s-read-file-as-string)

(define-condition file-not-existing-error (error)
  ((filename :type string :initarg :filename :reader filename)))
(defun read-file-as-string (filename &key (error-if-not-exists t))
  "Read file content as string. FILENAME specifies the path of file.
Keyword ERROR-IF-NOT-EXISTS specifies the operation to perform when the file
is not found. T (by default) means aon error will be signaled. When given NIL,
the function will return NIL in that case."
  (cond
    ((uiop:file-exists-p filename)
     (uiop:read-file-string filename))
    (error-if-not-exists
     (error 'file-not-existing-error :filename filename))
    (t nil)))

;;; tests

(def-suite* read-file-as-string
  :description "Test the read-file-as-string function."
  :in main-system)

(test read-file-as-string-normal-file
  (let ((result (read-file-as-string "README.md")))
    (is (not (null result)))))

(test randomtest
  (for-all ((a (gen-integer :min 1 :max 4))
	    (b (gen-integer :min 5 :max 10)))
    "Test random tests."
    (is (<= a b))))
