(import (io simple))

; (let-values (((a b) (values 1 2)) (c (values 1 2 3))) (list a b c)) ;=> (1 2 (1 2 3))
(pr
  (let-values ([(a b) (values 1 2)]
               [c (values 1 2 3)])
    (list a b c)))

; (let*-values (((a b) (values 1 2)) ((a b) (values b a))) (list a b)) ;=> (2 1)
(pr
  (let*-values ([(a b) (values 1 2)]
                [(a b) (values b a)]) ; a=2, b=1
    (list a b)))

(exit)