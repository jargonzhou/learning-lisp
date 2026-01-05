;; 1. Getting Started

(ns examples.introduction
  (:require
   [clojure.repl :refer [doc find-doc source]]
   [clojure.core :refer [str]]))

; HOF: higher-order functions
(defn blank?
  "Check whether string is blank"
  [str]
  (every? #(Character/isWhitespace %) str))

; protocols
(defrecord Person [first-name last-name])

; convenient literal syntax
(defn hello-world [username]
  (println (format "Hello, %s" username)))

(hello-world "Clojure")
[1 2 3 4] ; vector
[1,2,3,4] ; treat `,` as whitespace and ignore them

; necessary ()
(let [x 42]
  (cond (= x 10) "equal"
        (> x 10) "more"))

; functional language
(def compositions
  #{{:name "The Art of the Fugue" :composer "J. S. Bach"}
    {:name "Musical Offering" :composer "J. S. Bach"}
    {:name "Requiem" :composer "Giuseppe Verdi"}
    {:name "Requiem" :composer "W. A. Mozart"}})
;; (def composers
;;   #{{:composer "J. S. Bach" :country "Germany"}
;;     {:composer "W. A. Mozart" :country "Austria"}
;;     {:composer "Giuseppe Verdi" :country "Italy"}})
;; (def nations
;;   #{{:nation "Germany" :language "German"}
;;     {:nation "Austria" :language "German"}
;;     {:nation "Italy" :language "Italian"}})
(for [c compositions :when (= (:name c) "Requiem")] (:composer c))

; concurrent programming
; STM: software transactional memory
(def accounts (ref #{}))
(defrecord Account [id balance])
(dosync
 (alter accounts conj (->Account "CLJ" 1000.00)))

; embrace JVM
(System/getProperties)
(.. "hello" getClass getProtectionDomain)
(.start (new Thread (fn [] (println "Hello" (Thread/currentThread)))))


; navigating Clojure libraries
(def fibs (lazy-cat [0 1] (map + fibs (rest fibs))))
(take 10 fibs)
; documentation
(doc str)
(find-doc "reduce")
(source str)
; Java reflection
(instance? java.util.Collection [1 2 3])
