(import (io simple))

;;; if
; (let ((ls (quote (a b c)))) (if (null? ls) (quote ()) (cdr ls))) ;=> (b c)
(pr
  (let ([ls '(a b c)])
    (if (null? ls)
        '()
        (cdr ls))))

; (let ((ls (quote ()))) (if (null? ls) (quote ()) (cdr ls))) ;=> ()
(pr
  (let ([ls '()])
    (if (null? ls)
        '()
        (cdr ls))))

; (let ((abs (lambda (x) (if (< x 0) (- 0 x) x)))) (abs -4)) ;=> 4
(pr
  (let ([abs (lambda (x) (if (< x 0) (- 0 x) x))])
    (abs -4)))

; (let ((x -4)) (if (< x 0) (list (quote minus) (- 0 x)) (list (quote plus) 4))) ;=> (minus 4)
(pr
  (let ([x -4])
    (if (< x 0)
        (list 'minus (- 0 x))
        (list 'plus 4))))

;;; not
; (not #f) ;=> #t
(pr (not #f))
; (not #t) ;=> #f
(pr (not #t))
; (not (quote ())) ;=> #f
(pr (not '()))
; (not (< 4 5)) ;=> #f
(pr (not (< 4 5)))

;;; and
; (let ((x 3)) (and (> x 2) (< x 4))) ;=> #t
(pr
  (let ([x 3])
    (and (> x 2) (< x 4))))
; (let ((x 5)) (and (> x 2) (< x 4))) ;=> #f
(pr
  (let ([x 5])
    (and (> x 2) (< x 4))))
; (and #f (quote (a b)) (quote (c d))) ;=> #f
(pr (and #f '(a b) '(c d)))
; (and (quote (a b)) (quote (c d)) (quote (e f))) ;=> (e f)
(pr (and '(a b) '(c d) '(e f)))

;;; or
; (let ((x 3)) (or (< x 2) (> x 4))) ;=> #f
(pr
  (let ([x 3])
    (or (< x 2) (> x 4))))
; (let ((x 5)) (or (< x 2) (> x 4))) ;=> #t
(pr
  (let ([x 5])
    (or (< x 2) (> x 4))))
; (or #f (quote (a b)) (quote (c d))) ;=> (a b)
(pr (or #f '(a b) '(c d)))

;;; cond
; (let ((x 0)) (cond ((< x 0) (list (quote minus) (abs x))) ((> x 0) (list (quote plus) x)) (else (list (quote zero) x)))) 
; ;=> (zero 0)
(pr
  (let ([x 0])
    (cond
      [(< x 0) (list 'minus (abs x))]
      [(> x 0) (list 'plus x)]
      [else (list 'zero x)])))

(define select
  (lambda (x)
    (cond
      [(not (symbol? x))]
      [(assq x '((a . 1) (b . 2) (c . 3))) => cdr]
      [else 0])))

; (select 3) ;=> #t
(pr (select 3))
; (select (quote b)) ;=> 2
(pr (select 'b))
; (select (quote e)) ;=> 0
(pr (select 'e))

;;; when, unless
; (let ((x -4) (sign (quote plus))) (when (< x 0) (set! x (- 0 x)) (set! sign (quote minus))) (list sign x)) 
; ;=> (minus 4)
(pr
  (let ([x -4] [sign 'plus])
    (when (< x 0)
      (set! x (- 0 x))
      (set! sign 'minus))
    (list sign x)))

(define check-pair
  (lambda (x)
    (unless (pair? x)
      (syntax-violation 'check-pair "invalid argument" x))
    x))
; (check-pair (quote (a b c))) ;=> (a b c)
(pr (check-pair '(a b c)))
; (pr (check-pair 'a)) ; Exception in check-pair: invalid argument a

;;; case
; (let ((x 4) (y 5)) (case (+ x y) ((1 3 5 7 9) (quote odd)) ((0 2 4 6 8) (quote even)) (else (quote out-of-range)))) 
; ;=> odd
(pr
  (let ([x 4] [y 5])
    (case (+ x y)
      [(1 3 5 7 9) 'odd]
      [(0 2 4 6 8) 'even]
      [else 'out-of-range])))

(exit)