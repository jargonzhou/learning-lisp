(import (io simple))

; (+ 3 4) ;=> 7
(pr (+ 3 4))
; ((if (odd? 3) + -) 6 2) ;=> 8
(pr ((if (odd? 3) + -) 6 2))
; ((lambda (x) x) 5) ;=> 5
(pr ((lambda (x) x) 5))(let ((f (lambda (x) (+ x x)))) (f 8)) ;=> 16
; 
(pr
  (let ([f (lambda (x) (+ x x))])
    (f 8)))

;;; apply

; (apply + (quote (4 5))) ;=> 9
(pr (apply + '(4 5)))
; (apply min (quote (6 8 3 2 5))) ;=> 2
(pr (apply min '(6 8 3 2 5)))
; (apply min 5 1 3 (quote (6 8 3 2 5))) ;=> 1
(pr (apply min 5 1 3 '(6 8 3 2 5)))
; (apply vector (quote a) (quote b) (quote (c d e))) ;=> #(a b c d e)
(pr (apply vector 'a 'b '(c d e)))

(define first
  (lambda (ls)
    (apply (lambda (x . y) x) ls)))
(define rest
  (lambda (ls)
    (apply (lambda (x . y) y) ls)))

; (first (quote (a b c d))) ;=> a
(pr (first '(a b c d)))
; (rest (quote (a b c d))) ;=> (b c d)
(pr (rest '(a b c d)))

; (apply append (quote (1 2 3)) (quote ((a b) (c d e) (f)))) ;=> (1 2 3 a b c d e f)
(pr (apply append '(1 2 3) '((a b) (c d e) (f))))

(exit)