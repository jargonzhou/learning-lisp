(import (io simple))

(define x 3)
; x ;=> 3
(pr x)

(define f
  (lambda (x y)
    (* (+ x y) 2)))
; (f 5 4) ;=> 18
(pr (f 5 4))

(define (sum-of-squares x y)
  (+ (* x x) (* y y)))
; (sum-of-squares 3 4) ;=> 25
(pr (sum-of-squares 3 4))

(define f (lambda (x) (+ x 1)))
; (let ((x 2)) (define f (lambda (y) (+ y x))) (f 3)) ;=> 5
(pr
  (let ([x 2])
    (define f
      (lambda (y) (+ y x)))
    (f 3)))
; (f 3) ;=> 4
(pr (f 3))

(define f 
  (lambda (x) (g x))) ; g is not already defined
(define g
  (lambda (x) (+ x x)))
; (f 3) ;=> 6
(pr (f 3))

(exit)