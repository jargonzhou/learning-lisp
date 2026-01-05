(import
  (io simple)
  (files))

(comments "raise")
; Exception: no go
#;(raise
  (condition
    (make-error)
    (make-message-condition "no go")))

; Exception: oops
#;(raise-continuable
  (condition
    (make-violation)
    (make-message-condition "oops")))

(prs 
  (list
    (call/cc
      (lambda (k)
        (vector
          (with-exception-handler
            (lambda (x) (k (+ x 5)))
            (lambda () (+ (raise 17) 8))))))))

(prs
  (list
    (vector
      (with-exception-handler
        (lambda (x) (+ x 5))
        (lambda () (+ (raise-continuable 17) 8))))))

; Exception occurred with condition components:
;   0. &non-continuable
#;(prs
  (list
    (vector
      (with-exception-handler
        (lambda (x) (+ x 5))
        (lambda () (+ (raise 17) 8))))))

(comments "with-exception-handler")
(define (try thunk)
  (call/cc
    (lambda (k)
      (with-exception-handler
        (lambda (x) (if (error? x) (k #f) (raise x)))
        thunk))))
(prs
  (try (lambda () 17))
  (try (lambda () (raise (make-error))))
  ; Exception occurred with condition components:
  ; 0. &violation
  #;(try (lambda () (raise (make-violation)))) 

  ; Exception: oops
  #;(with-exception-handler
    (lambda (x)
      (raise
        (apply condition
          (make-message-condition "oops")
          (simple-conditions x))))
    (lambda ()
      (try (lambda () (raise (make-violation)))))))

(comments "guard")
(prs
  (guard (x [else x]) (raise "oops"))
  ; Exception occurred with condition components:
  ; 0. &error
  #;(guard (x [#f #f]) (raise (make-error))))

(let ()
  (define-syntax try
    (syntax-rules ()
      [(_ e1 e2 ...)
       (guard (x [(error? x) #f]) e1 e2 ...)]))
  (define open-one
    (lambda fn*
      (let loop ([ls fn*])
        (if (null? ls)
          (error 'open-one "all open attempts failed" fn*)
          (or (try (open-input-file (car ls)))
            (loop (cdr ls)))))))
  (make-sure-file-not-exists "foo.ss")
  (make-sure-file-exists "bar.ss")
  (prs (open-one "foo.ss" "bar.ss")))

(exit)