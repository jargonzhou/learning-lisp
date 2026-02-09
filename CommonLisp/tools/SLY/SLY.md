# SLY
* https://github.com/joaotavora/sly
* https://joaotavora.github.io/sly/

- SLY is Sylvester the Cat's Common Lisp IDE for Emacs.
>
- SLY is a fork of SLIME. We tracks its bugfixes, particularly to the implementation backends. All SLIME's familar features (debugger, inspector, xref, etc...) are still available, with improved overall UX.

```shell
M-x package-install RET sly RET
M-x sly RET
```

Doom Emacs: `~/.config/emacs/modules/lang/common-lisp/config.el`

# Manual

read the manual in Emacs: `M-x sly-info`.

## Introduction

minor mode `sly-mode`: complements major mode `list-mode`.

SLY's user-interface(written in Emacs Lisp), is connected via sockets to one or more instances of a server programn `Slynk`(written in Common Lisp) that is running in the Lisp process.

## Getting started

- Supported Platforms
- Downloading SLY

```
M-x package-install RET sly RET
```

- Basic setup

```
; ~/.emacs or ~/.emacs.d/init.el
(setq inferior-lisp-program "/opt/sbcl/bin/sbcl")
```

- Running SLY

```
; start Lips subprocess
M-x sly

; connect to a running process on a local or remote machine
M-x sly-connect
```

- Basic customization
- Multiple Lisps

## A SLY tour for SLIME users

## Working with source files

- Evaluating code

| Command   | Command                               | Description                                                      |
| --------- | ------------------------------------- | ---------------------------------------------------------------- |
| `C-x C-e` | `M-x sly-eval-last-expression`        | with numberic argument, insert the value into the current buffer |
| `C-M-x`   | `M-x sly-eval-defun`                  | with numberic argument, insert the value into the current buffer |
| `C-c :`   | `M-x sly-interactive-eval`            |                                                                  |
| `C-c C-r` | `M-x sly-eval-region`                 |                                                                  |
| `C-c C-p` | `M-x sly-pprint-eval-last-expression` |                                                                  |
| `C-c E`   | `M-x sly-edit-value`                  |                                                                  |
| `C-c C-u` | `M-x sly-undefine-function`           |                                                                  |
|           | `M-x sly-remove-method`               |                                                                  |

- Compiling functions and files

| Command   | Command                         | Description |
| --------- | ------------------------------- | ----------- |
| `C-c C-c` | `M-x sly-compile-defun`         |             |
| `C-c C-k` | `M-x sly-compile-and-load-file` |             |
| `C-c M-k` | `M-x sly-compile-file`          |             |
| `C-c C-l` | `M-x sly-load-file`             |             |
|           | `M-x sly-compile-region`        |             |
| `M-n`     | `M-x sly-next-note`             | annotations |
| `M-p`     | `M-x sly-previous-note`         |             |
| `C-c M-c` | `M-x sly-remove-notes`          |             |
| `C-x`     | `M-x next-error`                |             |

- Autodoc

implemented by `eldoc-mode` of Emacs.

| Command | Command                    | Description |
| ------- | -------------------------- | ----------- |
|         | `M-x sly-arglist`          |             |
|         | `M-x sly-autodoc-mode`     |             |
|         | `M-x sly-autodoc-manually` |             |

- Semantic indentation

SLY does not distinguish between macros with the same symbol-name but different packages.

```
(slynk:print-identation-loosage)

sly-common-lisp-indent-function
```

- Reader conditional fontification

example: `#+linux`.

- Macro-expansion commands

| Command   | Command                          | Description                  |
| --------- | -------------------------------- | ---------------------------- |
| `C-c C-m` | `M-x sly-expand-1`               |                              |
|           | `M-x sly-macroexpand-1`          |                              |
| `C-c M-m` | `M-x sly-macroexpand-all`        |                              |
|           | `M-x sly-compiler-macroexpand-1` |                              |
|           | `M-x sly-cimpiler-macroexpand`   |                              |
|           | `M-x sly-format-string-expand`   |                              |
| `C-c C-m` | `M-x sly-macroexpand-1-inplace`  | in sly macroexpansion buffer |
| `g`       | `M-x sly-macroexpand-1-inplace`  |                              |
| `q`       | `M-x sly-temp-buffer-quit`       |                              |
| `C-_`     | `M-x sly-macroexpand-undo`       |                              |

## Common functionality

- Finding definitions

When pressed with the cursor over a symbol name, that symbol's name definition is looked up by the Lisp process, thus producing a Lisp source location: a file, a file-less buffer.

