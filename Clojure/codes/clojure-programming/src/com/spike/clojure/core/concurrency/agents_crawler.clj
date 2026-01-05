(ns com.spike.clojure.core.concurrency.agents-crawler
  (:require [net.cgrand.enlive-html :as enlive])
  (:use [clojure.string :only (lower-case)])
  (:import (java.net URL MalformedURLException)
           (java.util.concurrent LinkedBlockingQueue BlockingQueue)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; agents, 并行化工作量: 网络爬虫
; 并不是很好调试啊, REPL方式?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn- links-from
  "提取网页内容`html`中以`base-url`为前缀的连接."
  [^URL base-url html]
  (remove nil? (for [link (enlive/select html [:a])]
                 (when-let [href (-> link :attrs :href)]
                   (try
                     (URL. base-url href)
                     (catch MalformedURLException e
                       (.printStackTrace e)))))))

(defn- words-from
  "提取网页内容`html`中单词"
  [html]
  (let [chunks (-> html
                   (enlive/at [:script] nil)
                   (enlive/select [:body enlive/text-node]))]
    (->> chunks
         (mapcat (partial re-seq #"\w+"))
         (remove (partial re-matches #"\d+"))
         (map lower-case))))



; 数据结构
(def url-queue (LinkedBlockingQueue.)) ; 需要抓取的链接 
(def crawled-urls (atom #{}))          ; 已抓取过的链接
(def word-freqs (atom {}))             ; 词频

(declare get-url run process handle-results)
(def agents (set (repeatedly 25 #(agent {::t #'get-url :queue url-queue}))))

(defn ^::blocking get-url
  "获取下一个待抓取的链接"
  [{:keys [^BlockingQueue queue] :as state}] ; BlockingQueue[URL]
 ;(println "DEBUG[get-url]>>>" state)
  (let [url (.take queue)]
    (try
      (if (@crawled-urls url)
        state
        {:url url :content (slurp url) ::t #'process})
      (catch Exception e
        (.printStackTrace e)
        state)
      (finally (run *agent*)))))           ; *agent* 在agent action中表示当前agent

(defn process
  "获取网页中链接和计算单词词频"
  [{:keys [url content]}] ; url is URL
  ;(println "DEBUG[process]>>>" url content)
  (try
    (let [html (enlive/html-resource (java.io.StringReader. content))]
      {::t #'handle-results
       :url url
       :links (links-from url html)
       :words (reduce (fn [m word]
                        (update-in m [word] (fnil inc 0)))
                      {}
                      (words-from html))})
    (finally (run *agent*))))

(defn ^::blocking handle-results
  "更新已抓取链接, 更新待抓取链接和合并词频"
  [{:keys [url links words]}]
  ;(println "DEBUG[handle-results]>>>" url links words)
  (try
    (swap! crawled-urls conj url)
    (doseq [url links]
      (.put url-queue url))
    (swap! word-freqs (partial merge-with +) words)
    {::t #'get-url :queue url-queue}
    (catch Exception e
      (.printStackTrace e))
    (finally (run *agent*))))

(defn paused?
  "判断是否暂停: 通过元数据`::paused`."
  [agent]
  (::paused (meta agent)))

(defn run
  "执行."
  ([] (doseq [a agents] (run a)))
  ([a]
   (when (agents a)
     (send a (fn [{transition ::t :as state}]
               (when-not (paused? *agent*)
                 (let [dispatch-fn (if (-> transition meta ::blocking)
                                     send-off
                                     send)]
                   (dispatch-fn *agent* transition)))
               state)))))


(defn pause
  "暂停: 加`::paused`元数据."
  ([] (doseq [a agents] (pause a)))
  ([a] (alter-meta! a assoc ::paused true)))

(defn restart
  "重启: 移除`::paused`元数据."
  ([] (doseq [a agents] (restart a)))
  ([a]
   (alter-meta! a dissoc ::paused)
   (run a)))

(defn test-crawler
  [agent-count starting-url]
  (def agents (set (repeatedly agent-count
                               #(agent {::t #'get-url :queue url-queue}))))
  (.clear url-queue)
  (swap! crawled-urls empty)
  (swap! word-freqs empty)
  (.add url-queue (URL. starting-url))
  (run)
  (Thread/sleep 10000)
  (pause)
  [(count @crawled-urls) (count url-queue)])

;(test-crawler 5 "http://www.iciba.com/")
;(test-crawler 5 "http://www.bbc.co.uk/news/")