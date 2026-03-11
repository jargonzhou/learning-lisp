# Guile
* https://www.gnu.org/software/guile/

> Guile is a programming language
>
> Guile is designed to help programmers create flexible applications that can be extended by users or other programmers with plug-ins, modules, or scripts.
>
> With Guile you can create applications and games for the desktop, the Web, the command-line, and more.

# Usage

REPL:
```shell
# Windows WSL
➜  guile-3.0.11 sudo apt update && sudo apt install libunistring-dev
➜  guile-3.0.11 ./configure
➜  guile-3.0.11 make
➜  guile-3.0.11 sudo make install
➜  guile-3.0.11 which guile
/usr/local/bin/guile

# alias guile=/home/zhoujiagen/guile/guile-3.0.11/meta/guile
➜  guile-3.0.11 ./meta/guile
GNU Guile 3.0.11
Copyright (C) 1995-2024 Free Software Foundation, Inc.

Guile comes with ABSOLUTELY NO WARRANTY; for details type `,show w'.
This program is free software, and you are welcome to redistribute it
under certain conditions; type `,show c' for details.

Enter `,help' for help.
scheme@(guile-user)> (version)
$1 = "3.0.11"
scheme@(guile-user)> (+ 1 2 3)
$2 = 6
scheme@(guile-user)> (define (factorial n) ; define a function
                        (if (zero? n) 1 (* n (factorial (- n 1)))))
scheme@(guile-user)> (factorial 20)
$3 = 2432902008176640000
scheme@(guile-user)> (getpwnam "zhoujiagen")
$4 = #("zhoujiagen" "x" 1000 1000 ",,," "/home/zhoujiagen" "/usr/bin/zsh")
scheme@(guile-user)> (exit)
➜  guile-3.0.11
```

```shell
$ cat hello-world.scm
#!/usr/bin/guile -s
!#
(display "Hello, world!")
(newline)
$ guile hello-world.scm
Hello, world!
```

# Distribution
* [Distributing Guile Code](https://www.gnu.org/software/guile/manual/html_node/Distributing-Guile-Code.html)
* [guile-hall](https://gitlab.com/a-sassmannshausen/guile-hall): Hall is a command-line application and a set of Guile libraries that allow you to quickly create and publish Guile projects. It allows you to transparently support the GNU build system, manage a project hierarchy & provides tight coupling to Guix.

# See Also
