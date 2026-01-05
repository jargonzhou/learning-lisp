(ns com.spike.clojure.core.concurrency.refs
  (:require [com.spike.clojure.core.concurrency.commons :as commons]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ref: 唯一的协同引用类型
;;; STM(Software Transactional Memory, 软件事务内存)
;;; alter, commute, ref-set, ref-max-history, ensure 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; 示例: RPG游戏

; 最大生命值校验器
(defn- enforce-max-health
  "默认校验器."
  [{:keys [name health]}]
  (fn [character-data]
    (or (<= (:health character-data) health)
        (throw (IllegalStateException.
                (str name " is already at max health!"))))))

(defn character
  "创建角色, 返回ref."
  [name & {:as opts}]
  (ref (merge {:name name  ; 名称 
               :items #{}  ; 武器set
               :health 500}; 生命值
              opts)))
(defn character-with-validator
  "带校验器的创建角色, 返回ref. 参数中:validators指定角色特定的校验器."
  [name & {:as opts}]
  (let [cdata (merge {:name name :items #{} :health 500} opts)
        cdata (assoc cdata :max-health (:health cdata))
        validators (list* (enforce-max-health cdata)
                          (:validators cdata))]
    (ref (dissoc cdata :validators)
         :validator #(every? (fn [v] (v %)) validators))))

;;; alter: in-transaction-value
(defn loot
  "掠夺: 从`from`抢夺武器到`to`."
  [from to]
  (dosync                              ; 划定事务边界
   (when-let [item (first (:items @from))]
     (alter to update-in [:items] conj item)
     (alter from update-in [:items] disj item))))

(defn attack
  "攻击: 挑衅者`aggressor`攻击目标`target`."
  [aggressor target]
  (dosync
   (let [damage (* (rand 0.1) (:strength @aggressor))]
     (commute target update-in [:health] #(max 0 (- % damage))))))

(defn heal
  "治疗: 医治者`healer`给目标`target`加血, 消耗魔法值`:mana`."
  [healer target]
  (dosync
   (let [aid (min (* (rand 0.1) (:mana @healer)) ; 最大生命值限制
                  (- (:max-health @target) (:health @target)))]
     (commute healer update-in [:mana] - (max 5 (/ aid 5)))
     (commute target update-in [:health] + aid))))

(def alive? (comp pos? :health))       ; 是否或者
(defn play
  "决斗: 角色`character`在角色`other`上施加动作`action`"
  [character action other]
  (while (and (alive? @character)
              (alive? @other)
              (action character other))
    (Thread/sleep (rand-int 50))))



; 巨龙史矛革
(def smaug (character "Smaug" :health 500 :strength 400 :items (set (range 50))))
; 比尔伯
(def bilbo (character "Bilbo" :health 100 :strength 100))
; 甘道夫
(def gandalf (character "Gandalf" :health 75 :mana 750))
(println @smaug)
(println @bilbo)
(println @gandalf)

; 测试最大生命值校验器
(def bilbo-with-validator (character-with-validator "Bilbo" :health 100 :strength 100))
; 未修改`heal`中aid时: IllegalStateException Bilbo is already at max health!
(heal gandalf bilbo-with-validator)
; 加到满血
(dosync (alter bilbo-with-validator assoc-in [:health] 95))
(heal gandalf bilbo-with-validator)
(= 100 (:health @bilbo-with-validator)); true


#_(commons/wait-futures 1
                        (println "hello"))

(commons/wait-futures 1
                      (while (loot smaug bilbo))
                      (while (loot smaug gandalf)))
(println @smaug)
(println @bilbo)
(println @gandalf)
(map (comp count :items deref) [bilbo gandalf])
(filter (:items @bilbo) (:items @gandalf)) ; ()

;;; commute: 交换原则(commutative property), 最小化事务冲突
(def x (ref 0))
(time (commons/wait-futures 5 ; 2211.310136 msecs
                            (dotimes [_ 1000]
                              (dosync (alter x + (apply + (range 1000)))))
                            (dotimes [_ 1000]
                              (dosync (alter x - (apply + (range 1000)))))))
(println @x)                           ; 0
(time (commons/wait-futures 5 ; 234.28676 msecs
                            (dotimes [_ 1000]
                              (dosync (commute x + (apply + (range 1000)))))
                            (dotimes [_ 1000]
                              (dosync (commute x - (apply + (range 1000)))))))
(println @x)                           ; 0


(commons/wait-futures 1
                      (play bilbo attack smaug)
                      (play smaug attack bilbo))
(map (comp :health deref) [bilbo smaug])

; 加血后再决斗
(dosync
 (alter smaug assoc :health 500)
 (alter bilbo assoc :health 100))
(commons/wait-futures 1
                      (play bilbo attack smaug)
                      (play smaug attack bilbo)
                      (play gandalf heal bilbo))
(map (comp #(select-keys % [:name :health :mana]) deref)
     [smaug bilbo gandalf])


;;; ref-set直接设置, 通常用于重新初始化
(dosync (ref-set bilbo {:name "Bilbo"})) ; {:name "Bilbo"}


;;; ref的历史版本值: 事务内使用解引用, 可能触发事务重试
(ref-max-history (ref "abc" :min-history 3 :max-history 30)) ; 30
(def a (ref 0))
(ref-history-count a)                  ; 0
(future (dotimes [_ 500]               ; 比较频繁的修改事务
          (dosync (Thread/sleep 200)
                  (alter a inc))))
@(future (dosync (Thread/sleep 1000)   ; 较慢的只读事务: 事务内使用解引用
                 @a))
(ref-history-count a)

;;; ensure: 处理写歪斜(write skew)
;; 事务依赖读取的ref, 但在事务进行中该ref被其他事务修改
(def daylight (ref 1))                 ; 日照: 中午, 傍晚
(defn attack-with-daylight
  "带日照因素的攻击: 挑衅者`aggressor`攻击目标`target`."
  [aggressor target]
  (dosync
   (let [damage (* (rand 0.1) (:strength @aggressor) (ensure daylight))]
     (commute target update-in [:health] #(max 0 (- % damage))))))
