(import (io simple))

(comments "eol-style")
(prs 
  (eol-style crlf)
  ; (eol-style lfcr) ; invalid eol style lfcr
)

(comments "error-handling-mode")
(prs
  (error-handling-mode replace)
  ; (error-handling-mode relpace) ; invalid error handling mode relpace
)

(exit)