(library (tools queue)
  (export make-queue putq! getq delq!)
  (import (rnrs base) (rnrs mutable-pairs))

  ;;; queue
  ;;; a list and a header
  ;;; header is pair: car point to the first pair of list, cdr point to the last pair of list

  (define make-queue
    (lambda ()
      (let ([end (cons 'ignored '())])
        (cons end end))))

  (define putq!
    (lambda (q v)
      (let ([end (cons 'ignored '())])
        (set-car! (cdr q) v)
        (set-cdr! (cdr q) end)
        (set-cdr! q end))))

  (define getq
    (lambda (q)
      (car (car q))))

  (define delq!
    (lambda (q)
      (set-car! q (cdr (car q)))))

)