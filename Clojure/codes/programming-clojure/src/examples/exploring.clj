;; 2. Exploring Clojure
(ns examples.exploring
  (:require
   [clojure.repl :refer [doc]]
   [clojure.string :as str])
  ; import Java libs
  (:import (org.apache.commons.lang3 StringUtils)))

(defn greeting
  "Return a greeting of the form 'hello, username.'"
  [username]
  (str "Hello, " username))

(comment
  (greeting "world"))
(greeting "world")

(doc greeting)

; multiple argument lists and method bodies
(defn greeting2
  "Returns a greeting of the form 'Hello, username.'
   Default username is 'world'."
  ([] (greeting2 "world"))
  ([username] (str "Hello, " username)))
(greeting2)

; variable arity
(defn date [person-1 person-2 & chaperones]
  (println person-1 "and" person-2
           "went out with" (count chaperones) "chaperones."))
(date "Romeo" "Juliet" "Friar Lawrence" "Nurse")

; anonymous functions
(defn indexnable-word? [word]
  (> (count word) 2))
(filter indexnable-word? (str/split "A fine day its is" #"\W+"))
(filter (fn [w] (> (count w) 2)) (str/split "A fine day" #"\W+"))
; #(): %1, %2, %& for rest arguments, % for the single-argument function
(filter #(> (count %) 2) (str/split "A fine day its is" #"\W+"))

(defn indexable-words [text]
  ; using let
  (let [indexable-word? (fn [w] (> (count w) 2))]
    (filter indexable-word? (str/split text #"\W+"))))
(indexable-words "a fine day it is")

(defn make-greeter [greeting-prefix]
  ; capture values of parameters
  (fn [username] (str greeting-prefix ", " username)))
(def hello-greeting (make-greeter "Hello"))
(def aloha-greeting (make-greeter "Aloha"))
(hello-greeting "world")
(aloha-greeting "world")
((make-greeter "Howdy") "pardner")

; vars, binds, namespaces
(defn square-corners [bottom left size]
  (let [top (+ bottom size)
        right (+ left size)]
    [[bottom left] [top left] [top right] [bottom right]]))
(square-corners 1 1 2)

; where's my for loop
; Apache Commons Lang - StringUtils.indexOfAny
(StringUtils/indexOfAny "zzabyycdxx" "za")
(StringUtils/indexOfAny "zzabyycdxx" "by")
; Clojure approach
(defn indexed [coll] (map-indexed vector coll))
(indexed "abcde")
(defn index-filter [pred coll]
  (when pred
    (for [[idx elt] (indexed coll) :when (pred elt)] idx)))
(index-filter #{\a \b} "abcdbbb")
(index-filter #{\a \b} "xyz")
(defn index-of-any [pred coll]
  (first (index-filter pred coll)))
(index-of-any #{\z \a} "zzabyycdxx")
(index-of-any #{\b \y} "zzabyycdxx")