# SLIB
* https://people.csail.mit.edu/jaffer/SLIB.html

> The SLIB Portable Scheme Library
>
> SLIB is a portable library for the programming language Scheme. It provides a platform independent framework for using packages of Scheme procedures and syntax. As distributed, SLIB contains useful packages for all R4RS and R5RS Scheme implementations. Its catalog can be transparently extended to accomodate packages, both source and compiled, specific to a site, implementation, user, or directory.
>
> SLIB supports Bigloo, Chez, ELK 3.0, Gambit 4.0, Gauche, Guile, JScheme, Kawa, Larceny, MacScheme, MIT/GNU Scheme, Pocket Scheme, RScheme, scheme->C, Scheme48, SCM, SCM Mac, scsh, sisc, Stk, T3.1, umb-scheme, and VSCM.


```shell
# slib-3b7.zip
➜  make infoz
➜  make install
➜  ls /usr/local/lib/slib # where SLIB installed
Bev2slib.scm      collectx.scm      elk.init          lineio.scm        
...
➜  slib -v
slib 3b7
```

For [Guile](../guile/Guile.md)
```shell
➜  ln -s /usr/local/lib/slib /usr/local/share/guile/site/3.0/slib
➜  export SCHEME_LIBRARY_PATH=/usr/local/lib/slib/
➜  export GUILE_AUTO_COMPILE=0

➜  slib guile
WARNING: Use of `load' in declarative module (ice-9 slib).  Add #:declarative? #f to your define-module invocation.
GNU Guile 3.0.9
Copyright (C) 1995-2023 Free Software Foundation, Inc.

Guile comes with ABSOLUTELY NO WARRANTY; for details type `,show w'.
This program is free software, and you are welcome to redistribute it
under certain conditions; type `,show c' for details.

Enter `,help' for help.
scheme@(guile-user)> (quit)

➜  guile
scheme@(guile-user)> (use-modules (ice-9 slib))
scheme@(guile-user)> (require 'primes)
scheme@(guile-user)> (prime? 13)
$1 = #t
scheme@(guile-user)> (slib:load "math-real")

# Graph
scheme@(guile-user)> (use-modules (ice-9 slib))
scheme@(guile-user)> (require 'charplot)
scheme@(guile-user)> (set! charplot:dimensions '(20 55))
# for variable pi
scheme@(guile-user)> (require 'color)
scheme@(guile-user)> (plot sin 0 (* 2 pi))
           ________________________________________
         1|-:       ****                           |
          | :     **    **                         |
      0.75|-:    *       **                        |
          | :   *         **                       |
       0.5|-:  *            *                      |
          | : *             **                     |
      0.25|-:**              *                     |
          | :*                *                    |
         0|-*------------------*------------------*|
          | :                   *                * |
     -0.25|-:                   *               ** |
          | :                    **            *   |
      -0.5|-:                     *            *   |
          | :                      *          *    |
     -0.75|-:                       **      **     |
          | :                        **    **      |
        -1|-:                         *****        |
          |_:_____._____:_____._____:_____._____:__|
            0           2           4           6
scheme@(guile-user)>
```