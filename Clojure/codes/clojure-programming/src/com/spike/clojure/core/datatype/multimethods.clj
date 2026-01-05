(ns com.spike.clojure.core.datatype.multimethods)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 多重方法
; defmulti: 定义多重转发
; defmethod: 定义方法的实现
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 转发函数的实际定义
; 转发函数 [方法实现的参数] (返回的转发值)
(defn- fill-dispatch
  [node value]
  (if (= :input (:tag node))
    [(:tag node) (-> node :attrs :type)]
    (:tag node)))

(defmulti fill
  "Fill a xml/html node with the provided value."
  #'fill-dispatch                      ; 重定向到实际的转发函数
  :default nil)                        ; 默认的转发值(计算出转发值为nil)

(defmethod fill nil
  [node value]
  (assoc node :content [(str value)]))
(defmethod fill :div                   ; :div为转发值
  [node value]
  (assoc node :content [(str value)]))
; 按<input/>的type分别定义
(defmethod fill [:input nil]
  [node value]
  (assoc-in node [:attrs :value] (str value)))
(defmethod fill [:input "hidden"]
  [node value]
  (assoc-in node [:attrs :value] (str value)))
(defmethod fill [:input "text"]
  [node value]
  (assoc-in node [:attrs :value] (str value)))
(defmethod fill [:input "radio"]
  [node value]
  (if (= value (-> node :attrs :value))
    (assoc-in node [:attrs :checked] "checked")
    (update-in node [:attrs] dissoc :checked)))
(defmethod fill [:input "checkbox"]
  [node value]
  (if (= value (-> node :attrs :value))
    (assoc-in node [:attrs :checked] "checked")
    (update-in node [:attrs] dissoc :checked)))
(defmethod fill :default               ; 未找到匹配的转发值上的方法实现
  [node value]
  (assoc-in node [:attrs :name] (str value)))

; usage
(def node {:tag :input
           :attrs {:value "first choice"
                   :type "checkbox"}})
(def value "first choice")
; {:tag :input, :attrs {:value "first choice", :type "checkbox", :checked "checked"}}
(fill node value)
; {:tag :input, :attrs {:value "first choice", :type "checkbox"}}
(fill (fill node value) "off")


;;; defmethod中重复的方法实现怎么处理??? 见hierarchies.clj
