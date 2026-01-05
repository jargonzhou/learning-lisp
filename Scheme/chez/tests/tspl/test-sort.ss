(import (tspl sort)
        (io simple)
        (rnrs))

(prs
  (sort < '(3 4 2 1 2 5))
  (sort > '(0.5 1/2))
  (sort > '(1/2 0.5))
  (list->string (sort char>? (string->list "coins"))))

(prs 
  (merge char<?
    '(#\a #\c)
    '(#\b #\c #\d))
  (merge <
    '(1/2 2/3 3/4)
    '(0.5 0.6 0.7))
  (list->string (merge char>? (string->list "old") (string->list "toe"))))

(exit)