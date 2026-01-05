(import (io simple))

(comments "syntax-case")

(comments "syntax")

(define-syntax _or
  (lambda (x)
    (syntax-case x ()
      [(_) #'#f]
      [(_ e) #'e]
      [(_ e1 e2 e3 ...)
       #'(let ([t e1]) (if t t (_or e2 e3 ...)))])))

(prs
  (_or)
  (_or 'a)
  (_or 'a 'b))

(comments "identifier?")
(define-syntax _let
  (lambda (x)
    (define (ids? ls)
      (or (null? ls)
        (and (identifier? (car ls))
          (ids? (cdr ls)))))
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (ids? #'(i ...))          ; fender
       #'((lambda (i ...) b1 b2 ...) e ...)])))

(_let ([p (cons 0 #f)])
  (define-syntax pcar
    (lambda (x)
      (syntax-case x ()
        [_ (identifier? x) #'(car p)]
        [(_ e) #'(set-car! p e)])))
  (_let ([a pcar])
    (pcar 1)
    (prs
      (list a pcar))))

(comments "free-identifier=?, bound-identifier=?")
(define-syntax _cond
  (lambda (x)
    (syntax-case x ()
      [(_ (e0 e1 e2 ...))
       (and (identifier? #'e0) (free-identifier=? #'e0 #'else))
       #'(begin e1 e2 ...)]
      [(_ (e0 e1 e2 ...)) #'(if e0 (begin e1 e2 ...))]
      [(_ (e0 e1 e2 ...) c1 c2 ...)
       #'(if e0 (begin e1 e2 ...) (_cond c1 c2 ...))])))

(let ([else #f])
  (prs
    (_cond [else (write "oops")])))

(define-syntax _let
  (lambda (x)
    (define (ids? ls)
      (or (null? ls)
        (and (identifier? (car ls))
          (ids? (cdr ls)))))
    (define (unique-ids? ls)
      (or (null? ls)
        (and (not (memp
                    (lambda (x) (bound-identifier=? x (car ls)))
                    (cdr ls)))
          (unique-ids? (cdr ls)))))
    (prs x)
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (and (ids? #'(i ...)) (unique-ids? #'(i ...)))
       #'((lambda (i ...) b1 b2 ...) e ...)]
      [(_ ((i e) ...) b1 b2 ...)
       (not (and (ids? #'(i ...)) (unique-ids? #'(i ...))))
       #'(error '_let "duplicate identifier" (syntax->datum #'(i ...)))])))

(_let ([a 3] [b 4])
  (prs (+ a b)))

; Exception in _let: duplicate identifier with irritant (a a)
; (_let ([a 3] [a 4])
  ; (prs (+ a a)))

(_let ([a 0])
  (let-syntax ([dolet (lambda (x)
                        (syntax-case x ()
                          [(_ b)
                           #'(let ([a 3] [b 4]) (+ a b))]))])
    (prs
      (dolet a)
      (dolet b)
      (dolet c))))

(comments "with-syntax")
(define-syntax _cond
  (lambda (x)
    (syntax-case x ()
      [(_ c1 c2 ...)
        (let f ([c1 #'c1]
                [cmore #'(c2 ...)])
          (if (null? cmore)
            (syntax-case c1 (else =>)
              [(else e1 e2 ...)
               #'(begin e1 e2 ...)]
              [(e0)
               #'(let ([t e0]) (if t t))]
              [(e0 => e1)
               #'(let ([t e0]) (if t (e1 t)))]
              [(e0 e1 e2 ...)
               #'(if e0 (begin e1 e2 ...))])
            (with-syntax ([rest (f (car cmore) (cdr cmore))])
              (syntax-case c1 (=>)
                [(e0)
                  #'(let ([t e0]) (if t t rest))]
                [(e0 => e1)
                 #'(let ([t e0]) (if t (e1 t) rest))]
                [(e0 e1 e2 ...)
                 #'(if e0 (begin e1 e2 ...) rest)]))))])))

(comments "quasisyntax")
(define-syntax _case
  (lambda (x)
    (syntax-case x ()
      [(_ e c1 c2 ...)
       #`(let ([t e])
           #,(let f ([c1 #'c1]
                     [cmore #'(c2 ...)])
               (if (null? cmore)
                (syntax-case c1 (else)
                  [(else e1 e2 ...)
                   #'(beign e1 e2 ...)]
                  [((k ...) e1 e2 ...)
                   #'(if (memv t '(k ...)) (begin e1 e2 ...))])
                (syntax-case c1 ()
                  [((k ...) e1 e2 ...)
                   #'(if (memv t '(k ...))
                       (begin e1 e2 ...)
                       #,(f (car cmore) (cdr cmore)))]))))])))

(comments "make-variable-transformer")

(_let ([ls (list 0)])
  (define-syntax a
    (make-variable-transformer
      (lambda (x)
        (syntax-case x ()
          [id (identifier? #'id) #'(car ls)]
          [(set! _ e) #'(set-car! ls e)]
          [(_ e ...) #'((car ls) e ...)]))))
  (_let ([before a])
    (set! a 1)
    (prs
      (list before a ls))))

(comments "syntax->datum")
(define (symbolic-identifier=? x y)
  (eq? (syntax->datum x)
    (syntax->datum y)))
(prs
  (symbolic-identifier=? #'x #'y)
  (symbolic-identifier=? #'x #'x))

(comments "datum->syntax")
(define-syntax loop
  (lambda (x)
    (syntax-case x ()
      [(k e ...)
       (with-syntax ([break (datum->syntax #'k 'break)])
        #'(call/cc
            (lambda (break)
              (let f () e ... (f)))))])))

(_let ([n 3] [ls '()])
  (prs 
    (loop
      (if (= n 0) (break ls))
      (set! ls (cons 'a ls))
      (set! n (- n 1)))))

(define-syntax include
  (lambda (x)
    (define (read-file fn k)
      (let ([p (open-input-file fn)])
        (let f ([x (read p)])
          (if (eof-object? x)
            (begin (close-port p) '())
            (cons (datum->syntax k x) (f (read p)))))))
    (syntax-case x ()
      [(k filename)
       (let ([fn (syntax->datum #'filename)])
         (with-syntax ([(expr ...) (read-file fn #'k)])
           #'(begin expr ...)))])))

(let ([x "okay"])
  (include "codes/scheme/chez/c08/f-def.ss")
  (prs (f)))

(comments "generate-temporaries")

(define-syntax _letrec
  (lambda (x)
    (syntax-case x ()
      [(_ ((i e) ...) b1 b2 ...)
       (with-syntax ([(t ...) (generate-temporaries #'(i ...))])
        #'(let ([i #f] ...)
            (let ([t e] ...)
              (set! i t)
              ...
              (let () b1 b2 ...))))])))

(prs
  (_letrec ([sum (lambda (x) (if (zero? x) 0 (+ x (sum (- x 1)))))]) 
    (sum 5)))

(exit)