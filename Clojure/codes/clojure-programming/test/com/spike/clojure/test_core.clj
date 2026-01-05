(ns com.spike.clojure.test-core
  (:require [clojure.test :refer :all]
            [com.spike.clojure.core :refer :all]))

(deftest a-test
  (testing "a function return its argument"
    (is (= 1 (foo 1)))))

;;; user `(run-tests)` to run tests.
