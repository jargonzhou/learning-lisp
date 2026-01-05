(ns hangman.core-test
  (:require [clojure.spec.alpha :as s]
            [clojure.spec.gen.alpha :as gen]
            [clojure.spec.test.alpha :as stest]
            [clojure.test :refer :all]
            [hangman.core :as h :refer [letters valid-letter? Player random-player shuffled-player alpha-player freq-player]]))

(s/def ::letter (set letters))
(s/def ::word
  (s/with-gen
    (s/and string? #(pos? (count %)) #(every? valid-letter? (seq %)))
    #(gen/fmap (fn [letters] (apply str letters))
               (s/gen (s/coll-of ::letter :min-count 1)))))

(s/def ::progress-letter
  (conj (set letters) \_))

(s/def ::progress
  (s/coll-of ::progress-letter :min-cout 1))

(defn- letters-left [progress]
  (->> progress (keep #{\_}) count))

(s/fdef hangman.core/new-progress
  :args (s/cat :word ::word)
  :ret ::progress
  :fn (fn [{:keys [args ret]}]
        (= (count (:word args)) (count ret) (letters-left ret))))

(s/fdef hangman.core/update-progress
  :args (s/cat :progress ::progress :word ::word :guess ::letter)
  :ret ::progress
  :fn (fn [{:keys [args ret]}]
        (>= (-> args :progress letters-left)
            (-> ret letters-left))))

(s/fdef hangman.core/complete?
  :args (s/cat :progress ::progress :word ::word)
  :ret boolean?)

(defn player? [p]
  (satisfies? Player p))

(s/def ::player
  (s/with-gen player?
    #(s/gen #{random-player shuffled-player alpha-player freq-player})))

(s/def ::verbose (s/with-gen boolean? #(s/gen false?)))
(s/def ::score pos-int?)

(s/fdef hangman.core/game
  :args (s/cat :word ::word
               :player ::player
               :opts (s/keys* :opt-un [::verbose]))
  :ret ::score)

(defn run-gen [& args]
  (stest/summarize-results
   (stest/check (stest/enumerate-namespace 'hangman.core))))

(defn run-gen2 [& args]
  (stest/instrument (stest/enumerate-namespace 'hangman.core))
  (stest/summarize-results (stest/check 'hangman.core/new-progress))
  (stest/check 'hangman.core/update-progress)
  (stest/check 'hangman.core/complete?)
  (stest/summarize-results (stest/check 'hangman.core/game))
  (run-gen)
  (-> 'hangman.core stest/enumerate-namespace stest/check stest/summarize-results))

; NOTE: should load core.clj first
(deftest gen-test
  (testing "gen 1"
    (run-gen))
  (testing "gen 2"
    (run-gen2)))

(run-tests)