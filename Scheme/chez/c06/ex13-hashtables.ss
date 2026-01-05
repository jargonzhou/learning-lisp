(import (io simple))

(comments "make-eq-hashtable")
(let ()
  (define ht1 (make-eq-hashtable))
  (define ht2 (make-eq-hashtable 32))
  (prs ht1 ht2))

(comments "hashtable-mutable?")
(prs
  (hashtable-mutable? (make-eq-hashtable))
  (hashtable-mutable? (hashtable-copy (make-eq-hashtable)))
)

(comments "hashtable-hash-function, hashtable-equivalence-function")
(let ()
  (define ht (make-eq-hashtable))
  (prs
    (hashtable-hash-function ht)
    (eq? (hashtable-equivalence-function ht) eq?)))

(let ()
  (define ht (make-hashtable string-hash string=?))
  (prs
    (eq? (hashtable-hash-function ht) string-hash)
    (eq? (hashtable-equivalence-function ht) string=?)))

(comments "hashtable-set!")
(let ()
  (define ht (make-eq-hashtable))
  (hashtable-set! ht 'a 73)
  (prs ht))

(comments "hashtable-ref")
(let ()
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))

  (let ()
    (define eqht (make-eq-hashtable))
    (hashtable-set! eqht p1 73)
    (prs 
      (hashtable-ref eqht p1 55)
      (hashtable-ref eqht p2 55)))

  (let ()
    (define equalht (make-hashtable equal-hash equal?))
    (hashtable-set! equalht p1 73)
    (prs 
      (hashtable-ref equalht p1 55)
      (hashtable-ref equalht p2 55))))

(comments "hashtable-contains?")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))
  (hashtable-set! ht p1 73)
  (prs 
    (hashtable-contains? ht p1))
    (hashtable-contains? ht p2))

(comments "hashtable-update!")
(let ()
  (define ht (make-eq-hashtable))
  (hashtable-update! ht 'a
    (lambda (x) (* x 2))
    55)
  (prs (hashtable-ref ht 'a 0))
  (hashtable-update! ht 'a
    (lambda (x) (* x 2))
    0)
  (prs (hashtable-ref ht 'a 0)))

(comments "hashtable-delete!")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))
  (hashtable-set! ht p1 73)
  (prs (hashtable-contains? ht p1))
  (hashtable-delete! ht p1)
  (prs (hashtable-contains? ht p1))
  (prs (hashtable-contains? ht p2))
  (hashtable-delete! ht p2))

(comments "hashtable-size")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))
  (prs (hashtable-size ht))
  (hashtable-set! ht p1 73)
  (prs (hashtable-size ht))
  (hashtable-delete! ht p1)
  (prs (hashtable-size ht)))

(comments "hashtable-copy")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (hashtable-set! ht p1 "c")
  (let ()
    (define ht-copy (hashtable-copy ht))
    (prs (hashtable-mutable? ht-copy))
    (hashtable-delete! ht p1)
    (prs (hashtable-ref ht p1 #f))
    ; (hashtable-delete! ht-copy p1) ; #<eq hashtable> is not mutable
    (prs (hashtable-ref ht-copy p1 #f))))

(comments "hashtable-clear!")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))
  (hashtable-set! ht p1 "first")
  (hashtable-set! ht p2 "second")
  (prs (hashtable-size ht))
  (hashtable-clear! ht)
  (prs (hashtable-size ht))
  (prs (hashtable-ref ht p1 #f)))


(comments "hashtable-keys")
(let ()
  (define ht (make-eq-hashtable))
  (define p1 (cons 'a 'b))
  (define p2 (cons 'a 'b))
  (hashtable-set! ht p1 "one")
  (hashtable-set! ht p2 "two")
  (hashtable-set! ht 'q "three")
  (prs (hashtable-keys ht)))

(exit)