(import (io simple))

; (lambda (x) (+ x 3)) ;=> #<procedure at ex2-lambda.ss:28>
(pr 
  (lambda (x) (+ x 3))) 

; ((lambda (x) (+ x 3)) 7) ;=> 10
(pr 
  ((lambda (x) (+ x 3)) 7)) 

; ((lambda (x y) (* x (+ x y))) 7 13) ;=> 140
(pr
  ((lambda (x y) (* x (+ x y))) 7 13))

; ((lambda (f x) (f x x)) + 11) ;=> 22
(pr
  ((lambda (f x) (f x x)) + 11))

; ((lambda () (+ 3 4))) ;=> 7
(pr
  ((lambda () (+ 3 4))))

; ((lambda (x . y) (list x y)) 28 37) ;=> (28 (37))
(pr
  ((lambda (x . y) (list x y)) 28 37))

; ((lambda (x . y) (list x y)) 28 37 47 28) ;=> (28 (37 47 28))
(pr
  ((lambda (x . y) (list x y)) 28 37 47 28))

; ((lambda (x y . z) (list x y z)) 1 2 3 4) ;=> (1 2 (3 4))
(pr
  ((lambda (x y . z) (list x y z)) 1 2 3 4))

; ((lambda x x) 7 13) ;=> (7 13)
(pr
  ((lambda x x) 7 13))

(exit)