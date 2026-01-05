(import (tspl oop)
        (io simple))

(let ()
  (define-object (kons kar kdr)
    ((get-car (lambda () kar))
     (get-cdr (lambda () kdr))
     (set-car! (lambda (x) (set! kar x)))
     (set-cdr! (lambda (x) (set! kdr x)))))
  (define p (kons 'a 'b))
  (prs
    (send-message p get-car)
    (send-message p get-cdr)
    (send-message p set-cdr! 'c)
    (send-message p get-cdr)))

(let ()
  (define-object (kons kar kdr)
    ((count 0))
    ((get-car (lambda () (set! count (+ count 1)) kar))
     (get-cdr (lambda () (set! count (+ count 1)) kdr))
     (accesses (lambda () count))))
     
  (define p (kons 'a 'b))
  (prs
    (send-message p get-car)
    (send-message p get-cdr)
    (send-message p accesses)
    (send-message p get-cdr)
    (send-message p accesses)))

(exit)