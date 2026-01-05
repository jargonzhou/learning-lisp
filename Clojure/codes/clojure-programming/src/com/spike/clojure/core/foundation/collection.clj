(ns com.spike.clojure.core.foundation.collection)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 集合数据结构
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

'(a b :name 12.5)                      ; list
['a 'b :name 12.5]                     ; vector
{:name "Chas" :age 31}                 ; map
#{1 2 3}                               ; set

{Math/PI "~3.14"                       ; another map
 [:composite "key"] 42
 nil "nothing"}
#{{:first-name "chas" :last-name "emeric"} ; set of map
  {:first-name "brian" :last-name "carper"}
  {:first-name "christophe" :last-name "grand"}}

; 操作vector
(def v [1 2 3])
(conj v 4)
(conj v 4 5)
(seq v)                                ; vector的序列视图
; 操作map
(def m {:a 5 :b 6})
(conj m [:c 7])
(seq m)                                ; map的序列视图
; 操作set
(def s #{1 2 3})
(conj s 10)
(conj s 3 4)
(seq s)                                ; set的序列视图
; 操作list
(def lst '(1 2 3))
(conj lst 0)                           ; 加到前面
(conj lst 0 -1)
(seq lst)                              ; list的序列视图

(into v [4 5])                         ; into建立在seq和conj上
(into m [[:c 7] [:d 8]])
(into #{1 2} [2 3 4 5 3 3 2])
(into [1] {:a 1 :b 2})

;;; [1] 抽象
;;; [1.1] 集合 - Colletion
;;; conj, seq, count, empty, =
(conj '(1 2 3) 4 5)
(into '(1 2 3) [:a :b :c])
(defn swap-pairs
  "交换顺序集合中两两元素"
  [sequential]
  (into (empty sequential)             ; 创建空的顺序集合
        (interleave ; 交替从两个集合中取首元素
         (take-nth 2 (drop 1 sequential))
         (take-nth 2 sequential))))
(swap-pairs (apply list (range 10)))
(defn map-map
  [f m]
  (into (empty m)                      ; 创建空的map
        (for [[k v] m] [k (f v)])))    ; for列表推导
(map-map inc (hash-map :z 5 :c 6 :a 0))
(map-map inc (sorted-map :z 5 :c 6 :a 0))
(count '(1 2 3))
(count [1 2 3])
(count #{1 2 3})
(count {:a 1 :b 2 :c 3})


;;; [1.2] 序列 - Sequence
;;; seq, first, rest, next, lazy-seq
(seq "Clojure")
(seq {:a 5 :b 6})
(seq (java.util.ArrayList. (range 5)))
(seq (into-array ["Clojure" "Programming"]))
(seq [])                               ; nil
(seq nil)                              ; nil

(first "Clojure")
(rest "Clojure")
(next "Clojure")
(rest [1])                             ; ()
(next [1])                             ; nil
(rest nil)                             ; ()
(next nil)                             ; nil

; 序列不是迭代器
(doseq [x (range 3)]                   ; x会绑定到下一个值
  (println x))
(let [r (range 3)
      rst (rest r)]                    ; r, rst均是不可变的
  (prn (map str rst))
  (prn (map #(+ 100 %) r))
  (prn (conj r -1) (conj rst 42)))
; 序列不是列表
(let [s (range 1e6)]                   ; range返回lazy seq
  (time (count s)))
(let [s (apply list (range 1e6))]
  (time (count s)))

; 创建序列
(cons 0 (range 1 5))                   ; (0 1 2 3 4)
(cons :a [:b :c :d])                   ; (:a :b :c :d)
(list* 0 1 2 3 (range 4 10))           ; (0 1 2 3 4 5 6 7 8 9)

; 惰性序列(lazy seq)
(defn random-ints
  "return a lazy seq of random intergers in the range [0, limit)."
  [limit]
  (lazy-seq
   (cons (rand-int limit)
         (random-ints limit))))       ; 递归调用
(take 10 (random-ints 50))


;;; [1.3] 关系型 - Associative
;;; assoc, dissoc, get, contains?
;;; 可应用于map, vector, set
(def m {:a 1 :b 2 :c 3})
(get m :b)
(get m :d)                             ; nil
(get m :d "not-found")                 ; 指定默认值
(assoc m :d 4)
(dissoc m :b)
(assoc m
       :x 4
       :y 5
       :z 6)                           ; 指定多个键值对
(dissoc m :a :c)                       ; 指定多个键

(def v [1 2 3])                        ; key作为数组下标
(get v 1)
(get v 10)
(get v 10 "not-found")
(assoc v
       1 4
       0 -12
       2 :p)                           ; 会替换掉元素

(def s #{1 2 3})                       ; key为元素本身
(get s 2)
(get s 4)
(get s 4 "not-found")

(contains? [1 2 3] 0)                  ; true
(contains? {:a 5 :b 6} :b)             ; true
(contains? {:a 5 :b 6} 5)              ; false
(contains? #{1 2 3} 1)                 ; true

; get区分不了值不存在和值为nil
(find {:ethel nil} :luck)              ; nil
(find {:ethel nil} :ethel)             ; [:ethel nil]
(if-let [e (find {:a 5 :b 6} :a)]
  (format "found %s => %s" (key e) (val e))
  "not found")
(if-let [[k v] (find {:a 5 :b 6} :a)]
  (format "found %s => %s" k v)
  "not found")


;;; [1.4] 索引的集合 - Indexed
(def v [:a :b :c])
(nth v 2)
(get v 2)
(nth v -1)                             ; IndexOutOfBoundsException
(get v -1)                             ; nil


;;; [1.5] 栈 - Stack
;;; conj, pop peek
; list as a stack
(conj '() 1)
(conj '(2 1) 3)                        ; (3 2 1): 放入头部
(peek '(3 2 1))                        ; 3: 从头部peek
(pop '(3 2 1))                         ; (2 1): 从头部pop
(pop '(1))                             ; ()
(pop '())                              ; IllegalStateException

; vector as a statck
(conj [] 1)
(conj [1 2] 3)                         ; [1 2 3]: 放入尾部
(peek [1 2 3])                         ; 3: 从尾部peek
(pop [1 2 3])                          ; [1 2]: 从尾部pop
(pop [1])                              ; []
(pop [])                               ; IllegalStateException


;;; [1.6] 集 - Set
;;; get, disj
(get #{1 2 3} 2)                       ; 将set作为自身元素到自身元素的map
(get #{1 2 3} 4)                       ; nil
(get #{1 2 3} 4 "not-found")

(disj #{1 2 3} 3 1)                    ; 从集合中移除元素

; TODO(zhoujiagen) clojure.set


;;; [1.7] 有序的集合 - Sorted
;;; rseq, subseq, rsubseq
(def sm (sorted-map :z 5 :x 9 :y 0 :b 2 :a 3 :c 4))
(rseq sm)
(subseq sm <= :c)                      ; ([:a 3] [:b 2] [:c 4])
(subseq sm > :b <= :y)                 ; ([:c 4] [:x 9] [:y 0])
(rsubseq sm > :b <= :y)                ; ([:y 0] [:x 9] [:c 4])

; 比较函数, 排序函数
(compare 2 2)                          ; 字典序
(compare "ab" "abc")
(compare ["a" "b" "c"] ["a" "b"])
(sort < (repeatedly 10 #(rand-int 100)))
(sort-by first > (map-indexed vector "Clojure")) ; first => >, first为keyfn

(sorted-map :a 1 :c 3 :b 2)
(sorted-set 1 3 2)
(sorted-map-by compare :z 5 :x 9 :y 0 :b 2 :a 3 :c 4)
(sorted-set-by compare 1 3 2)
(sorted-map-by (comp - compare) :z 5 :x 9 :y 0 :b 2 :a 3 :c 4) ; 倒序

;;; [2] 访问集合元素
(get [:a :b :c] 2)
(get {:a 5 :b 6} :b)
(get {:a 5 :b 6} :c "not-found")
(get #{1 2 3} 3)
; 集合本身是函数
([:a :b :c] 2)
({:a 5 :b 6} :b)
({:a 5 :b 6} :c "not-found")
(#{1 2 3} 3)
([:a :b :c] -1)                        ; IndexOutOfBoundsException
; 集合的key(关键字和符号)通常是函数
(:b {:a 5 :b 6})
(:c {:a 5 :b 6} "not-found")
(:c #{:a :b :c})

(map :name [{:age 21 :name "David"}    ; 关键字作为函数
            {:gender :f :name "Suzanne"}
            {:name "Sara" :location "NYC"}])
(some #{1 3 7} [0 2 4 5 6])            ; 集合作为函数
(some #{1 3 7} [0 2 3 4 5 6])
(filter :age [{:age 21 :name "David"}  ; 关键字作为函数
              {:gender :f :name "Suzanne"}
              {:name "Sara" :location "NYC"}])
; 返回不满足条件的元素的集合
(filter (comp (partial <= 25) :age) [{:age 21 :name "David"}
                                     {:gender :f :name "Suzanne" :age 20}
                                     {:name "Sara" :location "NYC" :age 34}])
; 返回满足条件的元素的集合
(remove (comp (partial <= 25) :age) [{:age 21 :name "David"}
                                     {:gender :f :name "Suzanne" :age 20}
                                     {:name "Sara" :location "NYC" :age 34}])


;;; [3] 数据结构的类型
;;; list, vector, set, map
; list
'(1 2 3)
'(1 2 (+ 1 2))                         ; (1 2 (+ 1 2))
(list 1 2 (+ 1 2))                     ; (1 2 3)
(list? '(1 2 3))
; vector
(vector 1 2 3)
(vector (range 5))                     ; [(0 1 2 3 4)]
(vec (range 5))                        ; [0 1 2 3 4]
(vector? [1 2 3])
; set
#{1 2 3}
#{1 2 3 3}                             ; IllegalArgumentException
(hash-set :a :b :c :d)                 ; #{:c :b :d :a}
(set [1 6 1 8 3 7 7])                  ; #{7 1 6 3 8}
(apply str (remove (set "aeiouy") "vowels are useless"))
(defn numeric? [s]
  (every? (set "0123456789") s))
(numeric? "123")
(numeric? "42b")
; map
{:a 5 :b 6}
{:a 5 :a 6}                            ; IllegalArgumentException
(hash-map :a 5 :b 6)
(apply hash-map [:a 5 :b 6])
(def m {:a 5 :b 6})
(keys m)
(vals m)
(map key m)
(map val m)
(def playlist                          ; map作为临时的数据结构
  [{:title "Elephant" :artist "The White Stripes" :year 2003}
   {:title "Helioself" :artist "Papas Fritas" :year 1997}
   {:title "Stories from the City, Stories form the Sea"
    :artist "PJ Harvey" :year 2000}
   {:title "Buildings and Grounds" :artist "Papas Fritas" :year 2000}
   {:title "Zen Rodeo" :artist "Mardi Gras BB" :year 2002}])
(map :title playlist)
(group-by :artist playlist)            ; 按键分组


;;; [4] 不可变性和持久性
;;; 易变集合(transient)
(def x (transient []))                 ; 定义易变集合
(def y (conj! x 1))                    ; 易变操作: conj!
(count y)                              ; 1
(count x)                              ; 1

(def v [1 2])
(def tv (transient v))
(prn v)
(conj v 3)                             ; 不影响原有持久性集合
(prn v)
(prn tv)
(conj! tv 3)
(prn tv)
(get tv 0)
(persistent! tv)
(get tv 0)                             ; IllegalAccessError, 变为持久性集合后不可再用

; 易变集合用于优化目的
(into #{} (range 5))
(defn native-into
  "自定义实现的into: 使用不可变集合"
  [coll source]
  (reduce conj coll source))
(= (into #{} (range 500))
   (native-into #{} (range 500)))
(time (do (into #{} (range 1e6))       ; 683.815918 msecs
          nil))
(time (do (native-into #{} (range 1e6)) ; 1382.071776 msecs
          nil))
(defn faster-info
  "使用易变集合实现的into"
  [coll source]
  (persistent! (reduce conj! (transient coll) source)))
(time (do (faster-info #{} (range 1e6)) ; 619.29363 msecs
          nil))

; 易变集合需要使用其修改操作的返回值
(let [tm (transient {})]
  (doseq [x (range 100)]
    (assoc! tm x 0))
  (persistent! tm))                    ; {0 0, 1 0, 2 0, 3 0, 4 0, 5 0, 6 0, 7 0}
; 易变集合不能组合: persistent!不会遍历嵌套的易变集合
(persistent! (transient [(transient {})]))
; 易变集合没有值语义
(= (transient [1 2]) (transient [1 2])) ; false

;;; [5] 元数据
;;; map形式, 关联到Clojure数据结构/序列/记录/符号/引用类型
(def a ^{:created (System/currentTimeMillis)}
  [1 2 3])
(meta a)                               ; 访问元数据
(meta ^:private [1 2 3])               ; ^:key 值为true
(meta ^:private ^:dynamic [1 2 3])
; 更新元数据
(def b ^:private [1 2 3])
(meta b)
(def b (with-meta a (assoc (meta a)    ; 完全替换
                           :modified (System/currentTimeMillis))))
(meta b)
(def b (vary-meta a                    ; 更新
                  assoc :modified (System/currentTimeMillis)))
(meta b)
; 元数据不影响值语义
(= ^{:a 5} 'any-value
   ^{:b 5} 'any-value)                 ; true
