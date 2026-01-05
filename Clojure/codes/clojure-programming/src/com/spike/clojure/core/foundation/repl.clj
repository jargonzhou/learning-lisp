(ns com.spike.clojure.core.foundation.repl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 内嵌的REPL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn embedded-repl
  "简单的REPL实现, 输入:quit退出."
  []
  (print (str (ns-name *ns*) ">>> "))
  (flush)
  (let [expr (read)                    ; Read
        value (eval expr)]             ; Evaluate
    (when (not= :quit value)
      (println value)                  ; Print
      (recur))))                       ; Loop