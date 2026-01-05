(ns examples.sequences)

(def x (for [i (range 1 3)] (do (println i) i)))
(println x)
(doall x)
(dorun x)