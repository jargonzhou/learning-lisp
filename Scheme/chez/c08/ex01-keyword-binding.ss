(import (io simple) (chezscheme))

(comments "define-syntax")
; (define-syntax _let*
(trace-define-syntax _let*                   ; Section 3.1 Tracing in Chez Scheme Version 9 User's Guide
  (syntax-rules ()
    [(_ () b1 b2 ...) (let () b1 b2 ...)]
    [(_ ((i1 e1) (i2 e2) ...) b1 b2 ...)
     (let ([i1 e1])
       (_let* ([i2 e2] ...) b1 b2 ...))]))

(_let* ([x 0]) x)

(let ()
  (define even?
    (lambda (x)
      (or (= x 0) (odd? (- x 1)))))
  (define-syntax odd?
    (syntax-rules ()
      [(_ x) (not (even? x))]))
  (prs (even? 10)))

(let ()
  (define-syntax bind-to-zero
    (syntax-rules ()
      [(_ id) (define id 0)]))

  (bind-to-zero x)
  (prs x))

(comments "let-syntax, letrec-syntax")
(let ([f (lambda (x) (+ x 1))])
  (let-syntax ([f (syntax-rules ()
                    [(_ x) x])]
               [g (syntax-rules ()
                    [(_ x) (f x)])])    ; f: in let
    (prs (list (f 1) (g 1)))))

(let ([f (lambda (x) (+ x 1))])
  (letrec-syntax ([f (syntax-rules ()
                       [(_ x) x])]
                  [g (syntax-rules ()
                       [(_ x) (f x)])]) ; f: in letrec-syntax
    (prs (list (f 1) (g 1)))))

(exit)