;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 3. Maps, Keywords, and Sets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ns basics.c03-maps-keywords-sets)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this goes with that
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; maps
{"title" "Oliver Twist" "author" "Dickens" "published" 1838} ; {"title" "Oliver Twist", "author" "Dickens", "published" 1838}
; hash-map
(hash-map "title" "Oliver Twist"
          "author" "Dickens"
          "published" 1838) ; {"author" "Dickens", "published" 1838, "title" "Oliver Twist"}

(def book {"title" "Oliver Twist"
           "author" "Dickens"
           "published" 1838})
(get book "published") ; 1838
; map as a function
(book "published") ; 1838
(book "non-exisit-key") ; nil

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; keywords
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def book2
  {:title "Oliver Twist" :author "Dickens" :published 1838})
(println "Title:" (book2 :title)); output Title: Oliver Twist
(println "By:" (book2 :author)); output By: Dickens
(println "Published:" (book2 :published)); output Published: 1838

; keyword as a function to map
(:title book2) ; "Oliver Twist"
(book2 :title) ; "Oliver Twist"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; changing your map without changing it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; assoc
(assoc book2 :page-count 362) ; {:title "Oliver Twist", :author "Dickens", :published 1838, :page-count 362}
(assoc book2 :page-count 362 :title "War & Peace") ; {:title "War & Peace", :author "Dickens", :published 1838, :page-count 362}

; dissoc
(dissoc book2 :published) ; {:title "Oliver Twist", :author "Dickens"}
(dissoc book2 :title :author :published) ; {}
(dissoc book2 :non-exist-key) ; {:title "Oliver Twist", :author "Dickens", :published 1838}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; other handy map functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; keys
(keys book2) ; (:title :author :published)
; vals
(vals book2) ; ("Oliver Twist" "Dickens" 1838)
; the comma
{:title "Oliver Twist", :author "Dickens", :published 1838} ; {:title "Oliver Twist", :author "Dickens", :published 1838}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(def genres #{:sci-fi :romance :mystery})
(def authors #{"Dickens" "Austen" "King"})

; contains?
(contains? authors "Austen") ; true
(contains? genres "Austen") ; false

; set as a function
(authors "Austen") ; "Austen"
(genres :historical) ; nil

; keyword as a function to set
(:sci-fi genres) ; :sci-fi
(:historical genres) ; nil

; conj
(def more-authors (conj authors "Clarke"))
(conj more-authors "Clarke") ; #{"King" "Dickens" "Clarke" "Austen"}
; disj
(disj more-authors "King") ; #{"Dickens" "Clarke" "Austen"}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; in the wild
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; keywords are not strings
(book2 "title") ; nil
(assoc book2 "title" "Pride and Prejudice") ; {:title "Oliver Twist", :author "Dickens", :published 1838, "title" "Pride and Prejudice"}

(def anonymous-book {:title "The Arabian Nights" :author nil})
(anonymous-book :author) ; nil
(contains? anonymous-book :author) ; true
(contains? anonymous-book :non-exist-key) ; false

(def possible-authors #{"Austen" "Dickens" nil})
(possible-authors nil) ; nil
(contains? possible-authors nil) ; true

; treat map as sequences
; first, rest, count
(first book2) ; [:title "Oliver Twist"] - maybe others
(rest book2) ; ([:author "Dickens"] [:published 1838])
(count book2) ; 3


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; staying out of trouble
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
