(ns com.spike.clojure.core.concurrency.vars
  (:use (clojure repl)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; var
;;; 提供命名空间内全局实体, 各线程上可将该实体绑定到不同的值
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(println map)
(println (var map))                    ; 引用var自身
(println #'map)                        ; 引用var自身的语法糖
(println @#'map)
(= #'map (var map))                    ; true
(= map @#'map)                         ; true

;;; [1] 定义var
; [1.1] 私有var
(def ^:private everything 42)
(def ^{:private true} everything 42)
(meta #'everything)
; defn-: 私有函数
(defn- private-f
  []
  (println "in private function"))
(private-f)


; [1.2] 文档字符串
(def a
  "A sample value."
  5)
(doc a)
(meta #'a)
(def ^{:doc "A sample value.."} aa 5)
(doc aa)


; [1.3] 常量
(def ^:const something 42)
(def ^:const max-value 255)            ; 编译时替换
(defn valid-value?
  [v]
  (<= v max-value))                    ; 不受max-value重定义的影响
(def max-value 500)
(println max-value)                    ; 500
(valid-value? 299)                     ; false


;;; [2] 动态作用域
(def ^:dynamic *max-value* 255)        ; 动态var, 根绑定
(defn valid-value?
  [v]
  (<= v *max-value*))
(binding [*max-value* 500]             ; 每线程上覆盖根绑定
  (valid-value? 299))                  ; true
; 仅在当前线程上覆盖根绑定
(binding [*max-value* 500]
  (println (valid-value? 299))         ; true
  (doto (Thread. #(println "in other thread:" (valid-value? 299))) ; false
    .start
    .join))

; 使用动态绑定提供: 隐式参数和向上层函数返回值
(def ^:dynamic *response-code* nil)
(defn http-get
  [url-string]
  (let [conn (-> url-string java.net.URL. .openConnection)
        response-code (.getResponseCode conn)]
    (when (thread-bound? #'*response-code*)  ; 是否创建var的线程本地绑定
      (set! *response-code* response-code))  ; 修改线程本地值, 外层调用者可以访问
    (when (not= 404 response-code)
      (-> conn .getInputStream slurp))))

(http-get "http://clojuredocs.org/search?q=doc")
(println *response-code*)
(binding [*response-code* nil]
  (let [content (http-get "http://clojuredocs.org/search?q=doc")]
    (println "Response code was: " *response-code*))) ; Response code was:  200

; 绑定传播: 动态var绑定可以在线程间传播(agent send/send-off, future, pmap等)
(def ^:dynamic *max-value* 255)        ; 动态var, 根绑定
(defn valid-value?
  [v]
  (<= v *max-value*))
(binding [*max-value* 500]
  (println (valid-value? 299))         ; true
  @(future (valid-value? 299)))        ; true
; 一般的lazy seq不支持
(binding [*max-value* 500]
  (map valid-value? [299]))            ; (false)
(map #(binding [*max-value* 500]       ; (true), 手动传播
        (valid-value? %))
     [299])

; 修改var的根绑定
(def x 0)
(alter-var-root #'x inc)               ; 1

; 前置申明
(declare complex-helper-fn other-helper-fn) ; 声明多个绑定
(defn public-api-function              ; 公开函数的定义
  [arg1 arg2]
  (other-helper-fn arg1 arg2 (complex-helper-fn arg1 arg2)))

(defn- complex-helper-fn               ; 辅助函数的定义
  [arg1 arg2]
  [arg1 arg2])
(defn- complex-helper-fn
  [arg1 arg2 arg3]
  [arg1 arg2 arg3])



