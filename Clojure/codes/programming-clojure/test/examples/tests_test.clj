(ns examples.tests_test
  (:require [clojure.test :as t]))

; ------------------------------------------------------------------------------
; assertions
; ------------------------------------------------------------------------------
; is macro
(t/is (= 4 (+ 2 2)))
(t/is (instance? Integer 256))
; 
; FAIL in () (output.calva-repl:82)
; expected: (instance? Integer 256)
;   actual: java.lang.Long
(t/is (.startsWith "abcde" "ab"))
; assertions for testing exceptions
(t/is (thrown? ArithmeticException (/ 1 0)))
(t/is (thrown-with-msg? ArithmeticException #"Divide by zero"
                        (/ 1 0)))

; ------------------------------------------------------------------------------
; documenting tests
; ------------------------------------------------------------------------------
(t/is (= 5 (+ 2 2)) "Crazy arithmetic")
;document groups of assertions with `testing` macro
(t/testing "Arithmetic"
  (t/testing "with positive integers"
    (t/is (= 4 (+ 2 2)))
    (t/is (= 7 (+ 3 4))))
  (t/testing "with negative integers"
    (t/is (= -4 (+ -2 -2)))
    (t/is (= -1 (+ 3 -4)))))

; ------------------------------------------------------------------------------
; defining tests
; ------------------------------------------------------------------------------
; 1. `with-test` macro
(t/with-test
  (defn my-function [x y]
    (+ x y))
  (t/is (= 4 (my-function 2 2)))
  (t/is (= 7 (my-function 3 4))))
; 2. `deftest`
(t/deftest addition
  (t/is (= 4 (+ 2 2)))
  (t/is (= 7 (+ 3 4))))
(t/deftest subtraction
  (t/is (= 1 (- 4 3)))
  (t/is (= 3 (- 7 4))))
; group and compose tests
(t/deftest arithmetic
  (addition)
  (subtraction))

; ------------------------------------------------------------------------------
; running tests
; ------------------------------------------------------------------------------
; if no namespace specified, current namespace is used
; default: run in an undefined order
;; (run-tests 'examples.tests_test)

; run test in order
; `test-ns-hook` prevents execution of fixtures
;; (defn test-ns-hook []
;;   (arithmetic))

; ------------------------------------------------------------------------------
; omitting tests from production code
; ------------------------------------------------------------------------------
; bind `*load-tests*` to false

; ------------------------------------------------------------------------------
; fixtures
; ------------------------------------------------------------------------------
(defn my-fixture [f]
  ; Perform setup, establish bindings, whatever.
  (println "Setup")
  (f)  ; Then call the function we were passed.
  ; Tear-down / clean-up code here.
  (println "Teardown"))

; attach to namespace: 
;  each: (use-fixtures :each fixture1 fixture2 ...)
;  once: (use-fixtures :once fixture1 fixture2 ...)
(t/use-fixtures :once my-fixture)

(t/deftest addition-after-use-fixtures
  (t/is (= 4 (+ 2 2)))
  (t/is (= 7 (+ 3 4))))

; ------------------------------------------------------------------------------
; saving tests output to a file
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; extending test-is
; ------------------------------------------------------------------------------


; ------------------------------------------------------------------------------
; THE WILD WORLD
; ------------------------------------------------------------------------------

(t/run-tests)