(ns com.spike.clojure.core.marco.implicity-bindings)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; defmacro宏引入的两个隐藏的本地绑定: &env, &form
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; &env
;;; 一个map, key是当前上下文所有本地绑定的名称
(defmacro spy-env
  []
  (let [ks (keys &env)]
    `(prn (zipmap '~ks [~@ks]))))      ; {key value}
(let [x 1
      y 2]
  (spy-env)                            ; {x 1, y 2}
  (+ x y))

; 编译期对没有引用本地绑定的表达式提前求值
(defmacro simplify
  [expr]
  (let [locals (set (keys &env))]
    (if (some locals (flatten expr))   ; 如果表达式中有本地绑定
      expr
      (do
        (println "Precomputing: " expr)
        ;(list `quote (eval expr))
        `(quote ~(eval expr))))))
(prn (flatten '(apply + (range 5e7))))
(defn f
  [a b c]
  (+ a b c (simplify (apply + (range 5e7)))))
(prn (f 1 2 3))                        ; 立即返回1249999975000006

; spike on this
;(prn (list `quote (eval (+ 1 2))))
;(defmacro dummy
;  []
;  (list `quote (eval (+ 1 2))))
;(macroexpand-1 '(dummy))
;(defmacro dummy2
;  []
;  (list 'quote (eval (+ 1 2))))
;(macroexpand-1 '(dummy2))
;
;(defmacro dummy3
;  []
;  `(quote ~(eval (+ 1 2))))
;(macroexpand-1 '(dummy3))


;;; &form
;;; 宏被扩展的整个形式: 包含宏的名称和传给宏的所有参数的列表
;;; 宏的名称可能被重命名
;;; 保存用户指定的元数据(类型提示等)和reader添加的元数据(调用宏的代码行号等)
(defmacro spy-form
  [^long x ^long y]
  (prn &form)                          ; (spy-form 1 2)
  (prn (meta &form))                   ; {:line 1, :column 1}
  `(+ ~x ~y))
(prn (macroexpand-1 '(spy-form 1 2)))
(spy-form 1 2)

(defmacro ontology
  "Well, the Semantic Web!!!"
  [& triples]
  (every? #(or (== 3 (count %))
               (throw (IllegalArgumentException.
                        ;"All triples must have 3 elements."
                       (format "`%s` provided to `%s` on line %s does not have 3 elements"
                               %
                               (first &form)             ; 宏名称
                               (-> &form meta :line))))) ; 调用的行号
          triples)
  (prn triples))



;; 保持用户提供的类型提示
(set! *warn-on-reflection* true)       ; 开启反射警告
(defn first-char-of-either
  [a b]
  (.substring ^String (or a b) 0 1))   ; Reflection warning
(binding [*print-meta* true]
  (prn '^String (or a b)))             ; ^{:line 2, :column 9, :tag String} (or a b)
; 大多数宏会丢弃元数据
(binding [*print-meta* true]
  (prn (macroexpand '^String (or a b))))
(defmacro OR
  ([] nil)
  ([x]
   (let [result (with-meta (gensym "res") (meta &form))] ; 带上元数据
     `(let [~result ~x]
        ~result)))
  ([x & next]
   (let [result (with-meta (gensym "res") (meta &form))]
     `(let [or# ~x
            ~result (if or# or# (OR ~@next))]
        ~result))))
(binding [*print-meta* true]
  (prn (macroexpand '^String (OR a b)))) ; ^{:line 2, :column 22, :tag String} (OR a b)


;;; TODO(zhoujiagen) mock &env: 即模拟当前上下文的绑定
(defn macroexpand1-env
  [env form]
  (if-let [[x & xs] (and (seq? form) (seq form))]
    (if-let [v (and (symbol? x) (resolve x))]
      (if (-> v meta :macro)
        (apply @v form env xs)
        form)
      form)
    form))
; Precomputing:  (range 10)
; (quote (0 1 2 3 4 5 6 7 8 9))
(prn (macroexpand1-env '{} '(simplify (range 10))))
(prn (-> '(simplify (range 10)) meta :macro))
; (range 10)
(prn (macroexpand1-env '{range nil} '(simplify (range 10))))