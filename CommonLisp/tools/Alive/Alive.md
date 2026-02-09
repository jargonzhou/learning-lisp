# Alive: The Average Lisp VSCode Environment
* https://github.com/nobody-famous/alive

> Common Lisp Extension for VSCode

# Setup

```shell
cd ~/quicklisp/local-projects
git clone https://github.com/nobody-famous/alive-lsp.git
➜  alive-lsp git:(main) ls
README-dev.md README.md     alive-lsp.asd clue          clue.asd      run-server.sh run-tests.ps1 run-tests.sh  src           test

✗ rlwrap sbcl
* (ql:quickload "bordeaux-threads")
* (ql:quickload "usocket")
* (ql:quickload "cl-json")
* (ql:quickload "flexi-streams")

* (ql:quickload "alive-lsp")
* (alive/server::start :port 8006)
#<SB-THREAD:THREAD "Alive LSP Server" RUNNING {10034D5D73}>

# Alive VSCode Settings
Lsp > Install:Path
# MacOS
~/quicklisp/local-projects/alive-lsp
# Windwos WSL
~/quicklisp/local-projects/alive-lsp
# Windows
C:\Users\xxx\quicklisp\local-projects\alive-lsp
Lsp > Remote:Port
8006
```

# Commands

- **Select S-Expression (Alt+Shift+Up/Alt+Up)**: Selects the surrounding top level expression for the current cursor position.
- **Send To REPL (Alt+Shift+Enter/Alt+Enter)**: Sends selected text to the REPL. If nothing is selected, sends the top level form at the cursor position.
- **Eval Surrounding Form**: Sends selected text to the REPL. If nothing is selected, sends the immediate closing form at the cursor position.
- **Load File (Alt+Shift+L/Alt+L)**: Load the current file into the REPL.
- **Inline Evaluation (Alt+Shift+E)**: Evaluate the enclosing top-level form, showing the result inline. If there is a selection, evaluates the selected code.
- **Inline Eval Surrounding Form**: Evaluate the immediate enclosing form at the cursor, showing the result inline. If there is a selection, evaluates the selected code.
- **Clear Inline Results (Alt+Shift+C)**: Clear the inline results.
- **REPL History (Alt+Shift+R/Alt+R)**: Expressions that are evaluated from the REPL window are added to the history. This command opens a quick pick selector with the history. The most recently used item is at the top, i.e. similar behavior to the Run Tasks command.
- **Select Restart (Alt+Shift+0-9)**: Selects the restart with the given number for the currently visible debugger.
- **Load ASDF System**: Tell the REPL to load an ASDF system. A list of known systems will be given to choose from.
- **Open Scratch Pad**: Opens a temporary file, {workspace}/.vscode/alive/scratch.lisp, that can be used to evaluate expressions, making use of the normal editing features like code completion.
- **Macro Expand All**: Selected text is passed to macroexpand and expanded in place. If nothing is selected, the form surrounding the cursor is sent.
- **Macro Expand 1**: Selected text is passed to macroexpand-1 and expanded in place. If nothing is selected, the form surrounding the cursor is sent.
- **Inspect Macro**: An inspector is opened for the currently selected text. If nothing is selected, the form surrounding the cursor is sent.
- **Trace Function (Alt+Shift+T/Alt+T)**: Trace the function whose name the cursor is currently over.
- **Untrace Function (Alt+Shift+U/Alt+U)**: Untrace the function whose name the cursor is currently over.
- **Trace Package**: Traces all functions in the selected package.
- **Untrace Package**: Removes tracing for all functions in the selected package.

# alive-lsp
* https://github.com/nobody-famous/alive-lsp

> Language Server Protocol implementation for use with the Alive extension

