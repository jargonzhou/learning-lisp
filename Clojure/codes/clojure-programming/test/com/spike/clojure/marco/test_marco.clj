(ns com.spike.clojure.marco.test-marco
  (:require [clojure.test :refer :all]
            [com.spike.clojure.core.marco.implicity-bindings :refer [simplify ontology]]))

(deftest test-simplify
  (testing "simplify"
    (@#'simplify nil {} '(inc 1))
    (@#'simplify nil {'x nil} '(inc x))))

(deftest test-ontology
  (testing "ontology"
    (ontology ["Boston" :capital-of])))