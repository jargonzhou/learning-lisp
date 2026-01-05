;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2. Vectors and Lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c02-vectors-lists)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; one thing after another
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; vectors
[1 2 3 4] ; [1 2 3 4]
[1 "two" 3 "four"] ; [1 "two" 3 "four"]
[true 3 "four" 5] ; [true 3 "four" 5]
; nested vector
[1 [true 3 "four" 5] 6] ; [1 [true 3 "four" 5] 6]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a toolkit of functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; vector
(vector true 3 "four" 5) ; [true 3 "four" 5]
(vector) ; []

; count
(def novels ["Emma" "Coma" "War and Peace"])
(count novels) ; 3
; first, rest
(first novels) ; "Emma"
(rest novels) ; ("Coma" "War and Peace")
(rest (rest novels)) ; ("War and Peace")
(rest ["Ready Player One"]) ; ()
(rest []) ; ()
; nth
(def year-books ["1491" "April 1865" "1984" "2001"])
(def third-book (first (rest (rest year-books))))
(println third-book) ; output 1984
(nth year-books 2) ; "1984"
; use vector like a function
(year-books 2) ; "1984"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; growing your vectors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; conj: conjunction - append
(conj novels "Carrie") ; ["Emma" "Coma" "War and Peace" "Carrie"]
; cons: construct - prepend, return list
(cons "Carrie" novels) ; ("Carrie" "Emma" "Coma" "War and Peace")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; lists
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
'(1 2 3) ; (1 2 3)
'(1 2 3 "four" 5 "six") ; (1 2 3 "four" 5 "six")
'(1 2.0 2.9999 "four" 5.001 "six") ; (1 2.0 2.9999 "four" 5.001 "six")
'([1 2 ("a" "list" "inside a" "vector")] "inside" "a" "list") ; ([1 2 ("a" "list" "inside a" "vector")] "inside" "a" "list")

; list
(list 1 2 3 "four" 5 "six") ; (1 2 3 "four" 5 "six")

; count, first, rest, nth
(def poems '("Iliad" "Odyssey" "Now We Are Six"))
(count poems) ; 3
(first poems) ; "Iliad"
(rest poems) ; ("Odyssey" "Now We Are Six")
(nth poems 2) ; "Now We Are Six"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; lists versus vectors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; conj with list: prepend
(conj poems "Jabberwocky") ; ("Jabberwocky" "Iliad" "Odyssey" "Now We Are Six")
(def vector-poems ["Iliad" "Odyssey" "Now We Are Six"])
; conj with vector: append
(conj vector-poems "Jabberwocky") ; ["Iliad" "Odyssey" "Now We Are Six" "Jabberwocky"] 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def more-novels (conj novels "Jaws"))
(println more-novels) ; output [Emma Coma War and Peace Jaws]

; persistent data structures

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; overwhelmingly choose vector over list for sequential-data-structure needs
