(import (io simple))

(comments "condition?")
(prs
  (condition? 'stable)
  (condition? (make-error))
  (condition? (make-message-condition "oops"))
  (condition?
    (condition
      (make-error)
      (make-message-condition "no such element"))))

(comments "condition")
(prs
  (condition)
  (condition
    (make-error)
    (make-message-condition "oops")))
(let ()
  (define-record-type (&xcond make-xcond xcond?) (parent &condition))
  (prs
    (xcond? (make-xcond))
    (xcond? (condition (make-xcond)))
    (xcond? (condition))
    (xcond? (condition (make-error) (make-xcond)))))

(comments "simple conditions")
(prs
  (simple-conditions (condition))
  (simple-conditions (make-error))
  (simple-conditions (condition (make-error)))
  (simple-conditions
    (condition
      (make-error)
      (make-message-condition "oops"))))

(let ([c1 (make-error)]
      [c2 (make-who-condition "f")]
      [c3 (make-message-condition "invalid argument")]
      [c4 (make-message-condition "error occurred while reading from file")]
      [c5 (make-irritants-condition '("a.ss"))])
  (let ([s (simple-conditions
             (condition
               (condition (condition c1 c2) c3)
               (condition c4 (condition c5))))]
        [l (list c1 c2 c3 c4 c5)])
    (prs
      s
      l
      (equal? s l))))

(comments "define-condition-type")
(let ()
  (define-condition-type &mistake &condition make-mistake mistake?
    (type mistake-type))

  (let* ([c1 (make-mistake 'spelling)]
        [c2 (condition c1 (make-irritants-condition '(eggregius)))])
    (prs
      (mistake? 'booboo)
      
      (mistake? c1)
      (mistake-type c1)
      
      (mistake? c2)
      (mistake-type c2)
      (irritants-condition? c2)
      (condition-irritants c2))))

(comments "condition-predicate, condition-accessor")
(let ()
  (define-record-type (&mistake make-mistake $mistake?)
    (parent &condition)
    (fields (immutable type $mistake-type)))
  
  (define rtd (record-type-descriptor &mistake))
  (define mistake? (condition-predicate rtd))
  (define mistake-type (condition-accessor rtd $mistake-type))
  
  (let* ([c1 (make-mistake 'spelling)]
        [c2 (condition c1 (make-irritants-condition '(eggregius)))])
    (prs
      (list (mistake? c1) (mistake? c2))
      (mistake-type c1)
      ($mistake-type c1)
      (mistake-type c2)
      ; Exception in $mistake-type: #<compound condition> is not of type #<record type &mistake>
      #;($mistake-type c2))))

(exit)