(import 
  (rename (tspl engines) (timed-lambda lambda)) ; use timed-lambda
  (io simple)
  (chezscheme))

(comments "make-engine")
(let ()
  (define eng (make-engine (lambda () 3)))
  (prs
    (eng 10 (lambda (ticks value) value) (lambda (x) x))
    (eng 10 list (lambda (x) x))))

(let ()
  ; (define (fibonacci n)
  ;   (if (< n 2)
  ;     n
  ;     (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))
  (define fibonacci         ; use lambda instead
    (lambda (n)
      (if (< n 2)
        n
        (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))
  
  (define eng (make-engine (lambda () (fibonacci 10))))
  
  (prs 
    (eng 50 list (lambda (new-eng) (set! eng new-eng) "expired"))
    (eng 50 list (lambda (new-eng) (set! eng new-eng) "expired"))
    (eng 50 list (lambda (new-eng) (set! eng new-eng) "expired"))
    (eng 50 list (lambda (new-eng) (set! eng new-eng) "expired"))))

(define fibonacci
  (lambda (n)
    (if (< n 2)
      n
      (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

(let ()
  (define (mileage thunk)
    (let loop ([eng (make-engine thunk)]
               [total-ticks 0])
      (eng 50
        (lambda (ticks value)
          (+ total-ticks (- 50 ticks)))
        (lambda (new-eng)
          (loop new-eng (+ total-ticks 50))))))
          
  (prs
    (mileage (lambda () (fibonacci 10)))))


(comments "round robin")
(let ()
  (define (round-robin engs)
    (if (null? engs)
      '()
      ((car engs)
        1
        (lambda (ticks value)
          (cons value (round-robin (cdr engs))))
        (lambda (eng) 
          (round-robin (append (cdr engs) (list eng)))))))
       
  (prs
    (round-robin
      (map 
        (lambda (x)
          (make-engine
            (lambda () (fibonacci x))))
        '(4 5 2 8 3 7 6 2)))))

(comments "parallel or")
(let ()
  (define (first-true engs)
    (if (null? engs)
      #f
      ((car engs)
        1
        (lambda (ticks value)
          (or value (first-true (cdr engs))))
        (lambda (eng)
          (first-true
            (append (cdr engs) (list eng)))))))

  ;; parallel-or
  (define-syntax por
    (syntax-rules ()
      [(_ x ...)
       (first-true
         (list (make-engine (lambda () x)) ...))]))
           
  (prs
    (por 1 2)
    (por
      ((lambda (x) (x x)) (lambda (x) (x x))) ; nonterminating
      (fibonacci 10))))

(exit)