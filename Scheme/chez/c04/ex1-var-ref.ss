(import (io simple))

; list ;=> #<procedure list>
(pr 
  list) 

(define x 'a)
; (list x x) ;=> (a a)
(pr 
  (list x x))

; (let ((x (quote b))) (list x x)) ;=> (b b)
(pr 
  (let ([x 'b])
    (list x x)))

; (let ((let (quote let))) let) ;=> let
(pr 
  (let ([let 'let]) let)) 

(define f
  (lambda (x)
    (g x)))
(define g
  (lambda (x)
    (+ x x)))

; (define ff (gg 3)) ; Exception: variable gg is not bound
; (define gg
;   (lambda (x)
;     (+ x x)))

(exit)