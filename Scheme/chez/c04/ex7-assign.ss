(import (io simple))

(define flip-flop
  (let ([state #f])
    (lambda ()
      (set! state (not state))
      state)))

(pr (flip-flop)) ; (flip-flop) ;=> #t
(pr (flip-flop)) ; (flip-flop) ;=> #f
(pr (flip-flop)) ; (flip-flop) ;=> #t

(define memoize
  (lambda (proc)
    (let ([cache '()])
      (lambda (x)
        (cond
          [(assq x cache) => cdr]
          [else
            (let ([ans (proc x)])
              (set! cache (cons (cons x ans) cache))
              ans)])))))

(define fibonacci
  (memoize
    (lambda (n)
      (if (< n 2)
        1
        (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))))

; (trace fibonacci)

; (fibonacci 100) ;=> 573147844013817084101
(pr (fibonacci 100))

(exit)