(load "commons.scm")

;;; CPS: Continue-Passing-Style
;;; example: (* 3 (+ 1 2))
;;; passing function which depend on current function's result to current function

;;; identity function
(define (id x)
    x)

;;; current function: +
(define (k+ a b k)
    (k (+ a b)))

;;; current function: *
(define (k* a b k)
    (k (* a b)))

(println (k+ 1 2 (lambda (x) (k* 3 x id))))

(define (fact n)
    (if (= n 1)
        1
        (* n (fact (- n 1)))))

(println (fact 6))

(define (fact-cps n k)
    (if (= n 1)
        (k 1)
        (fact-cps (- n 1) (lambda (x) (k (* n x))))))

(println (fact-cps 6 id))


;;; exception hadling

(define (non-number-error x)
    (display "value error: ")
    (display x)
    (display " is not number.")
    (newline)
    `error)

(define (kproduct lst k kerror)
    (let ((break k))
        (let loop((lst lst) (k k))
            (cond 
            ((null? lst) (k 1))
            ((not (number? (car lst))) (kerror (car lst)))
            ((zero? (car lst)) (break 0))
            (else (loop (cdr lst) (lambda (x) (k (* (car lst) x)))))))))

(begin
    (println (kproduct `(2 4 7) id non-number-error))
    (println (kproduct `(2 4 7 NAN) id non-number-error)))

;;; short name
(define call/cc call-with-current-continuation)


(println (* 3 (call/cc (lambda (k) (println k) (+ 1 2)))))      ; 9
(println (* 3 (call/cc (lambda (k) (println k) (+ 1 (k 2))))))  ; 6


(define cc)
(* 3 (call/cc (lambda (k)
                 (set! cc k)
                 (+ 1 2))))
(+ 100 (cc 3))
