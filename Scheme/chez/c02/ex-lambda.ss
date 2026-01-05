;;; lambdas
(import (io simple))

(let ([f (lambda x x)])
  (pr (f 1 2 3 4)))

(let ([f (lambda x x)])
  (pr (f)))

(let ([g (lambda (x . y) (list x y))])
  (pr (g 1 2 3 4)))

(let ([h (lambda (x y . z) (list x y z))])
  (pr (h 'a 'b 'c 'd)))

(exit)