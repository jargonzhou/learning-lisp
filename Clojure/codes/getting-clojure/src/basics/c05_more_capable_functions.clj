;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 5. More Capable Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ns basics.c05-more-capable-functions
  (:require [clojure.repl :as repl]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; one function, different parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; multi-arity functions
(defn greet
  ([to-whom]
   (println "Welcome to Blotts Books" to-whom))
  ([message to-whom]
   (println message to-whom)))
(greet "Dolly") ; output Welcome to Blotts Books Dolly
(greet "Howdy" "Stranger") ; output Howdy Stranger

(defn greet2
  ([to-whom]
   ; call one arity from the other
   (greet2 "Welcome to Blotts Books" to-whom))
  ([message to-whom]
   (println message to-whom)))
(greet2 "Dolly") ; output Welcome to Blotts Books Dolly
(greet2 "Howdy" "Stranger") ; output Howdy Stranger


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; arguments with wild abandon
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; arbitrary number of arguments/variadic functions: &
(defn print-any-args [& args]
  (println "My arguments are:" args))
(print-any-args 7 true nil) ; output My arguments are: (7 true nil)

(defn first-argument [x & _] x)
;; (first-argument) ; ERROR
(first-argument 1 2 3) ; 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; multimethods
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; normalize book
; {:title "War and Peace" :author "Tolstoy"}
; {:book "Emma" :by "Austen"}
; ["1984" "Orwell"]

(defn normalize-book-f [book]
  (if (vector? book)
    {:title (first book) :author (second book)}
    (if (contains? book :title)
      book
      {:title (:book book) :author (:by book)})))
(doseq [book [{:title "War and Peace" :author "Tolstoy"}
              {:book "Emma" :by "Austen"}
              ["1984" "Orwell"]]]
  (println (normalize-book-f book)))
; output
; {:title War and Peace, :author Tolstoy}
; {:title Emma, :author Austen}
; {:title 1984, :author Orwell}

; the dispatch function: return a result/dispatch-val to pick an implementation
(defn dispatch-book-format [book]
  (cond
    (vector? book) :vector-book
    (contains? book :title) :standard-map
    (contains? book :book) :alternativ-map))
; the multi method
(defmulti normalize-book dispatch-book-format)
; the implemantations: dispatch-val
(defmethod normalize-book :vector-book [book]
  {:title (first book) :author (second book)})
(defmethod normalize-book :standard-map [book]
  book)
(defmethod normalize-book :alternativ-map [book]
  {:title (:book book) :author (:by book)})

(doseq [book [{:title "War and Peace" :author "Tolstoy"}
              {:book "Emma" :by "Austen"}
              ["1984" "Orwell"]]]
  (println (normalize-book book)))
; output
; {:title War and Peace, :author Tolstoy}
; {:title Emma, :author Austen}
; {:title 1984, :author Orwell}

; choose any criteria in writing the dispatch function
(defn dispatch-published [book]
  (cond
    (< (:published book) 1928) :public-domain
    (< (:published book) 1978) :old-copyritht
    :else :new-copyright))
(defmulti compute-royalties dispatch-published) ; 计算版税
(defmethod compute-royalties :public-domain [book] 0)
(defmethod compute-royalties :old-copyritht [book] 1)
(defmethod compute-royalties :new-copyright [book] 2)

; there are no requirement that all the bits of a sginle multimethod be defined
; in the same file or at the same time
(def books [{:title "Pride and Prejudice" :author "Austen" :genre :romance}
            {:title "World War Z" :author "Brooks" :genre :zombie}])
(defmulti book-description :genre) ; keyword as a function
(defmethod book-description :romance [book]
  (str "The heart warming new romance by " (:author book)))
(defmethod book-description :zombie [book]
  (str "The heart consuming new zombie adventure by " (:author book)))

(def ppz {:title "Pride and Prejudice and Zombies"
          :author "Grahame-Smith"
          :genre :zombie-romance}) ; a new genre
(defmethod book-description :zombie-romance [book]
  (str "The heart warming and sonsuming new romance by " (:author book)))

(book-description (first books)) ; "The heart warming new romance by Austen"
(book-description ppz) ; "The heart warming and sonsuming new romance by Grahame-Smith"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; deeply recursive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def books
  [{:title "Jaws" :copies-sold 2000000}
   {:title "Emma" :copies-sold 3000000}
   {:title "2001" :copies-sold 4000000}])

; may stack overlfow
(defn sum-copies
  ([books] (sum-copies books 0))
  ([books total]
   (if (empty? books)
     total
     (sum-copies
      (rest books)
      (+ total (:copies-sold (first books)))))))
(sum-copies books) ; 9000000

; recur
(defn sum-copies2
  ([books] (sum-copies books 0))
  ([books total]
   (if (empty? books)
     total
     (recur
      (rest books)
      (+ total (:copies-sold (first books)))))))
(sum-copies2 books) ; 9000000

; loop, recur
(defn sum-copies3 [books]
  (loop [books books
         total 0]
    (if (empty? books)
      total
      (recur
       (rest books)
       (+ total (:copies-sold (first books)))))))
(sum-copies3 books) ; 9000000

; map, apply
(defn sum-copies4 [books]
  (apply + (map :copies-sold books)))
(sum-copies4 books) ; 9000000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; docstring
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defn average
  "Return the average of a and b."
  [a b]
  (/ (+ a b) 2.0))
(average 3 4) ; 3.5
(repl/doc average)
; output
; -------------------------
; basics.c05-more-capable-functions/average
; ([a b])
;   Return the average of a and b.

(defn multi-average
  "Return the average of 2 or 3 numbers."
  ([a b]
   (/ (+ a b) 2.0))
  ([a b c]
   (/ (+ a b c) 3.0)))
(repl/doc multi-average)
; output
; -------------------------
; basics.c05-more-capable-functions/multi-average
; ([a b] [a b c])
;   Return the average of 2 or 3 numbers.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pre and post conditions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defn publish-book [book]
  (when-not (contains? book :title)
    (throw (ex-info "Books must contain :title" {:book book})))
  book)
(try
  (publish-book {:title2 "Book1"})
  (catch Exception e (println (.getMessage e))))
; output
; Books must contain :title

(defn publish-book2 [book]
  {:pre [(:title book)] ; :pre a-vector-of-exprs on arguments
   :post [(boolean? %)] ; :post a-vector-of-exprs on result
   }
  book)
;; (publish-book2 {:title2 "Book1"})
; output
; Execution error (AssertionError) at basics.c05-more-capable-functions/publish-book2 (c05_more_capable_functions.clj:207).
; Assert failed: (:title book)

;; (publish-book2 {:title "Book1"})
; output
; Execution error (AssertionError) at basics.c05-more-capable-functions/publish-book2 (c05_more_capable_functions.clj:206).
; Assert failed: (boolean? %)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [& more]
; [& args] [&args]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; =
; ClojureScript to-url: the built-in `class` function