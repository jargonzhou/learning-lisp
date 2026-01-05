(import (tspl interpreter)
        (io simple))

(prs
  (interpret 3)

  (interpret '(cons 3 4))

  (interpret
    '((lambda (x . y) (list x y))
      'a 'b 'c 'd))

  (interpret
    '(((call/cc (lambda (k) k))
       (lambda (x) x))
       "HEY!"))
  
  (interpret
    '((lambda (memq)
        (memq memq 'a '(b c a d e)))
      (lambda (memq x ls)
        (if (null? ls)
          #f
          (if (eq? (car ls) x)
            ls
            (memq memq x (cdr ls)))))))

  (interpret
    '((lambda (reverse)
        (set! reverse
          (lambda (ls new)
            (if (null? ls)
              new
              (reverse (cdr ls) (cons (car ls) new)))))
        (reverse '(a b c d e) '()))
      #f))
)

(exit)