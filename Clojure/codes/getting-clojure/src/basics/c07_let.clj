;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 7. Let
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c07-let)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a local, temporary place for your stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defn compute-discount-amount [amount discount-percent min-charge]
  (if (> (* amount (- 1.0 discount-percent)) min-charge)
    (* amount (- 1.0 discount-percent))
    min-charge))
(compute-discount-amount 10 0.2 1) ; 8.0
; let
(defn compute-discount-amount2 [amount discount-percent min-charge]
  (let [discounted-amount (* amount (- 1.0 discount-percent))]
    (if (> discounted-amount min-charge)
      discounted-amount
      min-charge)))
(compute-discount-amount2 10 0.2 1) ; 8.0

(defn compute-discount-amount3 [amount discount-percent min-charge]
  ; refer to previous defined `discount`
  (let [discount          (* amount discount-percent)
        discounted-amount (- amount discount)]
    (println "Discount:" discount)
    (println "Discounted amount:" discounted-amount)
    (if (> discounted-amount min-charge)
      discounted-amount
      min-charge)))
(compute-discount-amount3 10 0.2 1) ; 8.0
; output
; Discount: 2.0
; Discounted amount: 8.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; let over fn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a map of username to discount
(def user-discounts
  {"Nicholas" 0.10 "Jonathan" 0.07 "Felicia" 0.05})
(defn mk-discount-price-f [user-name user-discounts min-charge]
  ; let over fn
  (let [discount-percent (user-discounts user-name)]
    (fn [amount]
      (let [discount        (* amount discount-percent)
            discount-amount (- amount discount)]
        (if (> discount-amount min-charge)
          discount-amount
          min-charge)))))
(def compute-jonathan-price
  (mk-discount-price-f "Jonathan" user-discounts 10.0))
(compute-jonathan-price 20.0) ; 18.6


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; variations on the theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def anonymous-book
  {:title "Sir Gawain and the Green Knight"})
(def with-author
  {:title "Once and Future King" :author "White"})

; if-let
(defn uppercase-author [book]
  (if-let [author (:author book)]
    (.toUpperCase author)
    "ANONYMOUS"))
(uppercase-author anonymous-book) ; "ANONYMOUS"
(uppercase-author with-author) ; "WHITE"

; when-let
(defn uppercase-author2 [book]
  (when-let [author (:author book)]
    (.toUpperCase author)))
(uppercase-author2 anonymous-book) ; nil
(uppercase-author2 with-author) ; "WHITE"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; let relies on lexical scope
; let binding overrides

