# Roswell
* https://github.com/roswell/roswell

> Common Lisp environment setup Utility.
>
> Roswell is a Lisp implementation installer/manager, launcher, and much more! It started as a command-line tool with the aim to make installing and managing Common Lisp implementations really simple and easy.
>
> Roswell has now evolved into a full-stack environment for Common Lisp development, and has many features that makes it easy to test, share, and distribute your Lisp applications. We aim to push the Common Lisp community to a whole new level of productivity.

storage: `~/.roswell`

```shell
# Windows Git Bash
$ ros --version
roswell 24.10.115(NO-GIT-REVISION)

$ ros setup

$ ros run -- --version
SBCL 2.6.0

# setup Quicklisp!!!
$ ros run -- --load ~/quicklisp/setup.lisp
```

# See Also
* [Day 1: Roswell, as a Common Lisp implementation manager](https://fukamachi.hashnode.dev/day-1-roswell-as-a-common-lisp-implementation-manager)