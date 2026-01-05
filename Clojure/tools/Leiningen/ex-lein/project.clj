(defproject ex-lein "0.1.0-SNAPSHOT"
  :description "Example Leiningen project"
  :url "https://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.12.3"]
                 [clj-http "3.13.1"] ; https://clojars.org/clj-http
                 ]
  :main ^:skip-aot ex-lein.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})
