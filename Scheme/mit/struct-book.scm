;;; NOTE: MIT/GNU Scheme

;;; structure: book
(define-structure (book keyword-constructor copier)
    title
    author
    publisher
    year
    isbn)

(define bazaar 
    (make-book
        `title "The Cathedral and the Bazaar"
        `author "Eric S. Raymond"
        `publisher "O'Reilly"
        `year 1999
        `isbn 0596001088))

(define cathedral (copy-book bazaar))

(begin 
    (display (book? bazaar))        ; check
    (newline)
    (display bazaar)
    (newline)
    (display (book-title bazaar))   ; access attribute
    (newline)
    (set-book-year! bazaar 2001)    ; modify attribute
    (display (book-year bazaar)))