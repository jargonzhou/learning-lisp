;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 20. Macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns advanced.c20-macros)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; there are three kinds of numbers in the world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; macros to the rescue
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; easier macros with syntax quoting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro describe-it-m [it]
  `(let [value# ~it]
     (cond
       (list? value#) :a-list
       (vector? value#) :a-vector
       (number? value#) :a-number
       :else :no-idea)))
(describe-it-m 42) ; :a-number
(macroexpand-1 '(map describe-it-m [10 "a string"])) ; (map describe-it-m [10 "a string"]) 
;; (map describe-it-m [10 "a string"]) ; ERROR
; Syntax error compiling at ...c20_macros.clj:35:1).
; Can't take value of a macro: #'advanced.c20-macros/describe-it-m
(defn describe-it-f [it]
  (describe-it-m it))
(map describe-it-f [10 "a string"]) ; (:a-number :no-idea)
(map #(describe-it-m %) [10 "a string"]) ; (:a-number :no-idea)