(ns examples.references)

; ------------------------------------------------------------------------------
; refs
; ------------------------------------------------------------------------------
(def current-track (ref "Mars, the Bringer of War"))
(deref current-track)
(println @current-track)

(dosync (ref-set current-track "Venus, the Bringer of Peace"))
(println @current-track)

; STM
(def current-composer (ref "Holst"))
(dosync
 (ref-set current-track "Credo")
 (ref-set current-composer "Byrd"))
; alter
(defrecord Message [sender text])
(def messages (ref ()))
(defn add-message [msg]
  (dosync (alter messages conj msg)))

(add-message (->Message "user 1" "hello"))
(add-message (->Message "user 2" "howdy"))

(defn add-message-commute [msg]
  (dosync (commute messages conj msg)))
(add-message-commute (->Message "user 1" "hello 2"))
(add-message-commute (->Message "user 2" "howdy 2"))

(def counter (ref 0))
(defn next-counter []
  (dosync (alter counter inc)))
(next-counter)
(next-counter)

; ------------------------------------------------------------------------------
; atoms
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; agents
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; vars
; ------------------------------------------------------------------------------


; ------------------------------------------------------------------------------
; Snake
; ------------------------------------------------------------------------------
; see snake.clj