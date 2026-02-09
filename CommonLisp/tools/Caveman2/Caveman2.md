# Caveman2
* https://github.com/fukamachi/caveman

> Lightweight web application framework for Common Lisp.

```lisp
(ql:quickload :caveman2)
```

# Skaffold

```shell
* (caveman2:make-project #P"ex-caveman2")

touch ~/.config/common-lisp/source-registry.conf.d/caveman2.conf
# (:tree "/path/to/ex-caveman2/")
```

`src/config.lisp`
```lisp
(defconfig :common
    `(:databases
      ((:maindb :mysql
		:host "127.0.0.1"
		:port 3306
		:database-name "movies"
		:username "root"
		:password "*****"))))

(defconfig |development|
    '(:databases
      ((:maindb :mysql
	:host "127.0.0.1"
	:port 3306
	:database-name "movies"
	:username "root"
	:passowrd "*****"))))
```

`src/db.lisp`
```lisp
(:export ...
  :find-movies-from-db)

(defun find-movies-from-db (|id|)
  (with-connection (db)
    (let* ((query (dbi:prepare *connection*
                               "SELECT * FROM Movies WHERE `producerC#` = ?"))
	   (query (dbi:execute query |id|))
	   (result nil))
      (loop for row = (dbi:fetch query)
         while row
         do (push row result))
      result)))
```

`src/web.lisp`
```lisp
(defroute "/user.json" (&key |id|)
  (let ((movies (find-movies-from-db |id|)))
    (render-json (car movies))))
```

start
```lisp
(asdf:load-system "ex-caveman2")
(ex-caveman2:start :port 8080)
(ex-caveman2:stop)
```

output
```shell
# http://localhost:8080/user.json?id=1 
# {"title":"title","year":2000,"length":120,"genre":"genre","studioName":"studioName","producerC#":1}

# http://localhost:8080/user.json?id=2 
# null

Hunchentoot server is started.
Listening on 127.0.0.1:8080.
S(CLACK.HANDLER::HANDLER
   :SERVER :HUNCHENTOOT
   :ACCEPTOR #<SB-THREAD:THREAD "clack-handler-hunchentoot" RUNNING
                {100433C8E3}>)
> 127.0.0.1 - [03/Sep/2019:11:04:29 +08:00] "GET /user.json?id=1 HTTP/1.1" 200 99 "-" "-"
127.0.0.1 - [03/Sep/2019:11:04:39 +08:00] "GET /user.json?id=2 HTTP/1.1" 200 4 "-" "-"
127.0.0.1 - [03/Sep/2019:11:04:45 +08:00] "GET /user.json?id=1 HTTP/1.1" 200 99 "-" "-"
```


# Related

[Clack](https://github.com/fukamachi/clack): Clack is a web application environment for Common Lisp inspired by Python's WSGI and Ruby's Rack. 
Server:
- [Hunchentoot](http://weitz.de/hunchentoot/)
- [Wookie](http://wookie.beeets.com/)
- [Toot](https://github.com/gigamonkey/toot)
- [Woo](https://github.com/fukamachi/woo)

[Lack](https://github.com/fukamachi/lack): Lack, the core of Clack

> Lack is a Common Lisp library which allows web applications to be constructed of modular components. It was originally a part of Clack, however it's going to be rewritten as an individual project since Clack v2 with performance and simplicity in mind.
>
> The scope is defining Lack applications and wrapping it up with Lack middlewares. On the other hand, Clack is an abstraction layer for HTTP and HTTP servers and provides unified API.

# See Also