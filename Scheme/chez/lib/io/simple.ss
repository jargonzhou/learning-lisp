(library (io simple)
  (export displayln println comments pr prs)
  (import (rnrs base) (rnrs io simple))
  
  ;;; Print texts, line seperated.
  (define (displayln . texts)
    (if (null? texts)
      (newline)
      (for-each (lambda (x) (display x) (newline)) texts)))
  
  (define println displayln)

  ;;; Print comments.
  (define (comments text)
    (newline)
    (display ";;; ")
    (display text)
    (newline))

  ;;; Print form  ;=> form value.
  (define-syntax pr
    (syntax-rules ()
      [(_ obj)
        (begin
          (write 'obj)
          (display " ;=> ")
          (write obj)
          (newline))]))
  
  ;;; Batched form  ;=> form value.
  (define-syntax prs
    (syntax-rules ()
      [(_) (newline)]
      [(_ obj1 obj2 ...)
        (begin
          (write 'obj1)
          (display " ;=> ")
          (write obj1)
          (newline)
          (prs obj2 ...))])))