(ns com.spike.clojure.core.datatype.inlines
  (:refer-clojure :exclude [update]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 协议的内联实现: deftype或defrecord时直接实现方法
; 用于性能优化, 实现Java接口时只能使用这种方法
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defprotocol Matrix                    ; 协议
  "Protocol for working with 2d data structures."
  (lookup [matrix i j])
  (update [matrix i j value])
  (rows [matrix])
  (cols [matrix])
  (dims [matrix]))

;;; 内联实现
; 使用defrecord覆盖Object方法会产生变异错误
(deftype InlinePoint [x y]
  Matrix                               ; 内联实现的协议
  (lookup [pt i j]
    (when (zero? j)
      (case i
        0 x
        1 y)))
  (update [pt i j value]
    (if (zero? j)
      (condp = i
        0 (InlinePoint. value y)
        1 (InlinePoint. x value))
      pt))
  (rows [pt] [[x] [y]])
  (cols [pt] [[x y]])
  (dims [pt] [2 1])
  Object                               ; Java接口, java.lang.Object
  (equals [this other]
    (and (instance? (class this) other)
         (= x (.x other))
         (= y (.y other))))
  (hashCode [this]
    (-> x hash (hash-combine y))))

;;; 使用reify定义匿名类型
(defn listener
  [f]
  (reify
    java.awt.event.ActionListener
    (actionPerformed [this e]
      (f e))))
(.listFiles (java.io.File. ".")
            (reify
              java.io.FileFilter
              (accept [this file]
                (.isDirectory file))))