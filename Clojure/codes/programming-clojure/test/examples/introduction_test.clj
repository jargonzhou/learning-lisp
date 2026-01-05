(ns examples.introduction-test
  (:require
   [examples.introduction :refer [blank? ->Person]]
   [clojure.test :refer [deftest testing is run-tests]]))

(def foo (->Person "Aaron" "Bedra"))

(deftest blank-test
  (testing "blank?"
    (is (blank? ""))
    (is (not (blank? "hello"))))
  (testing "Person"
    (is (= "Aaron" (:first-name foo)))))

(run-tests)
