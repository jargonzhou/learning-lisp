(import (io simple))

(comments "cons, car, cdr, set-car!, set-cdr!, caar ...")
(prs 
  (cons 'a '()) 
  (cons 'a '(b c)) 
  (cons 3 4) 

  (car '(a)) 
  (car '(a b c)) 
  (car (cons 3 4)) 

  (cdr '(a)) 
  (cdr '(a b c)) 
  (cdr (cons 3 4)) 

  (let ([x (list 'a 'b 'c)])
    (set-car! x 1)
    x) 

  (let ([x (list 'a 'b 'c)])
    (set-cdr! x 1)
    x) 

  (caar '((a))) 
  (cadr '(a b c)) 
  (cdddr '(a b c d)) 
  (cadadr '(a (b c))) 
)

(comments "list, cons*")
(prs
  (list) 
  (list 1 2 3) 
  (list 3 2 1) 

  (cons* '()) 
  (cons* '(a b)) 
  (cons* 'a 'b 'c) 
  (cons* 'a 'b '(c d)) 
)

(comments "list?")
(prs
  (list? '()) 
  (list? '(a b c)) 
  (list? 'a) 
  (list? '(3 . 4)) 
  (list? 3) 
  (let ([x (list 'a 'b 'c)])
    (set-cdr! (cddr x) x)
    (list? x)) 
)

(comments "length")
(prs
  (length '()) 
  (length '(a b c)) 
  ; (length '(a b . c))         ; (a b . c) is not a proper list
  ; (length
  ;   (let ([ls (list 'a 'b)])
  ;     (set-cdr! (cdr ls) ls) 
  ;     ls))                    ; (a b a b a b ...) is circular
  (length
    (let ([ls (list 'a 'b)])
      (set-car! (cdr ls) ls) 
      ls))
)

(comments "list-ref, list-tail")
(prs
  (list-ref '(a b c) 0) 
  (list-ref '(a b c) 1) 
  (list-ref '(a b c) 2) 
  (list-tail '(a b c) 0) 
  (list-tail '(a b c) 2) 
  (list-tail '(a b c) 3) 
  (list-tail '(a b c . d) 2) 
  (list-tail '(a b c . d) 3) 
  (let ([x (list 1 2 3)])
    (eq? (list-tail x 2)
        (cddr x))) 
)

(comments "append")
(prs
  (append '(a b c) '()) 
  (append '() '(a b c)) 
  (append '(a b) '(c d)) 
  (append '(a b) 'c) 
  (let ([x (list 'b)])
    (eq? x (cdr (append '(a) x)))) 
)

(comments "reverse")
(prs
  (reverse '()) 
  (reverse '(a b c)) 
)

(comments "memq, memv, member")
(prs
  (memq 'a '(b c a d e)) 
  (memq 'a '(b c d e g)) 
  (memq 'a '(b a c a d a)) 

  (memv 3.4 '(1.2 2.3 3.4 4.5)) 
  (memv 3.4 '(1.3 2.5 3.7 4.9)) 
  (let ([ls (list 'a 'b 'c)])
    (set-car! (memv 'b ls) 'z)
    ls) 

  (member '(b) '((a) (b) (c))) 
  (member '(d) '((a) (b) (c))) 
  (member "b" '("a" "b" "c")) 
)

(comments "memp")
(prs
  (memp odd? '(1 2 3 4)) 
  (memp even? '(1 2 3 4)) 
  (let ([ls (list 1 2 3 4)])
    (eq? (memp odd? ls) ls)) 
  (let ([ls (list 1 2 3 4)])
    (eq? (memp even? ls) (cdr ls))) 
  (memp odd? '(2 4 6 8)) 
)

(comments "remq, remv, remove")
(prs
  (remq 'a '(a b a c a d)) 
  (remq 'a '(b c d)) 

  (remv 1/2 '(1.2 1/2 0.5 3/2 4)) 

  (remove '(b) '((a) (b) (c))) 
)

(comments "remp")
(prs
  (remp odd? '(1 2 3 4)) 
  (remp
    (lambda (x) (and (> x 0) (< x 10)))
    '(-5 15 3 14 -20 6 0 -9)) 
)

(comments "filter")
(prs
  (filter odd? '(1 2 3 4)) 
  (filter
    (lambda (x) (and (> x 0) (< x 10)))
    '(-5 15 3 14 -20 6 0 -9)) 
)

(comments "partition")
(prs
  (let-values ([(l1 l2) (partition odd? '(1 2 3 4))])
    (list l1 l2))
  (let-values ([(l1 l2) (partition 
                          (lambda (x) (and (> x 0) (< x 10)))
                          '(-5 15 3 14 -20 6 0 -9))])
    (list l1 l2))
)

(comments "find")
(prs
  (find odd? '(1 2 3 4)) 
  (find even? '(1 2 3 4)) 
  (find odd? '(2 4 6 8)) 
  (find not '(1 a #f 55)) 
)

(comments "assq, assv, assoc")
(prs
  (assq 'b '((a . 1) (b . 2))) 
  (cdr (assq 'b '((a . 1) (b . 2)))) 
  (assq 'c '((a . 1) (b . 2))) 

  (assv 2/3 '((1/3 . 1) (2/3 . 2))) 
  (assv 2/3 '((1/3 . a) (3/4 . b))) 

  (assoc '(a) '(((a) . a) (-1 . b))) 
  (assoc '(a) '(((b) . b) (a . c))) 

  (let ([alist (list (cons 2 'a) (cons 3 'b))])
    (set-cdr! (assv 3 alist) 'c)
    alist) 
)

(comments "assp")
(prs
  (assp odd? '((1 . a) (2 . b))) 
  (assp even? '((1 . a) (2 . b))) 
  (let ([ls (list (cons 1 'a) (cons 2 'b))])
    (eq? (assp odd? ls) (car ls))) 
  (let ([ls (list (cons 1 'a) (cons 2 'b))])
    (eq? (assp even? ls) (cadr ls))) 
  (assp odd? '((2 . b))) 
)

(comments "list-sort")
(prs 
  (list-sort < '(3 4 1 2 5))
  (list-sort > '(0.5 1/2))
  (list-sort > '(1/2 0.5))
  (list->string
    (list-sort char>? (string->list "hello")))
)

(exit)