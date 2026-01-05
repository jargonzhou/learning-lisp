(library (tools lazy)
  (export lazy-eval)
  (import (rnrs base))
  
  ;;; lazy evluation a thunk (zero-argument procedure)
  (define lazy-eval
      (lambda (thunk)
        (let ([val #f] [flag #f])
          (lambda ()
            (if (not flag)
              (begin 
                (set! val (thunk)) ; application of thunk
                (set! flag #t)))
            val)))) 
)