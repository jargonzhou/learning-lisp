(import (io simple))

(comments "open-bytevector-input-port")
(let ([ip (open-bytevector-input-port #vu8(1 2))])
  (let* ([x1 (get-u8 ip)]
         [x2 (get-u8 ip)]
         [x3 (get-u8 ip)])
    (prs x1 x2 (eof-object? x3))))

(comments "open-string-input-port")
(prs (get-line (open-string-input-port "hi.\nwhat's up?\n")))

(comments "open-bytevector-output-port")
(let-values ([(op g) (open-bytevector-output-port)])
  (put-u8 op 15)
  (put-u8 op 73)
  (put-u8 op 115)
  (set-port-position! op 2)
  (let ([bv1 (g)])
    (put-u8 op 27)
    (prs bv1 (g))))

(comments "open-string-output-port")
(let-values ([(op g) (open-string-output-port)])
  (put-string op "some data")
  (let ([str1 (g)])
    (put-string op "new stuff")
    (prs str1 (g))))

(comments "call-with-bytevector-output-port")
(let ([tx (make-transcoder 
            (latin-1-codec) (eol-style lf) (error-handling-mode replace))])
  (prs
    (call-with-bytevector-output-port
      (lambda (p) (put-string p "abc"))
      tx)))

(comments "call-with-string-output-port")
(let ()
  (define (object->string x)
    (call-with-string-output-port
      (lambda (p) (put-datum p x))))
  (prs (object->string (cons 'a '(b c)))))

(exit)