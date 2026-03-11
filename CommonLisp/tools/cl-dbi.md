# cl-dbi
* https://github.com/fukamachi/cl-dbi

> Database independent interface for Common Lisp.

``` lisp
(ql:quickload :cl-dbi)
```

``` lisp
(defvar *connection*
  (dbi:connect :mysql
               :host "127.0.0.1"
               :port 3306
               :database-name "movies"
               :username "root"
               :password "admin"))
*CONNECTION*
```

``` lisp
(let* ((query (dbi:prepare *connection*
                           "SELECT * FROM Movies WHERE `producerC#` = ?"))
       (query (dbi:execute query 1)))
  (loop for row = (dbi:fetch query)
        while row
        ;; process "row".
        do (print row)))

(:|title| "title" :|year| 2000 :|length| 120 :|genre| "genre" :|studioName|
 "studioName" :|producerC#| 1)
NIL
```

``` lisp
> (dbi:fetch-all (dbi:execute (dbi:prepare *connection* "SELECT * FROM Movies WHERE `producerC#` = ?")
                            1))
((:|title| "title" :|year| 2000 :|length| 120 :|genre| "genre" :|studioName|
  "studioName" :|producerC#| 1))
```

