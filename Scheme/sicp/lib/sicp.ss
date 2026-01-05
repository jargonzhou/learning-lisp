;;; When we found depdendency on existing procedures, we put them here.
(library (sicp)
  (export
    square
    even?
    true
    false
    nil)
  (import (rnrs))

  (define (square x) (* x x))
  ; (define (even? x) (= (remainder x 2) 0))

  (define true #t)
  (define false #f)
  (define nil '())
)

