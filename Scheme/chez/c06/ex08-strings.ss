(import (io simple))

(comments "comparison")
(prs 
  (string=? "mom" "mom")
  (string<? "mom" "mommy")
  (string>? "Dad" "Dad")
  (string=? "Mom and Dad" "mom and dad")
  (string<? "a" "b" "c")
)

(comments "comparison case-insensitive")
(prs 
  (string-ci=? "Mom and Dad" "mom and dad")
  (string-ci<=? "say what" "Say What!?")
  (string-ci>? "N" "m" "L" "k")
  (string-ci=? "Straße" "Strasse")
)

(comments "construction")
(prs 
  (string)
  (string #\a #\b #\c)
  (string #\H #\E #\Y #\!)

  (make-string 0)
  (make-string 0 #\x)
  (make-string 5 #\x)
)

(comments "string-length")
(prs 
  (string-length "abc")
  (string-length "")
  (string-length "hi there")
  (string-length (make-string 1000000))
)

(comments "string-ref, string-set!")
(prs 
  (string-ref "hi there" 0)
  (string-ref "hi there" 5)

  (let ([str (string-copy "hi three")])
    (string-set! str 5 #\e)
    (string-set! str 6 #\r)
    str)
)

(comments "string-copy")
(prs 
  (string-copy "abc")

  (let ([str "abc"])
    (eq? str (string-copy str)))
)

(comments "string-append")
(prs 
  (string-append)
  (string-append "abc" "def")
  (string-append "Hey " "you " "there!")
)

(comments "substring")
(prs 
  (substring "hi there" 0 1)
  (substring "hi there" 3 6)
  (substring "hi there" 5 5)

  (let ([str "hi there"])
    (let ([end (string-length str)])
      (substring str 0 end)))
)

(comments "string-fill!")
(prs 
  (let ([str (string-copy "sleepy")])
    (string-fill! str #\Z)
    str)
)

(comments "conversion")
(prs 
  (string-upcase "Hi")
  (string-downcase "Hi")
  (string-foldcase "Hi")

  (string-upcase "Straße")
  (string-downcase "Straße")
  (string-foldcase "Straße")
  (string-downcase "STRASSE") 

  (string-downcase "Σ")

  (string-titlecase "kNock KNoCK")
  (string-titlecase "who's there?")
  (string-titlecase "r6rs")
  (string-titlecase "R6RS")
)

(comments "normalize")
(prs 
  (string-normalize-nfd "\xE9;")
  (string-normalize-nfc "\xE9;")
  (string-normalize-nfd "\x65;\x301;")
  (string-normalize-nfc "\x65;\x301;")
)

(comments "from/to list")
(prs 
  (string->list "")
  (string->list "abc")
  (apply char<? (string->list "abc"))
  (map char-upcase (string->list "abc"))

  (list->string '())
  (list->string '(#\a #\b #\c))
  (list->string
    (map char-upcase
        (string->list "abc")))
)

(exit)