| Command | Command                                | Description |
| ------- | -------------------------------------- | ----------- |
|         | `M-x sly-edit-definition`              |             |
|         | `M-x sly-pop-find-definition-stack`    |             |
|         | `M-x sly-edit-definition-other-window` |             |
|         | `M-x sly-edit-definiiton-other-frame`  |             |

- Cross-referencing

finding and representing the definition of a function.

| Command | Command                       | Description            |
| ------- | ----------------------------- | ---------------------- |
|         | `M-x sly-edit-uses`           |                        |
|         | `M-x sly-who-calls`           |                        |
|         | `M-x sly-calls-who`           |                        |
|         | `M-x sly-who-references`      |                        |
|         | `M-x sly-who-binds`           |                        |
|         | `M-x sly-who-sets`            |                        |
|         | `M-x sly-who-macroexpands`    |                        |
|         | `M-x sly-who-specializes`     |                        |
|         | `M-x sly-list-callers`        | List callers/callees   |
|         | `M-x sly-list-callees`        |                        |
|         | `M-x sly-show-xref`           | in `*sly-xref*` buffer |
|         | `M-x sly-goto-xref`           |                        |
|         | `M-x sly-recompile-xref`      |                        |
|         | `M-x sly-recompile-all-xrefs` |                        |

- Auto-completion

```
; varible
sly-complete-symbol-function
; value
sly-flex-completions
sly-simple-completions

; buffer
*sly-completions*
```

| Command | Command                     | Description |
| ------- | --------------------------- | ----------- |
|         | `M-x sly-next-completion`   |             |
|         | `M-x sly-prev-completion`   |             |
|         | `M-x sly-choose-completion` |             |

- Interactive objects

in many buffers and modes in SLY, there are snippets of text that representa objects living in the Lisp process connected to SLY. These regions are known in SLY as **interactive values or objects**.

| Command   | Description       |     |
| --------- | ----------------- | --- |
| `M-RET`   | copy to REPL      |     |
| `M-S-RET` | copy call to REPL |     |
| `.`       | go to source      |     |
| `v`       | show source       |     |
| `p`       | pretty print      |     |
| `i`       | inspect           |     |
| `d`       | describe          |     |

- Documentation commands

| Command | Command                             | Description                     |
| ------- | ----------------------------------- | ------------------------------- |
|         | `M-x sly-info`                      | SLY manual                      |
|         | `M-x sly-describe-function`         |                                 |
|         | `M-x sly-apropos`                   |                                 |
|         | `M-x sly-apropos-all`               |                                 |
|         | `M-x sly-apropos-package`           |                                 |
|         | `M-x sly-hyperspec-lookup`          |                                 |
|         | `M-x hyperspec-lookup-format`       | lookup format character in CLHS |
|         | `M-x hyperspec-lookup-reader-macro` | lookup reader macro in CLHS     |

- Multiple connections

SLY is able to connect to multiple Lisp processes at the same time.

| Command | Command                                | Description                         |
| ------- | -------------------------------------- | ----------------------------------- |
|         | `M-x sly-list-connections`             |                                     |
|         | `M-x sly-next-connect`                 |                                     |
|         | `M-x sly-prev-connection`              |                                     |
|         | `M-x sly-goto-connection`              | in buffer by `sly-list-connections` |
|         | `M-x sly-connection-list-make-default` |                                     |
|         | `M-x sly-update-connection-list`       |                                     |
|         | `M-x sly-temp-buffer-quit`             |                                     |
|         | `M-x sly-restart-connection-at-point`  |                                     |
|         | `M-x sly-connect`                      | connect to a runnning slynk server  |
|         | `M-x sly-disconnect`                   | disconnect all connections          |
|         | `M-x sly-abort-connection`             |                                     |

- Disassembly commands

| Command | Command                            | Description |
| ------- | ---------------------------------- | ----------- |
|         | `M-x sly-disassemble-symbol`       |             |
|         | `M-x sly-toggle-trace-fdefinition` |             |
|         | `M-x sly-untrace-all`              |             |

- Abort/Recovery commands

| Command | Command                         | Description                                                               |
| ------- | ------------------------------- | ------------------------------------------------------------------------- |
|         | `M-x sly-interrupt`             | interrupt Lisp(`SIGINT`)                                                  |
|         | `M-x sly-restart-inferior-lisp` | restart the `inferior-lisp` process.                                      |
|         | `M-x sly-mrepl-sync`            | synchronize the current package and working directory from Emacs to Lisp. |
|         | `M-x sly-cd`                    | set the current directory of the Lisp process.                            |
|         | `M-x sly-pwd`                   | print the current directory of the Lisp process.                          |

- Temporary buffers

