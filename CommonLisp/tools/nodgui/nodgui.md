# nodgui
* https://github.com/lisp-mirror/nodgui

> Common Lisp bindings for the Tk GUI toolkit.

```lisp
; prepare: SDL2.dll, SDL2_TTF.dll, 
; pacman -S mingw-w64-x86_64-libjpeg-turbo
; pacman -S mingw-w64-x86_64-pkg-config
; pacman -S mingw-w64-x86_64-libffi
; src\wish-communication.lisp guess-wish-interpreter-path
; 2026-01-30  Couldn't execute "\\mingw64\\bin\\wish": 系统找不到指定的文件。
;    "D:/software/tcltk86-8.6.18.12.Win10.nightly.20260128/bin/wish.exe"
;
; (ql:quickload "nodgui")
; (nodgui.demo:demo)
```

# See Also
* [ltk](https://www.peter-herth.de/ltk/): LTK is a Common Lisp binding for the Tk graphics toolkit.