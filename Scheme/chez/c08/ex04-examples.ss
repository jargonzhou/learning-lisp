(import (io simple))

(comments "rec")
; permits internally recursive anonymous procedures to be created with minimal effor
(define-syntax rec
  (syntax-rules ()
    [(_ x e)
     (letrec ([x e]) x)]))

(let ([ls '(0 1 2 3 4 5)])
  (prs
    (map
      (rec
        sum
        (lambda (x)
          (if (= x 0)
            0
            (+ x (sum (- x 1))))))
      ls)))

(comments "sequence")
(define-syntax sequence
  (syntax-rules ()
    [(_ e0 e1 ...)
     (begin e0 e1 ...)]))

(sequence
  (display "Say what?")
  (newline))

(comments "method")
; a method expression is similar to a lambda expression, 
; except that in addition to the formal paramenters and body, 
; a method expresison also contains a list of instance variables (ivar ...)
(define-syntax method
  (lambda (x)
    (syntax-case x ()
      [(k (ivar ...) formals b1 b2 ...)
       (with-syntax ([(index ...)
                      (let f ([i 0] [ls #'(ivar ...)])
                        (if (null? ls)
                            '()
                            (cons i (f (+ i 1) (cdr ls)))))]
                     [self (datum->syntax #'k 'self)])
         #'(lambda (self . formals)
             (let-syntax ([ivar (identifier-syntax
                                  [_ (vector-ref self index)]
                                  [(set! _ e)
                                   (vector-set! self index e)])]
                          ...)
               b1 b2 ...)))])))

(let ([m (method (a) (x) (list a x self))])
  (prs
    (m (vector 1) 2)))

(let ([m (method (a) (x)
           (set! a x)
           (set! x (+ a x))
           (list a x self))])
  (prs
    (m (vector 1) 2)))

(comments "def-structure")
(define-syntax define-structure
  (lambda (x)
    (define gen-id
      (lambda (template-id . args)
        (datum->syntax template-id
          (string->symbol
            (apply string-append
              (map (lambda (x)
                     (if (string? x)
                         x
                         (symbol->string (syntax->datum x))))
                   args))))))
    (syntax-case x ()
      [(_ name field ...)
       (with-syntax ([constructor (gen-id #'name "make-" #'name)]
                     [predicate (gen-id #'name #'name "?")]
                     [(access ...)
                      (map (lambda (x) (gen-id x #'name "-" x))
                           #'(field ...))]
                     [(assign ...)
                      (map (lambda (x)
                             (gen-id x "set-" #'name "-" x "!"))
                           #'(field ...))]
                     [structure-length (+ (length #'(field ...)) 1)]
                     [(index ...)
                      (let f ([i 1] [ids #'(field ...)])
                        (if (null? ids)
                            '()
                            (cons i (f (+ i 1) (cdr ids)))))])
         #'(begin
             (define constructor
               (lambda (field ...)
                 (vector 'name field ...)))
             (define predicate
               (lambda (x)
                 (and (vector? x)
                      (= (vector-length x) structure-length)
                      (eq? (vector-ref x 0) 'name))))
             (define access
               (lambda (x)
                 (vector-ref x index)))
             ...
             (define assign
               (lambda (x update)
                 (vector-set! x index update)))
             ...))])))

(let ()
  (define-structure tree left right)
  (define t
    (make-tree
      (make-tree 0 1)
      (make-tree 2 3)))
      
  (prs
    t
    (tree? t)
    (tree-left t)
    (tree-right t)
    (set-tree-left! t 0)
    t))

(exit)