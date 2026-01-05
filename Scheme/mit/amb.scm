(load "commons.scm")

(define call/cc call-with-current-continuation)
(define fail #f)

(define (choose . ls)
  (if (null? ls)
    (fail)
    (let ((fail0 fail))
      (call/cc
        (lambda (cc)
          (set! fail (lambda ()
                       (set! fail fail0)
                       (cc (apply choose (cdr ls)))))
          (cc (car ls)))))))

 (call/cc
    (lambda (cc)
        (set! fail (lambda () (cc 'no-choice)))))

(define-syntax amb
    (syntax-rules ()
        ((_) (fail))
        ((_ a) a)
        ((_ a b ...)
        (let ((fail0 fail))
            (call/cc (lambda (cc)
                (set! fail (lambda () (set! fail fail0) (cc (amb b ...)))) (cc a)))))))

(println (amb))