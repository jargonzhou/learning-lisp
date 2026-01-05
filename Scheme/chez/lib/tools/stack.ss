(library (tools stack)
  (export make-stack)
  (import (rnrs base))

  (define make-stack
    (lambda ()
      ; data
      (let ([lst '()])
        ; method
        (lambda (msg . args)
          (cond
            [(eqv? msg 'empty?) (null? lst)]
            [(eqv? msg 'push!) (set! lst (cons (car args) lst))]
            [(eqv? msg 'top) (car lst)]
            [(eqv? msg 'pop!) 
              (let ([r (car lst)])
              (set! lst (cdr lst))
              r)]
            [else "oops"])))))
)