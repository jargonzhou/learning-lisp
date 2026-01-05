;;; Chapter 4. Foreign Interface
;;; https://cisco.github.io/ChezScheme/csug9.5/foreign.html

(import (io simple) (rnrs) (chezscheme))
;(load-shared-object "msvcrt.dll")
(load-shared-object "libc.dylib")

(pr (foreign-entry? "getenv"))

(define getenv
  (foreign-procedure "getenv" (string) string))

; varargs
; https://en.cppreference.com/w/c/io/fprintf
(define printf
  (foreign-procedure "printf" (string string) int))

(pr (getenv "JAVA_HOME"))
(pr (getenv "HOME"))

(pr (printf "%s\n" "Hello Scheme!"))

(exit)