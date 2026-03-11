;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Test entry point 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defpackage cl-hacks/tests/main
  (:use :cl
   :cl-cookbook
					;:rove
   :fiveam)
  (:export #:main-system
	   #:on-lisp-suite))
(in-package :cl-hacks/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-hacks)' in your Lisp.

#|
(deftest test-target-1
(testing "should (= 1 1) to be true"
(ok (= 1 1))))
|#

(def-suite main-system
  :description "cl-hacks/tests/main")

(def-suite on-lisp-suite
  :description "Tests of On Lisp")
