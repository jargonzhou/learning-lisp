(ns com.spike.clojure.core.concurrency.agents
  (:require [clojure.java.io :as io])
  (:use (com.spike.clojure.core.concurrency commons)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; agent
;;; send, send-off, agent-error, restart-agent, set-error-handler!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; [1] send(CPU密集型action), send-off(非CPU密集型action)
(def a (agent 500))                    ; 创建
(send a range 1000)

(def a (agent 1000))
(def b (agent 5000))
(send-off a #(Thread/sleep %))
(send-off b #(Thread/sleep %))
@a
(await a b)                            ; 等待发送给agent的action完成
@a                                     ; action已执行完返回nil(Thread/sleep的结果)


;;; [2] 处理agent action中的错误
(def a (agent nil))
; action中抛出异常
(send a (fn [_] (throw (Exception. "something is wrong"))))
a                                      ; #<Agent@702c6ab2 FAILED: nil>
; 给挂掉的agent发送action会失败
(send a identity)                      ; Exception something is wrong
(agent-error a)                        ; 显式获取异常
(restart-agent a 42)                   ; 重启挂掉的agent
(send a inc)
(agent-error a)                        ; nil
(reduce send a (for [x (range 3)]      ; action队列中塞几个异常action
                 (fn [_] (throw (Exception. (str "error #" x))))))
(restart-agent a 42)
(agent-error a)
(restart-agent a 42 :clear-actions true) ; 清空action队列

; agent的错误处理模式和错误处理器
(def a (agent nil :error-mode :continue))
(send a (fn [_] (throw (Exception. "something is wrong"))))
(send a identity)                      ; #<Agent@2fb806d: nil>

(def a (agent nil
              :error-mode :continue
              :error-handler (fn [the-agent exception]
                               (.println System/out (.getMessage exception)))))
(send a (fn [_] (throw (Exception. "something is wrong"))))
(send a identity)
; 显式设置
(set-error-handler! a (fn [the-agent exception]
                        (when (= "FATAL" (.getMessage exception))
                          (set-error-mode! the-agent :fail))))
(send a (fn [_] (throw (Exception. "FATAL"))))
(send a identity)                      ; Exception FATAL
(println #'a)


;;; [3] IO, 事务和嵌套的send
;;; 协调IO或者其他类型的阻塞操作

; [3.1] 使用agent记录引用状态的变更日志
; RPG Game START
(defn- enforce-max-health
  "默认校验器."
  [{:keys [name health]}]
  (fn [character-data]
    (or (<= (:health character-data) health)
        (throw (IllegalStateException.
                (str name " is already at max health!"))))))

(defn character
  "带校验器的创建角色, 返回ref. 参数中:validators指定角色特定的校验器."
  [name & {:as opts}]
  (let [cdata (merge {:name name :items #{} :health 500} opts)
        cdata (assoc cdata :max-health (:health cdata))
        validators (list* (enforce-max-health cdata)
                          (:validators cdata))]
    (ref (dissoc cdata :validators)
         :validator #(every? (fn [v] (v %)) validators))))

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
; RPG Game END

; 流agent
(def console (agent *out*))
(def character-log (agent (io/writer "character-states.log" :append true)))

(defn write
  "写入内容."
  [^java.io.Writer w & content]
  (doseq [x (interpose " " content)]
    (.write w (str x)))
  (doto w
    (.write "\n")
    .flush))

(defn log-reference
  "给引用加监视器, 监视器函数中将引用与流agent关联起来."
  [reference & writer-agents]
  (add-watch reference :log
             (fn [_ reference old new]
               (doseq [writer-agent writer-agents]
                 (send-off writer-agent write new)))))

; 巨龙史矛革
(def smaug (character "Smaug" :health 500 :strength 400))
; 比尔伯
(def bilbo (character "Bilbo" :health 100 :strength 100))
; 甘道夫
(def gandalf (character "Gandalf" :health 75 :mana 1000))

(log-reference bilbo console character-log)
(log-reference smaug console character-log)
(wait-futures 1
              (play bilbo attack smaug)
              (play smaug attack bilbo)
              (play gandalf heal bilbo))

;;; [3.2] 并行化工作量, 见agents_crawler.clj