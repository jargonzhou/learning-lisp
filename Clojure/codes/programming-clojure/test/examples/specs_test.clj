(ns examples.specs_test
  (:require
   [clojure.spec.alpha :as s]
   [examples.specs :refer :all]
   [clojure.test :refer [deftest testing is run-tests]]))


(deftest specs-test
  (testing "predicates"
    ; directly use the specs
    (is (s/valid? :my.app/company-name "Acme Moving"))
    (is (not (s/valid? :my.app/company-name 100)))))

(run-tests)