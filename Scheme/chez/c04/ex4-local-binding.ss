(import (io simple))

;;; let
; (let ((x (* 3.0 3.0)) (y (* 4.0 4.0))) (sqrt (+ x y))) ;=> 5.0
(pr
  (let ([x (* 3.0 3.0)] [y (* 4.0 4.0)])
    (sqrt (+ x y))))

; (let ((x (quote a)) (y (quote (b c)))) (cons x y)) ;=> (a b c)
(pr
  (let ([x 'a] [y '(b c)])
    (cons x y)))

; (let ((x 0) (y 1)) (let ((x y) (y x)) (list x y))) ;=> (1 0)
(pr
  (let ([x 0] [y 1])
    (let ([x y] [y x]) ; x = 1; y = 0
      (list x y))))

;;; let*
; (let* ((x (* 5.0 5.0)) (y (- x (* 4.0 4.0)))) (sqrt y)) ;=> 3.0
(pr
  (let* ([x (* 5.0 5.0)]
         [y (- x (* 4.0 4.0))])
    (sqrt y)))

; (let ((x 0) (y 1)) (let* ((x y) (y x)) (list x y))) ;=> (1 1)
(pr
  (let ([x 0] [y 1])
    (let* ([x y] [y x]) ; x = 1, y = 1
      (list x y))))

;;; letrec
; (letrec ((sum (lambda (x) (if (zero? x) 0 (+ x (sum (- x 1))))))) (sum 5)) ;=> 15
(pr
  ; sum: a mutually recuursive procedure
  (letrec ([sum (lambda (x) (if (zero? x) 0 (+ x (sum (- x 1)))))]) 
    (sum 5)))

;;; letrec*
; (letrec* ((sum (lambda (x) (if (zero? x) 0 (+ x (sum (- x 1)))))) (f (lambda () (cons n n-sum))) (n 15) (n-sum (sum n))) (f)) 
; ;=> (15 . 120)
(pr
  (letrec* ([sum (lambda (x) (if (zero? x) 0 (+ x (sum (- x 1)))))]
            [f (lambda () (cons n n-sum))]
            [n 15]
            [n-sum (sum n)])
    (f)))

; (letrec* ((f (lambda () (lambda () g))) (g (f))) (eq? (g) g)) ;=> #t
(pr
  (letrec* ([f (lambda () (lambda () g))]
            [g (f)])
    (eq? (g) g)))

; Exception: attempt to reference undefined variable f
; (letrec* ([g (f)]
;           [f (lambda () (lambda () g))])
;   (eq? (g) g))

(exit)