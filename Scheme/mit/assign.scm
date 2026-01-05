;;; assignment

(define bank-account
    (let ((balance 10))
        (lambda (n)
            (set! balance (+ balance n))
            balance)))

(begin
    (display (bank-account 20))
    (newline)
    (display (bank-account -25))
    (newline))

(define (make-bank-account balance)
    (lambda (n)
        (set! balance (+ balance n))
        balance))

(let ((ba1 (make-bank-account 10)))
    (display (ba1 20))
    (newline)
    (display (ba1 -25))
    (newline))

(let ((tree `((1 2) (3 4 5) (6 7 8 9))))
    (display tree)
    (newline)
    (set-car! (car tree) 100)           ; set-car!
    (display tree)
    (newline)
    (set-cdr! (third tree) `(a b c))    ; set-cdr!
    (display tree)
    (newline))