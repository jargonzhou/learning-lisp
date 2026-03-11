# SLIME: The Superior Lisp Interaction Mode for Emacs
* https://slime.common-lisp.dev/
* https://github.com/slime/slime

> SLIME is a Emacs mode for Common Lisp development. Inspired by existing systems such Emacs Lisp and ILISP, we are working to create an environment for hacking Common Lisp in.
>
> SLIME works with GNU Emacs versions 24.3 and later, on Linux, macOS, Windows, BSD, Unix.

features:
* **slime-mode**: An Emacs minor-mode to enhance lisp-mode with:
  * Code evaluation, compilation, and macroexpansion.
  * Online documentation (describe, apropos, hyperspec).
  * Definition finding (aka Meta-Point aka M-.).
  * Symbol and package name completion.
  * Automatic macro indentation based on &body.
  * Cross-reference interface (WHO-CALLS, etc).
  * ... and more.
* **SLDB**: Common Lisp debugger with an Emacs-based user interface.
* **REPL**: The Read-Eval-Print Loop ("top-level") is written in Emacs Lisp for tighter integration with Emacs. The REPL also has builtin "shortcut" commands similar those of the McCLIM listener.
* **Compilation notes**: SLIME is able to take compiler messages and annotate them directly into source buffers.
Inspector: Interactive object-inspector in an Emacs buffer.

```shell
# MELPA
M-x package-install RET
slime RET
```

`.emacs`
```lisp
;; Set your lisp system and, optionally, some contribs
;(setq inferior-lisp-program "/usr/local/bin/sbcl")
;(setq slime-contribs '(slime-fancy))

(setq inferior-lisp-program "sbcl")
```

# Usage

```shell
M-x slime RET
; SLIME 2.22
CL-USER> (+ 1 1)
2

CL-USER> ,
# in minibuffer, Command:
sayoonara RET
# in minibuffer, Connection closed.
```

load and compile files
```shell
# same folder as lisp files
M-x slime RET

; SLIME 2.22
CL-USER> (load "hello.lisp")
T
CL-USER> (hello-world)
Hello, Common Lisp!!
NIL
CL-USER> (load (compile-file "hello.lisp"))
; compiling file "/.../hello.lisp" (written 07 AUG 2019 01:55:50 PM):
; compiling (DEFUN HELLO-WORLD ...)

; wrote /.../hello.fasl
; compilation finished in 0:00:00.002
T
CL-USER> (hello-world)
Hello, Common Lisp!!
NIL
CL-USER>
```

# Manual

## Getting started

## Using Slime mode

> User-interface conventions/用户接口约定

* temporary buffers
* `*inferior-lisp*` buffer
* multithreading
* key bindings: when entering a three-key sequence, the final key can be pressed either with control or unmodified.
** `C-c C-d d`: `C-c C-d C-d`.
** never bind `C-h` anywhere in a key sequence.
** `global-set-key`
** `define-key`



