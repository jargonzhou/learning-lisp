(define (fact n)
    (if (= n 1) 
        1
        (* n (fact (- n 1)))))

(define (fact-tail n)
    (fact-rec n n))

(define (fact-rec n p)
    (if (= n 1)
        p
        (let ((m (- n 1)))
            (fact-rec m (* m p)))))

; named let
(define (fact-let n)
    (let loop((n1 n) (p n))             ; 1
        (if (= n1 1)
            p
            (let ((m (- n1 1)))
                (loop m (* p m))))))     ; 2

(define (fact-letrec n)
    (letrec ((iter (lambda (n1 p)        ; letrec 
                        (if (= n1 1)
                            p
                            (let ((m (- n1 1)))
                                (iter m (* p m))))))) ; *
        (iter n n)))

(define (fact-do n)
    (do ((n1 n (- n1 1))                  ; do
        (p n (* p (- n1 1))))
        ((= n1 1) p)))