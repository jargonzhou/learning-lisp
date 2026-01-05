(import (io simple)
  (rename (rnrs records syntactic)
    (record-type-descriptor rtd)
    (record-constructor-descriptor rcd)))

(comments "record-type-name")

(define (record->name x)
  (and (record? x) (record-type-name (record-rtd x))))

(let ()
  (define-record-type dim (fields w l h))
  (define-record-type dim2 (fields w l h) (opaque #t))
  
  (prs (record->name (make-dim 10 15 6))
       (record->name (make-dim2 10 15 6))))

(comments "record-type-parent")
(let ()
  (define-record-type point (fields x y))
  (define-record-type cpoint (parent point) (fields color))
  
  (prs (record-type-parent (rtd point))
       (record-type-parent (rtd cpoint))))

(comments "record-type-uid")
(let ()
  (define-record-type point (fields x y))
  (define-record-type cpoint
    (parent point)
    (fields color)
    (nongenerative e40cc926-8cf4-4559-a47c-cac636630314))
    
  (prs (record-type-uid (rtd point))
       (record-type-uid (rtd cpoint))))

(comments "record-type-generative? record-type-sealed? record-type-opaque?")
(let ()
  (define-record-type table
    (fields keys vals)
    (opaque #t))
  (define rtd1 (rtd table))

  (define-record-type cache-table
    (parent table)
    (fields key val)
    (nongenerative))
  (define rtd2 (rtd cache-table))
  
  (prs (record-type-generative? rtd1)
       (record-type-sealed? rtd1)
       (record-type-opaque? rtd1)
       
       (record-type-generative? rtd2)
       (record-type-sealed? rtd2)
       (record-type-opaque? rtd2)))

(comments "record-type-field-names")
(let ()
  (define-record-type point (fields x y))
  (define-record-type cpoint (parent point) (fields color))
  
  (prs (record-type-field-names (rtd point))
       (record-type-field-names (rtd cpoint))))

(comments "record-field-mutable?")
(let ()
  (define-record-type point (fields (mutable x) (mutable y)))
  (define-record-type cpoint (parent point) (fields color))
  
  (prs (record-field-mutable? (rtd point) 0)
       (record-field-mutable? (rtd cpoint) 0)))

(comments "record?")
(let ()
  (define-record-type statement (fields str))
  (define-record-type opaque-statement (fields str) (opaque #t))
  
  (let ([q (make-statement "He's dead, Jim")]
        [q2 (make-opaque-statement "He's moved on, Jim")])
    (prs (statement? q)
         (record? q)
         
         (opaque-statement? q2)
         (record? q2))))

(comments "record-rtd")
(define (print-fields r)
  (unless (record? r)
    (assertion-violation 'print-fields "not a record" r))
  (let loop ([rrtd (record-rtd r)])
    ; display fields in parent first
    (let ([prtd (record-type-parent rrtd)])
      (when prtd (loop prtd)))
    (let* ([v (record-type-field-names rrtd)]
           [n (vector-length v)])
      (do ([i 0 (+ i 1)])
        ((= i n))
        (write (vector-ref v i))
        (display "=")
        (write ((record-accessor rrtd i) r))
        (newline)))))

(let ()
  (define-record-type point (fields x y))
  (define-record-type cpoint (parent point) (fields color))
  
  (print-fields (make-cpoint -3 7 'blue)))