(import (io simple))

(comments "defaults")
(let ()
  (define-record-type point (fields x y))
  
  (let ([p (make-point 36 -17)])
    (pr p)
    (pr (point? p))
    (pr (point? '(cons 36 -17)))
    (pr (point-x p))
    (pr (point-y p))))

(comments "override names")
(let ()
  (define-record-type (point mkpoint ispoint?) 
    (fields 
      (mutable x x-val set-x-val!) 
      (immutable y y-val)))
    
  (let ([p (mkpoint 36 -17)]
        [p2 (mkpoint 36 -17)])
    (pr (ispoint? p))
    (pr (ispoint? p2))
    (pr (equal? p p2))
    (pr (ispoint? '(cons 36 -17)))
    (pr (x-val p))
    (pr (y-val p))

    (set-x-val! p (- (x-val p) 12))
    (pr (x-val p))))

(comments "subtype")
(let ()
  (define-record-type point (fields x y))
  (define-record-type cpoint (parent point) (fields color))

  (let ([cp (make-cpoint 3 4 'red)])
    (pr (point? cp))
    (pr (cpoint? cp))
    (pr (cpoint? (make-point 3 4)))
    (pr (point-x cp))
    (pr (point-y cp))
    (pr (cpoint-color cp))))

(comments "nongenerative")
(let ()
  (define (f p)
    (define-record-type point (fields x y) (nongenerative))
    (if (eq? p 'make) (make-point 3 4) (point? p)))
  (define p (f 'make))
  (pr (f p)))

(let ()
  (define (f)
    (define-record-type point (fields x y) (nongenerative))
    (make-point 3 4))
  (define (g p)
    (define-record-type point (fields x y) (nongenerative))
    (point? p))
  (pr (g (f))))

(comments "protocol")
(let ()
  (define-record-type point
    (fields x y d)
    (protocol
      (lambda (new)
        (lambda (x y)
          (new x y (sqrt (+ (* x x) (* y y))))))))
  
  (define-record-type cpoint
    (parent point)
    (fields color)
    (protocol
      (lambda (pargs->new)
        (lambda (c x y)
          ((pargs->new x y) c)))))
  
  (let ([p (make-point 3 4)]
        [cp (make-cpoint 'red 3 4)])
    (prs
      (point-x p)
      (point-y p)
      (point-d p)

      (point-x cp)
      (point-y cp)
      (cpoint-color cp))))