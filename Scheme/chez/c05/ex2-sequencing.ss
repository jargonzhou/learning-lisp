(import (io simple))

(define x 3)
; (begin (set! x (+ x 1)) (+ x x)) ;=> 8
(pr
  (begin
    (set! x (+ x 1))
    (+ x x)))

; (let () (begin (define x 3) (define y 4)) (+ x y)) ;=> 7
(pr 
  (let ()
    (begin (define x 3) (define y 4))
    (+ x y)))

(exit)