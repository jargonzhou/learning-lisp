(ns com.spike.clojure.core.datatype.hierarchies)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 层级: 定义具名对象(关键字或符号)和类/接口之间的关系
; 使用层级可以表达转发值之间的关系, 多重方法使用转发值细化如何选择具体的方法实现
; 类和接口智能作为一个层级的叶子节点
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 定义层级
(derive ::checkbox ::checkable)
(derive ::radio ::checkable)
(derive ::checkable ::input)
(derive ::text ::input)
; 测试层级关系
(isa? ::radio ::input)                 ; true, 具有传递性
(isa? ::radio ::text)                  ; false

; 私有层级
(def fill-hierarchy (-> (make-hierarchy)
                        (derive :input.radio ::checkable)
                        (derive :input.checkbox ::checkable)
                        (derive ::checkable :input)
                        (derive :input.text :input)
                        (derive :input.hiddent :input)))

(defn- fill-dispatch
  [node value]
  (if-let [type (and (= :input (:tag node))
                     (-> node :attrs :type))]
    (keyword (str "input." type))
    (:tag node)))

(defmulti fill
  #'fill-dispatch
  :default nil
  :hierarchy #'fill-hierarchy)
(defmethod fill nil
  [node value]
  (if (= :input (:tag node))
    (do
      (alter-var-root #'fill-hierarchy ; 动态修改层次定义
                      derive (fill-dispatch node value) :input)
      (fill node value))
    (assoc node :content [(str value)])))
(defmethod fill :input                 ; hidden, text
  [node value]
  (assoc-in node [:attrs :value] (str value)))
(defmethod fill ::checkable            ; radio, checkbox
  [node value]
  (if (= value (-> node :attrs :value))
    (assoc-in node [:attrs :checked] "checked")
    (update-in node [:attrs] dissoc :checked)))


; usage
(def node {:tag :input
           :attrs {:value "first choice"
                   :type "checkbox"}})
(def value "first choice")
; {:tag :input, :attrs {:value "first choice", :type "checkbox", :checked "checked"}}
(fill node value)
; {:tag :input, :attrs {:value "first choice", :type "checkbox"}}
(fill (fill node value) "off")

; 演示动态修改层次定义(alter-var-root)
; {:tag :input, :attrs {:type "date", :value "20171231"}}
(fill {:tag :input
       :attrs {:type "date"}}
      "20171231")