;;;; procedural interface for record types

(import (io simple)  
  ; alasing
  (rename (rnrs records procedural)
    (make-record-type-descriptor make-rtd)
    (make-record-constructor-descriptor make-rcd)
    (record-type-descriptor? rtd?))
  (rename (rnrs records syntactic)
    (record-type-descriptor rtd)
    (record-constructor-descriptor rcd)))

(comments "make-record-type-descriptor, make-record-constructor-descriptor")
(let ()
  ; rtd: record type descriptor
  (define point-rtd 
    (make-rtd 'point                          ; name
              #f                              ; parent
              #f                              ; uid
              #f                              ; sealed?
              #f                              ; opaque?
              '#((mutable x) (immutable y)))) ; fields
  ; rcd: record constructor descriptor
  (define point-rcd 
    (make-rcd point-rtd   ; rtd
              #f          ; parent-rcd
              #f))        ; protocol
  (define make-point (record-constructor point-rcd))
  (define point? (record-predicate point-rtd))
  (define point-x (record-accessor point-rtd 0))
  (define point-y (record-accessor point-rtd 1))
  (define point-x-set! (record-mutator point-rtd 0))

  (let ([p (make-point 3 4)])
    (prs p
         (point? p)
         (point-x p)
         (point-x-set! p 33)
         (point-x p))))

(comments "parent and child")
(let ()
  ; parent rtd
  (define rtd/parent
    (make-rtd 'parent #f #f #f #f '#((mutable x))))
  
  (define parent? (record-predicate rtd/parent))
  (define parent-x (record-accessor rtd/parent 0))
  (define set-parent-x! (record-mutator rtd/parent 0))

  ; child rtd
  (define rtd/child
    (make-rtd 'child rtd/parent #f #f #f '#((mutable x) (immutable y))))
  
  (define child? (record-predicate rtd/child))
  (define child-x (record-accessor rtd/child 0))
  (define set-child-x! (record-mutator rtd/child 0))
  (define child-y (record-accessor rtd/child 1))

  ; parent rcd
  (define rcd/parent
    (make-rcd rtd/parent 
              #f
              (lambda (new) (lambda (x) (new (* x x))))))

  (define make-parent (record-constructor rcd/parent))
  
  ; child rcd
  (define rcd/child
    (make-rcd rtd/child
              rcd/parent
              (lambda (pargs->new) (lambda (x y) ((pargs->new x) (+ x 5) y)))))

  (define make-child (record-constructor rcd/child))

  (prs (rtd? rtd/parent)
       (rtd? rcd/parent)
       ; Exception in record-mutator: field 1 of #<record type child> is immutable
       #;(record-mutator rtd/child 1))

  (let ([p (make-parent 10)]
        [c (make-child 10 'cc)])
    
    (prs (parent? p)
         (parent-x p)
         (set-parent-x! p 150)
         (parent-x p))
    
    (prs (parent? c)
         (child? c)
         (child? p)
         (parent-x c)
         (child-x c)
         (child-y c)

         ; Exception in child-x: #[#{parent ofnhxy19dn2n2kjilgrs8oo3a-2} 150] is not of type #<record type child>
         #;(child-x p))))