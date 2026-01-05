(ns com.spike.clojure.core.concurrency.atoms)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; atom
; 同步的, 无须同步的, 原子的, 先比较再设置的修改策略
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def sarah (atom {:name "Sarah" :age 25 :wears-glasses? false})) ; 创建
@sarah                                 ; 访问值, 不会阻塞
(swap! sarah update-in [:age] + 3)     ; 调用 (update-in @sarah [:age] + 3)
                                       ; 返回更新值
(swap! sarah (comp #(update-in % [:age] inc)
                   #(assoc % :glass-color "black")))
; 包裹的值在修改函数返回之前发生变化, 自动重试
(def xs (atom #{1 2 3}))
@xs
(wait-futures 1
              (swap! xs (fn [v]
                          (Thread/sleep 250)
                          (println "trying 4")
                          (conj v 4)))
              (swap! xs (fn [v]
                          (Thread/sleep 500)
                          (println "trying 5")
                          (conj v 5))))
;trying 4
;trying 5
;trying 5
@xs                                    ; #{1 4 3 2 5}

(def xs (atom #{:a :b :c}))
@xs                                    ; #{:c :b :a}
; compare-and-set!修改时需要知道当前值
(compare-and-set! xs :wrong "new value") ; false
@xs                                    ; #{:c :b :a}
(compare-and-set! xs @xs "new value")    ; true
@xs                                    ; new value
; compare-and-set!不使用值语义, 必须是同一对象
(def xs (atom #{1 2}))
(compare-and-set! xs #{1 2} "new value") ; false
@xs                                    ; #{1 2}
; reset!覆盖性修改
(reset! xs :y)
@xs                                    ; :y
