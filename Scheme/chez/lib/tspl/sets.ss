(library (tspl sets)
  (export set-of set-cons in is)
  (import (rnrs)
          ; (chezscheme) ; for trace
          )

  ;;; Use set-of-help, with an initial argument '()
  (define-syntax set-of
  ; (trace-define-syntax set-of
    (syntax-rules ()
      [(_ e m ...)
       (set-of-help e '() m ...)]))

  (define-syntax set-of-help
  ; (trace-define-syntax set-of-help
    (syntax-rules (in is)
      [(_ e base) (set-cons e base)]                    ; (1) e for element, base for set
      [(_ e base (x in s) m ...)                        ; (2) (x in s)
       (let loop ([set s])
         (if (null? set)
           base
           (let ([x (car set)])
             (set-of-help e (loop (cdr set)) m ...))))]
      [(_ e base (x is y) m ...)                        ; (3) (x is y)
       (let ([x y]) (set-of-help e base m ...))]
      [(_ e base p m ...)                               ; (4) p for predicate
       (if p (set-of-help e base m ...) base)]))

  (define-syntax in
    (lambda (x)
      (syntax-violation 'in "misplaced auxiliary keyword" x)))

  (define-syntax is
    (lambda (x)
      (syntax-violation 'is "misplaced auxiliary keyword" x)))

  ;;; Add element x to set y.
  (define (set-cons x y)
    (if (memv x y)
      y
      (cons x y)))
)