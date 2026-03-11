# Common Lisp

* [Terminology](./language/common-lisp.Terminology.md)
* [Package](./language/common-lisp.package.md)
* [Macro](./language/common-lisp.macro.md)
* [CLOS](./language/CLOS.md)

# Specifications
* Common Lisp: The Language. 1990.
* [The Common Lisp HyperSpec(CLHS)](http://www.lispworks.com/reference/HyperSpec/): an online hyperlinked version of the ANSI Common Lisp specification.
* The Common Lisp Standard: ANSI INCITS 226-1994 (formerly ANSI X3.226:1994): [Most recent standard of Common Lisp](https://stackoverflow.com/questions/33848241/most-recent-standard-of-common-lisp)

# Implementations
* https://common-lisp.net/implementations
* https://lisp-lang.org/wiki/article/implementations

# See Also
* [Awesome Common Lisp](https://github.com/CodyReichert/awesome-cl): A curated list of awesome Common Lisp frameworks, libraries and other shiny stuff.
* [Awesome Common Lisp Application Software](https://github.com/azzamsa/awesome-cl-software): List of awesome application software built with Common Lisp.
* [Awesome Lisp Companies](https://github.com/azzamsa/awesome-lisp-companies)
* [Awesome Common Lisp Learning](https://github.com/GustavBertram/awesome-common-lisp-learning): A curated list of awesome Common Lisp learning resources.
* [CL CommunitySpec (CLCS)](https://cl-community-spec.github.io/pages/index.html): This is a rendering of the original Common Lisp ANSI Specification draft.
* [CLiki](https://www.cliki.net/): CLiki is a Common Lisp wiki hosted by The Common Lisp Foundation. CLiki contains resources for learning about and using the programming language Common Lisp, and information about DFSG-compliant free software implemented in Common Lisp.
  * [Common Lisp implementation](https://www.cliki.net/Common%20Lisp%20implementation)
* [Common-Lisp.net](https://common-lisp.net/): This site is one among many gateways to Common Lisp. Its goal is to provide the Common Lisp community with development resources and to work as a starting point for new programmers.
* [Common Lisp Docs](https://lisp-docs.github.io/): The (Un)Official Common Lisp Documentation.
* [Google Common Lisp Style Guide](https://google.github.io/styleguide/lispguide.xml)
* [google/lisp-koans](https://github.com/google/lisp-koans): Common Lisp Koans is a language learning exercise in the same vein as the ruby koans, python koans and others. It is a port of the prior koans with some modifications to highlight lisp-specific features. Structured as ordered groups of broken unit tests, the project guides the learner progressively through many Common Lisp language features.
* [lisp-lang.org](https://lisp-lang.org/)
* Steve Losh. [A Road to Common Lisp](https://stevelosh.com/blog/2018/08/a-road-to-common-lisp/), 2018-08-27.

History
* [An overview of COMMON LISP](https://dl.acm.org/doi/10.1145/800068.802140): Guy L. Steele, Jr., 1982.

Related
* [Coalton](https://github.com/coalton-lang/coalton/): Coalton is an efficient, statically typed functional programming language that supercharges Common Lisp.

# FAQ
* [SBCL warning that a variable is defined but never used](https://stackoverflow.com/questions/31225756/sbcl-warning-that-a-variable-is-defined-but-never-used)
```lisp
(defun worker-2 (context p)
  (declare (ignore context))
  (print p))
```
