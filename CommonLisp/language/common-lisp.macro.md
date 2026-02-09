# Common Lisp Macro

# Terminology

- 求值(Evaluation)
    - 多次求值(Multiple Evaluation)
    - 求值顺序(Order of Evaluation)
- 宏展开(Macro Expansion)
- 反引用(Backquote)
- 变量捕获(Variable Capture)
- 参数列表解构(Destructuring in Parameter Lists)
- 符号宏(Symbol Macros)
- 回指宏(Anaphoric Macros)
- 读时宏(Read-Time Macros)
    - 宏字符(Macro Characters)
    - 分发宏字符(Dispatching Macro Characters)

# 函数与宏的区别

- function produce result, macro produce expressions, which when evaluated, produce result.

# 宏的构造

- backquote(`` ` ``): a special version of quote (`'`).
- comma `,`: cancel the quote.
- comma-at `,@`: splice the expression it affix.

➽ A comma(`,`) surrounded by 𝑛n comma(`,`) must be surrounded by at least 𝑛+1n+1 backquotes(`` ` ``).

`,` is **surrounded** by a particular operator if the operator is prepended to the `,`, or prepended to an expression which contains the `,`.

Example: the last `,` is surround by one `,` and two `` ` ``.

```
`(,a ,(b `,c))
```

➽ `,@` must occur within a sequence.

➽ the object to be spliced into must be a list, except it occur last.

Example:

```
`(a ,@1)     ; (a . 1)
`(a ,@1 b)   ; ERROR
```

# 陷阱

## 变量捕获(Variable Capture)

## 求值次数(Number of Evaluations)

## 求值顺序(Order of Evaluation)

## 非函数式的展开器(Non-functional Expanders)

## 递归(Recursion)

## See Also
* Common Lisp: The Language
* ANSI Common Lisp
* On Lisp
* Let Over Lambda