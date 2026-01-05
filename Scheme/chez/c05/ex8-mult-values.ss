(import (io simple))

; (call-with-values (lambda () (values)) +) ;=> 0
(pr (call-with-values (lambda () (values)) +))
; (call-with-values (lambda () (values 1)) +) ;=> 1
(pr (call-with-values (lambda () (values 1)) +))
; (call-with-values (lambda () (values 1 2 3)) +) ;=> 6
(pr (call-with-values (lambda () (values 1 2 3)) +))

(define head&tail
  (lambda (ls)
    (values (car ls) (cdr ls))))

(head&tail '(a b c))

; (call-with-values (lambda () (values (quote bond) (quote james))) (lambda (x y) (cons y x))) 
; ;=> (james . bond)
(pr
  (call-with-values
    (lambda () (values 'bond 'james))
    (lambda (x y) (cons y x))))
; (call-with-values values list) ;=> ()
(pr
  (call-with-values values list))

(define dxdy
  (lambda (p1 p2)
    (values (- (car p2) (car p1))
            (- (cdr p2) (cdr p1)))))

(define segment-length
  (lambda (p1 p2)
    (call-with-values
      (lambda () (dxdy p1 p2))
      (lambda (dx dy) (sqrt (+ (* dx dx) (* dy dy)))))))

(define segment-slope
  (lambda (p1 p2)
    (call-with-values
      (lambda () (dxdy p1 p2))
      (lambda (dx dy) (/ dy dx)))))

; (segment-length (quote (1 . 4)) (quote (4 . 8))) ;=> 5
(pr (segment-length '(1 . 4) '(4 . 8)))
; (segment-slope (quote (1 . 4)) (quote (4 . 8))) ;=> 4/3
(pr (segment-slope '(1 . 4) '(4 . 8)))

(exit)