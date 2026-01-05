(ns com.spike.clojure.core.marco.thread-operators)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 串行宏: ->, ->>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; ->
;;; thread-first: 依次后续form的第二个元素位置
; same as: (prn (reverse (conj [1 2 3] 4)))
(-> [1 2 3] (conj 4) reverse prn)      ; (4 3 2 1)

;;; ->>
;;; thread-last: 依次后续form的最后位置
; same as: (reduce + (take 10 (filter even? (map #(* % %) (range)))))
(->> (range)
     (map #(* % %))
     (filter even?)
     (take 10)
     (reduce +))                          ; 1140
