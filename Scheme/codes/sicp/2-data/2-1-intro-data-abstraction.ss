(import 
  (io simple)
  (sicp))

(comments "arithmetic operations for rational numbers")
; cons, car, cdr
(define (_cons x y)
  (define (dispatch m)
    (cond
      [(= m 0) x]
      [(= m 1) y]
      [else (error "Argument not 0 or 1 -- CONS" m)]))
  dispatch)
(define (_car z) (z 0))
(define (_cdr z) (z 1))

; wishful thinking
; assume: constructor and selectors
; n for numerator
; d for denominator
(define (make-rat n d)
  #;(cons n d)
  (let ([g (gcd n d)])
    (_cons (/ n g) (/ d g))))
(define (numer rat)
  (_car rat))
(define (denom rat)
  (_cdr rat))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; the toString() method like Java
(define (rat->string x)
  (let-values ([(op g) (open-string-output-port)])
    (put-datum op (numer x))
    (put-string op "/")
    (put-datum op (denom x))
    (g)))

; express the rules
; n1/d1 + n2/d2 = (n1d2 + n2d1) / (d1d2)
(define (add-rat x y)
  (make-rat
    (+ (* (numer x) (denom y))
      (* (numer y) (denom x)))
    (* (denom x) (denom y))))
; n1/d1 - n2/d2 = (n1d2 - n2d1) / (d1d2)
(define (sub-rat x y)
  (make-rat
    (- (* (numer x) (denom y))
      (* (numer y) (denom x)))
    (* (denom x) (denom y))))
; n1/d1 * n2/d2 = (n1n2) / (d1d2)
(define (mul-rat x y)
  (make-rat
    (* (numer x) (numer y))
    (* (denom x) (denom y))))
; n1/d1 / n2/d2 = (n1d2) / (d1n2)
(define (div-rat x y)
  (make-rat
    (* (numer x) (denom y))
    (* (denom x) (numer y))))
; n1/d1 =?= n2/d2
(define (equal-rat? x y)
  (=
    (* (numer x) (denom y))
    (* (numer y) (denom x))))

;;; usage of rat

(let ([one-half (make-rat 1 2)]
      [one-third (make-rat 1 3)])
  
  (prs (rat->string one-half))

  (print-rat one-half)
  (print-rat (add-rat one-half one-third))
  (print-rat (mul-rat one-half one-third))
  (print-rat (add-rat one-third one-third)))

(exit)