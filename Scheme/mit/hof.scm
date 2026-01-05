;;; high order function

(define (member-if pred lst)
    (cond 
        ((null? lst) `())
        ((pred (car lst)) lst)              ; first match
        (else (member-if pred (cdr lst)))))

(display (member-if positive? `(0 -1 -2 3 5 -7)))
(newline)
(display (member-if positive? `(0 -1 -2 -3 -5 -7)))
(newline)

(define (member pred obj lst)
    (cond ((null? lst) #f)
        ((pred obj (car lst)) #t)
        (else (member pred obj (cdr lst)))))

(display (member eqv? 5 `(0 -1 -2 3 5 -7)))        
(newline)
(display (member eqv? 4 `(0 -1 -2 3 5 -7)))    