;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A: Number Basics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#lang racket

; Takes a positive decimal integer and returns a list consisting of the digits that
; form the binary representation of the number
(define (decimal->bin n)
  (let loop ([n n]
             [l '()])
    (if (zero? n)
        l
        (let-values ([(n d) (quotient/remainder n 2)])
          (loop n (cons d l))))))

(decimal->bin 15) ; '(1 1 1 1)
(decimal->bin 10) ; '(1 0 1 0)
(decimal->bin 64206) ; '(1 1 1 1 1 0 1 0 1 1 0 0 1 1 1 0)

; ~r function: takes a base-10 value and outputs a formatted string in another base
(~r 64206 #:base 2) ; "1111101011001110"
(~r 64206 #:base 8) ; "175316"
(~r 64206 #:base 16) ; "face"
(~r 170 #:base 2 #:min-width 12 #:pad-string "0") ; "000010101010"
