(import (tspl sets)
        (io simple)
        (rnrs))

(prs
  (set-of x 
    (x in '(a b c)))
  
  (set-of x 
    (x in '(1 2 3 4)) 
    (even? x))
  
  (set-of (cons x y) 
    (x in '(1 2 3))
    (y is (* x x)))

  (set-of (cons x y)
    (x in '(a b))
    (y in '(1 2)))
)

(exit)