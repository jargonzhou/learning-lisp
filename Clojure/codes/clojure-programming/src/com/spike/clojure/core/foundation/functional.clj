(ns com.spike.clojure.core.foundation.functional
  (:require [clojure.string :as string]
            [clojure.java.io :as io]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 函数数据结构
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; [1] 函数
(defn call-twice
  "调用函数f两次."
  [f x]
  (f x)
  (f x))
(call-twice println 123)

(max 5 6)
(string/lower-case "Clojure")

;;; [1.1] map
(map string/lower-case ["Java" "Impretative" "Weeping" "Clojure" "Learning"
                        "Peace"])
(map * [1 2 3 4] [5 6 7 8])            ; 多个集合: (5 12 21 32)

;;; reduce
(reduce max [0 -3 10 48])
(reduce + 50 [1 2 3 4])                ; 带初始值 (50)
(reduce
 (fn [m v] ; m为map
   (assoc m v (* v v)))
 {} ; 初始值
 [1 2 3 4])

;;; [1.2] apply, partial
(apply hash-map [:a 5 :b 6])           ; apply: 函数应用
(def args [2 -2 10])
(apply * 0.5 3 args)                   ; 传入序列集合前可传入确定参数

(def only-strings
  (partial filter string?))            ; partial: 部分应用/偏函数
(only-strings ["a" 5 "b" 6])

;;; [1.3] 函数字面量 与 部分应用
(#(filter string? %) ["a" 5 "b" 6])
(#(filter % ["a" 5 "b" 6]) string?)
(#(filter % ["a" 5 "b" 6]) number?)
; 函数字面量强制要求指定所有参数, 而部分应用不需要
(#(map * % %2 %3) [1 2 3] [4 5 6] [7 8 9])   ; (28 80 162)
(#(apply map * %&) [1 2 3] [4 5 6] [7 8 9])  ; (28 80 162)
(#(apply map * %&) [1 2 3])                  ; (1 2 3)
((partial map *) [1 2 3] [4 5 6] [7 8 9])    ; (28 80 162)

;;; [2] 函数组合
(defn negated-sum-str
  "返回和的负值字符串: + => - => str"
  [& numbers]
  (str (- (apply + numbers))))
(negated-sum-str 10 12 3.4)            ; "-25.4"
(def negated-sum-str2 (comp str - +))  ; comp: + => - => str
(negated-sum-str2 10 12 3.4)

(def camel->keyword (comp
                     keyword
                     string/join
                     (partial interpose \-)
                     (partial map string/lower-case)
                     #(string/split % #"(?<=[a-z])(?=[A-Z])")))

(camel->keyword "CamelCase")           ; :camel-case
(camel->keyword "lowerCamelCase")      ; :lower-camel-case
; ->>串行宏: 其第一个参数作为后面函数的最后一个参数
(defn camel->keyword2
  [s]
  (->> (string/split s #"(?<=[a-z])(?=[A-Z])")
       (map string/lower-case)
       (interpose \-)
       string/join
       keyword))
(camel->keyword2 "CamelCase")
(camel->keyword2 "lowerCamelCase")

; 将键值对vector转换为map, 同时转换key
(def camel-pairs->map (comp
                       (partial apply hash-map)
                       (partial map-indexed (fn [i x]
                                              (if (odd? i)
                                                x
                                                (camel->keyword x))))))
(camel-pairs->map ["CamelCase" 5 "lowerCamelCase" 6])

; 高阶函数
(defn adder
  [n]
  (fn [x] (+ n x)))                    ; 返回函数
((adder 5) 18)

(defn doubler
  "返回函数r, 其返回f返回值的2倍"
  [f]
  (fn [& args]
    (* 2 (apply f args))))
(def doubler-+ (doubler +))
(doubler-+ 1 2 3)

; 日志系统
(defn print-logger
  [writer]
  #(binding [*out* writer] ; 绑定*out*到writer
     (println %)))
; 写入stdout
(def *out*-logger (print-logger *out*))
(*out*-logger "hello")
; 写入StringWriter
(def writer (java.io.StringWriter.))
(def retained-logger (print-logger writer))
(retained-logger "hello")
(str writer)
; 写入文件
(defn file-logger
  [file]
  #(with-open [f (io/writer file :append true)] ; 文件
     ((print-logger f) %)))
(def log->file (file-logger "message.log"))
(log->file "hello")
; 写入多个输出流
(defn multi-logger
  [& logger-fns] ; logger-fns: 日志函数
  #(doseq [f logger-fns]
     (f %)))
(def log (multi-logger
          (print-logger *out*)
          (file-logger "message.log")))
(log "hello again")
; 加时间戳
(defn timestamped-logger
  [logger]
  #(logger (format "[%1$tY-%1$tm-%1$te %1$tH:%1$tM:%1$tS] %2$s" (java.util.Date.) %)))
(def log-timestamped
  (timestamped-logger
   (multi-logger
    (print-logger *out*)
    (file-logger "message.log"))))
(log-timestamped "goodbye, now")

;;; [3] 纯函数
(defn prime?
  "是否是质数"
  [n]
  (cond
    (== 1 n) false
    (== 2 n) true
    (even? n) false
    :else (->>
           (range 3 (inc (Math/sqrt n)) 2) ; range: start stop step
           (filter #(zero? (rem n %)))
           empty?)))
(time (prime? 1125899906842679))       ; 计时
(let [m-prime? (memoize prime?)]       ; 内存化memoize: 缓存纯函数的计算结果
  (time (m-prime? 1125899906842679))
  (time (m-prime? 1125899906842679)))  ; 第二次明显更快
; 有副作用的函数不能内存化
(repeatedly 10 (partial rand-int 10))
(repeatedly 10 (partial (memoize rand-int) 10)) ; 不能产生随机数了
