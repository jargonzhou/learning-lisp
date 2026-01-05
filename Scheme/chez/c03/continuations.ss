(import
;   (chezscheme)
  (tools tests)
  (io simple))

(comments "return values of call/cc")

(pr (call/cc (lambda (k) (* 5 4))))
(pr (call/cc (lambda (k) (* 5 (k 4)))))
(pr (+ 2
       (call/cc (lambda (k) (* 5 (k 4))))))

(comments "nonlocal exit")
(define product
  (lambda (ls)
    (call/cc
      (lambda (break)
        (let f ([ls ls])
          (cond
            [(null? ls) 1]
            [(= (car ls) 0) (break 0)]
            [else (* (car ls) (f (cdr ls)))]))))))

(pr (product '(1 2 3 4 5)))
(pr (product '(1 2 3 0 5)))

(comments "continuation as return value")
(let ([x (call/cc (lambda (k) k))])
  (displayln (x (lambda (ignore) "hi"))))
; more debuging outputs
(let ([x (call/cc (lambda (k) (pr k) k))])
    (pr x)
    (pr (x (lambda (ignore) "hi"))))

(comments "outlize the continuation")
(define retry #f)
(define factorial
  (lambda (x)
    (if (= x 0)
      (call/cc (lambda (k) (set! retry k) 1))
      (* x (factorial (- x 1))))))

(pr (factorial 4))
; (inspect retry)
(pr (retry 1))
(pr (retry 2))
(pr (retry 5))

;;; lwp: light-weight process
; ; all lwps
; (define lwp-list '())
; ; create a lwp
; (define (lwp thunk)
;   ; (pr thunk) ; debug
;   (set! lwp-list (append lwp-list (list thunk))))
; ; start first lwp
; (define (start)
;   (let ([p (car lwp-list)])
;     ; (pr p) ; debug
;     (set! lwp-list (cdr lwp-list))
;     (p)))

; (define (pause)
;   (call/cc 
;     (lambda (k)
;       (lwp (lambda () (k #f)))  ; create a lwp
;       (start))))                ; start the first lwp

; (let ()
;     (lwp (lambda () (let f () (pause) (display "h") (f)))) ; 1
;     (lwp (lambda () (let f () (pause) (display "e") (f)))) ; 2
;     (lwp (lambda () (let f () (pause) (display "y") (f)))) ; 3
;     (lwp (lambda () (let f () (pause) (display "!") (f)))) ; 4
;     (lwp (lambda () (let f () (pause) (newline) (f))))     ; 5
;     (start))

(exit)