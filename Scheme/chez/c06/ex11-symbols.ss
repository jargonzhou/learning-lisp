(import (io simple))

(comments "symbol=?")
(prs
  (symbol=? 'a 'a)
  (symbol=? 'a (string->symbol "a"))
  (symbol=? 'a 'b)
)

(comments "string->symbol")
(prs
  (string->symbol "x")

  (eq? (string->symbol "x") 'x)
  (eq? (string->symbol "X") 'x)

  (eq? (string->symbol "x")
      (string->symbol "x"))

  (string->symbol "()")
)

(comments "symbol->string")
(prs
  (symbol->string 'xyz)
  (symbol->string 'Hi)
  (symbol->string (string->symbol "()"))
)

(exit)