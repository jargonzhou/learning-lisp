(import (io simple))

(define cons 'not-cons)
; (eval (quote (let ((x 3)) (cons x 4))) (environment (quote (rnrs)))) ;=> (3 . 4)
(pr (eval '(let ([x 3]) (cons x 4)) (environment '(rnrs))))

(define lambda 'not-lambda)
; (eval (quote (lambda (x) x)) (environment (quote (rnrs)))) ;=> #<procedure>
(pr (eval '(lambda (x) x) (environment '(rnrs))))

; Exception: attempt to reference unbound identifier cons
; (eval '(cons 3 4) (environment))

(define env (environment '(rnrs) '(prefix (rnrs lists) $)))
; (eval (quote ($cons* 3 4 (* 5 8))) env) ;=> (3 4 . 40)
(pr (eval '($cons* 3 4 (* 5 8)) env))

(exit)