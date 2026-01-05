(ns com.spike.clojure.core.marco.example
  (:require (clojure [string :as str]
                     [walk :as walk]
                     [pprint :as pprint])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 宏的示例
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro reverse-it
  "翻转符号名称."
  [form]
  (walk/postwalk #(if (symbol? %)
                    (symbol (str/reverse (name %)))
                    %)
                 form))

(reverse-it (nltnirp "foo"))
(reverse-it
 (qesod [gra (egnar 5)]
        (nltnirp (cni gra))))

;;; 展开宏: macroexpand-1, macroexpand, clojure.walk/macroexpand-all
; macroexpand-1只展开宏一次
;(doseq
; [arg (range 5)]
; (println (inc arg)))
(macroexpand-1 '(reverse-it
                 (qesod [gra (egnar 5)]
                        (nltnirp (cni gra)))))
; macroexpand展开宏, 直到最顶级的形式不是宏
(pprint/pprint (macroexpand '(reverse-it
                              (qesod [gra (egnar 5)]
                                     (nltnirp (cni gra))))))
; clojure.walk/macroexpand-all模拟完全宏展开, 不支持&env, &form