(defpackage cl-hacks/tests/on-lisp/utilities/lists
  (:use #:cl
        :on-lisp/utilities/lists
       	#:fiveam)
  (:import-from :cl-hacks/tests/main #:on-lisp-suite))
(in-package :cl-hacks/tests/on-lisp/utilities/lists)

(def-suite* lists-suite
  :description "Tests on list utilities."
  :in on-lisp-suite)

(test lists-test
      (let ((result (last1 '(1 2 3))))
	(is (= 3 result))
	(is (equalp (list 1 2) (mklist '(1 2))))))

;(run! 'lists-suite)

