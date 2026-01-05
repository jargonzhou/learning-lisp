(import (io simple) (chezscheme))

(comments "syntax-rules")
(define-syntax _or
; (trace-define-syntax _or
  (syntax-rules ()
    [(_) #f]
    [(_ e) e]
    [(_ e1 e2 e3 ...)
     (let ([t e1]) (if t t (_or e2 e3 ...)))]))

(let ([x 5])
  (prs
    (_or (< x 2) (> x 4))
    
    (_or #f '(a b) '(c d))

    (let ([if #f])
      (let ([t 'okay])
        (_or if t)))))

; warning: not complete
(define-syntax _cond
; (trace-define-syntax _cond
  (syntax-rules (else)
    [(_ (else e1 e2 ...))
     (begin e1 e2 ...)]
    [(_ (e0 e1 e2 ...))
     (if e0 (begin e1 e2 ...))]
    [(_ (e0 e1 e2 ...) c1 c2 ...)
     (if e0 (begin e1 e2 ...) (_cond c1 c2 ...))]))

(define (select x)
  (_cond
    [(< x 0) 'negative]
    [(and (>= x 0) (< x 100)) 'positive]
    [else 'giant]))

(prs (select 3))

(comments "identifier-syntax")
(let ()
  (define-syntax a (identifier-syntax car))
  (prs (list (a '(1 2 3)) a)))

(let ([ls (list 0)])
  (define-syntax a
    (identifier-syntax
      [id (car ls)]
      [(set! id e) (set-car! ls e)]))
      
  (let ([before a])
    (set! a 1)
    (prs (list before a ls))))