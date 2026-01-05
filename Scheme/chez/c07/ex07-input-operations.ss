(import (io simple))

(comments "lookahead")
(define (get-word p)
  (list->string
    (let f ()
      (let ([c (lookahead-char p)])
        (cond
          [(eof-object? c) '()]
          [(char-alphabetic? c) (get-char p) (cons c (f))]
          [else '()])))))
(prs (get-word (open-string-input-port "hi.\nwhat's up?\n")))

(comments "get-string-n!")
(define (string-set! s i c)
  (let ([sip (open-string-input-port (string c))])
    (get-string-n! sip s i 1)
    (if #f #f)))

(define (string-fill! s c)
  (let ([n (string-length s)])
    (let ([sip (open-string-input-port (make-string n c))])
      (get-string-n! sip s 0 n)
      (if #f #f))))

(let ([x (make-string 3)])
  (string-fill! x #\-)
  (string-set! x 2 #\))
  (string-set! x 0 #\;)
  (prs x))

(comments "get-line")
(let ([sip (open-string-input-port "one\ntwo\n")])
  (let* ([s1 (get-line sip)]
         [s2 (get-line sip)])
    (prs s1 s2 (port-eof? sip))))

(let ([sip (open-string-input-port "one\ntwo")])
  (let* ([s1 (get-line sip)]
         [s2 (get-line sip)])
    (prs s1 s2 (port-eof? sip))))

(comments "get-datum")
(let ([sip (open-string-input-port "; a\n\n one (two )\n")])
  (let* ([x1 (get-datum sip)]
         [c1 (lookahead-char sip)]
         [x2 (get-datum sip)])
    (prs x1 c1 x2 (port-eof? sip))))

(exit)