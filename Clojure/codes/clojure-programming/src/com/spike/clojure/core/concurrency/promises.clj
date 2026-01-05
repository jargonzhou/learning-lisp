(ns com.spike.clojure.core.concurrency.promises)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; promise
; 创建时不指定执行的代码或值, 通过deliver填入值
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def p (promise))
(realized? p)                          ; false
(deliver p 42)
(realized? p)                          ; true
(prn @p)
; 数据流变量
(def a (promise))
(def b (promise))
(def c (promise))
(future
  (deliver c (+ @a @b))                ; 定义promise之间的关系
  (prn "Deliver complete!"))
(deliver a 15)
(deliver b 16)
(prn @c)
; 让基于回调的API以同步的方式执行
(defn call-service
  [arg1 arg2 callback-fn]
  (future (callback-fn (+ arg1 arg2) (- arg1 arg2))))
@(call-service 8 7 *)                  ; 15

(defn sync-fn
  [async-fn]   ; 异步回调函数
  (fn [& args] ; 返回函数
    (let [result (promise)]
      (apply async-fn (conj (vec args) #(deliver result %&)))
      @result)))
((sync-fn call-service) 8 7)           ; (15 1)
(apply * ((sync-fn call-service) 8 7))