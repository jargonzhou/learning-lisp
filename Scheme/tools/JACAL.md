# JACAL
* https://people.csail.mit.edu/jaffer/JACAL

> JACAL is an interactive symbolic mathematics program.
>
> JACAL can manipulate and simplify equations, scalars, vectors, and matrices of single and multiple valued algebraic expressions containing numbers, variables, radicals, and algebraic differential, and holonomic functions.

# Concepts
* Algebra
* Calculus
* Matrices and Tensors
* Lambda Calculus

# Usage

The JACAL program is written in the Algorithmic Language Scheme.

versions:
```shell
$ ls
jacal-1c8-1.exe  scm-5f4-1.exe  slib-3c1-1.exe
```

example session:
```shell
e0 : (math);
e0: math
e1 : (2 + 3 * a) * 4 * a * b^2;
               2   2
e1: (8 a + 12 a ) b
e2 : a:[[1, 3, 5], [2, 4, 7]];
   [ 1  3  5 ]
a: [         ]
   [ 2  4  7 ]
e2 : b:[2, 4];
b: [2, 4]
e2 : a + b;
    [ 3  5  7  ]
e2: [          ]
    [ 6  8  11 ]
e3 : 3 + 2;
e3: 5
e4 : c + b;
e4: [2 + c, 4 + c]
e5 : e1 + e3;
                   2   2
e5: 5 + (8 a + 12 a ) b
e6 : qed;
> (exit)
```