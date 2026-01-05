(import (io simple))

(comments "constants")
(prs 
  3.2
  #f
  #\c
  "hi"  
  #vu8(3 4 5)
)

(comments "quote")
(prs 
  (+ 2 3)
  '(+ 2 3)
  (quote (+ 2 3))
  'a
  'cons
  '()
  '7
)


(comments "quasiquote")
(comments "unquote")
(prs 
  `(+ 2 3)
  `(+ 2 ,(* 3 4))
  `(a b (,(+ 2 3) c) d)
  `(a b ,(reverse '(c d e)) f g)
  (let ([a 1] [b 2])
    `(,a . ,b))
)

(comments "unquote-splicing")
(prs `(+ ,@(cdr '(* 2 3)))
  `(a b ,@(reverse '(c d e)) f g)
  (let ([a 1] [b 2])
    `(,a ,@b))
)

(prs 
  '`,(cons 'a 'b)
  `',(cons 'a 'b)
)

(comments "unquote, unquote-splicing with zero or more subforms")
(prs 
  `(a (unquote) b)
  `(a (unquote (+ 3 3)) b)
  `(a (unquote (+ 3 3) (* 3 3)) b)

  (let ([x '(m n)])
    ``(a ,@,@x f))

  (let ([x '(m n)])
    (eval `(let ([m '(b c)] [n '(d e)]) `(a ,@,@x f))
      (environment '(rnrs))))
)

(exit)