(import (io simple))

(comments "comparison")
(prs
  (char>? #\a #\b)
  (char<? #\a #\b)
  (char<? #\a #\b #\c)
  (let ([c #\r])
    (char<=? #\a c #\z))
  (char<=? #\Z #\W)
  (char=? #\+ #\+)
)

(comments "comparison case-insensitive")
(prs
  (char-ci<? #\a #\B)
  (char-ci=? #\W #\w)
  (char-ci=? #\= #\+)
  (let ([c #\R])
    (list (char<=? #\a c #\z)
          (char-ci<=? #\a c #\z)))
)

(comments "character kind")
(prs
  (char-alphabetic? #\a)
  (char-alphabetic? #\T)
  (char-alphabetic? #\8)
  (char-alphabetic? #\$)

  (char-numeric? #\7)
  (char-numeric? #\2)
  (char-numeric? #\X)
  (char-numeric? #\space)

  (char-whitespace? #\space)
  (char-whitespace? #\newline)
  (char-whitespace? #\Z)
)

(comments "case predicate")
(prs
  (char-lower-case? #\r)
  (char-lower-case? #\R)

  (char-upper-case? #\r)
  (char-upper-case? #\R)

  (char-title-case? #\I)
  (char-title-case? #\x01C5)
)

(comments "character category")
(prs
  (char-general-category #\a)
  (char-general-category #\space)
  (char-general-category #\x10FFFF)
)

(comments "case conversion")
(prs
  (char-upcase #\g)
  (char-upcase #\G)
  (char-upcase #\7)
  (char-upcase #\ς)

  (char-downcase #\g)
  (char-downcase #\G)
  (char-downcase #\7)
  (char-downcase #\ς)

  (char-titlecase #\g)
  (char-titlecase #\G)
  (char-titlecase #\7)
  (char-titlecase #\ς)

  (char-foldcase #\g)
  (char-foldcase #\G)
  (char-foldcase #\7)
  (char-foldcase #\ς)
)

(comments "from/to integer conversion")
(prs
  (char->integer #\newline)
  (char->integer #\space)
  (- (char->integer #\Z) (char->integer #\A))

  (integer->char 48)
  (integer->char #x3BB)
)

(exit)