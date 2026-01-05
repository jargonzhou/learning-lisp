(ns com.spike.clojure.core.datatype.records)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 记录(records): deftype的特例 - 均生成Java类
; 对所定义的类型提供了与Clojure和Java进行互操作的默认行为, 特性:
; (1) 值语义
; (2) 实现了Associative接口
; (3) 支持元数据
; (4) Clojure reader支持
; (5) 额外的构造函数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrecord Point [x y])
(prn (.x (Point. 3 4)))

; 指定基本类型的类型提示
(defrecord NamedPoint [^String name ^long x ^long y])
(prn NamedPoint)

;;; 值语义
(= (Point. 3 4) (Point. 3 4))

;;; Associative接口
(prn (:x (Point. 3 4)))
(prn (:z (Point. 3 4) 0))
; 运行时添加新字段
; #com.spike.clojure.core.datatype.records.Point{:x 3, :y 4, :z 5}
(prn (assoc (Point. 3 4) :z 5))
(let [p (assoc (Point. 3 4) :z 5)]     ; 降级为map: {:y 4, :z 5}
  (prn (dissoc p :x)))
(let [p (assoc (Point. 3 4) :z 5)]     ; 仍是记录类型
  (prn (dissoc p :z)))

;;; 元数据支持
(-> (Point. 3 4)
    (with-meta {:foo :bar})
    meta)                                ; {:foo :bar}

;;; 可读入的表示法
; #com.spike.clojure.core.datatype.records.Point{:x 3, :y 4, :z [:a :b]}
(pr-str (assoc (Point. 3 4) :z [:a :b]))
; #com.spike.clojure.core.datatype.records.Point{:x 3, :y 4, :z [:a :b]}
(prn (read-string (pr-str (assoc (Point. 3 4) :z [:a :b]))))

;;; 额外的构造函数
; #com.spike.clojure.core.datatype.records.Point{:x 3, :y 4, :z 5}
(prn (Point. 3 4
             {:foo :bar}               ; 元数据 
             {:z 5}))                  ; 额外字段


;;; 工厂函数
;;; deftype和defrecord会创建->MyType的工厂函数
;;; defrecord会创建map->MyType的工厂函数
(prn (->Point 3 4))
(prn (map->Point {:x 3 :y 4 :z 5}))
(prn (Point/create {:x 3 :y 4 :z 5}))  ; create静态方法
; 自定义工厂函数
(defn log-point
  [x]
  {:pre [(pos? x)]}
  (Point. x (Math/log x)))
(prn (log-point Math/E))
