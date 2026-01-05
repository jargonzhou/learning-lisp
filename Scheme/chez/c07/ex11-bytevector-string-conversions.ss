(import (io simple))

(comments "bytevector->string")
(let ([tx (make-transcoder
            (utf-8-codec)
            (eol-style lf)
            (error-handling-mode replace))])
  (prs (bytevector->string #vu8(97 98 99) tx)))

(comments "string->bytevector")
(let ([tx (make-transcoder
            (utf-8-codec)
            (eol-style lf)
            (error-handling-mode replace))])
  (prs (string->bytevector "abc" tx)))

(comments "string->utf8")
(prs (string->utf8 "abc"))

(comments "utf8->string")
(prs (utf8->string #vu8(97 98 99)))

(exit)