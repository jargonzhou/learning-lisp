(ns com.spike.clojure.core.foundation.special-form)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 特殊形式(special form)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; [1] 阻止求值: quote
(quote x)
'x

(symbol? (quote x))
(symbol? 'x)

'(+ x x)
(list? '(+ x x))
(list '+ 'x 'x)                        ; 构造列表


;;; [2] 代码块: do
(do
  (println "hi")
  (apply * [4 5 6]))


;;; [3] 定义var: def
(def p "foo")
p


;;; [4] 本地绑定: let
(defn hypot
  "计算直角三角形的斜边"
  [x y]
  (let [x2 (* x x)
        y2 (* y y)]
    (Math/sqrt (+ x2 y2))))

(hypot 3 4)

; 不关心返回值: _
(let [location "CN"
      _ (println "Current location:" location)
      location "USA"]
  (print location))

;;; [4.1] 顺序解构
; 访问vector中元素
(def v [42 "foo" 99.2 [5 12]])
(first v)                              ; 第一个元素
(second v)                             ; 第二个元素
(last v)                               ; 最后一个元素
(nth v 2)                              ; 第3个元素
(v 2)                                  ; 第3个元素: vector作为函数
(.get v 2)                             ; 第3个元素: java.util.List中方法

(let [[x y z] v]
  (+ x z))                             ; 141.2=42+99.2

(let [[x _ _ [y z]] v]                 ; 忽略绑定和嵌套解构
  (+ x y z))                           ; 59=42+5+12

(let [[x & rest] v]                    ; 剩下的元素
  [rest (class rest)])

(let [[x _ z :as original-vector] v]   ; 保持被解构的值
  (conj original-vector (+ x z)))      ; [42 "foo" 99.2 [5 12] 141.2]

;;; [4.2] map解构
(def m {:a 5 :b 6
        :c [7 8 9]
        :d {:e 10 :f 11}
        "foo" 88
        42 false})

(let [{a :a b :b} m]
  (+ a b))
(let [{f "foo" v 42} m]                ; 解构时key可以是关键字, 任何类型的值
  (print f v)
  (if v 1 0))                          ; 0

; map解构应用于vector/字符串/数组, 将key视为其下标
(let [{x 3 y 8} [12 0 0 -18 44 6 0 0 1]]
  (+ x y))                             ; -17

(let [{{e :e} :d} m]                   ; 内嵌map
  (* 2 e))                             ; 20

; 保持被结构的集合
(let [{r1 :x r2 :y :as randoms}
      (zipmap [:x :y :z] (repeatedly (partial rand-int 10)))] ;两个vector合并为map 
  (assoc randoms :sum (+ r1 r2))) ; map中添加元素

; 指定默认值
(let [{k :unknown x :a
       :or {k 50}} m]
  (println k x))                       ; 50 5

; 绑定符号到map中同名关键字对应的元素: :keys(关键字key), :strs(字符串key), :syms(符号key)
(def chas {:name "Chas" :age 31 :location "Massachusetts"})
(let [{:keys [name age location]} chas]
  (format "%s is %s years old and lives in %s." name age location))

(def brian {"name" "Brian" "age" 31 "location" "British Columbia"})
(let [{:strs [name age location]} brian]
  (format "%s is %s years old and lives in %s." name age location))

(def christophe {'name "Christophe" 'age 33 'location "Rhone-Alpes"})
(let [{:syms [name age location]} christophe]
  (format "%s is %s years old and lives in %s." name age location))

; 对顺序集合的剩余部分使用map解构
(def user-info ["robert8990" 2011 :name "Bob" :city "Boston"])
(let [[username account-year & {:keys [name city]}] user-info]
  (format "%s is in %s" name city))

;;; [4.3] 结合使用顺序解构和map解构
(let [{[x _ y] :c} m] ; {[]}
  (println x y))
(def map-in-vector ["James" {:birthday (java.util.Date. 73 1 6)}])
(let [[name {bd :birthday}] map-in-vector] ; [{}]
  (str name " was bron on " bd))


;;; [5] 定义函数: fn
(fn [x]
  (+ 10 x))
((fn [x] (+ 10 x)) 8)                  ; 调用
((fn [x y z] (+ x y z))
 3 4 12)
; 多个参数列表
(def strange-adder (fn adder-self-reference
                     ([x] (adder-self-reference x 1))
                     ([x y] (+ x y))))
(strange-adder 23)
(strange-adder 23 1)
; 使用letfn处理函数定义互相引用问题
(letfn [(odd? [n] (even? (dec n)))
        (even? [n] (or (zero? n) (odd? (dec n))))]
  (odd? 11))                           ; true

; defn
(defn strange-adder
  ([x] (strange-adder x 1))
  ([x y] (+ x y)))
(strange-adder 23)
(strange-adder 23 1)

;; 解构函数参数
; 可变参数
(defn concat-rest
  [x & rest]
  (apply str (butlast rest)))
(concat-rest 0 1 2 3 4)                ; 123
(defn make-user
  [& [user-id]]
  {:user-id (or user-id
                (str (java.util.UUID/randomUUID)))})
(make-user)
(make-user "Bobby")
; 关键字参数
(defn make-user2
  [username & {:keys [email join-date]
               :or {join-date (java.util.Date.)}}] ; 默认值
  {:username username
   :join-date join-date
   :email email})
(make-user2 "Bobby")
(make-user2 "Bobby"
            :join-date (java.util.Date. 111 0 1) ; 关键字参数
            :email "bobby@example.com")
; TODO(zhoujiagen) 前置条件和后置条件
; 函数字面量: #()
(#(Math/pow %1 %2) 2 10)
(#(Math/pow % %2) 2 10)                ; %等价于%1
(#(- % (apply + %&)) 10 1 2)           ; %&引用剩余参数


;;; [6] 条件判断: if: (if condition then [else])
(if true \t)
(if false \t)                          ; else分支不存在返回nil
(if false \t \s)
; TODO(zhoujiagen) when, cond, if-let, when-let

;;; [7] 循环: loop, recur
; 将程序执行转移到离本地上下文最近的loop头, loop头可以是loop定义的, 也可以是函数定义的
(loop [x 5]
  (if (neg? x)
    x                                  ; 最后一个表达式的值作为loop形式的值
    (recur (dec x))))                  ; 程序执行转移
(defn countdown
  [x]
  (if (zero? x)
    :blastoff!
    (do (println x)
        (recur (dec x)))))               ; 跳转到countdown函数处
(countdown 5)
; TODO(zhoujiagen) doseq, dotimes, map/reduce/for

;;; [8] 引用var: var
(def x 5)
x
(var x)                                ; 引用var自身
#'x


;;; [9] 与Java互操作: ., new
; 对象初始化
(java.util.ArrayList. 10)
(new java.util.ArrayList 10)
; 静态方法
(Math/pow 2 10)
(. Math pow 2 10)
; 实例方法
(.substring "hello" 1 3)
(. "hello" substring 1 3)
; 静态成员变量
Integer/MAX_VALUE
(. Integer MAX_VALUE)
; 实例成员变量
(let [point (java.awt.Point.)]
  (println (.x point))
  (println (. point x)))


;;; [10] 异常处理: try, throw
(try
  (prn :try)
  (/ 1 0)
  (catch Exception e
    (.printStackTrace e))
  (finally
    (prn :finally)))

;;; [11] 状态修改: set!
(let [point (java.awt.Point.)]
  (println (.x point))
  (set! (.x point) -42)                ; 设置Jaava对象的字段
  (println (.x point)))


;;; TODO(zhoujiagen) [12] 锁的原语: monitor-enter, monitor-exit


;;; [13] 求值语义函数: eval, 参数为form
(eval :foo)                            ; 关键字
(eval [1 2 3])                         ; vector
(eval "text")                          ; 字符串
(defn average
  [numbers]
  (/ (apply + numbers) (count numbers)))
; (average [1 2 3 4 5])
(eval '(average [1 2 3 4 5]))
(eval (read-string "(average [1 2 3 4 5])"))


