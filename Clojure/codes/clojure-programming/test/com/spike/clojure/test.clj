;;; make sure 'resources' folder exists
;;; run 'Run tests in com.spike.clojure.test'

(ns com.spike.clojure.test
  (:require [clojure.test :refer :all]))

(defprotocol Bark
  (bark [this]))

(extend-protocol Bark
  java.util.Map
  (bark [this]
    (or (:bark this)
        (get this "bark"))))

(defrecord Chihuahua [weight price]
  Bark
  (bark [this] "Yip!"))

(defrecord PetStore [dog])

; file content:
; {:dog #com.spike.clojure.test.Chihuahua{:weight 12, :price "$84.50"}}
(defn configured-petstore
  []
  (-> "resources/petstore-config.clj"
      slurp
      read-string
      map->PetStore))

(def ^:private dummy-petstore (PetStore. (Chihuahua. 12 "$84.50")))

; test
(deftest test-configured-petstore
  (is (= (configured-petstore) dummy-petstore)))

;;; fixture

(defn petstore-config-fixture
  [f]
  (let [file (java.io.File. "resources/petstore-config.clj")]
    (try
      (spit file (with-out-str (pr dummy-petstore)))
      (f)
      (finally
        (.delete file)))))

; register fixture
(use-fixtures :once petstore-config-fixture)
