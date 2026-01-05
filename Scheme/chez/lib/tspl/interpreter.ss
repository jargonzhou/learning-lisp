(library (tspl interpreter)
  (export interpret)
  (import (rnrs) (rnrs mutable-pairs))
  
  ;;; Environment wiht primitive procedures. 
  (define primitive-environment
    `((apply . ,apply)
      (assq . ,assq)
      (call/cc . ,call/cc)
      (car . ,car)
      (cadr . ,cadr)
      (caddr . ,caddr)
      (cadddr . ,cadddr)
      (cddr . ,cddr)
      (cdr . ,cdr)
      (cons . ,cons)
      (eq? . ,eq?)
      (list . ,list)
      (map . ,map)
      (memv . ,memv)
      (null? . ,null?)
      (pair? . ,pair?)
      (read . ,read)
      (set-car! . ,set-car!)
      (set-cdr! . ,set-cdr!)
      (symbol? . ,symbol?)))

  ;;; Construct a new environment from 
  ;;; a formal parameter specification, 
  ;;; a list of actual parameters, and
  ;;; an outer environment.
  (define (new-env formals actuals env)
    (cond
      [(null? formals) env]
      [(symbol? formals) (cons (cons formals actuals) env)]
      [else
        (cons
          (cons (car formals) (car actuals))
          (new-env (cdr formals) (cdr actuals) env))]))

  (define (lookup var env)
    (cdr (assq var env)))

  (define (assign var val env)
    (set-cdr! (assq var env) val))

  ; Evaluate expression, recognizing a small set of core forms.
  (define (exec expr env)
    (cond
      [(symbol? expr) (lookup expr env)]                ; 1. symbol
      [(pair? expr)                                     ; 2. pair
       (case (car expr)
        [(quote) (cadr expr)]                           ; 2.1 quote
        [(lambda)                                       ; 2.2 lambda
         (lambda vals
           (let [(env (new-env (cadr expr) vals env))]
             (let loop ([exprs (cddr expr)])
               (if (null? (cdr exprs))
                 (exec (car exprs) env)
                 (begin
                   (exec (car exprs) env)
                   (loop (cdr exprs)))))))]
        [(if)                                           ; 2.3 if
         (if (exec (cadr expr) env)
           (exec (caddr expr) env)
           (exec (cadddr expr) env))]
        [(set!)                                         ; 2.4 set!
         (assign (cadr expr) (exec (caddr expr) env) env)]
        [else                                           ; 2.5 others
         (apply
           (exec (car expr) env)
           (map (lambda (x) (exec x env)) (cdr expr)))])]
      [else expr]))                                      ; 3. others

  (define (interpret expr)
    (exec expr primitive-environment))
)