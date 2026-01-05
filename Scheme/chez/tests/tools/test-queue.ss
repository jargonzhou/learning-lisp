(import (tools queue) (tools tests))

(let ([q (make-queue)])
  (putq! q 'a)
  (putq! q 'b)
  (run-test getq q)
  (delq! q)
  (run-test getq q))

(exit)