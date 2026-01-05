(import (io simple))

;;; named let

(define divisors
  (lambda (n)
    (let f ([i 2])
      (cond
        [(>= i n) '()]
        [(integer? (/ n i)) (cons i (f (+ i 1)))]
        [else (f (+ i 1))]))))
; (divisors 5) ;=> ()
(pr (divisors 5))
; (divisors 32) ;=> (2 4 8 16)
(pr (divisors 32))

(define divisors
  (lambda (n)
    (let f ([i 2] [ls '()])
      (cond
        [(>= i n) ls]
        [(integer? (/ n i)) (f (+ i 1) (cons i ls))]
        [else (f (+ i 1) ls)]))))
; (divisors 5) ;=> ()
(pr (divisors 5))
; (divisors 32) ;=> (16 8 4 2)
(pr (divisors 32))

;;; do
(define factorial
  (lambda (n)
    (do ([i n (- i 1)] [a 1 (* a i)])
      ((zero? i) a))))
; (factorial 10) ;=> 3628800
(pr (factorial 10))

(define fibonacci
  (lambda (n)
    (if (= n 0)
        0
        (do ([i n (- i 1)]
             [a1 1 (+ a1 a2)]
             [a2 0 a1])
          ((= i 1) a1)))))
; (fibonacci 6) ;=> 8
(pr (fibonacci 6))

(define divisors
  (lambda (n)
    (do ([i 2 (+ i 1)]
         [ls '() (if (integer? (/ n i)) (cons i ls) ls)])
      ((>= i n) ls))))
; (divisors 5) ;=> ()
(pr (divisors 5))
; (divisors 32) ;=> (16 8 4 2)
(pr (divisors 32))

(define scale-vector!
  (lambda (v k)
    (let ([n (vector-length v)])
      (do ([i 0 (+ i 1)])
        ((= i n))
        (vector-set! v i (* (vector-ref v i) k))))))
(define vec (vector 1 2 3 4 5))
(scale-vector! vec 2)
; vec ;=> #(2 4 6 8 10)
(pr vec)

(exit)