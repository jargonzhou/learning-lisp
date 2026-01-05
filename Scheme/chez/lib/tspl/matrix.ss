(library (tspl matrix)
  (export make-matrix 
          matrix? 
          matrix-rows 
          matrix-columns
          matrix-ref
          matrix-set!
          mul)
  (import (rnrs))

  ;;; Create a matrix (a vector of vector).
  (define (make-matrix rows columns)
    (do ([m (make-vector rows)]
         [i 0 (+ i 1)])
      ((= i rows) m)
      (vector-set! m i (make-vector columns)))) 

  ;;; Check to see if it is a matrix.
  (define (matrix? x)
    (and (vector? x)
         (> (vector-length x) 0)
         (vector? (vector-ref x 0))))

  ;; Get the number of rows in a matrix.
  (define (matrix-rows x)
    (vector-length x))

  ;; Get the number of columns in a matrix.
  (define (matrix-columns x)
    (vector-length (vector-ref x 0)))

  ;;; Get the jth element of the ith row.
  (define (matrix-ref m i j)
    (vector-ref (vector-ref m i) j))
 
  ;;; Set the jth element of the ith row.
  (define (matrix-set! m i j x)
    (vector-set! (vector-ref m i) j x))

  ;;; Multiply a matrix by a scalar.
  (define (matrix-scalar-mul m x)
    (let* ([nr (matrix-rows m)]
           [nc (matrix-columns m)]
           [r (make-matrix nr nc)]) ; the result
      (do ([i 0 (+ i 1)])
        ((= i nr) r)
        (do ([j 0 (+ j 1)])
          ((= j nc))
          (matrix-set! r i j (* x (matrix-ref m i j)))))))

  ;;; Multiply a matrix by a matrix.
  (define (matrix-matrix-mul m1 m2)
    (let* ([nr1 (matrix-rows m1)]
           [nr2 (matrix-rows m2)]
           [nc2 (matrix-columns m2)]
           [r (make-matrix nr1 nc2)])                           ; the result: nr1 * nc2
      (unless (= (matrix-columns m1) nr2) (match-error m1 m2))  ; nc1 == nr2
      (do ([i 0 (+ i 1)])
        ((= i nr1) r)
        (do ([j 0 (+ j 1)])
          ((= j nc2))
          (do ([k 0 (+ k 1)]
               [a 0 (+ a (* (matrix-ref m1 i k) (matrix-ref m2 k j)))])
            ((= k nr2) 
             (matrix-set! r i j a)))))))

  ;;; Called when mul receive a pair of incompatible arguments.
  (define (match-error what1 what2)
    (assertion-violation 'mul "incompatible operands" what1 what2))

  ;;; The generic matrix/scalar multiplication procedure.
  (define (mul x y)
    (cond
      [(number? x)
       (cond
         [(number? y) (* x y)]
         [(matrix? y) (matrix-scalar-mul y x)]
         [else (type-error y)])]
      [(matrix? x)
        (cond
          [(number? y) (matrix-scalar-mul x y)]
          [(matrix? y) (matrix-matrix-mul x y)]
          [else (type-error y)])]
      [else (type-error x)]))

  ;;; Called when mul receive an invalid type of argument.
  (define (type-error what)
    (assertion-violation 'mul "not a number or a matrix" what))
)