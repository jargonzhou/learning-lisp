(ns com.spike.clojure.core.marco.syntax)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 宏的语法: 
; 语法引述 syntax quote(`)
; 反引述   unquote(~)
; 拼接反引述 splicing unquote(~@)
; 这些语法不是专门为宏设计的.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 不使用宏语法
(defmacro hello
  [name]
  (list 'println name))
; usage
(hello "Clojure")

(def a (atom 10))
(while (pos? @a) (do (println @a) (swap! a dec)))

; something wrong in the book, cause un-end loop!!!
(defmacro one-while
  [test & body]
  (prn test "," body)
  (list 'loop []
        (concat (concat (list 'when test) body) (list '(recur)))))
; usage
(def a (atom 2))
(one-while (pos? @a) (prn @a) (swap! a dec))
;;; 使用宏语法
(defmacro another-while
  [test & body]
  `(loop []
     (when ~test
       ~@body
       (recur))))
; usage
(def b (atom 3))
(another-while (pos? @b)
               (do
                 (prn @b)
                 (swap! b dec)))

;;; `
;;; 与'类似, 但
;;; 将无命名空间限定的符号求值为当前命名空间的符号
;;; 允许反引述
(def foo 123)
(prn foo (quote foo) 'foo `foo)
(prn map (quote map) 'map `map)        ; 命名空间限定的符号


;;; ~, ~@
;;; 模板内求值
(prn (list `map `println [foo]))
(prn `(map println [~foo]))
(prn `(map println ~[foo]))
(prn `(println ~(keyword (str foo))))  ; 反引述整个form
;;; list拼接
(prn (let [defs '((def x 123)
                  (def y 456))]
       (concat (list 'do) defs)))
(prn (let [defs '((def x 123)
                  (def y 456))]
       `(do ~@defs)))
(defmacro foo
  [& body]                             ; body: 代码体
  `(do-something ~@body))
(macroexpand-1 '(foo (doseq [x (range 5)]
                       (println x))
                     :done))

;;; 宏不能作为值来进行组合或者传递
(defn fn-hello
  [x]
  (str "Hello, " x "!"))
(defmacro macro-hello
  [x]
  `(str "Hello, " ~x "!"))
(map fn-hello ["Brian" "Not Brain"])
(map macro-hello ["Brian" "Not Brain"]) ; CompilerException
(map #(macro-hello %) ["Brian" "Not Brain"]) ; 改为匿名函数中调用宏

;;; 让宏用户选择名称
;;; 不稳定的宏: 向外部代码暴露一个名称的宏
(defmacro with
  [name & body]                        ; 名称作为宏的参数传入 
  `(let [~name 5]
     ~@body))
(with bar (+ 10 bar))
(with foo (+ 20 foo))
; (clojure.core/let [bar 5] (+ 10 bar))
(prn (macroexpand-1 '(with bar (+ 10 bar))))

;;; 宏的参数带有副作用, 且多次出现: 重复求值问题
(defmacro spy
  [x]
  `(do
     (println "spied" '~x ~x)          ; '~: 求值后quote
     ~x))
; (do (clojure.core/println "spied" (quote (rand-int 10)) (rand-int 10)) (rand-int 10))
(prn (macroexpand-1 '(spy (rand-int 10))))
(defmacro correct-spy
  [x]
  `(let [x# ~x]                        ; 使用本地绑定
     (println "spied" '~x x#)
     x#))
(prn (macroexpand-1 '(correct-spy (rand-int 10))))

(defn spy-helper
  [expr value]
  (prn expr value)
  value)
(defmacro simple-spy
  [x]
  `(spy-helper '~x ~x))
(prn (macroexpand-1 '(simple-spy (rand-int 10))))
(prn (simple-spy (rand-int 10)))