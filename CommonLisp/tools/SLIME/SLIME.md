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