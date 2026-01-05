(import (io simple))

;;; map
; (map abs (quote (1 -2 3 -4 5 -6))) ;=> (1 2 3 4 5 6)
(pr (map abs '(1 -2 3 -4 5 -6)))

;;; for-each
; (let ((same-count 0)) (for-each (lambda (x y) (when (= x y) (set! same-count (+ same-count 1)))) (quote (1 2 3 4 5 6)) (quote (2 3 3 4 7 6))) same-count) 
; ;=> 3
(pr
  (let ([same-count 0])
    (for-each
      (lambda (x y)
        (when (= x y)
          (set! same-count (+ same-count 1))))
      '(1 2 3 4 5 6)
      '(2 3 3 4 7 6))
    same-count))

;;; exists
; (exists symbol? (quote (1.0 #\a "hi" (quote ())))) ;=> #f
(pr (exists symbol? '(1.0 #\a "hi" '())))
; (exists member (quote (a b c)) (quote ((c b) (b a) (a c)))) ;=> (b a)
(pr (exists member '(a b c) '((c b) (b a) (a c))))
; (exists (lambda (x y z) (= (+ x y) z)) (quote (1 2 3 4)) (quote (1.2 2.3 3.4 4.5)) (quote (2.2 4.3 6.4 8.5))) ;=> #t
(pr (exists (lambda (x y z) (= (+ x y) z))
             '(1 2 3 4)
             '(1.2 2.3 3.4 4.5)
             '(2.2 4.3 6.4 8.5)))

;;; for-all
; (for-all symbol? (quote (a b c d))) ;=> #t
(pr (for-all symbol? '(a b c d)))
; (for-all = (quote (1 2 3 4)) (quote (1.0 2.0 3.0 4.0))) ;=> #t
(pr (for-all = '(1 2 3 4) '(1.0 2.0 3.0 4.0)))
(for-all (lambda (x y z) (= (+ x y) z)) (quote (1 2 3 4)) (quote (1.2 2.3 3.4 4.5)) (quote (2.2 4.3 6.5 8.5))) ;=> #f
(pr (for-all (lambda (x y z) (= (+ x y) z))
             '(1 2 3 4)
             '(1.2 2.3 3.4 4.5)
             '(2.2 4.3 6.5 8.5)))

;;; fold-left
; (fold-left cons (quote ()) (quote (1 2 3 4))) ;=> ((((() . 1) . 2) . 3) . 4)
(pr (fold-left cons '() '(1 2 3 4)))
; (fold-left (lambda (a x) (+ a (* x x))) 0 (quote (1 2 3 4 5))) ;=> 55
(pr (fold-left (lambda (a x) (+ a (* x x))) 0 '(1 2 3 4 5)))
; (fold-left (lambda (a . args) (append args a)) (quote (question)) (quote (that not to)) (quote (is to be)) (quote (the be: or))) 
; ;=> (to be or not to be: that is the question)
(pr
  (fold-left
    (lambda (a . args) (append args a))
    '(question)
    '(that not to)
    '(is to be)
    '(the be: or)))

;;; fold-right
; (fold-right cons (quote ()) (quote (1 2 3 4))) ;=> (1 2 3 4)
(pr (fold-right cons '() '(1 2 3 4)))
; (fold-right (lambda (x a) (+ a (* x x))) 0 (quote (1 2 3 4 5))) ;=> 55
(pr (fold-right (lambda (x a) (+ a (* x x))) 0 '(1 2 3 4 5)))
; (fold-right (lambda (x y a) (cons* x y a)) (quote ((with apologies))) (quote (parting such sorrow go ya)) (quote (is sweet gotta see tomorrow))) 
; ;=> (parting is such sweet sorrow gotta go see ya tomorrow (with apologies))
(pr
  (fold-right
    (lambda (x y a) (cons* x y a))
    '((with apologies))
    '(parting such sorrow go ya)
    '(is sweet gotta see tomorrow)))

;;; vector-map
; (vector-map abs (quote #(1 -2 3 -4 5 -6))) ;=> #(1 2 3 4 5 6)
(pr (vector-map abs '#(1 -2 3 -4 5 -6)))
; (vector-map (lambda (x y) (* x y)) (quote #(1 2 3 4)) (quote #(8 7 6 5))) ;=> #(8 14 18 20)
(pr (vector-map (lambda (x y) (* x y)) '#(1 2 3 4) '#(8 7 6 5)))

;;; vector-for-each
; (let ((same-count 0)) (vector-for-each (lambda (x y) (when (= x y) (set! same-count (+ same-count 1)))) (quote #(1 2 3 4 5 6)) (quote #(2 3 3 4 7 6))) same-count) 
; ;=> 3
(pr
  (let ([same-count 0])
    (vector-for-each
      (lambda (x y)
        (when (= x y)
          (set! same-count (+ same-count 1))))
      '#(1 2 3 4 5 6)
      '#(2 3 3 4 7 6))
    same-count))

;;; string-for-each

; (let ((ls (quote ()))) (string-for-each (lambda r (set! ls (cons r ls))) "abcd" "====" "1234") (map list->string (reverse ls))) 
; ;=> ("a=1" "b=2" "c=3" "d=4")
(pr
  (let ([ls '()])
    (string-for-each
      (lambda r (set! ls (cons r ls)))
      "abcd" "====" "1234")
    (map list->string (reverse ls))))


(exit)