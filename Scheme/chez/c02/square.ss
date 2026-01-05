(import (tools tests))

(define square
  (lambda (n)
    (* n n)))

(define *test-enabled?* #t)
(run-tests square '(-2 -1 0 1 2))

(exit)