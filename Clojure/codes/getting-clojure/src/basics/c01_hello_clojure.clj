;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1. Hello Clojure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ns basics.c01-hello-clojure
  (:gen-class))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; the very basics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(println "Hello, world!") ; Say hi
; lein repl

(str "Clo" "jure")
(str "Hello," " " "world" "!")
(str 3 " " 2 " " 1 " Blast off!")

(count "Hello, world")
(count "Hello")
(count "")

(println true)
(println false)
(println "Nobody's home:" nil)
(println "we can print many things:" true false nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; arithmetic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(+ 1900 84)
(* 16 124)
(- 2000 16)
(/ 25792 13)
(/ (+ 1984 2010) 2)
(+ 1000 500 500 1)
(- 2000 10 4 2)
; floating point
(/ (+ 1984.0 2010.0) 2.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; not variable assignment, but close
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; all-lower-case-with-words-separated-by-dashes concention
(def first-name "Russ")
(def the-average (/ (+ 20 40.0) 2.0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a function of your own
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defn hello-world []
  (println "Hello, world!"))
(hello-world)

(defn say-welcome [what]
  (println "Welcome to" what))
(say-welcome "Clojure")

(defn average [a b]
  (/ (+ a b) 2.0))
(average 5.0 10.0)

(defn chatty-average [a b]
  (println "chatty-average function called")
  (println "** first argument:" a)
  (println "** second argument:" b)
  (/ (+ a b) 2.0))
(chatty-average 10 20)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; lein new app blottsbooks
;  :gen-class
;  -main

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))
(-main)

(def author "Dickens")
; redefined var
(defn author [name]
  (println "Hey," name "is writing a book"))
(author "Dickens")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; exceptions
(try
  (/ 100 0)
  (catch Exception e (str "caught exception: " (.getMessage e))))
