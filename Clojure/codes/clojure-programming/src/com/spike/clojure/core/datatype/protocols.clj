(ns com.spike.clojure.core.datatype.protocols
  (:refer-clojure :exclude [update]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 协议
; 协议扩展方法:
; (1) extend-protocol: 可以在多个类型上实现单个协议
; (2) 内联实现: 用deftype或defrecord时直接实现方法, reify(对应于Java匿名内部类), 见inlines.clj
; (3) extend: 类型只能实现协议或Java接口, 无类型继承概念, 见extends.clj
; (4) extend-type: 可以在单个类型上实现多个协议
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; spikes on vector of vector(vov)
; REF: http://clojuredocs.org/clojure.core/apply
(def vov [[1 2 3] [4 5 6] [7 8 9]])
(prn vov)
; seems like flatten one level on the last argument
(apply map vector vov)
(map vector [1 2 3] [4 5 6] [7 8 9])

;;; 定义协议
(defprotocol Matrix
  "Protocol for working with 2d data structures."
  (lookup [matrix i j] "Look up with index i, j") ; 方法的第一个参数是this, slef
  (update [matrix i j value])
  (rows [matrix])
  (cols [matrix])
  (dims [matrix]))

;;; 在vector上实现协议(vov: vector of vector)
(extend-protocol Matrix
  clojure.lang.IPersistentVector
  (lookup [vov i j]
    (get-in vov [i j]))
  (update [vov i j value]
    (assoc-in vov [i j] value))
  (rows [vov]
    (seq vov))
  (cols [vov]
    (apply map vector vov))
  (dims [vov]
    [(count vov) (count (first vov))]))

;;; vov的工厂函数
(defn vov
  "Create a vector of (h, w) item vector"
  [h w]
  (vec (repeat h (vec (repeat w nil)))))

(def matrix (vov 3 4))
(prn matrix)
(prn (dims matrix))
(prn (update matrix 1 2 :x))
(prn (lookup (update matrix 1 2 :x) 1 2))
(prn (rows (update matrix 1 2 :x)))
(prn (cols (update matrix 1 2 :x)))

;;; 在nil上实现协议
(extend-protocol Matrix
  nil
  (lookup [x i j])
  (update [x i j value])
  (rows [x] [])
  (cols [x] [])
  (dims [x] [0 0]))
(prn (lookup nil 5 5))
(prn (dims nil))


;;; 在Java数组上实现协议
(extend-protocol Matrix
  (Class/forName "[[D")                ; double[][].class
  (lookup [matrix i j]
    (aget matrix i j))
  (update [matrix i j value]
    (let [clone (aclone matrix)]       ; 拷贝
      (aset clone i
            (doto (aclone (aget clone i))
              (aset j value)))
      clone))
  (rows [matrix]
    (map vec matrix))
  (cols [matrix]
    (apply map vector matrix))
  (dims [matrix]
    (let [rs (count matrix)]
      (if (zero? rs)
        [0 0]
        [rs (count (aget matrix 0))]))))

(def matrix-array (make-array Double/TYPE 2 3))
(prn (rows matrix-array))
(prn (rows (update matrix-array 1 1 3.4)))
(prn (lookup (update matrix-array 1 1 3.4) 1 1))
(prn (dims matrix-array))







