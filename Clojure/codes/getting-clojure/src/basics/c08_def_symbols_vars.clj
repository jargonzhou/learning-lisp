;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 8. Def, Symbols, and Vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c08-def-symbols-vars)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a global, stable place for your stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; def: bind the symbol to the value
(def title "Emma")
title ; "Emma"
(def PI 3.14)
PI
(def ISBN-LENGTH 13)
(def COMPANY-NAME "Blotts Books")
COMPANY-NAME

; defn: def, fn
(defn book-description [book]
  (str (:title book)
       "Written by"
       (:author book)))
(book-description {:title "Book 1" :author "Author 1"})
(def OLD-ISBN-LENGTH 10)
(def isbn-length [OLD-ISBN-LENGTH ISBN-LENGTH])
isbn-length
(defn valid-isbn? [isbn]
  (or (= (count isbn) OLD-ISBN-LENGTH)
      (= (count isbn) ISBN-LENGTH)))
(valid-isbn? "9781680503005") ; true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; symbols are things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; symbols are first-class takes up bytes in memory value in Clojure
; 'symbol
(def author "Austen")
(println author)
'author ; author
'title ; title
(str 'author) ; "author"
(= 'author 'author) ; true
(= 'author 'title) ; false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; bindings are things too
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; var: a thing that represents the binding between a symbol and a value
(def author2 "Austen") ; make a var
; #'a-var ; get at a var
#'author2 ; #'basics.c08-def-symbols-vars/author2
; (.get a-var) ; value of a-var
(.get #'author2) ; "Austen"
;; (.get author2) ; ERROR: No matching field found: get for class java.lang.String
; (.-sym a-var) ; symbol of a-var
(.-sym #'author2) ; author2
;; (.-sym author2) ; ERROR: No matching field found: sym for class java.lang.String

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; varying your vars
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; binding: ^:dynamic
; *dynamic-var*: earmuffs

(def ^:dynamic *debug-enabled* false)
(defn debug [msg]
  (if *debug-enabled*
    (println msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; donot try to use vars as variables.
; `let` does not create vars.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; `def` figures into some of the first code that runs when Clojure boots up.
; *print-length*
; set!
; REPL: *1, *2, *3, *e