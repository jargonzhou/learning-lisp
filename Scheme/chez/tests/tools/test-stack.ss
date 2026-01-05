(import (tools stack) (tools tests))

(define stack1 (make-stack))
(define stack2 (make-stack))

(let ([stack1 (make-stack)]
    [stack2 (make-stack)])
    (run-test stack1 'empty?)
    (run-test stack2 'empty?)
    (run-test stack1 'push! 'b)
    (run-test stack2 'push! 'c)
    (run-test stack1 'top)
    (run-test stack2 'top)
    (run-test stack1 'pop!)
    (run-test stack1 'empty?))