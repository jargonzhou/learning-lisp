;;; Tracing

(define length
    (lambda (lst)
        (if (null? lst)
            0
            (+ (length (cdr lst)) 1))))

(let ()
    (trace length) ; tracing
    (display (length '(a b c d)))
    (newline))

(exit)