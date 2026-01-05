(library (grades)
    (export gpa->grade gpa)
    (import (rnrs))

    (define (in-range? x n y)
        (and (>= n x) (< n y)))
    
    (define-syntax range-case
    ;(trace-define-syntax range-case
        (syntax-rules (- else)
            [(_ expr ((x - y) e1 e2 ...) ... [else ee1 ee2 ...])
            (let ([tmp expr])
                (cond
                    [(in-range? x tmp y) e1 e2 ...]
                    ...
                    [else ee1 ee2 ...]))]
            [(_ expr ((x - y) e1 e2 ...) ...)
            (let ([tmp expr])
                (cond
                    [(in-range? x tmp y) e1 e2 ...]
                    ...))]))

    (define (letter->number x)
        (case x
            [(a) 4.0]
            [(b) 3.0]
            [(c) 2.0]
            [(d) 1.0]
            [(f) 0.0]
            [else (assertion-violation 'grade "invalid letter grade " x)]))

    (define (gpa->grade x)
        (range-case x
            [(0.0 - 0.5) 'f]
            [(0.5 - 1.5) 'd]
            [(1.5 - 2.5) 'c]
            [(2.5 - 3.5) 'b]
            [else 'a]))

    (define-syntax gpa
    ;(trace-define-syntax gpa
        (syntax-rules ()
            [(_ g1 g2 ...)
            (let ([lst (map letter->number '(g1 g2 ...))])
                (/ (apply + lst) (length lst)))]))
)