| 分组     | 命令                                                       | 说明                                                                                                                                        |
| :------- | :--------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| 求值     | C-x C-e <br> M-x slime-eval-last-expression                | 对光标前的表达式求值并且将结果显示到显示区                                                                                                  |
| 求值     | C-M-x <br> M-x slime-eval-defun                            | 对当前toplevel的形式进行求值并将结果打印到显示区                                                                                            |
| 求值     | C-c : <br> M-x slime-interactive-eval                      | 从迷你缓冲区读取一个表达式并求值                                                                                                            |
| 求值     | C-c C-r <br> M-x slime-eval-region                         | 对区域进行求值                                                                                                                              |
| 求值     | C-c C-p <br> M-x slime-pprint-eval-last-expression         | 对光标前的表达式进行求值并将结果漂亮地打印在一个新的缓冲区里                                                                                |
| 求值     | C-c E <br> M-x slime-edit-value                            | 在一个叫做“Edit `<form>`”的新缓冲区里编辑一个可以setf的形式的值. 这个值会被插入一个临时缓冲区以便编辑，然后用C-c C-c命令来提交设置于Lisp中. |
| 求值     | C-x M-e <br> M-x slime-eval-last-expression-display-output | 对光标前的表达式求值并将结果打印在显示缓冲区里                                                                                              |
| 求值     | C-c C-u <br> M-x slime-undefine-function                   | 用fmakunbound来取消当前光标处函数的定义                                                                                                     |
| 编译     | C-c C-c <br> M-x slime-compile-defun                       | 编译光标处的top-level形式                                                                                                                   |
| 编译     | C-c C-k <br> M-x slime-compile-and-load-file               | 编译和加载当前缓冲区的源文件                                                                                                                |
| 编译     | C-c M-k <br> M-x slime-compile-file                        | 编译（但不加载）当前缓冲区的源文件                                                                                                          |
| 编译     | C-c C-l <br> M-x slime-load-file                           | 加载Lisp文件                                                                                                                                |
| 编译     | M-x slime-compile-region                                   | 编译选中的区域                                                                                                                              |
| 编译消息 | M-n <br> M-x slime-next-note                               | 将光标移到下一个编译器消息处并显示消息                                                                                                      |
| 编译消息 | M-p <br> M-x slime-previous-note                           | 将光标移到上一个编译器消息处并显示消息                                                                                                      |
| 编译消息 | C-c M-c <br> M-x slime-remove-notes                        | 删除缓冲区里的所有提示信息                                                                                                                  |
| 编译消息 | C-x ‘ <br> M-x next-error                                  | 访问下一个错误消息                                                                                                                          |
| 补全     | M-TAB <br> M-x slime-complete-symbol                       | 补全光标处的符号                                                                                                                            |
| 查找定义 | M-. <br> M-x slime-edit-definition                         | 跳至光标处符号的定义处                                                                                                                      |
| 查找定义 | M-, <br> M-* <br> M-x slime-pop-find-definition-stack      | 回到M-.命令执行的光标处                                                                                                                     |
| 查找定义 | C-x 5 . <br> M-x slime-edit-definition-other-frame         | 类似slime-edit-definition，但是会跳到另一个框架来编辑其定义                                                                                 |
| 查找定义 | M-x slime-edit-definition-with-etags                       | 使用ETAGES的表来寻找当前光标处的定义                                                                                                        |
| 文档     | C-c C-d d <br> M-x slime-describe-symbol                   | 描述当前光标处的符号                                                                                                                        |
| 文档     | C-c C-d f <br> M-x slime-describe-function                 | 描述当前光标处的函数                                                                                                                        |
| 文档     | C-c C-d a <br> M-x slime-apropos                           | 对于一个正则表达式执行一个合适的搜索，来搜索所有的Lisp符号名称，并且显示出相应的文档字符串                                                  |
| 文档     | C-c C-d z <br> M-x slime-apropos-all                       | 类似slime-apropos但是默认包含所有内部符号                                                                                                   |
| 文档     | C-c C-d p <br> M-x slime-apropos-package                   | 显示包内所有符号的合适的结果                                                                                                                |
| 文档     | C-c C-d h <br> M-x slime-hyperspec-lookup                  | 在Hyperspec里查找当前光标处的符号                                                                                                           |
| 文档     | C-c C-d ~ <br> M-x hyperspec-lookup-format                 | 在Hyperspec里查找一个foramt格式控制符                                                                                                       |
| 文档     | C-c C-d # <br> M-x hyperspec-lookup-reader-macro           | 在Hyperspec里查找一个读取宏                                                                                                                 |
| 交叉引用 | C-c C-w c <br> M-x slime-who-calls                         | 显示该函数的调用者                                                                                                                          |
| 交叉引用 | C-c C-w w <br> M-x slime-calls-who                         | 显示该函数调用了的函数                                                                                                                      |
| 交叉引用 | C-c C-w r <br> M-x slime-who-references                    | 显示对全局变量的引用                                                                                                                        |
| 交叉引用 | C-c C-w b <br> M-x slime-who-binds                         | 显示对全局标量的绑定                                                                                                                        |
| 交叉引用 | C-c C-w s <br> M-x slime-who-sets                          | 显示对全局标量的赋值                                                                                                                        |
| 交叉引用 | C-c C-w m <br> M-x slime-who-macroexpands                  | 显示某个宏扩展之后的结果                                                                                                                    |
| 交叉引用 | M-x slime-who-specializes                                  | 显示一个类所有已知的方法                                                                                                                    |
| 宏扩展   | C-c C-m <br> M-x slime-macroexpand-1                       | 将光标处的表达式宏展开一次                                                                                                                  |
| 宏扩展   | C-c M-m <br> M-x slime-macroexpand-all                     | 将光标处的表达式完全宏展开                                                                                                                  |
| 宏扩展   | M-x slime-compiler-macroexpand-1                           | 显示光标处的编译宏展开的sexp                                                                                                                |
| 宏扩展   | M-x slime-compiler-macroexpand                             | 反复展开光标处的编译宏的sex                                                                                                                 |
|          |                                                            |                                                                                                                                             |


> Evaluation commands/求值命令

> Compilation commands/编译命令

> Completion commands/补全命令

> Finding definitions (“Meta-Point” commands)/查找定义

> Documentation commands/文档命令

> Cross-reference commands/交叉引用命令
	- Xref buffer commands

> Macro-expansion commands/宏展开命令

> Disassembly commands/反汇编命令

> Abort/Recovery commands/退出/恢复命令

> Inspector commands/查看器命令

> Profiling commands/度量命令

> Shadowed Commands

> Semantic indentation

> Reader conditional fontification/读取器条件表达式

## SLDB: the SLIME debugger

> Examining frames/检查帧

> Invoking restarts/调用重启动

> Navigating between frames/帧间导航

> Stepping/步入

> Miscellaneous Commands/杂项命令


## Misc

## Customization

## Tips and Tricks

## Contributed Packages

* `slime-contribs` variable
* `slime-repl`
* `slime-mrepl`
* `inferior-slime-mode`
* `slime-c-p-c`
* `slime-fuzzy`
* `eldoc-mode`
* `slime-asdf`
* `slime-banner`
* `slime-editing-commands`
* `slime-fancy-inspector`
* `slime-presentations`
* `slime-typeout-frame`
* `slime-tramp`
* `slime-references`
* `slime-xref-browser`
* `slime-highlight-edits`
* `slime-scratch`
* `slime-trace-dialog`
* `slime-sprof`: SBCL statistical profiler `sb-sprof`.
* `slime-mdot-fu`
* `slime-fancy`
* `slime-quicklisp`

## ac-slime

* [Slime completion source for Emacs auto-complete package](https://github.com/purcell/ac-slime)
```lisp
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'slime-repl-mode))
```

## CLHS
* [How to connect Hyperspec documentation to Emacs SLIME on MS Windows](https://stackoverflow.com/questions/17534404/how-to-connect-hyperspec-documentation-to-emacs-slime-on-ms-windows)

```lisp
(setq inferior-lisp-program "clisp"
      common-lisp-hyperspec-root "c:/run/HyperSpec/"
      common-lisp-hyperspec-symbol-table "c:/run/HyperSpec/Data/Map_Sym.txt")
```

```shell
M-x hyperspec-lookup
```

# See Also
* [lisp-system-browser](https://github.com/mmontone/lisp-system-browser): Smalltalk-like system browser for Common Lisp. preinstalled in SLIME
* [Slime用户手册中文翻译版](https://github.com/unionx/slime-user-manual-cn)