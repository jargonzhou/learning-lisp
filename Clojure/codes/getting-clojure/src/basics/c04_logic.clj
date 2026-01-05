;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 4. Logic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c04-logic)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; the fundamental if
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; if
(defn print-greeting [preferred-customer]
  (if preferred-customer
    (println "Welcome back to Blotts Books!")
    (println "Welcome to Blotts Books!")))
(print-greeting false) ; output Welcome to Blotts Books!
(print-greeting true) ; output Welcome back to Blotts Books!

(defn shipping-charge [preferred-customer order-amount]
  (if preferred-customer
    0.00
    (* order-amount 0.10)))
(shipping-charge true 100.0) ; 0.0
(shipping-charge false 100.0) ; 10.0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; asking questions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; =
(= 1 1) ; true
(= 2 (+ 1 1)) ; true
(= "Anna Karenina" "Jane Eyre") ; false
(= "Emma" "Emma") ; true
(= (+ 2 2) 4 (/ 40 10) (* 2 2) (- 5 1)) ; true
(= 2 2 2 2 3 2 2 2 2 2) ; false
; not=
(not= "Anna Karenina" "Jane Eyre") ; true
(not= "Anna Karenina" "Anna Karenina") ; false
; >, <
(let [a 1
      b 2
      c 3]
  (if (> a b) (println "a is bigger than b"))
  (if (< b c) (println "b is smaller than c"))) ; output b is smaller than c
; predicates
(number? 1984) ; true
(number? "Anna Karenina") ; false
(string? "Anna Karenina") ; true
(keyword? "Anna Karenina") ; false
(keyword? :anna-karenina) ; true
(map? :anna-karenina) ; false
(map? {:title 1984}) ; true
(vector? 1984) ; false
(vector? [1984]) ; true

; not, and, or
(defn shipping-surcharge? [preferred-customer express oversized]
  (and (not preferred-customer) (or express oversized)))
(shipping-surcharge? false true false) ; true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; truthy and falsy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in boolean context, only `false` and `nil` are treated as false, everything else is treated as true.
(if 1
  "I like science fiction!"
  "I like mysteries!") ; "I like science fiction!"
(if "hello"
  "I like science fiction!"
  "I like mysteries!") ; "I like science fiction!"
(if []
  "I like science fiction!"
  "I like mysteries!") ; "I like science fiction!"
(if false
  "I like science fiction!"
  "I like mysteries!") ; "I like mysteries!"
(if nil
  "I like science fiction!"
  "I like mysteries!") ; "I like mysteries!"
; empty vector/map/set/list
(if [] 1) ; 1
(if {} 1) ; 1
(if #{} 1) ; 1
(if '() 1) ; 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; do and when
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; do
(do
  (println "This is 4 expressions.")
  (println "All grouped together as one")
  (println "That prints some stuff and then evaluates to 44")
  44) ; 44
; when: if with no else/falsy leg
(when true
  (print "Hello ")
  (println "Again")) ; output Hello Again

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; dealing with multiple conditions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; cond
(let [preferred-customer false
      order-amount 100]
  (cond
    preferred-customer 0.0
    (< order-amount 50.0) 5.0
    (< order-amount 100.0) 10.0
    ; catch-all clause
    :else (* 0.1 order-amount))) ; 10.0
; case
(defn customer-greeting [status]
  (case status
    :gold "Welcome, welcome, welcome back!!!"
    :preferred "Welcome back!"
    ; unpaired catch-all expression
    "Welcome to the Blotts Books"))
(customer-greeting :gold) ; "Welcome, welcome, welcome back!!!"
(customer-greeting :preferred) ; "Welcome back!"
(customer-greeting :nobody) ; "Welcome to the Blotts Books"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; throwing and catching
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; throw, ex-info
(defn publish-book [book]
  (when (not (:title book))
    (throw
     (ex-info "A book needs a title!" {:book book})))
  (when (or (not (:price book)) (< (:price book) 0))
    (throw (ArithmeticException. "unknown/negative price")))
  (println "Publish book" book))
; try
(try
  (publish-book {:title "War & Peace"})
  (catch RuntimeException e (.printStackTrace e))
  (catch ArithmeticException e (.printStackTrace e))) ; output stacktrace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; examples in Leiningen, Korma

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; and: return decidedly un-boolean values
(and true 1984) ; 1984
(and 2001 "Emma") ; "Emma"
(and 2001 nil "Emma") ; nil

; avoid testing for true or flase explicitly
; convention: close off the parentheses on the last line of expression
