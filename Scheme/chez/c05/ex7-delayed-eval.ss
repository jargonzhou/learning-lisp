(import (io simple))

(define stream-car
  (lambda (s) (car (force s)))) ; force

(define stream-cdr
  (lambda (s) (cdr (force s)))) ; force

(define counters
  (let next ([n 1])
    (delay (cons n (next (+ n 1)))))) ; delay

; (stream-car counters) ;=> 1
(pr (stream-car counters))
; (stream-car (stream-cdr counters)) ;=> 2
(pr (stream-car (stream-cdr counters)))

(define stream-add
  (lambda (s1 s2)
    (delay (cons
              (+ (stream-car s1) (stream-car s2))
              (stream-add (stream-cdr s1) (stream-cdr s2))))))

(define even-counters
  (stream-add counters counters))

; (stream-car even-counters) ;=> 2
(pr (stream-car even-counters))
; (stream-car (stream-cdr even-counters)) ;=> 4
(pr (stream-car (stream-cdr even-counters)))

(exit)