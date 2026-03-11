(import
  (io simple)
  (sicp))

(comments "linear recursion, iteration")
;;; use 'trace-' prefix to trace the procedure executions.
;;; it's a chezscheme extension.
(trace-define (factorial-r n)
  (if (= n 1)
    1
    (* n (factorial-r (- n 1)))))

(trace-define (factorial-i n)
  (trace-define (fact-iter product counter max-count)
    (if (> counter max-count)
      product
      (fact-iter
        (* counter product)
        (+ counter 1)
        max-count)))
  (fact-iter 1 1 n))

(factorial-r 6)
(newline)
(factorial-i 6)

(comments "tree recursion")
(trace-define (fib-r n)
  (cond
    [(= n 0) 0]
    [(= n 1) 1]
    [else (+ (fib-r (- n 1)) (fib-r (- n 2)))]))

(trace-define (fib-i n)
  (trace-define (fib-iter a b count)
    (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(fib-r 5)
(fib-i 5)

(comments "count changes")
(define (count-change amount)
  (define (cc amount kinds-of-coins)
    (cond
      [(= amount 0) 1]
      [(or (< amount 0) (= kinds-of-coins 0)) 0]
      [else (+ (cc                      ; without using any of this kind of coin
                 amount 
                 (- kinds-of-coins 1))
               (cc                      ; do use this kind of coin
                 (- amount (first-denomination kinds-of-coins))
                 kinds-of-coins))]))
  (define (first-denomination kinds-of-coins)
    (cond
      [(= kinds-of-coins 1) 1]
      [(= kinds-of-coins 2) 5]
      [(= kinds-of-coins 3) 10]
      [(= kinds-of-coins 4) 25]
      [(= kinds-of-coins 5) 50]))
  (cc amount 5))

; there is a HUGE tace output, so we do not use it.
(prs (count-change 100))

(comments "exponentiation")
(define (expt-r b n)
  (if (= n 0)
    1
    (* b (expt-r b (- n 1)))))
(define (expt-i b n)
  (define (expt-iter b counter product)
    (if (= counter 0)
      product
      (expt-iter b (- counter 1) (* b product))))
  (expt-iter b n 1))



(define (fast-expt b n)
  (cond
    [(= n 0) 1]
    [(even? n) (square (fast-expt b (/ n 2)))]
    [else (* b (fast-expt b (- n 1)))]))
  
(prs 
  (expt-r 2 10)
  (expt-i 2 10)
  (fast-expt 2 10))

(comments "GCD")
(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))
(prs (gcd 206 40))

(comments "testing for primality")
(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond
      [(> (square test-divisor) n) n]
      [(divides? test-divisor n) test-divisor]
      [else (find-divisor n (+ test-divisor 1))]))
  (define (divides? a b)
    (= (remainder b a) 0))
  (= n (smallest-divisor n)))

; The Fermat test
(define (fast-prime? n times)
  (define (fermat-test n)
    (define (expmod base exp m)
      (cond
        [(= exp 0) 1]
        [(even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m)]
        [else
         (remainder (* base (expmod base (- exp 1) m)) m)]))
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  (cond
    [(= times 0) true]
    [(fermat-test n) (fast-prime? n (- times 1))]
    [else false]))

(prs 
  (prime? 100001651)
  (fast-prime? 100001651 10))

(exit)