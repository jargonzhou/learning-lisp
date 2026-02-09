(defpackage ex-cl-project/tests/main
  (:use :cl
        :ex-cl-project
        :rove))
(in-package :ex-cl-project/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :ex-cl-project)' in your Lisp.

(deftest test-target-1
         (testing "should (= 1 1) to be true"
                  (progn
                   (print "runnig: should (= 1 1) to be true"))
                  (ok (= 1 1))))

;;; (run-suite *package*)