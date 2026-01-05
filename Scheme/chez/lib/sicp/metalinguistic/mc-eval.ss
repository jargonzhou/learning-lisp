;;; A metacircular evaluator.

(library (sicp metalinguistic mc-eval)
  (export driver-loop)
  (import (rnrs io simple) ; read, newline, display
    (only (rnrs mutable-pairs) set-car! set-cdr!)
    (only (rnrs programs) exit)
    (rename 
      (only (rnrs base) 
        define apply cond if else error quote let lambda
        cons list
        car cdr cadr caddr caadr cdadr cddr cdddr cadddr
        number? string? symbol? pair? eq? not null? 
        = <
        length map)
      (apply apply-in-underlying-scheme))  ; apply
  )

  (define false #f)
  (define true #t)

  ;;; =========================================================================
  ;;; eval
  ;;; =========================================================================

  ;;; evaluta expression in environment.
  (define (eval exp env)
    (cond
      [(self-evaluating? exp) exp]
      [(variable? exp) (lookup-variable-value exp env)]
      [(quoted? exp) (text-of-quotation exp)]
      [(assignment? exp) (eval-assignment exp env)]
      [(definition? exp) (eval-definition exp env)]
      [(if? exp) (eval-if exp env)]
      [(lambda? exp) (make-procedure (lambda-parameters exp) (lambda-body exp) env)]
      [(begin? exp) (eval-sequence (begin-actions exp) env)]
      [(cond? exp) (eval (cond->if exp) env)]
      [(application? exp) (apply (eval (operator exp) env) (list-of-values (operands exp) env))]
      [else (error "Unknown expression type -- EVAL" exp)]))

  ;;; evaluate each operand in combination expression in environment, 
  ;;; return the list of evaluation result.
  (define (list-of-values exps env)
    (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

  ;;; evaluate if expression in environment.
  (define (eval-if exp env)
    (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

  ;;; evaluate assignment to variables.
  (define (eval-assignment exp env)
    (set-variable-value! 
      (assignment-variable exp)
      (eval (assignment-value exp) env)
      env)
    'ok)
  
  ;;; evaluate definition to variable.
  (define (eval-definition exp env)
    (define-variable!
      (definition-variable exp)
      (eval (definition-value exp) env)
      env)
    'ok)

  ;;; =========================================================================
  ;;; representation of expressions
  ;;; =========================================================================

  ;;; self evaluating expression: number, string.
  (define (self-evaluating? exp)
    (cond
      [(number? exp) true]
      [(string? exp) true]
      [else false]))

  ;;; variable: symbol.
  (define (variable? exp) (symbol? exp))

  ;;; Determine whether expression represented as a tagged list.
  (define (tagged-list? exp tag)
    (if (pair? exp)
      (eq? (car exp) tag)
      #f))

  ;;; quotation: '.
  (define (quoted? exp)
    (tagged-list? exp 'quote))

  (define (text-of-quotation exp) (cadr exp))

  ;;; assignment expression.
  (define (assignment? exp)
    (tagged-list? exp 'set))

  (define (assignment-variable exp) (cadr exp))

  (define (assignment-value exp) (caddr exp))

  ;;; definition:
  ;;; (define <var> <value>)
  ;;; (define (<var> <parameter1> ... <parametern>) <body>)
  (define (definition? exp)
    (tagged-list? exp 'define))

  (define (definition-variable exp)
    (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

  (define (definition-value exp)
    (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)    ; formal parameters
                   (cddr exp))))  ; body

  ;;; lambda expression.
  (define (lambda? exp) (tagged-list? exp 'lambda))

  (define (lambda-parameters exp) (cadr exp))

  (define (lambda-body exp) (cddr exp))

  (define (make-lambda parameters body)
    (cons 'lambda (cons parameters body)))
  
  ;;; if expression.
  (define (if? exp) (tagged-list? exp 'if))

  (define (if-predicate exp) (cadr exp))

  (define (if-consequent exp) (caddr exp))

  (define (if-alternative exp)
    (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

  (define (make-if predicate consequent alternative)
    (list 'if predicate consequent alternative))

  ;;; begin expression sequences.
  (define (begin? exp) (tagged-list? exp 'begin))

  (define (begin-actions exp) (cdr exp))

  (define (last-exp? seq) (null? (cdr seq)))

  (define (first-exp seq) (car seq))

  (define (rest-exps seq) (cdr seq))

  ;;; sequence to expression.
  (define (sequence->exp seq)
    (cond
      [(null? seq) seq]
      [(last-exp? seq) (first-exp seq)]
      [else (make-begin seq)]))
  
  (define (make-begin seq) (cons 'begin seq))

  ;;; procedure application.
  (define (application? exp) (pair? exp))

  (define (operator exp) (car exp))

  (define (operands exp) (cdr exp))

  (define (no-operands? ops) (null? ops))

  (define (first-operand ops) (car ops))

  (define (rest-operands ops) (cdr ops))

  ;;; derived expressions.
  ;;; example: cond <- if
  (define (cond? exp) (tagged-list? exp 'cond))

  (define (cond-clauses exp) (cdr exp))

  (define (cond-else-clause? clause)
    (eq? (cond-predicate clause) 'else))

  (define (cond-predicate clause) (car clause))

  (define (cond-actions clause) (cdr clause))

  ;;; cond expression to if expression.
  (define (cond->if exp)
    (define (expand-clauses clauses)
      (if (null? clauses)
        'false
        (let ([first (car clauses)]
              [rest (cdr clauses)])
          (if (cond-else-clause? first)
            (if (null? rest)
              (sequence->exp (cond-actions first))
              (error "ELSE clause isn't last -- COND->IF" clauses))
            (make-if 
              (cond-predicate first)
              (sequence->exp (cond-actions first))
              (expand-clauses rest))))))
    (expand-clauses (cond-clauses exp)))

  ;;; =========================================================================
  ;;; apply
  ;;; =========================================================================

  ;;; apply procedure to arguments.
  (define (apply procedure arguments)
    (cond
      [(primitive-procedure? procedure)
       (apply-primitive-procedure procedure arguments)]
      [(compound-procedure? procedure)
       (eval-sequence
        (procedure-body procedure)
        (extend-environment 
          (procedure-parameters procedure)
          arguments
          (procedure-environment procedure)))]
      [else (error "Unknown procedure type -- APPLY" procedure)]))

  ;;; evaluate sequences of expressions.
  (define (eval-sequence exps env)
    (cond
      [(last-exp? exps) (eval (first-exp exps) env)]
      [else (eval-sequence (rest-exps exps) env)]))

  ;;; =========================================================================
  ;;; internal data structures:
  ;;; predicate
  ;;; procedure
  ;;; environment
  ;;; =========================================================================

  ;;; predicate.
  (define (true? x) (not (eq? x false)))

  (define (false? x) (eq? x false))

  ;;; representation of procedures.
  (define (make-procedure parameters body env)
    (list 'procedure parameters body env))

  (define (compound-procedure? p) (tagged-list? p 'procedure))

  (define (procedure-parameters p) (cadr p))

  (define (procedure-body p) (caddr p))

  (define (procedure-environment p) (cadddr p))

  (define (primitive-procedure? proc)
    (tagged-list? proc 'primitive))

  (define (apply-primitive-procedure proc args)
    (apply-in-underlying-scheme
      (primitive-implementation proc)
      args))
  
  (define (primitive-implementation proc) (cadr proc))

  ;;; operations on environment.
  ;;; environment: a list of frame
  ;;; frame: pair of list of variables and list of binding values
  (define (enclosing-environment env) (cdr env))

  (define (first-frame env) (car env))

  ;;; empty environment.
  (define the-empty-environment '())

  ;;; create a frame with (vars vals).
  (define (make-frame variables values)
    (cons variables values))

  (define (frame-variables frame) (car frame))

  (define (frame-values frame) (cdr frame))

  (define (add-binding-to-frame! var val frame)
    (set-car! frame (cons var (car frame)))
    (set-cdr! frame (cons val (cdr frame))))

  ;;; create a new frame with (vars vals) to extend base environment.
  (define (extend-environment vars vals base-env)
    (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
        (error "Too many arguments supplied" vars vals)
        (error "Too few arguments supploed" vars vals))))

  ;;; get value of variable in environment.
  (define (lookup-variable-value var env)
    (define (env-loop env)      ; find in env
      (define (scan vars vals)  ; find in frame
        (cond
          [(null? vars) (env-loop (enclosing-environment env))] ; try enclosing env
          [(eq? var (car vars)) (car vals)]                     ; found
          [else (scan (cdr vars) (cdr vals))]))                 ; try next
      (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ([frame (first-frame env)])
          (scan (frame-variables frame) (frame-values frame)))))
    (env-loop env))
  
  ;;; set value of variable in environment.
  (define (set-variable-value! var val env)
    (define (env-loop env)
      (define (scan vars vals)
        (cond
          [(null? vars) (env-loop (enclosing-environment env))]
          [(eq? var (car vars)) (set-car! vals val)]
          [else (scan (cdr vars) (cdr vals))]))
      (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ([frame (first-frame env)])
          (scan (frame-variables frame) (frame-values frame)))))
    (env-loop env))

  ;;; defeine a binding (variable value) in environment. 
  (define (define-variable! var val env)
    (let ([frame (first-frame env)])
      (define (scan vars vals)
        (cond
          [(null? vars) (add-binding-to-frame! var val frame)]
          [(eq? var (car vars)) (set-car! vals val)]
          [else (scan (cdr vars) (cdr vals))]))
      (scan (frame-variables frame) (frame-values frame))))

  ;;; =========================================================================
  ;;; Driver
  ;;; =========================================================================

  (define primitive-procedures
    (list (list 'car car)
          (list 'cdr cdr)
          (list 'cons cons)
          (list 'null? null?)
          (list 'exit exit)
          ; others
          ))

  (define (primitive-procedure-names)
    (map car primitive-procedures))

  (define (primitive-procedure-objects)
    (map (lambda (proc) (list 'primitive (cadr proc)))
      primitive-procedures))

  (define (setup-environment)
  (let ([initial-env 
         (extend-environment (primitive-procedure-names)
                             (primitive-procedure-objects)
                             the-empty-environment)])
      (define-variable! 'true true initial-env)
      (define-variable! 'false false initial-env)
      initial-env))

  ;;; the global environment
  (define the-global-environment (setup-environment))

  (define input-promt "> M-Eval input:")
  (define output-promt "> M-Eval value:")

  ;;; REPL
  (define (driver-loop)
    (promt-for-input input-promt)
    (let ([input (read)])
      (let ([output (eval input the-global-environment)])
        (announce-output output-promt)
        (user-print output)))
    (driver-loop))

  (define (promt-for-input string)
    (newline) (newline) (display string) (newline))

  (define (announce-output string)
    (newline) (display string) (newline))

  (define (user-print object)
    (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>)))
    (display object))

)