(library (tspl sort)
  (export sort merge)
  (import (rnrs))

  ;;; Sort a list with comparation predicate.
  (define (sort pred? l)
    (if (null? l) l (dosort pred? l (length l))))

  ;;; Merge two lists with comparation predicate.
  (define (merge pred? l1 l2)
    (domerge pred? l1 l2))

  ;;; Do sort sublist with length n in a list.
  (define (dosort pred? ls n)
    (if (= n 1)
      (list (car ls))
      (let ([i (div n 2)])
        (domerge pred?
          (dosort pred? ls i)
          (dosort pred? (list-tail ls i) (- n i))))))

  ;;; Do merge two lists with comparation predicate.
  (define (domerge pred? l1 l2)
    (cond
      [(null? l1) l2]
      [(null? l2) l1]
      [(pred? (car l2) (car l1))
       (cons (car l2) (domerge pred? l1 (cdr l2)))]
      [else (cons (car l1) (domerge pred? (cdr l1) l2))]))
)