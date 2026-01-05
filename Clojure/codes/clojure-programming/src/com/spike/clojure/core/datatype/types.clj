(ns com.spike.clojure.core.datatype.types)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 类型(types)
; 提供了对底层操作进行优化的能力
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 定义类型
(deftype Point [x y])
; 普通不可修改字段(public final)只能通过Java互操作语法访问
(prn (.x (Point. 3 4)))                ; 3
(prn (:x (Point. 3 4)))                ; nil


;;; 定义可修改字段: volatile, 非synchronized
;;; ^:volatile-mutable, ^:unsynchronized-mutable
(deftype MyType [^:volatile-mutable fld])
; 可修改字段是private字段, 只能在定义类型的内联方法中使用
(deftype SchrodingerCat [^:unsynchronized-mutable state]
  clojure.lang.IDeref
  (deref [sc]
    (locking sc                        ; 加锁
      (or state
          (set! state (if (zero? (rand-int 2)) ; 修改字段
                        :dead
                        :alive))))))
(defn schrodinger-cat
  []
  (SchrodingerCat. nil))
(def a-cat (schrodinger-cat))
(prn a-cat)
(prn (schrodinger-cat))
(prn (schrodinger-cat))

