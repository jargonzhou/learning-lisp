(ns com.spike.clojure.core.concurrency.futures)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; future
; 在另一个线程中执行代码, 未完成时解引用会阻塞当前线程; 会缓存结果
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def long-calculation (future (apply + (range 1e6))))
@long-calculation
@(future (Thread/sleep 500) :done!)    ; 当前线程会阻塞
(deref (future (Thread/sleep 5000) :done!)
       1000                            ; 指定超时时间和超时值
       :impatient!)
