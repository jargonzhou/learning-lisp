(import (io simple))

(comments "construction")
(prs
  (vector)
  (vector 'a 'b 'c)

  (make-vector 0)
  (make-vector 0 '#(a))
  (make-vector 5 '#(a))
)

(comments "vector-length")
(prs
  (vector-length '#())
  (vector-length '#(a b c))
  (vector-length (vector 1 '(2) 3 '#(4 5)))
  (vector-length (make-vector 300))
)

(comments "vector-ref")
(prs
  (vector-ref '#(a b c) 0)
  (vector-ref '#(a b c) 1)
  (vector-ref '#(x y z w) 3)
)

(comments "vector-set!")
(prs
  (let ([v (vector 'a 'b 'c 'd 'e)])
    (vector-set! v 2 'x)
    v)
)

(comments "vector-fill!")
(prs
  (let ([v (vector 1 2 3)])
    (vector-fill! v 0)
    v)
)

(comments "from/to list conversion")
(prs
  (vector->list (vector))
  (vector->list '#(a b c))

  (let ((v '#(1 2 3 4 5)))
    (apply * (vector->list v)))

  (list->vector '())
  (list->vector '(a b c))

  (let ([v '#(1 2 3 4 5)])
    (let ([ls (vector->list v)])
      (list->vector (map * ls ls))))
)

(comments "vector-sort!")
(prs
  (vector-sort < '#(3 4 2 1 2 5))
  (vector-sort > '#(0.5 1/2))
  (vector-sort > '#(1/2 0.5))

  (let ([v (vector 3 4 2 1 2 5)])
    (vector-sort! < v)
    v)
)

(exit)