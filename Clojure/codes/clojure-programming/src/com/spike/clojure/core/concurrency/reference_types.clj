(ns com.spike.clojure.core.concurrency.reference-types
  (:use (clojure pprint)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clojure的引用类型: var, ref, agent, atom
; var: in thread 
; ref: synchronous, coordinated
; atom: synchronous, uncoordinated
; agent: asynchronous, uncoordinated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; [1] 共性
;;; [1.1] 引用类型是包含其他值的容器
@(atom 12)
@(agent {:c 42})
(map deref [(agent {:c 42}) (atom 12) (ref "http://clojure.org") (var +)])

;;; [1.2] notification: watches, constraint: validators
(def sarah (atom {:name "Sarah" :age 25}))

;;; [2] Watches
(defn echo-watch
  [key identity old new] ; 观察器的key, 发生改变的引用, 引用的旧状态, 引用的新状态
  (println key old "=>" new))

(def sarah (atom {:name "Sarah" :age 25}))
(add-watch sarah :echo echo-watch)     ; 添加观察器
(swap! sarah update-in [:age] inc)     ; 修改引用的值
;:echo {:name Sarah, :age 25} => {:name Sarah, :age 26}
(add-watch sarah :echo2 echo-watch)    ; 添加另一个观察器
(swap! sarah update-in [:age] inc)
;:echo {:name Sarah, :age 26} => {:name Sarah, :age 27}
;:echo2 {:name Sarah, :age 26} => {:name Sarah, :age 27}

(remove-watch sarah :echo2)            ; 移除观察器
(swap! sarah update-in [:age] inc)
;:echo {:name Sarah, :age 27} => {:name Sarah, :age 28}

; 记录引用所有历史状态
(def history (atom ()))               ; 数据结构为list
(defn log->list
  [dest-atom watch-key source-ref-type old new]
  (when (not= old new)
    (swap! dest-atom conj new)))

(def sarah (atom {:name "Sarah" :age 25}))
(add-watch sarah :record (partial log->list history))

(swap! sarah update-in [:age] inc)
(swap! sarah update-in [:age] inc)
(swap! sarah identity)
(swap! sarah assoc :wears-glasses? true)
(swap! sarah update-in [:age] inc)
(pprint @history)

;;; [3] Validators
; 创建引用时指定, 适用与atom, ref, agent
(def n (atom 1 :validator pos?))
(swap! n + 500)
(swap! n - 1000)                       ; IllegalStateException
; 创建后指定/修改
(def sarah (atom {:name "Sarah" :age 25}))
(set-validator! sarah :age)
(swap! sarah dissoc :age)              ; IllegalStateException
(set-validator! sarah #(or (:age %)
                           (throw (IllegalStateException.
                                   "People must have `:age`s!"))))
(swap! sarah dissoc :age)