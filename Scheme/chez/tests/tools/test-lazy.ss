(import (tools lazy) (io simple))

(let ([p (lazy-eval (lambda ()
                      (display "Ouch!")
                      (newline)
                      "got me"))])
  (pr (p))
  (pr (p)))

(exit)