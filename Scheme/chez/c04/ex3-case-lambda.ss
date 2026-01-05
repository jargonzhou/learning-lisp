(import (io simple))

(define make-list
  (case-lambda
    [(n) (make-list n #f)]
    [(n x)
    (do ([n n (- n 1)]
          [ls '() (cons x ls)])
        ((zero? n) ls))]))

; (make-list 5) ;=> (#f #f #f #f #f)
(pr
  (make-list 5))
; (make-list 5 1) ;=> (1 1 1 1 1)
(pr 
  (make-list 5 1))

(define substring1
  (case-lambda
    [(s) (substring1 s 0 (string-length s))]
    [(s start) (substring1 s start (string-length s))]
    [(s start end) (substring s start end)] ; delegate to substring
    ))

; (list (substring1 "hi there") (substring1 "hi there" 1) (substring1 "hi there" 1 8)) 
; ;=> ("hi there" "i there" "i there")
(pr
  (list (substring1 "hi there")
    (substring1 "hi there" 1)
    (substring1 "hi there" 1 8)))

(define substring2
  (case-lambda
    [(s) (substring2 s 0 (string-length s))]
    [(s end) (substring2 s 0 end)]
    [(s start end) (substring s start end)] ; delegate to substring
    ))

(define substring3
  (case-lambda
    [(s) (substring3 s 0 (string-length s))]
    [(s start end) (substring s start end)] ; delegate to substring
    ))

(exit)