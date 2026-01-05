(ns com.spike.clojure.core.marco.hygenic)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 宏卫生
; 符号名冲突: 
; (1) 宏产生的代码会被嵌在外部代码中使用
; (2) 将用户代码作为参数传入宏
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;
(defmacro unhygienic
  [& body]
  `(let [x :oops]
     ~@body))
(unhygienic (println "x:" x))          ; CompilerException, let绑定错误
; (clojure.core/let [com.spike.clojure.core.marco.hygenic/x :oops] (println "x:" x))
(macroexpand-1 '(unhygienic (println "x:" x)))

(defmacro still-unhygienic
  [& body]
  `(let [~'x :oops]
     ~@body))
; (clojure.core/let [x :oops] (println "x:" x))
(macroexpand-1 '(still-unhygienic (println "x:" x)))
(still-unhygienic (println "x:" x))
(let [x :this-is-important]
  (still-unhygienic
   (println "x:" x))                  ; 输出x: :oops
  (println x))                         ; 输出:this-is-important

;;; gensym返回保证唯一的符号
(prn (gensym))
(prn (gensym))
(prn (gensym "sym"))                   ; 带前缀
(prn (gensym "sym"))

(defmacro hygienic
  [& body]
  (let [sym (gensym)]
    `(let [~sym :macro-value]
       ~@body)))
; (clojure.core/let [G__8283 :macro-value] (println "x: " x))
(macroexpand-1 '(hygienic (println "x: " x)))
(let [x :this-is-important]
  (hygienic
   (println "x:" x))                  ; 输出x: :this-is-important
  (println x))

; 自动gensym
(defmacro hygienic2
  [& body]
  `(let [x# :macro-value]
     ~@body))
; (clojure.core/let [x__8302__auto__ :macro-value] (println "x: " x))
(macroexpand-1 '(hygienic2 (println "x: " x)))
; 在同一个语法引述内自动gensym表示同意符号 
(prn `(x# x#))                         ; (x__8316__auto__ x__8316__auto__)
(defmacro auto-gensym
  [& numbers]
  `(let [x# (rand-int 10)]
     (+ x# ~@numbers)))                ; x#表示同一符号
(macroexpand-1 '(auto-gensym 1 2 3 4 5))
(auto-gensym 1 2 3 4 5)

(prn [`x# `x#])                        ; [x__8347__auto__ x__8348__auto__]
(defmacro our-doto
  [expr & forms])

