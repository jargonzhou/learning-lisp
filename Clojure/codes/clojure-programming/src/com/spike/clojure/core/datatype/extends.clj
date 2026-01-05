(ns com.spike.clojure.core.datatype.extends)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 重用实现: 类型只能实现协议或者Java接口
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrecord Point [x y])

; extend函数
(extend Point                          ; 要扩展的类型
  Matrix                               ; 要实现的协议
  {:lookup (fn [pt i j]                ; 具体方法实现的map
             (when (zero? j)
               (case i
                 0 (:x pt)
                 1 (:y pt))))
   :update (fn [pt i j value]
             (if (zero? j)
               (condp = i
                 0 (InlinePoint. value (:y pt))
                 1 (InlinePoint. (:x pt) value))
               pt))
   :rows (fn  [pt] [[(:x pt)] [(:y pt)]])
   :cols (fn [pt] [[(:x pt) (:y pt)]])
   :dims (fn [pt] [2 1])})