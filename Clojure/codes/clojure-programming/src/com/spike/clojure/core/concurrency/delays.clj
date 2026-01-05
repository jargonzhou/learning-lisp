(ns com.spike.clojure.core.concurrency.delays)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; delay
; 让代码延迟执行, 代码只会在显式调用deref的时候执行
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def d (delay (println "Running...")
              :done!))
(deref d)                              ; 显式调用deref(clojure.lang.IDeref)
(prn @d)                               ; 缓存结果, 直接返回

(defn get-html
  [url]
  {:url url
   :content (delay (slurp url))})
(def get-clojuredoc (get-html "http://clojuredocs.org/clojure.core/slurp"))
(prn get-clojuredoc)                   ; clojure.lang.Delay
(realized? (:content get-clojuredoc))  ; 是否已获取值: false
@(:content get-clojuredoc)
(realized? (:content get-clojuredoc))  ; true