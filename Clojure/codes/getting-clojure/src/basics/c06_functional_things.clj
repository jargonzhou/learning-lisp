;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 6. Functional Things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c06-functional-things)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; functions are values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def dracula {:title "Dracula"
              :author "Stoker"
              :price 1.99
              :genre :horror})
; price
(defn cheap? [book]
  (when (<= (:price book) 9.99)
    book))
(defn pricey? [book]
  (when (> (:price book) 9.99)
    book))
(cheap? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(pricey? dracula) ; nil
; genre
(defn horror? [book]
  (when (= (:genre book) :horror)
    book))
(defn adventure? [book]
  (when (= (:genre book) "adventure")
    book))
(horror? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(adventure? dracula) ; nil

(defn cheap-horror? [book]
  (when (and (cheap? book)
             (horror? book))
    book))
(defn pricey-adventure? [book]
  (when (and (pricey? book)
             (adventure? book))
    book))
(cheap-horror? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(pricey-adventure? dracula) ; nil

; functions are values
cheap? ; #function[basics.c06-functional-things/cheap?]
; alias
(def reasonably-priced? cheap?)
(reasonably-priced? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
; function as a argument
(defn run-with-dracula [f]
  (f dracula))
(run-with-dracula pricey?) ; nil
(run-with-dracula horror?) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(defn both? [first-predicate-f second-predicate-f book]
  (when (and (first-predicate-f book)
             (second-predicate-f book))
    book))
(both? cheap? horror? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(both? pricey? adventure? dracula) ; nil

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; functions on the fly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; fn
(fn [n] (* 2 n)) ; #function[basics.c06-functional-things/eval11433/fn--11434]
(println "A function:" (fn [n] (* 2 n)))
; output
; A function: #function[basics.c06-functional-things/eval11437/fn--11438]

; bind to a symbol
(def double-it (fn [n] (* 2 n)))
(double-it 2) ; 4
((fn [n] (* 2 n)) 2) ; 4
(defn cheaper-f [max-price]
  ; return a function
  (fn [book]
    (when (<= (:price book) max-price)
      book)))
(def real-cheap? (cheaper-f 1.00))
(def kind-of-cheap? (cheaper-f 1.99))
(def marginally-cheap? (cheaper-f 5.99))
(real-cheap? dracula) ; nil
(kind-of-cheap? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(marginally-cheap? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}

(defn both-f [predicate-f-1 predicate-f-2]
  (fn [book]
    (when (and (predicate-f-1 book) (predicate-f-2 book))
      book)))
(def cheap-horror2? (both-f cheap? horror?))
(cheap-horror2? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(def cheap-horror-possession?
  (both-f cheap-horror2?
          (fn [book] (= (:title book) "Possession"))))
(cheap-horror-possession? dracula) ; nil

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a functional toolkit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; apply
(+ 1 2 3 4) ; 10
(def the-function +)
(def args [1 2 3 4])
(apply the-function args) ; 10
(apply + [1 2 3 4]) ; 10
(def v ["The number " 2 " best selling " "book."])
(apply str v) ; "The number 2 best selling book."
(apply list v) ; ("The number " 2 " best selling " "book.")
(apply vector (apply list v)) ; ["The number " 2 " best selling " "book."]  

; partial
(def my-inc (partial + 1))
(my-inc 1) ; 2
(defn cheaper-than [max-price book]
  (when (<= (:price book) max-price)
    book))
(def real-cheap2? (partial cheaper-than 1.00))
(def kind-of-cheap2? (partial cheaper-than 1.99))
(def marginally-cheap2? (partial cheaper-than 5.99))
(real-cheap2? dracula) ; nil
(kind-of-cheap2? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}
(marginally-cheap2? dracula) ; {:title "Dracula", :author "Stoker", :price 1.99, :genre :horror}

; complement
(def not-adventure? (complement adventure?))
(adventure? dracula) ; nil
(not-adventure? dracula) ; true

; every-pred
(def cheap-horror3? (every-pred cheap? horror?))
(cheap-horror3? dracula) ; true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; function literals
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#(when (= (:genre %1) :adventrue) %1) ; #function[basics.c06-functional-things/eval11499/fn--11500]
(#(when (= (:genre %1) :adventrue) %1) dracula) ; nil

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; defn: def, fn

; update
(def book {:title "Emma" :copies 1000})
(def new-book (update book :copies inc))
new-book ; {:title "Emma", :copies 1001}
; update-in: nested maps
(def by-author
  {:name "Jane Austen"
   :book {:title "Emma" :copies 1000}})
(def new-by-author (update-in by-author [:book :copies] inc))
new-by-author ; {:name "Jane Austen", :book {:title "Emma", :copies 1001}}

; Ring handler, middleware

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; pure functions