(import (io simple))

; CPS: continuation passing style

(letrec ([f (lambda (x) (cons 'a x))]
        [g (lambda (x) (cons 'b (f x)))]
        [h (lambda (x) (g (cons 'c x)))])
    (pr (cons 'd (h '()))))

; k: the continuation
(letrec ([f (lambda (x k) (k (cons 'a x)))]
        [g (lambda (x k)
            (f x (lambda (v) (k (cons 'b v)))))]
        [h (lambda (x k) (g (cons 'c x) k))])
    (pr (h '() (lambda (v) (cons 'd v)))))

(exit)