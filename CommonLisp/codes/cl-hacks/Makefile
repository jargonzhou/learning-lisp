build:
	sbcl --load cl-hacks.asd \
		--eval '(ql:quickload :cl-hacks)' \
		--eval "(sb-ext:save-lisp-and-die #p\"cl-hacks\" :toplevel #'cl-cookbook:hello :executable t)"
