# clsql
* https://github.com/sharplispers/clsql

> A multi-platform SQL interface for Common Lisp

``` lisp
; brew install mysql-connector-c
(ql:quickload :clsql)
```

Connection
``` lisp
> (connected-databases)
NIL
> (database-name-from-spec '("127.0.0.1" "movies" "root" "admin") :mysql)
"127.0.0.1/movies/root"
> (connect '("127.0.0.1" "movies" "root" "admin") :database-type :mysql)
<CLSQL-MYSQL:MYSQL-DATABASE 127.0.0.1/movies/root OPEN {1004683993}>
> (connected-databases)
(#<CLSQL-MYSQL:MYSQL-DATABASE 127.0.0.1/movies/root OPEN {1004683993}>)
> (disconnect)
T
> (connected-databases)
NIL

> (connect '("127.0.0.1" "movies" "root" "admin") :database-type :mysql)
<CLSQL-MYSQL:MYSQL-DATABASE 127.0.0.1/movies/root OPEN {10046878B3}>
```

Query
``` lisp
> (query "SELECT  ORDINAL_POSITION, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_COMMENT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = 'movies' AND TABLE_NAME = 'Movies' ORDER BY ORDINAL_POSITION;")
((1 "title" "varchar(100)" "NO" NIL "") (2 "year" "int(11)" "NO" NIL "")
 (3 "length" "int(11)" "YES" NIL "") (4 "genre" "varchar(10)" "YES" NIL "")
 (5 "studioName" "varchar(30)" "YES" NIL "")
 (6 "producerC#" "int(11)" "YES" NIL ""))
("ORDINAL_POSITION" "COLUMN_NAME" "COLUMN_TYPE" "IS_NULLABLE" "COLUMN_DEFAULT"
 "COLUMN_COMMENT")

> (query "SELECT * FROM Movies;")
NIL
("title" "year" "length" "genre" "studioName" "producerC#")
```

Close Connection
``` lisp
> (connected-databases)
(#<CLSQL-MYSQL:MYSQL-DATABASE 127.0.0.1/movies/root OPEN {10047F2453}>)
> (find-database "127.0.0.1/movies/root")
<CLSQL-MYSQL:MYSQL-DATABASE 127.0.0.1/movies/root OPEN {10047F2453}>
1
> (disconnect :database (find-database "127.0.0.1/movies/root"))
T
> (find-database "127.0.0.1/movies/root")

debugger invoked on a SQL-DATABASE-ERROR in thread
<THREAD "main thread" RUNNING {10004F84C3}>:
  A database error occurred: NIL / NIL
  There exists no database called 127.0.0.1/movies/root.

Type HELP for debugger help, or (SB-EXT:EXIT) to exit from SBCL.

restarts (invokable by number or by possibly-abbreviated name):
  0: [CONTINUE] Return nil.
  1: [ABORT   ] Exit debugger, returning to top level.

(SB-INT:SIMPLE-EVAL-IN-LEXENV (FIND-DATABASE "127.0.0.1/movies/root") #<NULL-LEXENV>)
0] 0
NIL
> (connected-databases)
NIL
```