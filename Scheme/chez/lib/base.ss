(library (base)
  (export tree-copy)
  (import (rnrs base))
  
  ;;; Copy a tree.
  (define tree-copy
    (lambda (tr)
        (if (not (pair? tr))
            tr
            (cons (tree-copy (car tr))
                (tree-copy (cdr tr))))))
)