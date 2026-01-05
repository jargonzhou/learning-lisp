(import (tspl unification)
        (io simple))

(prs
  (unify 'x 'y)
  (unify '(f x y) '(g x y)) 
  (unify '(f x (h)) '(f (h) y))
  (unify '(f (g x) y) '(f y x))
  (unify '(f (g x) y) '(f y (g x)))
  (unify '(f (g x) y) '(f y z)))

(exit)