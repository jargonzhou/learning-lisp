(import (io simple))

(comments "boolean=?")
(prs
  (boolean=? #t #t)
  (boolean=? #t #f)
  (boolean=? #t (< 3 4))
)


(exit)