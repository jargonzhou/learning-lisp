(import (tspl printer))

(let ([datums (list
  'a
  (list 1 2)
  (cons 1 2)
  1
  1.0
  #\a
  "a"
  '#(1 2)
  '#vu8(1 2)
  (current-output-port)
  (lambda (x) (+ x 1))
  )])
  
  (do ([i 0 (+ i 1)])
    ((= i (length datums)))
    (write (list-ref datums i))
    (newline)))


(newline)

(exit)