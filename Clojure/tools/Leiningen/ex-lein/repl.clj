(require 'ex-lein.core)
(ex-lein.core/-main)
(require '[clj-http.client :as http])
(def response (http/get "https://leiningen.org"))
(keys response)
(:status response)

(doc -main)
(source -main)