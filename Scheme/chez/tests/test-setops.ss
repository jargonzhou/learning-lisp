;;; A demonstration of top-level program to use library (list-tools) and (more-setops).

(import (list-tools setops) (more-setops) (io simple) (rnrs))

(define get-set1
  (lambda ()
    (quoted-set a b c d)))
(define set1 (get-set1))          ; a,b,c,d
(define set2 (quoted-set a c e))  ; a,c,e

(pr (list set1 set2))
(pr (eq? (get-set1) (get-set1)))
(pr (eq? (get-set1) (set 'a 'b 'c 'd)))
(pr (union set1 set2))
(pr (intersection set1 set2))
(pr (difference set1 set2))
(pr (set-cons 'a set2))
(pr (set-cons 'b set2))
(pr (set-remove 'a set2))

(exit)