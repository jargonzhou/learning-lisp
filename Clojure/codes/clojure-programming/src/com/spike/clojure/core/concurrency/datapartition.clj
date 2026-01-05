(ns com.spike.clojure.core.concurrency.datapartition)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 简单的并行化: 数据划分
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; [1] 1e2 files, each 1e6 characters
(def files-try1 (repeat 100            ; repeat return a lazy seq
                        (apply str
                               (concat (repeat 1e6 \space)
                                       "END OF FILE"))))
(defn find-eof
  [string]
  (re-seq #"(END OF FILE)" string))
(find-eof "          END OF FILE")
; 使用dorun实例化lazy seq
(time (dorun (map find-eof files-try1))) ; 1710.313326 msecs
; 使用pmap
(time (dorun (pmap find-eof files-try1))) ; 756.07461 msecs

;;; [2] 100000 files, each 1000 characters
(def files-try2 (repeat 1e5
                        (apply str
                               (concat (repeat 1e3 \space)
                                       "END OF FILE"))))
(time (dorun (map find-eof files-try2))) ; 1668.698528 msecs

;;; [3] partition to 250 chunks
(def files-try3
  (->> files-try2 ; lazy seq as a function
       (partition-all 250)
       (pmap (fn [chunk]
               (doall (map find-eof chunk)))) ; doall强制实例化lazy seq
       (apply concat)
       dorun))
(time files-try3)                      ; 0.039188 msecs

; what's the difference between dorun and doall?
(dorun (range 1e2))                    ; nil
(doall (range 1e2))                    ; (1 ... 99)

;;; [4] pmap, pcalls, pvalues
; pmap
; http://clojuredocs.org/clojure.core/pmap
(defn long-running-job [n]
  (Thread/sleep 1000)
  (+ n 10))
(time (doall (map long-running-job (range 4))))  ; 4014.326617 msecs
(time (doall (pmap long-running-job (range 4)))) ; 1004.585207 msecs

; pcalls
(defn f1 [] (rand-int 10))
(defn f2 [] (* 2 (rand-int 10)))
(class (pcalls f1 f2))                 ; clojure.lang.LazySeq


; pvalues
(class (pvalues (* 1 2) (rand-int 10))) ; clojure.lang.LazySeq

