(import (io simple))

(comments "expressions")
(prs
  486
  (+ 137 349)
  (- 1000 334)
  (* 5 99)
  (/ 10 5)
  (+ 2.7 10)
  (+ 21 35 12 7)
  (* 25 4 12)
  (+ (* 3 5) (- 10 6))
  (+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6)))

(comments "naming")
(define size 2)
(prs
  size
  (* 5 size))

(define pi 3.14159)
(define radius 10)
(prs (* pi (* radius radius)))
(define circumference (* 2 pi radius))
(prs circumference)

(comments "compound procedures")
(define (square x) (* x x))
(prs
  (square 21)
  (square (+ 2 5))
  (square (square 3)))

(define (sum-of-squares x y)
  (+ (square x) (square y)))
(prs (sum-of-squares 3 4))

(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))
(prs (f 5))

(comments "conditional expressions, predicates")
(define (abs x)
  (cond 
    [(> x 0) x]
    [(= x 0) 0]
    [(< x 0) (- x)]))
(prs
  (abs -1)
  (abs 0)
  (abs 1))

(let ([x 6])
  (prs
    (and (> x 5) (< x 10))))

(define (ge x y)
  #;(or (> x y) (= x y))
  (not (< x y)))
(prs
  (ge 1 2)
  (ge 2 1))

(comments "square roots by Newton's method")
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(prs
  sqrt
  square

  (sqrt 9)
  (sqrt (+ 100 37))
  (sqrt (+ (sqrt 2) (sqrt 3)))
  (square (sqrt 1000)))

(comments "procedures as black-box abstractions")
(define (sqrt2 x)
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (average x y)
    (/ (+ x y) 2))
  
  (sqrt-iter 1.0 x))

(prs
  sqrt2
  square

  (sqrt2 9)
  (sqrt2 (+ 100 37))
  (sqrt2 (+ (sqrt2 2) (sqrt2 3)))
  (square (sqrt2 1000)))

(exit)