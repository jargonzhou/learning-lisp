(library (tspl unification)
  (export unify)
  (import (rnrs))

  ;;; Return true if and only if u occurs in v.
  (define (occurs? u v)
    (and (pair? v)
      (let f ([l (cdr v)])
        (and (pair? l)
          (or (eq? u (car l))
            (occurs? u (car l))
            (f (cdr l)))))))

  ;;; Return a new substitution procedure extending s 
  ;;; by the substitution of u with v.
  (define (sigma u v s)
    (lambda (x)
      (let f ([x (s x)])
        (if (symbol? x)
          (if (eq? x u) v x)
          (cons (car x) (map f (cdr x)))))))

  ;;; Try to substitue u for v.
  ;;; may require a full unification if (s u) is not a variable,
  ;;; may fail if it sees that u occurs in v.
  (define (try-subst u v s ks kf)
    (let ([u (s u)])
      (if (not (symbol? u))
        (uni u v s ks kf)
        (let ([v (s v)])
          (cond
            [(eq? u v) (ks s)]
            [(occurs? u v) (kf "cycle")]
            [else (ks (sigma u v s))])))))

  ;;; Attempt to unify u and v with a continuation-passing style that
  ;;; return a substitution to the success argument ks,
  ;;; or an error message to the failure argument kf.
  ;;; The substitution itself is represented by a procedure from variables to terms.
  (define (uni u v s ks kf)
    (cond
      [(symbol? u) (try-subst u v s ks kf)]
      [(symbol? v) (try-subst v u s ks kf)]
      [(and (eq? (car u) (car v))
         (= (length u) (length v)))
       (let f ([u (cdr u)] [v (cdr v)] [s s])
         (if (null? u)
          (ks s)
          (uni (car u) (car v) s (lambda (s) (f (cdr u) (cdr v) s)) kf)))]
      [else (kf "clash")]))

  (define (unify u v)
    (uni
      u
      v
      (lambda (x) x)
      (lambda (s) (s u))
      (lambda (msg) msg)))

)