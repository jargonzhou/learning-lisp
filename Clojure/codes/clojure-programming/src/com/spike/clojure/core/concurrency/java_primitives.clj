(ns com.spike.clojure.core.concurrency.java-primitives)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Java concurrency primitives
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Clojure中所有无参函数都实现了Java中的Runnable和Callable接口
(.start (Thread. #(println "Running...")))

;;; 使用locking宏获取给定对象上的锁
(defn add
  [some-list value]
  (locking some-list                   ; locking宏
    (.add some-list value)))

(let [some-list (java.util.ArrayList.)]
  (add some-list 123)
  (println some-list))
