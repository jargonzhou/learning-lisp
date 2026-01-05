(define (make-worker n)
    (lambda ()  (set! n (+ n 1))  n) )