some SLY commands create temporary buffers to display their results. - `RET`: do the most obvisou useful thing.

- Multi-threading

| Command     | Command                | Description                                                                      |
| ----------- | ---------------------- | -------------------------------------------------------------------------------- |
| `C-c C-x t` | `M-x sly-list-threads` | open `*sly-threads*` buffer. `C-h m` in the buffer to get full keybindings list. |

```
slynk:*default-worker-thread-bindings*

(push '(*read-default-float-format* . double-float)
	  slynk:*default-worker-thread-bindings*)
```

## The REPL and other special buffers

buffer `*sly-mrepl...*`

| Command | Command              | Description |
| ------- | -------------------- | ----------- |
|         | `M-x sly-mrepl`      |             |
|         | `M-x sly-mrepl-new`  |             |
|         | `M-x sly-mrepl-sync` |             |

- The REPL: the “top level”
- 
- REPL commands

| Command   | Command                                    | Description |
| --------- | ------------------------------------------ | ----------- |
| `RET`     | `M-x sly-mrepl-return`                     |             |
| `TAB`     | `M-x sly-mrepl-indent-and-complete-symbol` |             |
| `M-p`     | `M-x sly-mrepl-previous-input-or-button`   |             |
| `M-n`     | `M-x sly-mrepl-next-input-or-button`       |             |
| `C-r`     | `M-x isearch-backward`                     |             |
| `C-c C-b` | `M-x sly-interrupt`                        |             |
| `C-M-p`   | `M-x sly-button-backward`                  |             |
| `C-M-n`   | `M-x sly-button-forward`                   |             |
| `C-c C-o` | `M-x sly-mrepl-clear-recent-output`        |             |
| `C-c M-o` | `M-x sly-mrepl-clear-repl`                 |             |

- REPL output

- `*`, `**`, `***`: RELP backreferences - `*standard-output*`, `*error-output*`, `*trace-output*`

Slynk variables

```
SLYNK:*GLOBALLY-REDIRECT-IO*
SLYNK:*USE-DEDICATED-OUTPUT-STREAM*
SLYNK:*DEDICATED-OUTPUT-STREAM-PORT*
SLYNK:*DEDICATED-OUTPUT-STREAM-BUFFERING*
```

- REPL backreferences

`#v`: `#vENTRY-IDX:VALUE-IDX`

example:

```
; Cleared REPL history
CL-USER> (values 'a 'b 'c)          ; #v0
A
B
C
CL-USER> (list #v0)                 ; #v1
(A)
CL-USER> (list #v0:1 #v0:2)         ; #v2
(B C)
CL-USER> (append #v1:0 #v2:0)       ; #v3
(A B C)
CL-USER>
```

- The Inspector

alternative to `INSPECT` function. generic function `inspect-for-emacs` in `slynk-backend.lisp`.

| Command | Command                                | Description                                                   |
| ------- | -------------------------------------- | ------------------------------------------------------------- |
| `C-c I` | `M-x sly-inspect`                      | inspect the value of an expression entered in the minibuffer. |
| `RET`   | `M-x sly-inspector-operate-in-point`   | in the inspector                                              |
| `D`     | `M-x sly-inspector-describe-inspectee` |                                                               |
| `e`     | `M-x sly-inspector-eval`               |                                                               |
| `v`     | `M-x sly-inspector-toggle-verbose`     |                                                               |
| `l`     | `M-x sly-inspector-pop`                |                                                               |
| `n`     | `M-x sly-inspector-next`               |                                                               |
| `g`     | `M-x sly-inspector-reinspect`          |                                                               |
| `h`     | `M-x sly-inspector-history`            |                                                               |
| `q`     | `M-x sly-inspector-quit`               |                                                               |
| `>`     | `M-x sly-inspector-fetch-all`          |                                                               |
| `M-RET` | `M-x sly-mrepl-copy-part-to-repl`      |                                                               |
| `TAB`   | `M-x forward-button`                   |                                                               |
| `S-TAB` | `M-x backward-button`                  |                                                               |

- The SLY-DB Debugger

Lisp `*DEBUGGER-HOOK*`

SLY-DB pops up a buffer when a condition is signaled. The buffer displays a description of the condition, a list of restarts, and a backtrace.

- Examining frames

| Command   | Command                             | Description |
| --------- | ----------------------------------- | ----------- |
| `t`       | `M-x sly-db-toggle-details`         |             |
| `v`       | `M-x sly-db-show-frame-source`      |             |
| `e`       | `M-x sly-db-eval-in-frame`          |             |
| `d`       | `M-x sly-db-pprint-eval-in-frame`   |             |
| `D`       | `M-x sly-db-disassemble`            |             |
| `i`       | `M-x sly-sb-inspect-in-frame`       |             |
| `C-c C-c` | `M-x sly-db-recompile-frame-source` |             |

