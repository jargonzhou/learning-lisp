(ns examples.specs
  (:require [clojure.spec.alpha :as s]
            [clojure.spec.gen.alpha :as gen]
            [clojure.string :as str]))

(s/def ::ingredient (s/keys :req [::name ::quantity ::unit]))
(s/def ::name string?)
(s/def ::quantity number?)
(s/def ::unit keyword?)

(s/fdef scala-ingredient
  :args (s/cat :ingredient ::ingredient :factor number?)
  :ret ::ingredient)

(defn scala-ingredient [ingredient factor]
  (update ingredient :quantity * factor))

(let [i {:quantity 10 :name "something"}]
  (scala-ingredient i 5))

; ------------------------------------------------------------------------------
; validating data
; ------------------------------------------------------------------------------
; predicates
(s/def :my.app/company-name string?)
(s/valid? :my.app/company-name "Acme Moving")
(s/valid? :my.app/company-name 100)

; enumerated vallues: set as function
(s/def :marble/color #{:red :green :blue})
(s/valid? :marble/color :red)
(s/valid? :marble/color :pink)

(s/def :bowling/rool #{0 1 2 3 4 5 6 7 8 9 10})
(s/valid? :bowling/rool 5)

; range specs
(s/def :bowling/ranged-roll (s/int-in 0 11))
(s/valid? :bowling/ranged-roll 10)

; hanlding nil
(s/def :my.app/company-name-2 (s/nilable string?))
(s/valid? :my.app/company-name-2 nil)
(s/def ::nilable-boolean (s/nilable boolean?))

; logical specs: s/and, s/or
(s/def ::odd-int (s/and int? odd?))
(s/valid? ::odd-int 5)
(s/valid? ::odd-int 10)
(s/valid? ::odd-int 5.2)
(s/def ::odd-or-42 (s/or :odd ::odd-int :42 #{42}))
(s/conform ::odd-or-42 42)
(s/conform ::odd-or-42 23)
(s/explain ::odd-or-42 0)
(s/explain-str ::odd-or-42 0)
(s/explain-data ::odd-or-42 0)

; collection specs: s/coll-of, s/map-of

; collection sampling: s/every, s/every-kv, s/*coll-check-limit*

; tuples: s/tuple

; information maps

; ------------------------------------------------------------------------------
; validating functions
; ------------------------------------------------------------------------------


; ------------------------------------------------------------------------------
; generative function testing
; ------------------------------------------------------------------------------

; s/gen
(s/def :marble/color-red
  (s/with-gen :marble/color #(s/gen #{:red})))
(s/exercise :marble/color-red)

; gen/xxx
(s/def ::sku
  (s/with-gen (s/and string? #(str/starts-with? % "SKU-"))
    (fn [] (gen/fmap #(str "SKU-" %) (s/gen string?)))))
(s/exercise ::sku)