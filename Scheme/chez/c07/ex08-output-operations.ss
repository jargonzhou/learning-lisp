(import (io simple))

(comments "put-u8, put-bytevector, put-char, put-string, put-datum")
(let ([p (current-output-port)]
      [bp (standard-output-port)])
    (put-u8 bp 97)
    (put-u8 bp 10)

    (put-bytevector bp #vu8(97 10))
    
    (put-char p #\a)
    (put-char p #\newline)
    
    (put-string p "a\n")
    
    (put-datum p #\a)
    (put-datum p #\newline)
    
    (flush-output-port p)
    (flush-output-port bp))

(exit)