- Invoking restarts

| Command   | Command                       | Description |
| --------- | ----------------------------- | ----------- |
| `a`       | `M-x sly-db-abort`            |             |
| `q`       | `M-x sly-db-quit`             |             |
| `c`       | `M-x sly-db-continue`         |             |
| `0 ... 9` | `M-x sly-db-invoke-restart-n` |             |

- Navigating between frames

| Command | Command                             | Description |
| ------- | ----------------------------------- | ----------- |
| `n`     | `M-x sly-db-down`                   |             |
| `p`     | `M-x sly-db-up`                     |             |
| `M-n`   | `M-x sly-db-details-down`           |             |
| `M-p`   | `M-x sly-db-details-up`             |             |
| `>`     | `M-x sly-db-end-of-backtrace`       |             |
| `<`     | `M-x sly-db-beginning-of-backtrace` |             |

- Miscellaneous Commands

| Command | Command                                  | Description                                            |
| ------- | ---------------------------------------- | ------------------------------------------------------ |
| `r`     | `M-x sly-db-restart-frame`               |                                                        |
| `R`     | `M-x sly-db-return-from-frame`           |                                                        |
| `B`     | `M-x sly-db-break-with-default-debugger` |                                                        |
| `C`     | `M-x sly-db-inspect-condition`           |                                                        |
| `:`     | `M-x sly-db-interactive-eval`            |                                                        |
| `A`     | `M-x sly-db-break-with-system-debugger`  | attach debugger(eg `gdb`) to the current lisp process. |

- Trace Dialog

package `sly-trace-dialog`, similar to Common Lisp's `trace`(stream `*trace-output*`).

| Command   | Command                                     | Description            |
| --------- | ------------------------------------------- | ---------------------- |
| `C-c M-t` |                                             | trace function         |
| `C-c C-t` | `M-x sly-trace-dialog-toggle-trace`         |                        |
| `C-c T`   | `M-x sly-trace-dialog`                      |                        |
| `g`       | `M-x sly-trace-dialog-fetch-status`         | in trace dialog buffer |
| `G`       | `M-x sly-trace-dialog-fetch-traces`         |                        |
| `C-k`     | `M-x sly-trace-dialog-clear-fetched-traces` |                        |

- Stickers 粘贴标签

contrib `sly-stickers`: a tool for live code annotations, not intrusive. stickers can exist inside other stickers.

| Command               | Command                         | Description                                   |
| --------------------- | ------------------------------- | --------------------------------------------- |
| `C-c C-s C-s`         | `M-x sly-sticker-dwim`          | place/remove a sticker on any Lisp form.      |
| `C-u C-c C-s C-s`     |                                 | remove all stickers from the current function |
| `C-u C-u C-c C-s C-s` |                                 | remove all stickers from the current file     |
| `C-c C-s p`, `M-p`    | `M-x sly-stickers-prev-sticker` |                                               |
| `C-c C-s n`, `M-n`    | `M-x sly-stickers-next-sticker` |                                               |

stickers are **armed** when a definition or a file is compiled: change background color from default gray to blue. From this point on, when the Lisp code is excuted, the results of evaluating the underlying forms are captured in the Lisp side.

| Command       | Command                                     | Description                                                                                                                             |
| ------------- | ------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| `C-c C-s C-r` | `M-x sly-stickers-replay`                   | create buffer `*sly-stickers-replay*`, type `h` for keybinds: walk through recordings in the order they occurred.                       |
|               | `M-x sly-stickers-toggle-break-on-stickers` | enable breaking stockers                                                                                                                |
| `C-c C-s S`   | `M-x sly-stickers-fetch`                    | populate the sticker ovelay with the lastest captured result: turn green if the sticker has captured any recording, turn red otherwise. |

## Customization

- Emacs-side
- Keybindings
- Keymaps
- Defcustom variables
- Hooks
- Lisp-side (Slynk)
- Communication style
- Other configurables

## Tips and Tricks

- Connecting to a remote Lisp
- Setting up the Lisp image
- Setting up Emacs
- Setting up pathname translations
- Loading Slynk faster
- Connecting to SLY automatically
- REPLs and “Game Loops”
- Controlling SLY from outside Emacs

## Extensions

- Loading and unloading “on the fly”
- More contribs
- TRAMP
- Scratch Buffer

## Key (Character) Index

## Command and Function Index

## Variable and Concept Index

# slynk
* https://quickref.common-lisp.net/slynk.html

