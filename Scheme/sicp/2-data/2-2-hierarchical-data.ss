(import 
  (io simple)
  (sicp))

(prs
  (cons (cons 1 2)
    (cons 3 4))
    
  (cons (cons 1 (cons 2 3))
    4))

(comments "sequences")
(let ([one-through-four (list 1 2 3 4)])
  (prs
    one-through-four
    (car one-through-four)
    (cdr one-through-four)
    (car (cdr one-through-four))
    (cons 5 one-through-four)))

; list operations
(define (_list-ref items n)
  (if (= n 0)
    (car items)
    (_list-ref (cdr items) (- n 1))))

(define (_length items)
  (if (null? items)
    0
    (+ 1 (_length (cdr items)))))

(define (_append list1 list2)
  (if (null? list1)
    list2
    (cons (car list1) (_append (cdr list1) list2))))

(let ([squares (list 1 4 9 16 25)]
      [odds (list 1 3 5 7)])
  
  (prs
    (_list-ref squares 3)
    (_length odds)
    (_append squares odds)))

; mapping over lists
(define (_map proc items)
  (if (null? items)
    nil
    (cons (proc (car items))
      (_map proc (cdr items)))))

(prs
  (_map abs nil)
  (_map abs '())
  (_map abs (list -10 2.5 -11.6 17))
  (_map (lambda (x) (* x x)) (list 1 2 3 4)))

(comments "hierarchical structures")

(define (count-leaves x)
  (cond
    [(null? x) 0]
    [(not (pair? x)) 1]
    [else (+ (count-leaves (car x))
            (count-leaves (cdr x)))]))
(let* ([x (cons (list 1 2) (list 3 4))]
       [xx (list x x)])

  (prs
    x
    (_length x)
    (count-leaves x)
    
    xx
    (_length xx)
    (count-leaves xx)))

; mapping over trees
(define (scale-tree tree factor)
  (_map (lambda (sub-tree)
          (if (pair? sub-tree)
            (scale-tree sub-tree factor)
            (* sub-tree factor)))
    tree))
(prs
  (scale-tree
    (list 1 (list 2 (list 3 4) 5) (list 6 7))
    10))

(comments "sequence as conventional interfaces")
; TODO

(exit)